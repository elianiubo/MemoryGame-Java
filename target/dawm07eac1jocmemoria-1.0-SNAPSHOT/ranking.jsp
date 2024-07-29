<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title> Joc de memòria </title>
    <link rel="stylesheet" type="text/css" href="style/reset.css">
    <link rel="stylesheet" type="text/css" href="style/style.css">
    <script type="text/javascript" src="script.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
</head>
<body onload="inicialitzarComponents()">

<header>
    <h1>Joc de memòria</h1>
    <p>Rànking</p>
</header>
<div id="opcions">
    <ul>
        <a href="index.jsp"><li>Inici</li></a>
        <a href="ranking.jsp"><li>Rànking</li></a>
    </ul>
</div>

<%
String pathToPropsFile = config.getServletContext().getRealPath("/");
String fileName = pathToPropsFile + "ranking.txt";
BufferedReader is = new BufferedReader(new FileReader(fileName));

String fila = "";
%>
<table id="puntuacions">
    <th>Nom</th>
    <th>Dificultat</th>
    <th>Intents</th>
<%
 while((fila = is.readLine()) != null)
 {
    String[] partsfila = fila.split(",");
    out.print("<tr>");
    out.print("<td>" + partsfila[0] + "</td><td>" + partsfila[1] + "</td><td>" + partsfila[2] + "</td>");
    out.print("</tr>");
  }

%>
</table>
</body>
</html>