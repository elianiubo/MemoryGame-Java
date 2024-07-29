<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title> Joc de memòria </title>
	<link rel="stylesheet" type="text/css" href="style/reset.css">
	<link rel="stylesheet" type="text/css" href="style/style.css">
	<script src="script.js" type="text/javascript"></script>
</head>
<body>
    <%
    session.setAttribute("nouUsuari", true);
    %>

	<h1 id="titolPortada">Joc de Memòria</h1>

	<form action="joc.jsp" id="formulari" method="GET">

		<div id="inputs">
			<output id="outputNom">Nom</output>
			<input id="inputNom" type="text" name="Nom"/>
		</div>
		<input onclick="comprovacioNom()" id="botoAcceptar" value="Comencar" name="Comencar"/>
	</form>

</body>
</html>