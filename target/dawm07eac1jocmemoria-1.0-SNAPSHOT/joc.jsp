<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collections"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Joc de Memòria</title>
    <link rel="stylesheet" type="text/css" href="style/reset.css">
    <link rel="stylesheet" type="text/css" href="style/style.css">
    <script type="text/javascript" src="script.js"></script>
    <!--<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">-->
</head>
<body onload="inicialitzarComponents()">

<%
String dificultat = "4";
int numeroCartes;
String nom = request.getParameter("Nom");

if (String.valueOf(session.getAttribute("barrejar"))!="false" || String.valueOf(session.getAttribute("nouUsuari"))=="true") {
    session.setAttribute("nouUsuari", "false");


    session.setAttribute("numeroCartes", (int)(Math.pow(Integer.valueOf(dificultat), 2)));
    numeroCartes = Integer.parseInt(String.valueOf(session.getAttribute("numeroCartes")));
    ArrayList<String> cartes = new ArrayList<String>();
    for (int i=0; i<numeroCartes/2; i++) {
        cartes.add("carta" + i);
        cartes.add("carta" + i);
    }
    Collections.shuffle(cartes); //barregem les cartes
    // la variable de sessió és un array
    session.setAttribute("arrayCartes", cartes);
    session.setAttribute("barrejar", "false");
} else {
    numeroCartes = Integer.parseInt(String.valueOf(session.getAttribute("numeroCartes")));
}
%>

<header>
    <h1>Joc de Memòria</h1>
    <p>Parelles restants: <span><%="8"%></span></p>
    <p>Intents: <span>0</span></p>
    <p>Temps: <span>0</span></p>
    <p>Ajudes restants: <span>3</span></p>
</header>
<div id="opcions">
    <ul>
        <li onclick="reiniciarPartida()">Reiniciar</li>
        <li onclick="ajudaVisual()">Ajuda</li>
        <a href="ranking.jsp"><li>Rànking</li></a>
    </ul>
</div>

<div id="dialogoverlay"></div> 
<section>
    <table id="taula">
    <%
    for (int i=0; i<numeroCartes; i=i+Integer.parseInt(dificultat)) {
        // Número de files que tindrà el taulell
	out.print("<tr>");
        for (int j=0; j<Integer.parseInt(dificultat); j++) {
            // Número de cartes per cada fila
            // Es creen els divs amb els seus respectius IDs i backgrounds
            int num = i + j;
            out.print("<td>");
            out.print("<div id='" + ((ArrayList<String>)session.getAttribute("arrayCartes")).get(num) + "' class='carta' onclick='girarCarta(event)'>");
            out.print("<div class='flipper'>");
            out.print("<div class='cara'></div>");
            out.print("<div style='background-image: url(img/" + ((ArrayList<String>)session.getAttribute("arrayCartes")).get(num) + ".png)' class='dors'></div>");
            out.print("</div>");
            out.print("</div>");
            out.print("</td>");
        }
        out.print("</tr>");
    }
    %>
    </table>

    <!-- Components invisibles per fer el Pop-up de WIN -->
    <div id="dialogbox">
        <div>
            <div id="dialogboxhead">MOLT BÉ!</div>
            <div id="dialogboxbody"></div> 
            <div id="dialogboxfoot" onclick="guardarRanking('<%=nom%>', '<%=dificultat%>')">ACCEPTAR</div>
        </div>
    </div>
</section>

</body>
</html>