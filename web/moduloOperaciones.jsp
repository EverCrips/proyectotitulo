<!--
    *Diseñado y programado por Cristopher Pérez V.
    *Sistema Tekonn 2019
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%
    //SE OBTIENE LA SESION
    HttpSession sesion = request.getSession(false);
    String rolUs = (String) sesion.getAttribute("rolUs");
%>

<%
    //PRIMERO SE VALIDA QUE EL ROL SEA DISTINTO A NULL (SI ES NULL, NO HAY SESION ACTIVA)   
    if (rolUs != null) {
        if (rolUs.equals("ADMINISTRADOR") || rolUs.equals("SUPERVISOR") || rolUs.equals("CAPATAZ")) {

            ArrayList datosAdm = (ArrayList) sesion.getAttribute("datosUsuario");
            ArrayList datosOperacionesCapataz = (ArrayList) sesion.getAttribute("datosOperacionesCapataz");
            ArrayList datosOperacionesGeneral = (ArrayList) sesion.getAttribute("datosOperacionesGeneral");
            ArrayList datosZonasOperacion = (ArrayList) sesion.getAttribute("datosZonasOperacion");

            int cantOpeEnMarchaCapataz=0, cantOpeFinalizadaCapataz=0, cantOpeRechazadaCapataz=0, cantOpePendienteCapataz=0, cantOpeEnMarcha=0, cantOpeFinalizada=0, cantOpeRechazada=0, cantOpePendiente=0;
            if (rolUs.equals("CAPATAZ")) {
                cantOpeEnMarchaCapataz = (int) sesion.getAttribute("cantOpeEnMarchaCapataz");
                cantOpeFinalizadaCapataz = (int) sesion.getAttribute("cantOpeFinalizadaCapataz");
                cantOpeRechazadaCapataz = (int) sesion.getAttribute("cantOpeRechazadaCapataz");
                cantOpePendienteCapataz = (int) sesion.getAttribute("cantOpePendienteCapataz");
            } else {
                cantOpeEnMarcha = (int) sesion.getAttribute("cantOpeEnMarcha");
                cantOpeFinalizada = (int) sesion.getAttribute("cantOpeFinalizada");
                cantOpeRechazada = (int) sesion.getAttribute("cantOpeRechazada");
                cantOpePendiente = (int) sesion.getAttribute("cantOpePendiente");
            }

            //MANEJO DE ERROES
            String msjAlertGreen = (String) request.getAttribute("msjAlertGreen");
            String msjAlertRed = (String) request.getAttribute("msjAlertRed");
            String msjModalShow = (String) request.getAttribute("msjModalShow");

            String msjAlertStyleGreen = "";
            String msjAlertStyleRed = "";
            int opcionModalShowJs = 0;

            if (msjModalShow != null) {
                opcionModalShowJs = 1;
            }

            if (msjAlertGreen != null) {
                msjAlertStyleGreen = "display:block;";
            } else {
                msjAlertStyleGreen = "display:none;";
            }

            if (msjAlertRed != null) {
                msjAlertStyleRed = "display:block;";
            } else {
                msjAlertStyleRed = "display:none;";
            }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Panel operaciones</title>

        <!-- ********** INICIO ESTILOS ********** --> 
        <!-- BOOSTSTRAP ESTILO -->
        <link rel="stylesheet" href="css/principal/bootstrap.min.css">
        <!-- CSS PANEL -->
        <link rel="stylesheet" href="css/principal/cssPanel.css">
        <!-- METIS MENU -->
        <link rel="stylesheet" href="css/principal/metisMenu.css">
        <!-- TABLE -->
        <link rel="stylesheet" type="text/css" href="css/principal/datatables.min.css"/>
        <!-- ESTILOS PROPIOS - ESTILOS PROPIOS -->
        <link rel="stylesheet" href="css/estilosPropios/propios.css">        
        <!-- CND FONTAWESOME -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <!-- ********** FIN ESTILOS ********** --> 

    </head>
    <body onload="ejecutarModalFun()">

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
                <% switch (rolUs) {
                        case "ADMINISTRADOR":
                %>
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
                                <a href="#">
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
                <% break;
                    case "SUPERVISOR":
                %>
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
                <% break;
                    case "CAPATAZ":
                %>
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
                <% break;
                    }
                %>
                <!-- ***** FIN BARRA LATERAL ***** -->
            </nav>

            <!-- ***** INICIO CONTENIDO PÁGINA ***** -->
            <div id="page-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">Bienvenido al panel de operaciones</h1>                       
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="panelPrincipal.jsp">Inicio</a>
                            </li>
                            <li class="breadcrumb-item active">Panel operaciones - Gestión operación</li>
                        </ol>
                    </div>
                </div>

                <!-- INICIO CABECERA PANEL USUARIO -->
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-6 col-xl-6">
                        <div class="panel panel-green">
                            <div class="panel-heading">
                                Panel de operación, ¡RMS!
                            </div>
                            <div class="panel-body">
                                <ul style="list-style-type:circle;">
                                    <li>Creación RMS</li>
                                    <li>Visualización RMS</li>
                                    <li>Descargar RMS</li>
                                </ul>
                            </div>
                            <div class="panel-footer">
                                Tekonn Ltda.
                            </div>
                        </div>
                        <!-- /.col-lg-4 -->
                    </div>
                    <%
                        if (rolUs.equals("CAPATAZ")) {
                    %>
                    <div class="col-xs-12 col-sm-12 col-md-6 col-xl-6">
                        <div class="panel panel-green">
                            <div class="panel-heading">
                                Gráfico dinámico
                            </div>
                            <div class="panel-body" id="containerCharOpeCapa">

                            </div>
                            <div class="panel-footer">
                                Tekonn Ltda.
                            </div>
                        </div>
                        <!-- /.col-lg-4 -->
                    </div>
                    <%
                    } else {
                    %>
                    <div class="col-xs-12 col-sm-12 col-md-6 col-xl-6">
                        <div class="panel panel-green">
                            <div class="panel-heading">
                                Gráfico dinámico
                            </div>
                            <div class="panel-body" id="containerCharOpe">

                            </div>
                            <div class="panel-footer">
                                Tekonn Ltda.
                            </div>
                        </div>
                        <!-- /.col-lg-4 -->
                    </div>
                    <%
                        }
                    %>
                    <!-- CABECERA AUXILIAR 
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-red">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-support fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">13</div>
                                        <div>Support Tickets!</div>
                                    </div>
                                </div>
                            </div>
                            <a href="#">
                                <div class="panel-footer">
                                    <span class="pull-left">View Details</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div> -->
                </div>
                <!-- ***** FIN CABECERA PANEL USUARIO ***** -->
                <hr>
                <hr>                
                <!-- ***** INICIO FORMULARIO MODIFICAR DATOS ***** -->
                <div class="row">
                    <!-- ***** INICIO PANEL CENTRAL ***** -->
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <i class="fas fa-users"></i>  Operaciones RMS
                                <div class="pull-right">
                                    <div class="btn-group">
                                    </div>
                                </div>
                                <%
                                    if (rolUs.equals("CAPATAZ")) {
                                %>
                                <i class="fas fa-file-alt" id="icoAddUs" data-toggle="modal" data-target="#modalNuevoRMS" title="Crear nueva operación"></i>
                                <%
                                    }
                                %>
                            </div>
                            <div class="panel-body datosCuenta">                              
                                <div class="table-wrapper">
                                    <div class="table-title">
                                    </div>
                                    <div class="table-responsive">
                                        <table class="table table-striped table-hover" id="UsuariosActivos" style="width:100%;">
                                            <thead>
                                                <tr>
                                                    <th>Número operación</th>
                                                    <th>Nombre</th>
                                                    <th>Descripción</th>
                                                    <th>Fecha inicio</th>
                                                    <th>Fecha término</th>
                                                    <th>Estado</th>
                                                    <th>Acciones</th>
                                                </tr>
                                            </thead>
                                            <%
                                                if (rolUs.equals("CAPATAZ")) {
                                            %>
                                            <tbody>
                                                <%
                                                    if (datosOperacionesCapataz.get(0) == "null") {
                                                %>
                                                <tr>
                                                    <td style="display:none;"></td>
                                                </tr>                                    
                                                <%
                                                } else {
                                                    int i = 0,
                                                            aux = 1;
                                                    while (i < datosOperacionesCapataz.size()) {
                                                %>
                                                <tr>                                                               
                                                    <td><%=((String) datosOperacionesCapataz.get(i)).trim()%></td>
                                                    <td><%=((String) datosOperacionesCapataz.get(i + 1)).trim()%></td>
                                                    <td><%=((String) datosOperacionesCapataz.get(i + 2)).trim()%></td>
                                                    <td><%=((String) datosOperacionesCapataz.get(i + 3)).trim()%></td>
                                                    <td><%=((String) datosOperacionesCapataz.get(i + 4)).trim()%></td>
                                                    <td><%=((String) datosOperacionesCapataz.get(i + 5)).trim()%></td>
                                                    <td>
                                                        <%
                                                            switch ((String) datosOperacionesCapataz.get(i + 5)) {
                                                                case "EN MARCHA":
                                                        %>
                                                        <a class="descaPlanOpe" title="Visualizar Rms" style="cursor:pointer;">
                                                            <i class="fas fa-file-pdf"></i> 
                                                        </a>                                                        
                                                        <a href="#modalCerrarOperacion" data-toggle="modal" title="Cerrar operación" class="closeOpeTable">
                                                            <i class="fas fa-lock"></i> 
                                                        </a>
                                                        <%
                                                                break;
                                                            case "PENDIENTE":
                                                        %>
                                                        <a href="#modalAceptarOperacion" data-toggle="modal" title="Aceptar operación" class="aceptOpeTable">
                                                            <i class="fas fa-check-square"></i> 
                                                        </a>
                                                        <a href="#modalCancelarOperacion" data-toggle="modal" title="Rechazar operación" class="cancelOpeTable">
                                                            <i class="fas fa-window-close"></i> 
                                                        </a>
                                                        <a class="editRMSTable" title="Editar Rms" style="cursor:pointer;">
                                                            <i class="fas fa-edit"></i>
                                                        </a> 
                                                        <%
                                                                break;
                                                            default:
                                                        %>
                                                        <a class="descaPlanOpe" title="Visualizar Rms" style="cursor:pointer;">
                                                            <i class="fas fa-file-pdf"></i> 
                                                        </a>
                                                        <%
                                                                    break;
                                                            }
                                                        %>
                                                    </td>
                                                </tr> 
                                                <%
                                                            i = i + 6;
                                                            aux++;
                                                        }
                                                    }
                                                %>
                                            </tbody>
                                            <%
                                            } else {
                                            %>
                                            <tbody>
                                                <%
                                                    if (datosOperacionesGeneral.get(0) == "null") {
                                                %>
                                                <tr>
                                                    <td style="display:none;"></td>
                                                </tr>                                    
                                                <%
                                                } else {
                                                    int i = 0,
                                                            aux = 1;
                                                    while (i < datosOperacionesGeneral.size()) {
                                                %>
                                                <tr>                                                               
                                                    <td><%=((String) datosOperacionesGeneral.get(i)).trim()%></td>
                                                    <td><%=((String) datosOperacionesGeneral.get(i + 1)).trim()%></td>
                                                    <td><%=((String) datosOperacionesGeneral.get(i + 2)).trim()%></td>
                                                    <td><%=((String) datosOperacionesGeneral.get(i + 3)).trim()%></td>
                                                    <td><%=((String) datosOperacionesGeneral.get(i + 4)).trim()%></td>
                                                    <td><%=((String) datosOperacionesGeneral.get(i + 5)).trim()%></td>
                                                    <td>                                                       
                                                        <a class="descaPlanOpe" title="Visualizar Rms" style="cursor:pointer;">
                                                            <i class="fas fa-file-pdf"></i> 
                                                        </a>
                                                    </td>
                                                </tr> 
                                                <%
                                                            i = i + 6;
                                                            aux++;
                                                        }
                                                    }
                                                %>
                                            </tbody>
                                            <%
                                                }
                                            %>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- PANEL CENTRAL AUXILIAR 
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <i class="fa fa-bar-chart-o fa-fw"></i> Bar Chart Example
                                <div class="pull-right">
                                    <div class="btn-group">
                                    </div>
                                </div>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-4">

                                    </div>
                                    <div class="col-lg-8">
                                        <div id="morris-bar-chart"></div>
                                    </div>
                                </div>
                            </div>
                        </div>  -->    
                    </div>
                    <!-- ***** FIN PANEL CENTRAL ***** -->

                </div>
                <!-- ***** FIN FORMULARIO MODIFICAR DATOS ***** -->
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
        </div>

        <!-- INICIO MODAL NUEVA OPERACIÓN -->
        <div class="modal fade" id="modalNuevoRMS" tabindex="-1" role="dialog" aria-labelledby="modalNuevoRMS" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form method="post" action="servletPO" class="datosCuenta">
                        <div class="modal-header">
                            <img id="imgLogo" src="media/imagenes/logo.png" alt="logoTekonn" />
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h4>Registrar nueva operación</h4>
                                        </div>
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-lg-12">

                                                    <!-- DATOS 1 -->                               
                                                    <div class="row ">                                    
                                                        <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                            <label>Nombre operación</label>
                                                            <input id="nombreOperacion" name="nombreOperacion" type="text" class="form-control" required>
                                                        </div>
                                                        <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                            <label>Zona de operación</label>
                                                            <%
                                                                if (datosZonasOperacion.get(0) == "null") {
                                                                    //POR DEFECTO CARGOS
                                                            %>
                                                            <label>Lider del equipo</label>
                                                            <select id="zonaOperacion" name="zonaOperacion" class="form-control">
                                                                <option value="1">Interior zona norte</option>
                                                                <option value="2">Interior zona sur</option>
                                                                <option value="3">Interior zona este</option>
                                                                <option value="4">Interior zona oeste</option>
                                                            </select>
                                                            <%
                                                            } else {
                                                            %>
                                                            <select id="zonaOperacion" name="zonaOperacion" class="form-control">
                                                                <%
                                                                    int aux = 0;
                                                                    while (aux < datosZonasOperacion.size()) {
                                                                %>
                                                                <option value="<%=((String) datosZonasOperacion.get(aux)).trim()%>"><%=((String) datosZonasOperacion.get(aux + 1)).trim()%></option>

                                                                <%
                                                                            aux = aux + 2;
                                                                        }
                                                                    }
                                                                %>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <hr>
                                                    <!-- DATOS 2 -->                               
                                                    <div class="row ">                                    
                                                        <div class="col-xs-12 col-sm-12 col-md-12 col-xl-12 paddingDiv">
                                                            <textarea class="form-control" name="descripcionOperacion" rows="7" required="" placeholder="Descripción de la operación..."></textarea>                
                                                        </div>
                                                    </div>
                                                    <hr>                                               
                                                </div>
                                            </div>
                                        </div>
                                    </div>                                   
                                </div>
                            </div>
                            <input type="hidden" name="opcion" value="crearOperacion">
                            <input type="hidden" name="emailUs" value="<%= (String) datosAdm.get(3)%>">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Salir</button>
                            <button type="submit" class="btn btn-primary">Registrar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- FIN MODAL NUEVO OPERACIÓN -->

        <!-- INICIO MODAL CERRAR OPERACIÓN -->
        <div id="modalCerrarOperacion" class="modal fade">
            <div class="modal-dialog" id="meu" style="max-width: 400px;">
                <div class="modal-content">
                    <form method="post" action="servletPO" class="datosCuenta">
                        <div class="modal-header">						
                            <img id="imgLogo" src="media/imagenes/logo.png" alt="logoTekonn" />
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="container-fluid">
                                <p>¿Está seguro que desea finalizar la operación?</p>
                                <br>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">                                              
                                        <input type="text"  class="form-control" id="nombreOperacionCerrar" disabled="" />
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">                                               
                                        <textarea class="form-control" name="observacionesCerrarOperacion" rows="4" placeholder="Detallar observaciones..." required=""></textarea>
                                    </div>
                                </div>
                                <br>
                                <br>  
                                <p class="text-warning"><small>Esta acción no se puede deshacer</small></p>
                            </div>                                                                  
                        </div>
                        <input type="hidden" name="codigoCerrarOperacion" id="codigoCerrarOperacion"/>
                        <input type="hidden" name="emailUs2" value="<%= (String) datosAdm.get(3)%>">
                        <input type="hidden" name="opcion" value="cerrarOperacion">
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Salir">
                            <input type="submit" class="btn btn-danger" value="Aceptar">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- FIN MODAL CERRAR OPERACIÓN -->

        <!-- INICIO MODAL ACEPTAR OPERACIÓN -->
        <div id="modalAceptarOperacion" class="modal fade">
            <div class="modal-dialog" id="meu" style="max-width: 400px;">
                <div class="modal-content">
                    <form method="post" action="servletPO" class="datosCuenta">
                        <div class="modal-header">						
                            <img id="imgLogo" src="media/imagenes/logo.png" alt="logoTekonn" />
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="container-fluid">
                                <p>¿Está seguro que desea aceptar la operación?</p>
                                <br>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">                                              
                                        <input type="text"  class="form-control" id="nombreOperacionAceptar" disabled="" />
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">                                               
                                        <textarea class="form-control" name="observacionesAceptarOperacion" rows="4" placeholder="Detallar observaciones..." required=""></textarea>
                                    </div>
                                </div>
                                <br>
                                <br>  
                                <p class="text-warning"><small>Esta acción no se puede deshacer</small></p>
                            </div>                                                                  
                        </div>
                        <input type="hidden" name="codigoAceptarOperacion" id="codigoAceptarOperacion"/>
                        <input type="hidden" name="emailUs3" value="<%= (String) datosAdm.get(3)%>">
                        <input type="hidden" name="opcion" value="aceptarOperacion">
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Salir">
                            <input type="submit" class="btn btn-danger" value="Aceptar">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- FIN MODAL ACEPTAR OPERACIÓN -->

        <!-- INICIO MODAL CANCELAR OPERACIÓN -->
        <div id="modalCancelarOperacion" class="modal fade">
            <div class="modal-dialog" id="meu" style="max-width: 400px;">
                <div class="modal-content">
                    <form method="post" action="servletPO" class="datosCuenta">
                        <div class="modal-header">						
                            <img id="imgLogo" src="media/imagenes/logo.png" alt="logoTekonn" />
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="container-fluid">
                                <p>¿Está seguro que desea rechazar la operación?</p>
                                <br>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">                                              
                                        <input type="text"  class="form-control" id="nombreOperacionRechazar" disabled="" />
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">                                               
                                        <textarea class="form-control" name="observacionesRechazarOperacion" rows="4" placeholder="Detallar observaciones..." required=""></textarea>
                                    </div>
                                </div>
                                <br>
                                <br>  
                                <p class="text-warning"><small>Esta acción no se puede deshacer</small></p>
                            </div>                                                                  
                        </div>
                        <input type="hidden" name="codigoRechazarOperacion" id="codigoRechazarOperacion"/>
                        <input type="hidden" name="emailUs4" value="<%= (String) datosAdm.get(3)%>">
                        <input type="hidden" name="opcion" value="rechazarOperacion">
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Salir">
                            <input type="submit" class="btn btn-danger" value="Aceptar">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- FIN MODAL CANCELAR OPERACIÓN -->
        
        <input type="hidden" name="modalShowJs" value="<%=opcionModalShowJs%>" id="modalShowJs">
        <!-- INICIO DIV AVISOS EXITO ERROR -->
        <div id="modalExitoError" class="modal fade">
            <div class="modal-dialog" id="meu" style="max-width: 400px;">
                <div class="modal-content">                    
                    <div class="modal-header">
                        <img id="imgLogo" src="media/imagenes/logo.png" alt="logoTekonn" />
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <!-- ERROR - ÉXITO -->
                                                <div id="msjAlert" class="alert alert-success" style="<%=msjAlertStyleGreen%>">
                                                    <i class="fa fa-check-circle"></i> <%=msjAlertGreen%>
                                                </div>
                                                <div id="msjAlert" class="alert alert-danger" style="<%=msjAlertStyleRed%>">
                                                    <i class="fas fa-times-circle"></i> <%=msjAlertRed%>
                                                </div> 
                                            </div>
                                        </div>
                                    </div>
                                </div> 
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">Aceptar</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- FIN DIV AVISOS EXITO ERROR -->

        <!-- ***** INICIO FORMULARIO DESLOG ***** -->
        <form method="post" action="sesionServlet" name="deslogForm" id="deslogForm">
            <input type="hidden" name="opcion" value="deslog">
        </form>
        
        <form method="post" action="servletP" name="descaPlaniOpe" id="descaPlaniOpe">
            <input type="hidden" name="opcion" value="descargarOperacion">
            <input type="hidden" name="numOpeDesca" id="numOpeDesca">
        </form>

        <!-- AUX -->
        <input type="hidden" id="cantOpeEnMarcha" value="<%=cantOpeEnMarcha%>">
        <input type="hidden" id="cantOpeFinalizada" value="<%=cantOpeFinalizada%>">
        <input type="hidden" id="cantOpeRechazada" value="<%=cantOpeRechazada%>">
        <input type="hidden" id="cantOpePendiente" value="<%=cantOpePendiente%>">
        <input type="hidden" id="cantOpeEnMarchaCapataz" value="<%=cantOpeEnMarchaCapataz%>">
        <input type="hidden" id="cantOpeFinalizadaCapataz" value="<%=cantOpeFinalizadaCapataz%>">
        <input type="hidden" id="cantOpeRechazadaCapataz" value="<%=cantOpeRechazadaCapataz%>">
        <input type="hidden" id="cantOpePendienteCapataz" value="<%=cantOpePendienteCapataz%>">

        <!-- FORMULARIO AUXILIAR EDIT FORMULARIO VCCP -->
        <form method="post" action="servletPO" name="editarFormularioOpe" id="editarFormularioOpe">
            <input type="hidden" name="opcion" value="editarOperacionSelec">
            <input type="hidden" name="codigoOpeSele" id="codigoOpeSele">
        </form>
        <!-- ***** FIN FORMULARIO DESLOG ***** -->

        <!-- ********** INICIO SCRIPTS ********** -->       
        <!-- QUERY -->
        <script src="js/principal/jquery.js"></script>                      
        <!-- BOOSTSTRAP QUERY  -->
        <script src="js/principal/bootstrap.min.js"></script>
        <!-- METIS MENU -->
        <script src="js/principal/metisMenu.js"></script>
        <!-- NAVBAR -->
        <script src="js/principal/navbar.js"></script>
        <!-- TABLES -->
        <script type="text/javascript" src="js/principal/datatables.min.js"></script>
        <!-- MASK JQUERY -->
        <script type="text/javascript" src="js/principal/jquery.mask.js"></script>      
        <!-- QUERY PROPIAS - LISTAS -->        
        <script src="js/querysPropias/jsmodulosListas1.js"></script>   
        <!-- QUERY PROPIAS - SELECT REGION & COMUNA -->
        <script src="js/querysPropias/regionYcomuna.js"></script>
        <!-- QUERY PROPIAS - VALIDACIÓN FORMULARIOS -->
        <script src="js/querysPropias/validacionForm.js"></script>
        <!-- QUERY PROPIAS - AJAX FORMULARIOS -->
        <script src="js/querysPropias/validacionesAjax.js"></script>
        <!-- QUERY PROPIAS - GRÁFICOS -->
        <script src="js/querysPropias/chart.js"></script>       
        <!-- ANEXOS SRC - GRÁFICOS -->
        <script src="https://code.highcharts.com/highcharts.js"></script>
        <!-- ANEXOS SRC - GRÁFICOS DRILLDOWN -->
        <script src="https://code.highcharts.com/modules/drilldown.js"></script>
        <!-- ********** FIN SCRIPTS ********** -->

    </body>
</html>
<%
        } else {
            //OTRO ROL
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }

    } else {
        //NO HAY INICIO DE SESION
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    request.removeAttribute(
            "msjAlertGreen");
    request.removeAttribute(
            "msjAlertRed");
    request.removeAttribute(
            "msjModalShow");
%>





