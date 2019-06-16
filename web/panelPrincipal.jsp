<!--
    *Diseñado y programado por Cristopher Pérez V.
    *Sistema Tekonn 2019
-->
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //SE OBTIENE LA SESION
    HttpSession sesion = request.getSession(false);
    String rolUs = (String) sesion.getAttribute("rolUs");
%>

<!-- ***** INICIO ADMINISTRADOR ****** -->
<%
    //PRIMERO SE VALIDA QUE EL ROL SEA DISTINTO A NULL (SI ES NULL, NO HAY SESION ACTIVA)   
    if (rolUs != null) {
        ArrayList listaAvisos = (ArrayList) sesion.getAttribute("listaAvisos");
        switch (rolUs) {
            case "ADMINISTRADOR":
                ArrayList datosAdm = (ArrayList) sesion.getAttribute("datosUsuario");

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Panel Principal</title>

        <!-- ********** INICIO ESTILOS ********** --> 
        <!-- BOOSTSTRAP ESTILO -->
        <link rel="stylesheet" href="css/principal/bootstrap.min.css">
        <!-- CSS PANEL -->
        <link rel="stylesheet" href="css/principal/cssPanel.css">
        <!-- METIS MENU -->
        <link rel="stylesheet" href="css/principal/metisMenu.css">
        <!-- ESTILOS PROPIOS - ESTILOS PROPIOS -->
        <link rel="stylesheet" href="css/estilosPropios/propios.css">
        <link rel="stylesheet" href="css/estilosPropios/timeline.css">
        <!-- CND FONTAWESOME -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <!-- ********** FIN ESTILOS ********** --> 

    </head>

    <body>

        <div id="wrapper">

            <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a id="aLogo" class="navbar-brand" href="panelPrincipal.jsp"><img id="imgLogo" src="media/imagenes/logo.png" alt="logoTekonn" /></a>
                </div>

                <!-- ***** INICIO PANEL SUPERIOR ***** -->
                <ul class="nav navbar-top-links navbar-right">
                    <!-- ICONO -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fas fa-angle-right"></i>
                        </a>
                    </li>
                    <!-- ICONO MENU -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fas fa-exclamation"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-tasks">
                            <li>
                                <a href="reportarBug.jsp">
                                    <div>
                                        <i class="fas fa-bug"></i> Reportar error                                       
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <!-- ICONO ALERTAS -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fa fa-bell fa-fw"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-alerts">
                            <li>
                                <a href="avisos.jsp">
                                    <div>
                                        <i class="fas fa-comment-alt"></i> Avisos                                        
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <!-- ICONO USUARIO -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fa fa-user fa-fw"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-user">
                            <li>
                                <a href="panelPrincipalDatosCuenta.jsp">
                                    <i class="fas fa-cog"></i> 
                                    Perfil
                                </a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a onclick="deslogForm.submit()" style="cursor:pointer;">
                                    <i class="fas fa-sign-out-alt"></i> 
                                    Cerrar sesión
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fas fa-angle-left"></i>
                        </a>
                    </li>
                </ul>
                <!-- ***** FIN PANEL SUPERIOR ***** -->

                <!-- ***** INICIO BARRA LATERAL ***** -->
                <div class="navbar-default sidebar" role="navigation">
                    <div class="sidebar-nav navbar-collapse">
                        <ul class="nav" id="side-menu">                          
                            <li>
                                <a href="#"><i class="fas fa-users-cog"></i>  Panel usuarios<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a href="moduloUsuarios.jsp">Gestionar usuarios</a>
                                    </li>
                                    <li> 
                                        <a href="moduloPersonal.jsp">Gestionar personal</a>
                                    </li>
                                    <li> 
                                        <a href="moduloEquipos.jsp">Gestionar equipos</a>
                                    </li>
                                </ul>
                            </li>                            
                            <li>
                                <a href="#"><i class="fas fa-business-time"></i>  Panel operaciones<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a href="moduloOperaciones.jsp">Administrar operación</a>
                                    </li>
                                    <li> 
                                        <a href="moduloAreasZonas.jsp">Administrar áreas y zonas</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a href="#"><i class="fas fa-file-signature"></i>  Panel extras<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a href="moduloRiesgosCriticos.jsp">Visualizar riesgos</a>
                                    </li>
                                    <li> 
                                        <a href="moduloContenidos.jsp">Visualizar contenidos</a>
                                    </li>
                                </ul>
                            </li> 
                            <li>
                                <a href="#"><i class="fas fa-sign-out-alt"></i>  Salir<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a onclick="deslogForm.submit()" style="cursor:pointer;">
                                            <i class="fas fa-sign-out-alt"></i> 
                                            Cerrar sesión
                                        </a>
                                    </li>
                                </ul>
                            </li> 
                        </ul>
                    </div>
                </div>
                <!-- ***** FIN BARRA LATERAL ***** -->
            </nav>

            <!-- ***** INICIO CONTENIDO PÁGINA ***** -->
            <div id="page-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">Bienvenido <%= (String) datosAdm.get(0)%></h1>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item active">Inicio</li>                           
                        </ol>
                    </div>
                    <hr>
                    <div class="col-lg-12">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="main-timeline">
                                        <%
                                            if (((String) listaAvisos.get(0)).equals("null")) {
                                        %>
                                        <h4>¡No hay avisos actualmente!</h4>
                                        <%
                                        } else {
                                            int x = 0;
                                            while (x < listaAvisos.size()) {
                                        %>
                                        <div class="timeline">
                                            <a class="timeline-content">
                                                <%
                                                    switch ((String) listaAvisos.get(x + 4)) {
                                                        case "INFORMATIVO":
                                                %>
                                                <div class="timeline-year"><span><i class="fas fa-info"></i></span></div>
                                                            <%
                                                                    break;
                                                                case "ALERTA":
                                                            %>
                                                <div class="timeline-year"><span><i class="fas fa-exclamation"></i></span></div>
                                                            <%
                                                                    break;
                                                                case "TRABAJO":
                                                            %>
                                                <div class="timeline-year"><span><i class="fas fa-briefcase"></i></span></div>
                                                            <%
                                                                    break;
                                                                case "EDICIÓN":
                                                            %>
                                                <div class="timeline-year"><span><i class="fas fa-wrench"></i></span></div>
                                                            <%
                                                                    break;
                                                                case "OTROS":
                                                            %> 
                                                <div class="timeline-year"><span><i class="fas fa-random"></i></span></div>
                                                            <%
                                                                }
                                                            %>
                                                <h5 class="title"><%= (String) listaAvisos.get(x)%></h5>
                                                <p class="description">
                                                    <%= (String) listaAvisos.get(x + 1)%>
                                                </p>
                                                <hr>
                                                <p class="description">
                                                    <%= (String) listaAvisos.get(x + 3)%><br><%=(String) listaAvisos.get(x + 2)%>
                                                </p>
                                            </a>
                                        </div>
                                        <%
                                                    x = x + 5;
                                                }
                                            }
                                        %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>    

                <hr>
                <hr>
                <br><br>
                <div class="row">
                    <div class="col-lg-12" id="datUsu">
                        <h4>
                            <%= (String) datosAdm.get(0)%>
                        </h4>    
                    </div>
                </div> 
                <div class="row">
                    <div class="col-lg-12" id="datUsu"> 
                        <h5>
                            <%= (String) datosAdm.get(12)%>
                        </h5> 
                    </div>
                </div> 
                <br><br>                   

            </div>
            <!-- ***** FIN CONTENIDO PÁGINA ***** -->

            <!-- ***** INICIO FORMULARIO DESLOG ***** -->
            <form method="post" action="sesionServlet" name="deslogForm" id="deslogForm">
                <input type="hidden" name="opcion" value="deslog">
            </form>
            <!-- ***** FIN FORMULARIO DESLOG ***** -->

        </div>

        <!-- ********** INICIO SCRIPTS ********** -->       
        <!-- QUERY -->
        <script src="js/principal/jquery.js"></script>                      
        <!-- BOOSTSTRAP QUERY -->
        <script src="js/principal/bootstrap.min.js"></script>
        <!-- METIS MENU PROPIAS -->
        <script src="js/principal/metisMenu.js"></script>
        <!-- NAV BAR -->
        <script src="js/principal/navbar.js"></script>
        <!-- ********** FIN SCRIPTS ********** -->

    </body>
</html>
<!-- ***** FIN ADMINISTRADOR ***** -->

<!-- ***** INICIO GENERAL ***** -->
<%        break;
    case "GENERAL":
        ArrayList datosGeneral = (ArrayList) sesion.getAttribute("datosUsuario");
        String nombreGeneral = (String) datosGeneral.get(0);
        String rolGeneral = (String) datosGeneral.get(12);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Panel Principal</title>

        <!-- ********** INICIO ESTILOS ********** --> 
        <!-- BOOSTSTRAP ESTILO -->
        <link rel="stylesheet" href="css/principal/bootstrap.min.css">
        <!-- CSS PANEL -->
        <link rel="stylesheet" href="css/principal/cssPanel.css">
        <!-- METIS MENU -->
        <link rel="stylesheet" href="css/principal/metisMenu.css">
        <!-- ESTILOS PROPIOS - ESTILOS PROPIOS -->
        <link rel="stylesheet" href="css/estilosPropios/propios.css">
        <link rel="stylesheet" href="css/estilosPropios/timeline.css">
        <!-- CND FONTAWESOME -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <!-- ********** FIN ESTILOS ********** --> 

    </head>

    <body>

        <div id="wrapper">

            <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a id="aLogo" class="navbar-brand" href="panelPrincipal.jsp"><img id="imgLogo" src="media/imagenes/logo.png" alt="logoTekonn" /></a>
                </div>

                <!-- ***** INICIO PANEL SUPERIOR ***** -->
                <ul class="nav navbar-top-links navbar-right">
                    <!-- ICONO -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fas fa-angle-right"></i>
                        </a>
                    </li>
                    <!-- ICONO MENU -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fas fa-exclamation"></i>
                        </a>
                    </li>
                    <!-- ICONO ALERTAS -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fa fa-bell fa-fw"></i>
                        </a>
                    </li>
                    <!-- ICONO USUARIO -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fa fa-user fa-fw"></i>
                        </a>
                    </li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fas fa-angle-left"></i>
                        </a>
                    </li>
                </ul>
                <!-- ***** FIN PANEL SUPERIOR ***** -->

                <!-- ***** INICIO BARRA LATERAL ***** -->
                <div class="navbar-default sidebar" role="navigation">
                    <div class="sidebar-nav navbar-collapse">
                        <ul class="nav" id="side-menu">                          
                            <li>
                                <a href="#"><i class="fas fa-users-cog"></i>  Panel usuarios<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a href="moduloUsuarios.jsp">Gestionar usuarios</a>
                                    </li>
                                </ul>
                            </li>                             
                            <li>
                                <a href="#"><i class="fas fa-sign-out-alt"></i>  Salir<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a onclick="deslogForm.submit()" style="cursor:pointer;">
                                            <i class="fas fa-sign-out-alt"></i> 
                                            Cerrar sesión
                                        </a>
                                    </li>
                                </ul>
                            </li> 
                        </ul>
                    </div>
                </div>
                <!-- ***** FIN BARRA LATERAL ***** -->
            </nav>

            <!-- ***** INICIO CONTENIDO PÁGINA ***** -->
            <div id="page-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">Bienvenid@ <%= nombreGeneral%></h1>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item active">Inicio</li>                           
                        </ol>
                    </div>
                    <hr>
                    <div class="col-lg-12">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="main-timeline">
                                        <%
                                            if (((String) listaAvisos.get(0)).equals("null")) {
                                        %>
                                        <h4>¡No hay avisos actualmente!</h4>
                                        <%
                                        } else {
                                            int x2 = 0;
                                            while (x2 < listaAvisos.size()) {
                                        %>
                                        <div class="timeline">
                                            <a class="timeline-content">
                                                <%
                                                    switch ((String) listaAvisos.get(x2 + 4)) {
                                                        case "INFORMATIVO":
                                                %>
                                                <div class="timeline-year"><span><i class="fas fa-info"></i></span></div>
                                                            <%
                                                                    break;
                                                                case "ALERTA":
                                                            %>
                                                <div class="timeline-year"><span><i class="fas fa-exclamation"></i></span></div>
                                                            <%
                                                                    break;
                                                                case "TRABAJO":
                                                            %>
                                                <div class="timeline-year"><span><i class="fas fa-briefcase"></i></span></div>
                                                            <%
                                                                    break;
                                                                case "EDICIÓN":
                                                            %>
                                                <div class="timeline-year"><span><i class="fas fa-wrench"></i></span></div>
                                                            <%
                                                                    break;
                                                                case "OTROS":
                                                            %> 
                                                <div class="timeline-year"><span><i class="fas fa-random"></i></span></div>
                                                            <%
                                                                }
                                                            %>
                                                <h5 class="title"><%= (String) listaAvisos.get(x2)%></h5>
                                                <p class="description">
                                                    <%= (String) listaAvisos.get(x2 + 1)%>
                                                </p>
                                                <hr>
                                                <p class="description">
                                                    <%= (String) listaAvisos.get(x2 + 3)%><br><%=(String) listaAvisos.get(x2 + 2)%>
                                                </p>
                                            </a>
                                        </div>
                                        <%
                                                    x2 = x2 + 5;
                                                }
                                            }
                                        %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> 

                <hr>
                <hr>
                <br><br>
                <div class="row">
                    <div class="col-lg-12" id="datUsu">
                        <h4>
                            <%= (String) datosGeneral.get(0)%>
                        </h4>    
                    </div>
                </div> 
                <div class="row">
                    <div class="col-lg-12" id="datUsu"> 
                        <h5>
                            <%= (String) datosGeneral.get(12)%>
                        </h5> 
                    </div>
                </div> 
                <br><br>  

            </div>
            <!-- ***** FIN CONTENIDO PÁGINA ***** -->

            <!-- ***** INICIO FORMULARIO DESLOG ***** -->
            <form method="post" action="sesionServlet" name="deslogForm" id="deslogForm">
                <input type="hidden" name="opcion" value="deslog">
            </form>
            <!-- ***** FIN FORMULARIO DESLOG ***** -->

        </div>

        <!-- ********** INICIO SCRIPTS ********** -->       
        <!-- QUERY -->
        <script src="js/principal/jquery.js"></script>                      
        <!-- BOOSTSTRAP QUERY -->
        <script src="js/principal/bootstrap.min.js"></script>
        <!-- METIS MENU PROPIAS -->
        <script src="js/principal/metisMenu.js"></script>
        <!-- NAV BAR -->
        <script src="js/principal/navbar.js"></script>
        <!-- ********** FIN SCRIPTS ********** -->

    </body>
</html>
<!-- ***** FIN GENERAL ***** -->

<!-- ***** INICIO SUPERVISOR ****** -->
<%
        break;
    case "SUPERVISOR":
        ArrayList datosSup = (ArrayList) sesion.getAttribute("datosUsuario");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Panel Principal</title>

        <!-- ********** INICIO ESTILOS ********** --> 
        <!-- BOOSTSTRAP ESTILO -->
        <link rel="stylesheet" href="css/principal/bootstrap.min.css">
        <!-- CSS PANEL -->
        <link rel="stylesheet" href="css/principal/cssPanel.css">
        <!-- METIS MENU -->
        <link rel="stylesheet" href="css/principal/metisMenu.css">
        <!-- ESTILOS PROPIOS - ESTILOS PROPIOS -->
        <link rel="stylesheet" href="css/estilosPropios/propios.css">
        <link rel="stylesheet" href="css/estilosPropios/timeline.css">
        <!-- CND FONTAWESOME -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <!-- ********** FIN ESTILOS ********** --> 

    </head>

    <body>

        <div id="wrapper">

            <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a id="aLogo" class="navbar-brand" href="panelPrincipal.jsp"><img id="imgLogo" src="media/imagenes/logo.png" alt="logoTekonn" /></a>
                </div>

                <!-- ***** INICIO PANEL SUPERIOR ***** -->
                <ul class="nav navbar-top-links navbar-right">
                    <!-- ICONO -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fas fa-angle-right"></i>
                        </a>
                    </li>
                    <!-- ICONO MENU -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fas fa-exclamation"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-tasks">
                            <li>
                                <a href="reportarBug.jsp">
                                    <div>
                                        <i class="fas fa-bug"></i> Reportar error                                       
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <!-- ICONO ALERTAS -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fa fa-bell fa-fw"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-alerts">
                            <li>
                                <a href="avisos.jsp">
                                    <div>
                                        <i class="fas fa-comment-alt"></i> Avisos                                        
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <!-- ICONO USUARIO -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fa fa-user fa-fw"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-user">
                            <li>
                                <a href="panelPrincipalDatosCuenta.jsp">
                                    <i class="fas fa-cog"></i> 
                                    Perfil
                                </a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a onclick="deslogForm.submit()" style="cursor:pointer;">
                                    <i class="fas fa-sign-out-alt"></i> 
                                    Cerrar sesión
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fas fa-angle-left"></i>
                        </a>
                    </li>
                </ul>
                <!-- ***** FIN PANEL SUPERIOR ***** -->

                <!-- ***** INICIO BARRA LATERAL ***** -->
                <div class="navbar-default sidebar" role="navigation">
                    <div class="sidebar-nav navbar-collapse">
                        <ul class="nav" id="side-menu">                          
                            <li>
                                <a href="#"><i class="fas fa-users-cog"></i>  Panel usuarios<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li> 
                                        <a href="moduloPersonal.jsp">Gestionar personal</a>
                                    </li>
                                    <li> 
                                        <a href="moduloEquipos.jsp">Gestionar equipos</a>
                                    </li>
                                </ul>
                            </li>                            
                            <li>
                                <a href="#"><i class="fas fa-business-time"></i>  Panel operaciones<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a href="moduloOperaciones.jsp">Administrar operación</a>
                                    </li>
                                    <li> 
                                        <a href="moduloAreasZonas.jsp">Administrar áreas y zonas</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a href="#"><i class="fas fa-file-signature"></i>  Panel extras<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a href="moduloRiesgosCriticos.jsp">Visualizar riesgos</a>
                                    </li>
                                    <li> 
                                        <a href="moduloContenidos.jsp">Visualizar contenidos</a>
                                    </li>
                                </ul>
                            </li> 
                            <li>
                                <a href="#"><i class="fas fa-sign-out-alt"></i>  Salir<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a onclick="deslogForm.submit()" style="cursor:pointer;">
                                            <i class="fas fa-sign-out-alt"></i> 
                                            Cerrar sesión
                                        </a>
                                    </li>
                                </ul>
                            </li> 
                        </ul>
                    </div>
                </div>
                <!-- ***** FIN BARRA LATERAL ***** -->
            </nav>

            <!-- ***** INICIO CONTENIDO PÁGINA ***** -->
            <div id="page-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">Bienvenid@ <%= (String) datosSup.get(0)%></h1>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item active">Inicio</li>                           
                        </ol>
                    </div>
                    <hr>
                    <div class="col-lg-12">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="main-timeline">
                                        <%
                                            if (((String) listaAvisos.get(0)).equals("null")) {
                                        %>
                                        <h4>¡No hay avisos actualmente!</h4>
                                        <%
                                        } else {
                                            int x1 = 0;
                                            while (x1 < listaAvisos.size()) {
                                        %>
                                        <div class="timeline">
                                            <a class="timeline-content">
                                                <%
                                                    switch ((String) listaAvisos.get(x1 + 4)) {
                                                        case "INFORMATIVO":
                                                %>
                                                <div class="timeline-year"><span><i class="fas fa-info"></i></span></div>
                                                            <%
                                                                    break;
                                                                case "ALERTA":
                                                            %>
                                                <div class="timeline-year"><span><i class="fas fa-exclamation"></i></span></div>
                                                            <%
                                                                    break;
                                                                case "TRABAJO":
                                                            %>
                                                <div class="timeline-year"><span><i class="fas fa-briefcase"></i></span></div>
                                                            <%
                                                                    break;
                                                                case "EDICIÓN":
                                                            %>
                                                <div class="timeline-year"><span><i class="fas fa-wrench"></i></span></div>
                                                            <%
                                                                    break;
                                                                case "OTROS":
                                                            %> 
                                                <div class="timeline-year"><span><i class="fas fa-random"></i></span></div>
                                                            <%
                                                                }
                                                            %>
                                                <h5 class="title"><%= (String) listaAvisos.get(x1)%></h5>
                                                <p class="description">
                                                    <%= (String) listaAvisos.get(x1 + 1)%>
                                                </p>
                                                <hr>
                                                <p class="description">
                                                    <%= (String) listaAvisos.get(x1 + 3)%><br><%=(String) listaAvisos.get(x1 + 2)%>
                                                </p>
                                            </a>
                                        </div>
                                        <%
                                                    x1 = x1 + 5;
                                                }
                                            }
                                        %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>                   
                </div> 
                <hr>
                <hr>
                <br><br>
                <div class="row">
                    <div class="col-lg-12" id="datUsu">
                        <h4>
                            <%= (String) datosSup.get(0)%>
                        </h4>    
                    </div>
                </div> 
                <div class="row">
                    <div class="col-lg-12" id="datUsu"> 
                        <h5>
                            <%= (String) datosSup.get(12)%>
                        </h5> 
                    </div>
                </div> 
                <br><br>                     

            </div>
            <!-- ***** FIN CONTENIDO PÁGINA ***** -->

            <!-- ***** INICIO FORMULARIO DESLOG ***** -->
            <form method="post" action="sesionServlet" name="deslogForm" id="deslogForm">
                <input type="hidden" name="opcion" value="deslog">
            </form>
            <!-- ***** FIN FORMULARIO DESLOG ***** -->

        </div>

        <!-- ********** INICIO SCRIPTS ********** -->       
        <!-- QUERY -->
        <script src="js/principal/jquery.js"></script>                      
        <!-- BOOSTSTRAP QUERY -->
        <script src="js/principal/bootstrap.min.js"></script>
        <!-- METIS MENU PROPIAS -->
        <script src="js/principal/metisMenu.js"></script>
        <!-- NAV BAR -->
        <script src="js/principal/navbar.js"></script>
        <!-- ********** FIN SCRIPTS ********** -->

    </body>
</html>
<!-- ***** FIN ADMINISTRADOR ***** -->

<!-- ***** INICIO CAPATAZ **** -->
<%
        break;
    case "CAPATAZ":
        ArrayList datosCapa = (ArrayList) sesion.getAttribute("datosUsuario");
        String nombreCapa = (String) datosCapa.get(0);
        String rolCapa = (String) datosCapa.get(12);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Panel Principal</title>

        <!-- ********** INICIO ESTILOS ********** --> 
        <!-- BOOSTSTRAP ESTILO -->
        <link rel="stylesheet" href="css/principal/bootstrap.min.css">
        <!-- CSS PANEL -->
        <link rel="stylesheet" href="css/principal/cssPanel.css">
        <!-- METIS MENU -->
        <link rel="stylesheet" href="css/principal/metisMenu.css">
        <!-- ESTILOS PROPIOS - ESTILOS PROPIOS -->
        <link rel="stylesheet" href="css/estilosPropios/propios.css">
        <link rel="stylesheet" href="css/estilosPropios/timeline.css">
        <!-- CND FONTAWESOME -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <!-- ********** FIN ESTILOS ********** --> 

    </head>

    <body>

        <div id="wrapper">

            <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a id="aLogo" class="navbar-brand" href="panelPrincipal.jsp"><img id="imgLogo" src="media/imagenes/logo.png" alt="logoTekonn" /></a>
                </div>

                <!-- ***** INICIO PANEL SUPERIOR ***** -->
                <ul class="nav navbar-top-links navbar-right">
                    <!-- ICONO -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fas fa-angle-right"></i>
                        </a>
                    </li>
                    <!-- ICONO MENU -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fas fa-exclamation"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-tasks">
                            <li>
                                <a href="reportarBug.jsp">
                                    <div>
                                        <i class="fas fa-bug"></i> Reportar error                                       
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <!-- ICONO ALERTAS -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fa fa-bell fa-fw"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-alerts">
                            <li>
                                <a href="avisos.jsp">
                                    <div>
                                        <i class="fas fa-comment-alt"></i> Avisos                                        
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <!-- ICONO USUARIO -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fa fa-user fa-fw"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-user">
                            <li>
                                <a href="panelPrincipalDatosCuenta.jsp">
                                    <i class="fas fa-cog"></i> 
                                    Perfil
                                </a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a onclick="deslogForm.submit()" style="cursor:pointer;">
                                    <i class="fas fa-sign-out-alt"></i> 
                                    Cerrar sesión
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fas fa-angle-left"></i>
                        </a>
                    </li>
                </ul>
                <!-- ***** FIN PANEL SUPERIOR ***** -->

                <!-- ***** INICIO BARRA LATERAL ***** -->
                <div class="navbar-default sidebar" role="navigation">
                    <div class="sidebar-nav navbar-collapse">
                        <ul class="nav" id="side-menu">                                                    
                            <li>
                                <a href="#"><i class="fas fa-business-time"></i>  Panel operaciones<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a href="moduloOperaciones.jsp">Administrar operación</a>
                                    </li>                                  
                                </ul>
                            </li>
                            <li>
                                <a href="#"><i class="fas fa-file-signature"></i>  Panel extras<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a href="moduloRiesgosCriticos.jsp">Visualizar riesgos</a>
                                    </li>
                                    <li>
                                        <a href="visualizarTrabajador.jsp">Visualizar equipos</a>
                                    </li>
                                    <li> 
                                        <a href="moduloContenidos.jsp">Visualizar contenidos</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a href="#"><i class="fas fa-sign-out-alt"></i>  Salir<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a onclick="deslogForm.submit()" style="cursor:pointer;">
                                            <i class="fas fa-sign-out-alt"></i> 
                                            Cerrar sesión
                                        </a>
                                    </li>
                                </ul>
                            </li> 
                        </ul>
                    </div>
                </div>
                <!-- ***** FIN BARRA LATERAL ***** -->
            </nav>

            <!-- ***** INICIO CONTENIDO PÁGINA ***** -->
            <div id="page-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">Bienvenid@ <%= (String) datosCapa.get(0)%></h1>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item active">Inicio</li>                           
                        </ol>
                    </div>
                    <hr>
                    <div class="col-lg-12">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="main-timeline">
                                        <%
                                            if (((String) listaAvisos.get(0)).equals("null")) {
                                        %>
                                        <h4>¡No hay avisos actualmente!</h4>
                                        <%
                                        } else {
                                            int x3 = 0;
                                            while (x3 < listaAvisos.size()) {
                                        %>
                                        <div class="timeline">
                                            <a class="timeline-content">
                                                <%
                                                    switch ((String) listaAvisos.get(x3 + 4)) {
                                                        case "INFORMATIVO":
                                                %>
                                                <div class="timeline-year"><span><i class="fas fa-info"></i></span></div>
                                                            <%
                                                                    break;
                                                                case "ALERTA":
                                                            %>
                                                <div class="timeline-year"><span><i class="fas fa-exclamation"></i></span></div>
                                                            <%
                                                                    break;
                                                                case "TRABAJO":
                                                            %>
                                                <div class="timeline-year"><span><i class="fas fa-briefcase"></i></span></div>
                                                            <%
                                                                    break;
                                                                case "EDICIÓN":
                                                            %>
                                                <div class="timeline-year"><span><i class="fas fa-wrench"></i></span></div>
                                                            <%
                                                                    break;
                                                                case "OTROS":
                                                            %> 
                                                <div class="timeline-year"><span><i class="fas fa-random"></i></span></div>
                                                            <%
                                                                }
                                                            %>
                                                <h5 class="title"><%= (String) listaAvisos.get(x3)%></h5>
                                                <p class="description">
                                                    <%= (String) listaAvisos.get(x3 + 1)%>
                                                </p>
                                                <hr>
                                                <p class="description">
                                                    <%= (String) listaAvisos.get(x3 + 3)%><br><%=(String) listaAvisos.get(x3 + 2)%>
                                                </p>
                                            </a>
                                        </div>
                                        <%
                                                    x3 = x3 + 5;
                                                }
                                            }
                                        %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>                   
                </div>  
                <hr>
                <hr>
                <br><br>
                <div class="row">
                    <div class="col-lg-12" id="datUsu">
                        <h4>
                            <%= (String) datosCapa.get(0)%>
                        </h4>    
                    </div>
                </div> 
                <div class="row">
                    <div class="col-lg-12" id="datUsu"> 
                        <h5>
                            <%= (String) datosCapa.get(12)%>
                        </h5> 
                    </div>
                </div> 
                <br><br>  

            </div>
            <!-- ***** FIN CONTENIDO PÁGINA ***** -->

            <!-- ***** INICIO FORMULARIO DESLOG ***** -->
            <form method="post" action="sesionServlet" name="deslogForm" id="deslogForm">
                <input type="hidden" name="opcion" value="deslog">
            </form>
            <!-- ***** FIN FORMULARIO DESLOG ***** -->

        </div>

        <!-- ********** INICIO SCRIPTS ********** -->       
        <!-- QUERY -->
        <script src="js/principal/jquery.js"></script>                      
        <!-- BOOSTSTRAP QUERY -->
        <script src="js/principal/bootstrap.min.js"></script>
        <!-- METIS MENU PROPIAS -->
        <script src="js/principal/metisMenu.js"></script>
        <!-- NAV BAR -->
        <script src="js/principal/navbar.js"></script>
        <!-- ********** FIN SCRIPTS ********** -->

    </body>
</html>
<!-- ***** FIN CAPATAZ ***** --> 

<!-- ***** INICIO TRABAJADOR ***** -->
<%
        break;
    case "TRABAJADOR":
        ArrayList datosTra = (ArrayList) sesion.getAttribute("datosUsuario");
        String nombreTra = (String) datosTra.get(0);
        String rolTra = (String) datosTra.get(12);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Panel Principal</title>

        <!-- ********** INICIO ESTILOS ********** --> 
        <!-- BOOSTSTRAP ESTILO -->
        <link rel="stylesheet" href="css/principal/bootstrap.min.css">
        <!-- CSS PANEL -->
        <link rel="stylesheet" href="css/principal/cssPanel.css">
        <!-- METIS MENU -->
        <link rel="stylesheet" href="css/principal/metisMenu.css">
        <!-- ESTILOS PROPIOS - ESTILOS PROPIOS -->
        <link rel="stylesheet" href="css/estilosPropios/propios.css">
        <link rel="stylesheet" href="css/estilosPropios/timeline.css">
        <!-- CND FONTAWESOME -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <!-- ********** FIN ESTILOS ********** --> 

    </head>

    <body>

        <div id="wrapper">

            <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a id="aLogo" class="navbar-brand" href="panelPrincipal.jsp"><img id="imgLogo" src="media/imagenes/logo.png" alt="logoTekonn" /></a>
                </div>

                <!-- ***** INICIO PANEL SUPERIOR ***** -->
                <ul class="nav navbar-top-links navbar-right">
                    <!-- ICONO -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fas fa-angle-right"></i>
                        </a>
                    </li>
                    <!-- ICONO MENU -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fas fa-exclamation"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-tasks">
                            <li>
                                <a href="reportarBug.jsp">
                                    <div>
                                        <i class="fas fa-bug"></i> Reportar error                                       
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <!-- ICONO ALERTAS -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fa fa-bell fa-fw"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-alerts">
                            <li>
                                <a href="avisos.jsp">
                                    <div>
                                        <i class="fas fa-comment-alt"></i> Avisos                                        
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <!-- ICONO USUARIO -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fa fa-user fa-fw"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-user">
                            <li>
                                <a href="panelPrincipalDatosCuenta.jsp">
                                    <i class="fas fa-cog"></i> 
                                    Perfil
                                </a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a onclick="deslogForm.submit()" style="cursor:pointer;">
                                    <i class="fas fa-sign-out-alt"></i> 
                                    Cerrar sesión
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fas fa-angle-left"></i>
                        </a>
                    </li>
                </ul>
                <!-- ***** FIN PANEL SUPERIOR ***** -->

                <!-- ***** INICIO BARRA LATERAL ***** -->
                <div class="navbar-default sidebar" role="navigation">
                    <div class="sidebar-nav navbar-collapse">
                        <ul class="nav" id="side-menu">                                                   
                            <li>
                                <a href="#"><i class="fas fa-file-signature"></i>  Panel extras<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a href="moduloRiesgosCriticos.jsp">Visualizar riesgos</a>
                                    </li>
                                    <li>
                                        <a href="visualizarTrabajador.jsp">Visualizar operaciones/equipos</a>
                                    </li>
                                    <li> 
                                        <a href="moduloContenidos.jsp">Visualizar contenidos</a>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <a href="#"><i class="fas fa-sign-out-alt"></i>  Salir<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a onclick="deslogForm.submit()" style="cursor:pointer;">
                                            <i class="fas fa-sign-out-alt"></i> 
                                            Cerrar sesión
                                        </a>
                                    </li>
                                </ul>
                            </li> 
                        </ul>
                    </div>
                </div>
                <!-- ***** FIN BARRA LATERAL ***** -->
            </nav>

            <!-- ***** INICIO CONTENIDO PÁGINA ***** -->
            <div id="page-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">Bienvenid@ <%= (String) datosTra.get(0)%></h1>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item active">Inicio</li>                           
                        </ol>
                    </div>
                    <hr>
                    <div class="col-lg-12">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="main-timeline">
                                        <%
                                            if (((String) listaAvisos.get(0)).equals("null")) {
                                        %>
                                        <h4>¡No hay avisos actualmente!</h4>
                                        <%
                                        } else {
                                            int x4 = 0;
                                            while (x4 < listaAvisos.size()) {
                                        %>
                                        <div class="timeline">
                                            <a class="timeline-content">
                                                <%
                                                    switch ((String) listaAvisos.get(x4 + 4)) {
                                                        case "INFORMATIVO":
                                                %>
                                                <div class="timeline-year"><span><i class="fas fa-info"></i></span></div>
                                                            <%
                                                                    break;
                                                                case "ALERTA":
                                                            %>
                                                <div class="timeline-year"><span><i class="fas fa-exclamation"></i></span></div>
                                                            <%
                                                                    break;
                                                                case "TRABAJO":
                                                            %>
                                                <div class="timeline-year"><span><i class="fas fa-briefcase"></i></span></div>
                                                            <%
                                                                    break;
                                                                case "EDICIÓN":
                                                            %>
                                                <div class="timeline-year"><span><i class="fas fa-wrench"></i></span></div>
                                                            <%
                                                                    break;
                                                                case "OTROS":
                                                            %> 
                                                <div class="timeline-year"><span><i class="fas fa-random"></i></span></div>
                                                            <%
                                                                }
                                                            %>
                                                <h5 class="title"><%= (String) listaAvisos.get(x4)%></h5>
                                                <p class="description">
                                                    <%= (String) listaAvisos.get(x4 + 1)%>
                                                </p>
                                                <hr>
                                                <p class="description">
                                                    <%= (String) listaAvisos.get(x4 + 3)%><br><%=(String) listaAvisos.get(x4 + 2)%>
                                                </p>
                                            </a>
                                        </div>
                                        <%
                                                    x4 = x4 + 5;
                                                }
                                            }
                                        %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>                   
                </div> 
                <hr>
                <hr>
                <br><br>
                <div class="row">
                    <div class="col-lg-12" id="datUsu">
                        <h4>
                            <%= (String) datosTra.get(0)%>
                        </h4>    
                    </div>
                </div> 
                <div class="row">
                    <div class="col-lg-12" id="datUsu"> 
                        <h5>
                            <%= (String) datosTra.get(12)%>
                        </h5> 
                    </div>
                </div> 
                <br><br>  

            </div>
            <!-- ***** FIN CONTENIDO PÁGINA ***** -->

            <!-- ***** INICIO FORMULARIO DESLOG ***** -->
            <form method="post" action="sesionServlet" name="deslogForm" id="deslogForm">
                <input type="hidden" name="opcion" value="deslog">
            </form>
            <!-- ***** FIN FORMULARIO DESLOG ***** -->

        </div>

        <!-- ********** INICIO SCRIPTS ********** -->       
        <!-- QUERY -->
        <script src="js/principal/jquery.js"></script>                      
        <!-- BOOSTSTRAP QUERY -->
        <script src="js/principal/bootstrap.min.js"></script>
        <!-- METIS MENU PROPIAS -->
        <script src="js/principal/metisMenu.js"></script>
        <!-- NAV BAR -->
        <script src="js/principal/navbar.js"></script>
        <!-- ********** FIN SCRIPTS ********** -->

    </body>
</html>
<!-- ***** FIN TRABAJADOR ***** -->
<%
                break;
            default:
                request.getRequestDispatcher("index.jsp").forward(request, response);
                break;
        }

    } else {
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
%>