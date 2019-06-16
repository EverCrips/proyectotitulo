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
        if (rolUs.equals("ADMINISTRADOR") || rolUs.equals("SUPERVISOR")) {

            ArrayList datosAdm = (ArrayList) sesion.getAttribute("datosUsuario");
            ArrayList datosEquipos = (ArrayList) sesion.getAttribute("datosEquipos");
            ArrayList listaCapatazSinEquipo = (ArrayList) sesion.getAttribute("listaCapatazSinEquipo");

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

        <title>Panel equipos</title>

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

                <% 
                    switch(rolUs){ 
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
                <% 
                    break;
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
                <% 
                    break;
                    } 
                %>
                <!-- ***** FIN BARRA LATERAL ***** -->
            </nav>

            <!-- ***** INICIO CONTENIDO PÁGINA ***** -->
            <div id="page-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">Bienvenido al panel de equipos</h1>                       
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="panelPrincipal.jsp">Inicio</a>
                            </li>
                            <li class="breadcrumb-item active">Panel equipos - Gestión equipos</li>
                        </ol>
                    </div>
                </div>

                <!-- INICIO CABECERA PANEL USUARIO -->
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-6 col-xl-6">
                        <div class="panel panel-green">
                            <div class="panel-heading">
                                Panel de equipos, ¡gestionar ahora!
                            </div>
                            <div class="panel-body">
                                <ul style="list-style-type:circle;">
                                    <li>Crear nuevos equipos</li>
                                    <li>Visualizar los equipos</li>
                                    <li>Modificar equipos con trabajadores</li>
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
                                <i class="fas fa-users"></i>  Equipos Tekonn
                                <div class="pull-right">
                                    <div class="btn-group">
                                    </div>
                                </div>
                                <i class="fas fa-users" id="icoAddUs" data-toggle="modal" data-target="#modalNuevoEquipo" title="Agregar nuevo equipo"></i>
                            </div>
                            <div class="panel-body datosCuenta">                              
                                <div class="table-wrapper">
                                    <div class="table-title">
                                    </div>
                                    <div class="table-responsive">
                                        <table class="table table-striped table-hover" id="UsuariosActivos" style="width:100%;">
                                            <thead>
                                                <tr>
                                                    <th>Número de equipo</th>
                                                    <th>Nombre equipo</th>
                                                    <th>Descripción del equipo</th>
                                                    <th>Lider del equipo</th>
                                                    <th>Acciones</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    if (datosEquipos.get(0) == "null") {
                                                %>
                                                <tr>
                                                    <td style="display:none;"></td>
                                                </tr>                                    
                                                <%
                                                } else {
                                                    int i = 0,
                                                            aux = 1;
                                                    while (i < datosEquipos.size()) {
                                                %>
                                                <tr>                                                               
                                                    <td><%=((String) datosEquipos.get(i + 2)).trim()%></td>
                                                    <td><%=((String) datosEquipos.get(i)).trim()%></td>
                                                    <td><%=((String) datosEquipos.get(i + 1)).trim()%></td>
                                                    <td><%=((String) datosEquipos.get(i + 3)).trim()%></td>
                                                    <td>
                                                        <a href="#modalVisualizarEquipo" class="visuEquiTable" data-toggle="modal" title="Visualizar equipo">
                                                            <i class="fas fa-file-pdf"></i> 
                                                        </a>
                                                        <a class="editEqTable" title="Editar Equipo" style="cursor:pointer;">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        <a href="#modalEliminarEquipo" class="deleteEquiTable" data-toggle="modal" title="Desintegrar equipo">
                                                            <i class="fas fa-trash-alt"></i> 
                                                        </a>                                                       
                                                    </td>
                                                </tr> 
                                                <%
                                                            i = i + 4;
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

        <!-- INICIO MODAL NUEVO EQUIPOS -->
        <div class="modal fade" id="modalNuevoEquipo" tabindex="-1" role="dialog" aria-labelledby="modalNuevoEquipo" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form method="post" action="servletPU" class="datosCuenta">
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
                                            <h4>Datos del nuevo equipo</h4>
                                        </div>
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-lg-12">

                                                    <!-- DATOS 1 -->                               
                                                    <div class="row ">                                    
                                                        <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                            <label>Nombre del equipo</label>
                                                            <input id="nombreEquipo" name="nombreEquipo" type="text" class="form-control" required>
                                                        </div>
                                                        <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                            <label>Nombre lider equipo</label>
                                                            <%
                                                                if (listaCapatazSinEquipo.get(0) == "null") {
                                                                    //POR DEFECTO CARGOS
                                                            %>
                                                            <label>Lider del equipo</label>
                                                            <select id="liderEquipo" name="liderEquipo" class="form-control">
                                                                <option value="1">ADMIN</option>
                                                            </select>
                                                            <%
                                                            } else {
                                                            %>
                                                            <select id="liderEquipo" name="liderEquipo" class="form-control">
                                                                <%
                                                                    int aux = 0;
                                                                    while (aux < listaCapatazSinEquipo.size()) {
                                                                %>
                                                                <option value="<%=((String) listaCapatazSinEquipo.get(aux)).trim()%>"><%=((String) listaCapatazSinEquipo.get(aux + 1)).trim()%></option>

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
                                                            <label>Descripción del equipo</label>
                                                            <input id="descripcionEquipo" name="descripcionEquipo" type="text" class="form-control" required>
                                                        </div>
                                                    </div>
                                                    <hr>                                               
                                                </div>
                                            </div>
                                        </div>
                                    </div>                                   
                                </div>
                            </div>
                            <input type="hidden" name="opcion" value="crearEquipo">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Salir</button>
                            <button type="submit" class="btn btn-primary">Registrar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- FIN MODAL NUEVO USUARIO -->

        <!-- INICIO MODAL EDITAR EQUIPO -->
        <div class="modal fade" id="modalVisualizarEquipo" tabindex="-1" role="dialog" aria-labelledby="modalVisualizarEquipo" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form method="post" action="servletP" class="datosCuenta">
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
                                                            <label>Nombre del equipo</label>
                                                            <input id="nombreEquipoEd" name="nombreEquipoEd" type="text" class="form-control" readonly="">
                                                        </div>
                                                        <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                            <label>Nombre lider equipo</label>
                                                            <input id="nombreLider" name="nombreLider" type="text" class="form-control" readonly="">
                                                        </div>
                                                    </div>
                                                    <hr>

                                                    <div class="row ">                                    
                                                        <div class="col-xs-12 col-sm-12 col-md-12 col-xl-12 paddingDiv">
                                                            <label>Descripción del equipo</label>
                                                            <input id="descripcionEquipoEd" name="descripcionEquipoEd" type="text" class="form-control" readonly="">
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
                            <input type="hidden" name="opcion" value="descargarPlanillaEquipo">
                            <input type="hidden" name="numEquiDescPlani" id="numEquiDescPlani" >
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Salir</button>
                            <button type="submit" class="btn btn-primary">Descargar planilla</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- FIN MODAL VISUALIZAR EQUIPO -->

        <!-- INICIO MODAL DELETE -->
        <div id="modalEliminarEquipo" class="modal fade">
            <div class="modal-dialog" id="meu" style="max-width: 400px;">
                <div class="modal-content">
                    <form method="post" action="servletPU" class="datosCuenta">
                        <div class="modal-header">						
                            <img id="imgLogo" src="media/imagenes/logo.png" alt="logoTekonn" />
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="container-fluid">
                                <p>¿Está seguro que desea eliminar al siguiente equipo?</p>
                                <hr>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">
                                        <input type="text"  class="form-control" id="nombreEquipoBorrar" disabled="" />
                                    </div>
                                </div>
                                <br>
                                <br>  
                                <p class="text-warning"><small>Esta acción no se puede deshacer</small></p>
                            </div>                                                                  
                        </div>
                        <input type="hidden" name="codigoEquipoBorrar" id="codigoEquipoBorrar"/>
                        <input type="hidden" name="opcion" value="borrarEquipo">
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Salir">
                            <input type="submit" class="btn btn-danger" value="Eliminar">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- FIN MODAL DELETE -->    

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

        <!-- FORMULARIO AUXILIAR EDIT EQ -->
        <form method="post" action="servletPU" name="editarEquiSelec" id="editarEquiSelec">
            <input type="hidden" name="opcion" value="editarEquiSelec">
            <input type="hidden" name="codigoEq" id="codigoEq">
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





