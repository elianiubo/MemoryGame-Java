<%-- 
    Document   : carta
    Created on : 08-sep-2019
    Author     : Germán Flores
--%>
<%@page import="java.text.DecimalFormat"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    Map<String, Integer> comanda = new HashMap();
    Map<String, Integer> articles = new HashMap();
%>
<%
    //Definim aquestes variables per fer-les servir al BODY
    String articleDiv = "";
    Integer preu = 0;

    /*
     TODO
     Els articles són els que podeu veure a la carpeta img 
     (excepte check.png i logo png)
     Fem coincidir el nom de l'article amb el nom del fitxer sense l'extensió
     (amanida, beer, coffee,...)
     
     Què heu de fer?
     Afegir tots els articles, amb el seu preu.
     */
        articles.put("amanida", 10);
        articles.put("beer", 3);
        articles.put("coffee", 2);
        articles.put("coke", 4);
        articles.put("gofre", 5);
        articles.put("hamburger", 15);
        articles.put("pizza", 20);
        articles.put("quiche", 15);
        

    /*
     TODO
     Si s'està executant aquesta pàgina és perquè l'usuari ha fet clic a un dels
     enllaços de Quantitat, llavors la url serà: 
     .../carta.jsp?article=xxx&quantitat=yyy
     on xxx és el nom de l'article i 'yyy' és la quantitat que volen comprar.
     A la variable Java article, hem recuperat el nom de l'article, 
     concretament amb  request.getParameter("article").
     Hem fet coincidir el nom del paràmetre  amb el nom de la variable Java, 
     però és casualitat. Hem fet el mateix amb quantitat.
     Què heu de fer?
     Afegiu l'article i la quantitat a la comanda
        (si no és null)
     */
    String article = request.getParameter("article");
    String quantitat = request.getParameter("quantitat");
    
    if (article != null && quantitat != null) {
        comanda.put(article, Integer.parseInt(quantitat));
    }
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Carta</title>
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
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-8">
                    <h1>Articles</h1>
                </div>
                <div class="col-md-2">
                    <h1>Comanda</h1>
                </div>
            </div>                
            <div class="row">
                <div class="col-md-8">
                    <div class="row">
                        <div class="col-md-3 divArticle">
                            <div class="row">
                                <%   /*
                                     articleDiv serà la variable que assignem per fer-la servir en tota la div.
                                     Només canviant el valor, la resta pot ser igual per a totes les divs de tots els articles.
                                     És a dir, un cop construida la div de l'article amanida, la podem copiar i només canviant
                                     el valor d'articleDiv, la resta no l'haureu de canviar.
                                     pageContext.setAttribute("articleDiv", articleDiv); permet fer servir
                                     la variable Java articleDiv com a variable JSTL ${articleDiv} (ho necessitareu)
                                     */
                                    articleDiv = "amanida";
                                    pageContext.setAttribute("articleDiv", articleDiv);
                                %>
                                <!--
                                TODO
                                Inseriu un element img class="img-responsive" amb
                                src de la carpeta img l'article xxx.png on xxx ha de ser variable                                
                                -->
                                 <img class = "img-responsive" src='img/<%=articleDiv%>.jpg'/>
                            </div>
                            <div class="row">
                                <%
                                    preu = articles.get(articleDiv);
                                %>
                                <div class="col-md-4">
                                    <h4>Preu: <%=preu%>€</h4>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <h5>Quantitat:</h5>
                                </div>
                                <!--
                                TODO
                                Si ja s'han afegit articles, com podeu veure a les imatges de l'enunciat,
                                les aquests mostren un check i els que no, mostren l'enllaç 1,2,3,4 o 5
                                Què heu de fer?
                                Mostrar el check o els enllaços depenent de si l'article està afegit o no.
                                Com?
                                Heu de mirar si el Map conté l'element articleDiv,
                                    Si el conté, llavors
                                        heu de mostrar tal qual 
                                            <div class="col-md-6">

                                            </div>
                                            <div class="col-md-2">
                                                <img class = "img-responsive" src='img/check.png'/>
                                            </div>
                                    Si no el conté, llavors
                                        heu de mostrar 
                                            <div class="col-md-5">
                                                <h4><a href='xxx'>1</a></h4>
                                                <h4><a href='xxx'>2</a></h4>
                                                <h4><a href='xxx'>3</a></h4>
                                                <h4><a href='xxx'>4</a></h4>
                                                <h4><a href='xxx'>5</a></h4>
                                            </div>
                                            <div class="col-md-3">

                                            </div>                                        
                                            on xxx l'heu de construir amb JSTL i la url ha de ser:
                                            carta.jsp?article=yyy&quantitat=zzz
                                                on yyy és l'article d'aquesta div
                                                i  zzz és la quantitat (pot ser: 1,2,3,4, o 5).
                                            Feu un bucle for del 1 al 5 per construir amb JSTL 
                                            les url amb els enllaços anteriors.
                                -->                  
                                <%
                                    if(comanda.containsKey(articleDiv)){
                                %>
                                <div class="col-md-6">

                                </div>
                                <div class="col-md-2">
                                    <img class = "img-responsive" src='img/check.png'/>
                                </div>
                                <%
                                    }
                                    else{
                                %>
                                <div class="col-md-5">
                                    <h5>
                                    <c:forEach begin="1" end="5" varStatus="loop">
                                    <a href='<c:url value="carta.jsp?article=${articleDiv}&quantitat=${loop.index}"/>'>${loop.index}</a>
                                    </c:forEach>
                                    </h5>
                                </div>
                                <div class="col-md-3">

                                </div>
                                <%
                                    }
                                %>                         
                            </div>
                            <!--
                            TODO
                            Un cop fet la div de l'article amanida, copieu-la per a cada article.
                            Recordeu que a cada div heu de canviar el valor articleDiv.
                            Poseu 4 articles en aquesta <div class="row"> i els altres quatre en altra nova.
                            Us ha de quedar aquesta estructura:
                                <div class="col-md-8">
                                    <div class="row">
                                        divs de 4 articles
                                    </div>
                                    <div class="row">
                                        divs de 4 articles
                                    </div>
                                </div>
                            -->
                        </div>
                        <div class="col-md-3 divArticle">
                            <div class="row">
                                <%
                                    articleDiv = "beer";
                                    pageContext.setAttribute("articleDiv", articleDiv);
                                %>
                                 <img class = "img-responsive" src='img/<%=articleDiv%>.jpg'/>
                            </div>
                            <div class="row">
                                <%
                                    preu = articles.get(articleDiv);
                                %>
                                <div class="col-md-4">
                                    <h4>Preu: <%=preu%>€</h4>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4"><h5>Quantitat:</h5>
                                </div>                 
                                <%
                                    if(comanda.containsKey(articleDiv)){
                                %>
                                <div class="col-md-6">

                                </div>
                                <div class="col-md-2">
                                    <img class = "img-responsive" src='img/check.png'/>
                                </div>
                                <%
                                    }
                                    else{
                                %>
                                <div class="col-md-5">
                                    <h5>
                                    <c:forEach begin="1" end="5" varStatus="loop">
                                    <a href='<c:url value="carta.jsp?article=${articleDiv}&quantitat=${loop.index}"/>'>${loop.index}</a>
                                    </c:forEach>
                                    </h5>
                                </div>
                                <div class="col-md-3">

                                </div>
                                <%
                                    }
                                %>                      
                            </div>
                        </div>
                        <div class="col-md-3 divArticle">
                            <div class="row">
                                <%
                                    articleDiv = "coffee";
                                    pageContext.setAttribute("articleDiv", articleDiv);
                                %>
                                 <img class = "img-responsive" src='img/<%=articleDiv%>.jpg'/>
                            </div>
                            <div class="row">
                                <%
                                    preu = articles.get(articleDiv);
                                %>
                                <div class="col-md-4">
                                    <h4>Preu: <%=preu%>€</h4>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4"><h5>Quantitat:</h5>
                                </div>                 
                                <%
                                    if(comanda.containsKey(articleDiv)){
                                %>
                                <div class="col-md-6">

                                </div>
                                <div class="col-md-2">
                                    <img class = "img-responsive" src='img/check.png'/>
                                </div>
                                <%
                                    }
                                    else{
                                %>
                                <div class="col-md-5">
                                    <h5>
                                    <c:forEach begin="1" end="5" varStatus="loop">
                                    <a href='<c:url value="carta.jsp?article=${articleDiv}&quantitat=${loop.index}"/>'>${loop.index}</a>
                                    </c:forEach>
                                    </h5>
                                </div>
                                <div class="col-md-3">

                                </div>
                                <%
                                    }
                                %>                      
                            </div>
                        </div>                        
                        <div class="col-md-3 divArticle">
                            <div class="row">
                                <%
                                    articleDiv = "coke";
                                    pageContext.setAttribute("articleDiv", articleDiv);
                                %>
                                 <img class = "img-responsive" src='img/<%=articleDiv%>.jpg'/>
                            </div>
                            <div class="row">
                                <%
                                    preu = articles.get(articleDiv);
                                %>
                                <div class="col-md-4">
                                    <h4>Preu: <%=preu%>€</h4>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4"><h5>Quantitat:</h5>
                                </div>                 
                                <%
                                    if(comanda.containsKey(articleDiv)){
                                %>
                                <div class="col-md-6">

                                </div>
                                <div class="col-md-2">
                                    <img class = "img-responsive" src='img/check.png'/>
                                </div>
                                <%
                                    }
                                    else{
                                %>
                                <div class="col-md-5">
                                    <h5>
                                    <c:forEach begin="1" end="5" varStatus="loop">
                                    <a href='<c:url value="carta.jsp?article=${articleDiv}&quantitat=${loop.index}"/>'>${loop.index}</a>
                                    </c:forEach>
                                    </h5>
                                </div>
                                <div class="col-md-3">

                                </div>
                                <%
                                    }
                                %>                      
                            </div>
                        </div>
                    </div>
                    <div class="row">
                         <div class="col-md-3 divArticle">
                            <div class="row">
                                <%
                                    articleDiv = "gofre";
                                    pageContext.setAttribute("articleDiv", articleDiv);
                                %>
                                 <img class = "img-responsive" src='img/<%=articleDiv%>.jpg'/>
                            </div>
                            <div class="row">
                                <%
                                    preu = articles.get(articleDiv);
                                %>
                                <div class="col-md-4">
                                    <h4>Preu: <%=preu%>€</h4>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4"><h5>Quantitat:</h5>
                                </div>                 
                                <%
                                    if(comanda.containsKey(articleDiv)){
                                %>
                                <div class="col-md-6">

                                </div>
                                <div class="col-md-2">
                                    <img class = "img-responsive" src='img/check.png'/>
                                </div>
                                <%
                                    }
                                    else{
                                %>
                                <div class="col-md-5">
                                    <h5>
                                    <c:forEach begin="1" end="5" varStatus="loop">
                                    <a href='<c:url value="carta.jsp?article=${articleDiv}&quantitat=${loop.index}"/>'>${loop.index}</a>
                                    </c:forEach>
                                    </h5>
                                </div>
                                <div class="col-md-3">

                                </div>
                                <%
                                    }
                                %>                      
                            </div>
                        </div>  
                        <div class="col-md-3 divArticle">
                            <div class="row">
                                <%
                                    articleDiv = "hamburger";
                                    pageContext.setAttribute("articleDiv", articleDiv);
                                %>
                                 <img class = "img-responsive" src='img/<%=articleDiv%>.jpg'/>
                            </div>
                            <div class="row">
                                <%
                                    preu = articles.get(articleDiv);
                                %>
                                <div class="col-md-4">
                                    <h4>Preu: <%=preu%>€</h4>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4"><h5>Quantitat:</h5>
                                </div>                 
                                <%
                                    if(comanda.containsKey(articleDiv)){
                                %>
                                <div class="col-md-6">

                                </div>
                                <div class="col-md-2">
                                    <img class = "img-responsive" src='img/check.png'/>
                                </div>
                                <%
                                    }
                                    else{
                                %>
                                <div class="col-md-5">
                                    <h5>
                                    <c:forEach begin="1" end="5" varStatus="loop">
                                    <a href='<c:url value="carta.jsp?article=${articleDiv}&quantitat=${loop.index}"/>'>${loop.index}</a>
                                    </c:forEach>
                                    </h5>
                                </div>
                                <div class="col-md-3">

                                </div>
                                <%
                                    }
                                %>                      
                            </div>
                        </div>
                        <div class="col-md-3 divArticle">
                            <div class="row">
                                <%
                                    articleDiv = "pizza";
                                    pageContext.setAttribute("articleDiv", articleDiv);
                                %>
                                 <img class = "img-responsive" src='img/<%=articleDiv%>.jpg'/>
                            </div>
                            <div class="row">
                                <%
                                    preu = articles.get(articleDiv);
                                %>
                                <div class="col-md-4">
                                    <h4>Preu: <%=preu%>€</h4>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4"><h5>Quantitat:</h5>
                                </div>                 
                                <%
                                    if(comanda.containsKey(articleDiv)){
                                %>
                                <div class="col-md-6">

                                </div>
                                <div class="col-md-2">
                                    <img class = "img-responsive" src='img/check.png'/>
                                </div>
                                <%
                                    }
                                    else{
                                %>
                                <div class="col-md-5">
                                    <h5>
                                    <c:forEach begin="1" end="5" varStatus="loop">
                                    <a href='<c:url value="carta.jsp?article=${articleDiv}&quantitat=${loop.index}"/>'>${loop.index}</a>
                                    </c:forEach>
                                    </h5>
                                </div>
                                <div class="col-md-3">

                                </div>
                                <%
                                    }
                                %>                      
                            </div>
                        </div>
                        <div class="col-md-3 divArticle">
                            <div class="row">
                                <%
                                    articleDiv = "quiche";
                                    pageContext.setAttribute("articleDiv", articleDiv);
                                %>
                                 <img class = "img-responsive" src='img/<%=articleDiv%>.jpg'/>
                            </div>
                            <div class="row">
                                <%
                                    preu = articles.get(articleDiv);
                                %>
                                <div class="col-md-4">
                                    <h4>Preu: <%=preu%>€</h4>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4"><h5>Quantitat:</h5>
                                </div>                 
                                <%
                                    if(comanda.containsKey(articleDiv)){
                                %>
                                <div class="col-md-6">

                                </div>
                                <div class="col-md-2">
                                    <img class = "img-responsive" src='img/check.png'/>
                                </div>
                                <%
                                    }
                                    else{
                                %>
                                <div class="col-md-5">
                                    <h5>
                                    <c:forEach begin="1" end="5" varStatus="loop">
                                    <a href='<c:url value="carta.jsp?article=${articleDiv}&quantitat=${loop.index}"/>'>${loop.index}</a>
                                    </c:forEach>
                                    </h5>
                                </div>
                                <div class="col-md-3">

                                </div>
                                <%
                                    }
                                %>                      
                            </div>
                        </div>

                    </div>        
                </div>
                <div class="col-md-2">
                    <div class="row">
                        <div class="col-md-6">
                            <img class = "img-responsive" src='img/logo.png'/>
                        </div>
                        <div class="col-md-4">

                            <%
                                /*
                                 TODO
                                 Calculeu el valor de totalArticles: nombre d'articles afegits a la comanda
                                 Calculeu el valor totalComanda: preu total de la comanda
                                 */
                                Integer totalArticles = 0;
                                Integer totalComanda = 0;
                                
                                /*
                                TODO
                                Per calcular el total d'articles heu de recòrrer al map anomenat comanda.
                                Ho podeu fer amb un bucle de tipus for on a cada volta mireu si la comanda
                                inclou l'article i quants n'hi ha.
                                Per exemple, el for ha de ser així:
                                for (Map.Entry<String, Integer> v : comanda.entrySet())
                                
                                on v és l'assossiació <Article, Quantitat>
                                
                                Anem sumant la quantitat d'articles de cada element de la comanda.
                                
                                En el cas del preu, sumem el preu, que l'aconseguim del map anomenat articles.
                                Cada volta del bucle sumem al total de la comanda el preu * quantitat 
                                */
                                
                                totalArticles = 0;
                                for (Map.Entry<String, Integer> v : comanda.entrySet())
                                {
                                    int preuArticle = articles.get(v.getKey());
                                    int quantitatArticle = v.getValue();
                                    
                                    totalArticles += quantitatArticle;
                                    totalComanda += preuArticle * quantitatArticle;
                                }

                            %>
                            <h4>
                                Articles: <h5> <%= totalArticles%></h5>
                            </h4>
                            <h4>
                                Preu total:<h5> <%=totalComanda%></h5>
                            </h4>
                            <h4><a href='<c:url value="comanda.jsp"/>'>Veure</a></h4>
                            <%
                                /*
                                 TODO
                                 Necessitarem que les variables articles i comanda
                                 siguin accessibles desde JSTL. Ho necessitareu a comanda.jsp
                                 Què heu de fer?
                                 Feu que articles i comanda siguin accessibles desde JSTL
                                 */
                            session.setAttribute("articles", articles);
                            session.setAttribute("comanda", comanda);
                            %>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </body>
</html>
