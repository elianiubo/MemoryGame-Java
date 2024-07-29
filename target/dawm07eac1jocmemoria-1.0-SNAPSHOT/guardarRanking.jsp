<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.IOException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
String nom = request.getParameter("nom");
String dificultat = request.getParameter("dificultat");
String intents = request.getParameter("intents");

String pathToPropsFile = config.getServletContext().getRealPath("/");
String fileName = pathToPropsFile + "ranking.txt";

PrintWriter fout = null;
try {
    fout = new PrintWriter(new BufferedWriter(new FileWriter(fileName, true)));
    fout.println(nom + "," + dificultat + "," + intents);
} catch (IOException e) {
    System.err.println(e);
} finally {
    if (fout != null) {
        fout.close();
    }
} 
%>