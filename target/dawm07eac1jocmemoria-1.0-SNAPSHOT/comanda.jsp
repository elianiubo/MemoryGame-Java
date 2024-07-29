<%-- 
    Document   : comanda
    Created on : 09-09-2019
    Author     : Germán Flores
--%>
<%@page import="java.util.Map"%>
<%@page import="java.text.DecimalFormat"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    /*
     TODO
     Si s'està executant aquesta pàgina perquè l'usuari ha donat a un dels
     enllaços Eliminar, llavors la url serà .../comanda.jsp?article=xxx, on xxx
     és el nom de l'article.
     A la variable Java article, hem recuperat aquest nom d'article amb
     request.getParameter("article") 
     I a la variable Java comanda, hem recuperat la llista d'articles (o comanda)
      amb session.getAttribute("comanda");     
     Què heu de fer?
     Elimineu l'article de la comanda
     */
    String article = request.getParameter("article");
    Map<String, Integer>  comanda = (Map) session.getAttribute("comanda");
        
    comanda.remove(article);
    
    /* 
     TODO
     Necessitareu la variable articles de la pàgina carta.jsp per calcular els preus a les files JSTL
    */
    Map<String, Integer> articles = (Map) session.getAttribute("articles");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Comanda</title>
        <!-- CSS -->
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

        <!-- css propis -->
        <link href="owncss/restaurant.css" rel="stylesheet">

        <!-- JAVA SCRIPT -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>


    </head>
    <body>
        <c:set var="test" value="Valor d'una variable d'àmbit de sessió"
               scope="session" />
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-10">
                    <h1>Comanda realitzada</h1>
                </div>
            </div>                
            <div class="row">
                <div class="col-md-8">
                    <table class="table table-hover">
                        <thead class="thead-inverse">
                            <tr>
                                <th></th>
                                <th>Article</th>
                                <th>Quantitat</th>
                                <th>Preu</th>
                                <th>Subtotal</th>
                                <th>Acció</th>
                            </tr>
                        </thead>
                        <!--
                        TODO
                        Amb JSTL heu de desenvolupar les files de la table que es pot veure a l'enunciat.
                        El contingut són els articles que hi ha a la comanda
                        No cal que sigui exacte a la que veieu, però el contingut ha de ser el mateix.
                        L'enllaç Eliminar de cada fila, és l'element
                            <a  href='xxx'>Eliminar</a>
                                on xxx l'heu de construir amb JSTL i la url ha de ser comanda.jsp?article=yyy
                                    on yyy és l'article de la fila
                        Per a la imatge, podeu fer servir la classe css ownImgTable
                        
                        Heu definir i calcular la variable JSTL TotalComanda com la suma de tots els articles.
                        Aquesta variable l'utilitzareu per fer la suma de la comanda.
                        -->

                        <c:set value="1" var="altern"></c:set>
                        <c:set value="0" var="TotalComanda"></c:set>
                        <c:set value="warning" var="classRow"></c:set>
                        <c:forEach items="${comanda}" var="item">
                            <c:set value="${item.key}" var="valor"></c:set> 
                            <%
                                String nom = (String) pageContext.getAttribute("valor");
                                Integer preu = articles.get(nom);
                                Integer quantitat = comanda.get(nom);
                                Integer subtotal = preu * quantitat;

                            %>
                            <c:set value="<%=subtotal%>" var="subtotal"></c:set> 
                            <c:choose>
                                <c:when test="${altern>0}">
                                    <c:set value="warning" var="classRow"></c:set>
                                    <c:set value="0" var="altern"></c:set>
                                </c:when>
                                <c:otherwise>
                                    <c:set value="info" var="classRow"></c:set>
                                    <c:set value="1" var="altern"></c:set>
                                </c:otherwise>
                            </c:choose>
                            <tr class="${classRow}">
                                <td>
                                            <img class="ownImgTable" src='img/${item.key}.jpg'/>
                                </td>
                                <td>${item.key}</td>
                                <td><c:out value="${item.value}"/></td>
                                <td><c:out value="<%= preu %>"/></td>
                                <td><c:out value="<%= subtotal %>"/></td>
                                <td><a  href='<c:url value="comanda.jsp?article=${item.key}"/>'>Eliminar</a></td>
                            </tr> 
                            <c:set value="${TotalComanda+subtotal}" var="TotalComanda"></c:set>
                        </c:forEach>
                        <tfoot>
                            <tr>     
                                <th></th>
                                <th class="text-right">Total Comanda</th>                                                                        
                                <th>
                                    <fmt:setLocale value="es_ES"/>
                                    <fmt:formatNumber value="${TotalComanda}" type="number"/></th>
                                <th></th>
                            </tr>
                        </tfoot>
                    </table>
                    </table>
                </div>
                <div class="col-md-2">
                   <h4><a href='<c:url value="carta.jsp"/>'>Tornar</a></h4>
                </div>
            </div>
        </div>
    </body>
</html>
