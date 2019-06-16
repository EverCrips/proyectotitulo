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

            ArrayList operacionSelec = (ArrayList) sesion.getAttribute("operacionSelec");
            ArrayList rmsOperaSelec = (ArrayList) sesion.getAttribute("rmsOperaSelec");
            ArrayList rmsDisponibles = (ArrayList) sesion.getAttribute("rmsDisponibles");
            ArrayList datosEquipoSelec = (ArrayList) sesion.getAttribute("datosEquipoSelec");

            int cantCapaAct = (int) sesion.getAttribute("cantCapaAct");
            int cantCapaInac = (int) sesion.getAttribute("cantCapaInac");
            int cantTraAct = (int) sesion.getAttribute("cantTraAct");
            int cantTraInac = (int) sesion.getAttribute("cantTraInac");

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

        <title>Panel operaciones - Editar</title>

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
                        <h1 class="page-header">Bienvenido a la edición de operación</h1>                       
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="panelPrincipal.jsp">Inicio</a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="moduloOperaciones.jsp">Panel operaciones</a>
                            </li>
                            <li class="breadcrumb-item active">Panel operación - Edición</li>
                        </ol>
                    </div>
                </div>

                <!-- INICIO CABECERA PANEL USUARIO -->
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-6 col-xl-6">
                        <div class="panel panel-green">
                            <div class="panel-heading">
                                Panel de operaciones, ¡gestionar ahora!
                            </div>
                            <div class="panel-body">
                                <ul style="list-style-type:circle;">
                                    <li>Agregar RMS</li>
                                    <li>Puntuar RMS</li>
                                    <li>Quitar RMS</li>
                                </ul>
                            </div>
                            <div class="panel-footer">
                                Tekonn Ltda.
                            </div>
                        </div>
                        <!-- /.col-lg-4 -->
                    </div>                
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
                                <i class="far fa-file"></i>  Detalle operación
                                <div class="pull-right">
                                    <div class="btn-group">
                                    </div>
                                </div>
                                <a href="#modalVisualizarEquipo" id="icoAddUs" class="visuEquiTableOpe" data-toggle="modal" title="Visualizar equipo">
                                    <i class="fas fa-address-book"></i> 
                                </a>
                            </div>
                            <div class="panel-body datosCuenta"> 
                                <form method="post" action="servletPO" class="datosCuenta">
                                    <div class="row "> 
                                        <div class="col-xs-12 col-sm-2 col-md-2 col-xl-2 paddingDiv">
                                            <label>Nº</label>
                                            <input id="numeroOperacionSele" name="numeroOperacionSele" type="text" class="form-control" readonly="" value="<%=operacionSelec.get(0).toString()%>">
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="row ">                                    
                                        <div class="col-xs-12 col-sm-3 col-md-3 col-xl-3 paddingDiv">
                                            <label>Nombre operación</label>
                                            <input id="nombreOperacionSele" name="nombreOperacionSele" type="text" class="form-control" readonly="" value="<%=operacionSelec.get(1).toString()%>">
                                        </div>
                                        <div class="col-xs-12 col-sm-3 col-md-3 col-xl-3 paddingDiv">
                                            <label>Zona de operación</label>
                                            <input id="zonaOperacionSele" name="zonaOperacionSele" type="text" class="form-control" readonly="" value="<%=operacionSelec.get(6).toString()%>">
                                        </div>
                                        <div class="col-xs-12 col-sm-3 col-md-3 col-xl-3 paddingDiv">
                                            <label>Fecha inicio</label>
                                            <input id="fechainicioSele" name="fechainicioSele" type="text" class="form-control" readonly="" value="<%=operacionSelec.get(3).toString()%>">
                                        </div>
                                        <div class="col-xs-12 col-sm-3 col-md-3 col-xl-3 paddingDiv">
                                            <label>Fecha término</label>
                                            <input id="fechaterminoSele" name="fechaterminoSele" type="text" class="form-control" readonly="" value="<%=operacionSelec.get(4).toString()%>">
                                        </div>
                                    </div>
                                    <hr>
                                    <!-- DATOS 2 -->                               
                                    <div class="row ">                                    
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                            <label>Descripción operación</label>
                                            <textarea class="form-control" name="descripcionOperacionSele" rows="4" ><%=operacionSelec.get(2).toString()%></textarea>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                            <label>Observaciones</label>
                                            <textarea class="form-control" name="observacionesOperacionSele" rows="4"><%=operacionSelec.get(8).toString()%></textarea>
                                        </div>
                                    </div> 
                                    <hr>
                                    <input type="hidden" name="opcion" value="editarFormSelec">
                                    <input type="hidden" name="numeroFormEditSelec" value="<%=operacionSelec.get(0).toString()%>">
                                    <input type="submit" class="btn btn-success" style="float:right" value="Guardar cambios">
                                </form>
                                <input type="hidden" name="auxCodigoEq" id="auxCodigoEq" value="<%=operacionSelec.get(5).toString()%>">
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
                        <hr>
                        <hr>
                    </div>                   
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <i class="far fa-file"></i>  Detalles
                                <div class="pull-right">
                                    <div class="btn-group">
                                    </div>
                                </div>
                                <%
                                    if (rolUs.equals("CAPATAZ")) {
                                %> 
                                <i class="fas fa-grip-vertical" id="icoAddUs" data-toggle="modal" data-target="#modalAgregarRms" title="Agregar rms"></i>
                                <%
                                    }
                                %> 
                            </div>
                            <div class="panel-body datosCuenta">                              
                                <div class="table-wrapper">
                                    <div class="table-responsive">
                                        <table class="table table-striped table-hover" id="UsuariosActivos" style="width:100%;">
                                            <thead>
                                                <tr>
                                                    <th>Nº rms</th>
                                                    <th>Nombre rms</th>
                                                    <%
                                                        if (rolUs.equals("CAPATAZ")) {
                                                    %>
                                                    <th>Acciones</th>
                                                    <%
                                                        }
                                                    %>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    if (rmsOperaSelec.get(0) == "null") {
                                                %>
                                                <tr>
                                                    <td style="display:none;"></td>
                                                </tr>                                    
                                                <%
                                                } else {
                                                    int i = 0,
                                                            aux = 1;
                                                    while (i < rmsOperaSelec.size()) {
                                                %>
                                                <tr>                                                               
                                                    <td><%=((String) rmsOperaSelec.get(i)).trim()%></td>
                                                    <td><%=((String) rmsOperaSelec.get(i + 1)).trim()%></td>
                                                    <%
                                                        if (rolUs.equals("CAPATAZ")) {
                                                    %>
                                                    <td>
                                                        <a href="#modalQuitarRmsOpe" class="deleteRmsOpe" data-toggle="modal" title="Remover rms">
                                                            <i class="fas fa-times"></i> 
                                                        </a>
                                                        <a href="#modalEditarRmsOpe" class="editRmsOpe" data-toggle="modal" title="Editar rms">
                                                            <i class="fas fa-pen"></i> 
                                                        </a>
                                                    </td>
                                                    <%
                                                        }
                                                    %>
                                                </tr> 
                                                <%
                                                            i = i + 2;
                                                            aux++;
                                                        }
                                                    }
                                                %>
                                            </tbody>
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

        <!-- INICIO MODAL AGREGAR RMS -->
        <div class="modal fade" id="modalAgregarRms" tabindex="-1" role="dialog" aria-labelledby="modalAgregarRms" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
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
                                            <i class="fas fa-user-circle"></i>  Rms disponibles
                                            <div class="pull-right">
                                                <div class="btn-group">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="panel-body datosCuenta">                              
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <!-- DATOS 1 -->                               
                                                    <div class="row ">                                    
                                                        <div class="col-xs-12 col-sm-12 col-md-12 col-xl-12 paddingDiv">
                                                            <select id="rmsSelec" name="rmsSelec" class="form-control" onchange="selectRmsOpe()">
                                                                <%
                                                                    int aux = 0;
                                                                    while (aux < rmsDisponibles.size()) {
                                                                %>
                                                                <option value="<%=((String) rmsDisponibles.get(aux + 1)).trim()%>"><%=((String) rmsDisponibles.get(aux)).trim()%></option>

                                                                <%
                                                                        aux = aux + 3;
                                                                    }
                                                                %>
                                                            </select>
                                                        </div>                                                   
                                                    </div> 
                                                    <hr>
                                                    <div class="row">
                                                        <div class="col-xs-12 col-sm-10 col-md-10 col-xl-10 paddingDiv" >
                                                            <ul id="divRmsOpe">

                                                            </ul>
                                                        </div>
                                                        <div class="col-xs-12 col-sm-2 col-md-2 col-xl-2 paddingDiv" >
                                                            <ul id="divColumnaOpe">

                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>                                   
                                </div>
                            </div>
                            <input type="hidden" name="opcion" value="agregarRmsOpe">
                            <input type="hidden" name="auxOpe" id="auxOpe">
                            <input type="hidden" name="auxnumeroRmsOpe" id="auxnumeroRmsOpe">
                            <input type="hidden" name="codigoOpe" id="codigoOpe" value="<%=operacionSelec.get(0).toString()%>">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Salir</button>
                            <button type="submit" class="btn btn-primary" >Agregar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- FIN MODAL NUEVO USUARIO -->

        <!-- INICIO MODAL DELETE -->
        <div id="modalQuitarRmsOpe" class="modal fade">
            <div class="modal-dialog" id="meu" style="max-width: 400px;">
                <div class="modal-content">
                    <form method="post" action="servletPO" class="datosCuenta">
                        <div class="modal-header">						
                            <img id="imgLogo" src="media/imagenes/logo.png" alt="logoTekonn" />
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="container-fluid">
                                <p>¿Está seguro que desea remover el siguiente rms de la operación seleccionada?</p>
                                <hr>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">                                               
                                        <input type="text"  class="form-control" id="nombreRmsOperacionRemover" disabled="" />
                                    </div>
                                </div>
                                <br>
                                <br>  
                                <p class="text-warning"><small>Esta acción no se puede deshacer</small></p>
                            </div>                                                                  
                        </div>
                        <input type="hidden" name="opcion" value="removerRmsOperacion">
                        <input type="hidden" name="numeroRmsRemoverOperacion" id="numeroRmsRemoverOperacion">
                        <input type="hidden" name="codigoOperacionSelec" value="<%=operacionSelec.get(0).toString()%>">
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Salir">
                            <input type="submit" class="btn btn-danger" value="Remover">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- FIN MODAL DELETE -->    

        <!-- INICIO MODAL EDIT RMS -->
        <div class="modal fade" id="modalEditarRmsOpe" tabindex="-1" role="dialog" aria-labelledby="modalEditarRmsOpe" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
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
                                            <i class="fas fa-user-circle"></i>  Rms seleccionado
                                            <div class="pull-right">
                                                <div class="btn-group">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="panel-body datosCuenta">                              
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <!-- DATOS 1 -->                               
                                                    <div class="row ">                                    
                                                        <div class="col-xs-12 col-sm-12 col-md-12 col-xl-12 paddingDiv" id="diFormOpeSelec">

                                                        </div>                                                   
                                                    </div> 
                                                    <hr>
                                                    <div class="row">
                                                        <div class="col-xs-12 col-sm-10 col-md-10 col-xl-10 paddingDiv" >
                                                            <ul id="divRmsOpeSelec">

                                                            </ul>
                                                        </div>
                                                        <div class="col-xs-12 col-sm-2 col-md-2 col-xl-2 paddingDiv" >
                                                            <ul id="divColumnaOpeSelec">

                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>                                   
                                </div>
                            </div>
                            <input type="hidden" name="opcion" value="editarRmsOpe">
                            <input type="hidden" name="auxOpeSelec" id="auxOpeSelec">
                            <input type="hidden" name="auxnumeroRmsOpeSelec" id="auxnumeroRmsOpeSelec">
                            <input type="hidden" name="codigoOpeSelec" id="codigoOpeSelec" value="<%=operacionSelec.get(0).toString()%>">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Salir</button>
                            <button type="submit" class="btn btn-primary" >Guardar cambios</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- FIN MODAL EDIT RMS -->

        <!-- INICIO MODAL VISUALIZAR EQUIPO -->
        <div class="modal fade" id="modalVisualizarEquipo" tabindex="-1" role="dialog" aria-labelledby="modalVisualizarEquipo" aria-hidden="true">
            <div class="modal-dialog" role="document">
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
                                    <div class="panel-heading">
                                        <h4>Datos equipo</h4>
                                    </div>
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="row ">                                    
                                                    <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                        <label>Nº equipo</label>
                                                        <input id="numEqOp" type="text" class="form-control" readonly="" value="<%=((String) datosEquipoSelec.get(0)).trim()%>">
                                                    </div>
                                                </div>
                                                <hr>
                                                <div class="row ">                                    
                                                    <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                        <label>Nombre del equipo</label>
                                                        <input id="nomEqOp" type="text" class="form-control" readonly="" value="<%=((String) datosEquipoSelec.get(1)).trim()%>">
                                                    </div>
                                                    <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                        <label>Nombre lider equipo</label>
                                                        <input id="nomLiEqOp" type="text" class="form-control" readonly="" value="<%=((String) datosEquipoSelec.get(3)).trim()%>">
                                                    </div>
                                                </div>
                                                <hr>

                                                <div class="row ">                                    
                                                    <div class="col-xs-12 col-sm-12 col-md-12 col-xl-12 paddingDiv">
                                                        <label>Descripción del equipo</label>
                                                        <input id="desEqOp" type="text" class="form-control" readonly="" value="<%=((String) datosEquipoSelec.get(2)).trim()%>">
                                                    </div>
                                                </div>                                               
                                            </div>
                                        </div>
                                    </div>                                   
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        Trabajadores del equipo
                                        <div class="pull-right">
                                            <div class="btn-group">
                                            </div>
                                        </div>

                                    </div>                                       
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-lg-12">


                                                <div class="row ">                                    
                                                    <div class="col-xs-12 col-sm-12 col-md-12 col-xl-12 paddingDiv">
                                                        <ul>
                                                            <li id="traEquSelec">

                                                            </li>
                                                        </ul>
                                                    </div>
                                                    <hr>                                               
                                                </div>                                               
                                            </div>
                                        </div>
                                    </div>                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Salir</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- FIN MODAL VISUALIZAR EQUIPO -->

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

        <input type="hidden" id="cantCapaAct" value="<%=cantCapaAct%>">
        <input type="hidden" id="cantCapaInac" value="<%=cantCapaInac%>">
        <input type="hidden" id="cantTraAct" value="<%=cantTraAct%>">
        <input type="hidden" id="cantTraInac" value="<%=cantTraInac%>">

        <!-- FORMULARIO AUXILIAR ADD RMS -->
        <form method="post" action="servletPO" name="agregarRmsOpe" id="agregarRmsOpe">
            <input type="hidden" name="opcion" value="agregarRmsOpe">

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
    request.removeAttribute("msjAlertGreen");
    request.removeAttribute("msjAlertRed");
    request.removeAttribute("msjModalShow");
%>






