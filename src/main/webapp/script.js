var parellaSeleccionada = 0;
var carta1, carta2;
var idCarta1, idCarta2;
var comptadorParelles = null, totalParelles, numCartes;
var intents = 0;
var permetSeguir;
var peticioHTTP;
var taulellJoc;
var comptadorAjudes;
var temps, cronometre;
var cartesDescobertes = [];
var audio;

function inicialitzarComponents(){
	comptadorParelles = document.getElementsByTagName('span')[0].innerHTML;
	totalParelles = comptadorParelles;
	permetSeguir = true;
	taulellJoc = document.getElementById('taula').innerHTML;
	numCartes = document.getElementsByClassName('carta');
	temps = 0;
	cronometre = setInterval(comptadorTemps, 1000);
	comptadorAjudes = 3;
	audio = document.createElement('audio');
	inicializarXHR();
}

function comprovacioNom() {
	var input = document.getElementById('inputNom').value;
	if (input == null || input.trim()=="") {
		document.getElementById('inputNom').style.borderColor = "red";
	}
	else {
		document.getElementById('inputNom').style.borderColor = "#ccc";
		document.getElementById("formulari").submit(); 
	}

}

function girarCarta(event) {
	parellaSeleccionada++;
		if (permetSeguir == true) {
			// Estan totes les cartes en joc cap per avall
			if (parellaSeleccionada == 1) {
				// L'usuari ha elegit una carta
				carta1 = event.currentTarget;
				primeraCarta();
			}
			else {
				// L'usuari ha elegit les dues cartes
				carta2 = event.currentTarget;
				segonaCarta();
				// Comprova si s'ha fet una parella
				comprovarCartes();
			}
		}
		else {
			// Hi ha alguna carta en joc cap per amunt
			parellaSeleccionada = 0;
		}
}

function primeraCarta() {
	carta1.removeAttribute("onclick");
	idCarta1 = carta1.id;
	carta1.classList.add("cartaGirada");
	audio.setAttribute('src', 'sons/girarCarta.mp3');
	audio.play();
}

function segonaCarta() {
	permetSeguir = false;
	carta2.removeAttribute("onclick");
	idCarta2 = carta2.id;
	carta2.classList.add("cartaGirada");
}

function tornarGirarCartes() {
	carta1.classList.remove("cartaGirada");
	carta2.classList.remove("cartaGirada");
	carta1.setAttribute("onclick", "girarCarta(event)");
	carta2.setAttribute("onclick", "girarCarta(event)");
	permetSeguir = true;
}

function comprovarCartes() {
	intents++;
	// Incrementa la variable intents i la mostra per pantalla
	document.getElementsByTagName('span')[1].innerHTML = intents;
	if (idCarta1 != idCarta2) {
		// Les cartes són diferents
		intentFallat();
	}
	else {
		// Les cartes són iguals
		parellaRealitzada();
		comprovarWin();
	}
}

function intentFallat() {
	audio.setAttribute('src', 'sons/error.mp3');
	audio.play();
	parellaSeleccionada = 0;
	setTimeout('tornarGirarCartes()',500);
}

function parellaRealitzada() {
	audio.setAttribute('src', 'sons/encert.mp3');
	audio.play();
	carta1.style.opacity = 0.7;
	carta2.style.opacity = 0.7;
	cartesDescobertes.push(carta1);
	carta1 = "";
	carta2 = "";
	parellaSeleccionada = 0;
	comptadorParelles--;
	document.getElementsByTagName('span')[0].innerHTML = comptadorParelles;
	permetSeguir = true;
}

function comprovarWin() {
	if (comptadorParelles == 0) {
		// El comptador de parelles arriba a zero
		clearInterval(cronometre);
		document.getElementsByTagName('li')[1].style.opacity = 0.5;
		document.getElementsByTagName('li')[1].removeAttribute("onclick");
		Alert.render('Has guanyat la partida amb ' + intents + ' intents');
	}
}

function popUp() {
	this.render = function(dialog) { 
		var WinW = window.innerWidth; 
		var WinH = window.innerHeight; 
		var dialogoverlay = document.getElementById('dialogoverlay'); 
		var dialogbox = document.getElementById('dialogbox'); 
		dialogoverlay.style.width = "100%"; 
		dialogoverlay.style.height = WinH+"px";
		dialogbox.style.width = "35em"; 
		document.getElementById('dialogboxbody').innerHTML = dialog;
	} 

	this.tancarPopUp = function() {
		document.getElementById('dialogbox').style.width = "0";
		document.getElementById('dialogoverlay').style.width = "0"; 
	} 
}

var Alert = new popUp();

function inicializarXHR() {
	// Prepara un objecte de petició HTTP segons el navegador
	if (window.XMLHttpRequest) peticioHTTP = new XMLHttpRequest();
	else peticioHTTP = new ActiveXObject("Microsoft.XMLHTTP");
}

function realitzarPeticio(url, metode, funcion) {
	// Defineix l'acció
	peticioHTTP.onreadystatechange = funcion;
	// Realitza la petició
	peticioHTTP.open(metode, url, true);
	peticioHTTP.send(null);
}

function guardarRanking(nom, dificultat) {
	realitzarPeticio('guardarRanking.jsp?nom='+nom+'&dificultat='+dificultat+'&intents='+intents, 'GET', null);
	Alert.tancarPopUp();
}

function reiniciarPartida() {
    realitzarPeticio('barrejar.jsp', 'GET', null);
    javascript:location.reload();
}

function ajudaVisual() {
	if (comptadorAjudes > 0 && comptadorParelles >0) {
		// A l'usuari li queden ajudes i encara no ha acabat la partida
		realitzaAjuda();
	}
	if (comptadorAjudes == 1) {
		// L'usuari ja no disposa de més ajudes
		bloquejaAjuda();
	}
	comptadorAjudes--;
	// Redueix les ajudes restants i les mostra per pantalla
	document.getElementsByTagName('span')[3].innerHTML = comptadorAjudes;
}

function realitzaAjuda(){
	for (i = 0; i < numCartes.length; i++) {
    	numCartes[i].classList.add("cartaGirada");
    	numCartes[i].removeAttribute("onclick");
	}
	intents += 5;;
	document.getElementsByTagName('span')[1].innerHTML = intents;
	setTimeout('fiAjudaVisual()',3000);
}

function bloquejaAjuda() {
	document.getElementsByTagName('li')[1].style.opacity = 0.5;
	document.getElementsByTagName('li')[1].removeAttribute("onclick");
}

function fiAjudaVisual() {
	for (i = 0; i < numCartes.length; i++) {
		var coincidencies = 0;
		// Torna a girar totes les cartes
		for (x = 0; x < cartesDescobertes.length; x++) {
			if (cartesDescobertes[x].id == numCartes[i].id) {
				coincidencies++;
			}
		}
		if (coincidencies == 0) {
			numCartes[i].classList.remove("cartaGirada");
			numCartes[i].setAttribute("onclick", "girarCarta(event)");
		}
	}
}

function comptadorTemps() {
	temps++;
	document.getElementsByTagName('span')[2].innerHTML = temps;
}