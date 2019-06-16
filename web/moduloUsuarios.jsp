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
        if (rolUs.equals("ADMINISTRADOR") || rolUs.equals("GENERAL")) {

            ArrayList datosAdm = (ArrayList) sesion.getAttribute("datosUsuario");
            ArrayList datosUsuarios = (ArrayList) sesion.getAttribute("datosUsuarios");
            ArrayList datosCargos = (ArrayList) sesion.getAttribute("datosCargos");

            int cantAdmAct = (int) sesion.getAttribute("cantAdmAct");
            int cantAdmInac = (int) sesion.getAttribute("cantAdmInac");
            int cantSuperAct = (int) sesion.getAttribute("cantSuperAct");
            int cantSuperInac = (int) sesion.getAttribute("cantSuperInac");

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

        <title>Panel usuarios</title>

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
                    if (rolUs.equals("GENERAL")) {                   
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
                <% }else{ %>
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
                <% } %>
                <!-- ***** FIN BARRA LATERAL ***** -->
            </nav>

            <!-- ***** INICIO CONTENIDO PÁGINA ***** -->
            <div id="page-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">Bienvenido al panel de personal</h1>                       
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="panelPrincipal.jsp">Inicio</a>
                            </li>
                            <li class="breadcrumb-item active">Panel usuario - Gestión usuario</li>
                        </ol>
                    </div>
                </div>

                <!-- INICIO CABECERA PANEL USUARIO -->
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-6 col-xl-6">
                        <div class="panel panel-green">
                            <div class="panel-heading">
                                Panel de usuarios, ¡gestionar ahora!
                            </div>
                            <div class="panel-body">
                                <ul style="list-style-type:circle;">
                                    <li>Crear nuevos usuarios</li>
                                    <li>Visualizar sus datos</li>
                                    <li>Desactivar usuarios</li>
                                    <li>Reingresar usuarios</li>
                                </ul>
                            </div>
                            <div class="panel-footer">
                                Tekonn Ltda.
                            </div>
                        </div>
                        <!-- /.col-lg-4 -->
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-6 col-xl-6">
                        <div class="panel panel-green">
                            <div class="panel-heading">
                                Gráfico dinámico
                            </div>
                            <div class="panel-body" id="containerCharUs">

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
                                <i class="fas fa-user-circle"></i>  Usuarios Tekonn
                                <div class="pull-right">
                                    <div class="btn-group">
                                    </div>
                                </div>
                                <i class="fas fa-user-plus" id="icoAddUs" data-toggle="modal" data-target="#modalNuevoUsuario" title="Agregar nuevo usuario"></i>
                            </div>
                            <div class="panel-body datosCuenta">                              
                                <div class="table-wrapper">
                                    <div class="table-title">
                                    </div>
                                    <div class="table-responsive">
                                        <table class="table table-striped table-hover" id="UsuariosActivos" style="width:100%;">
                                            <thead>
                                                <tr>
                                                    <th>Nombre</th>
                                                    <th>Rut</th>
                                                    <th>Región</th>
                                                    <th>Correo</th>
                                                    <th>Empresa</th>
                                                    <th>Rol</th>
                                                    <th>Estado</th>
                                                    <th>Acciones</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    if (datosUsuarios.get(0) == "null") {
                                                %>
                                                <tr>
                                                    <td style="display:none;"></td>
                                                </tr>                                    
                                                <%
                                                } else {
                                                    int i = 0,
                                                            aux = 1;
                                                    while (i < datosUsuarios.size()) {
                                                        String estado = (String) datosUsuarios.get(i + 1);
                                                        if (estado.equals("1")) {
                                                            estado = "Activo";
                                                %>
                                                <tr>                                                               
                                                    <td><%=((String) datosUsuarios.get(i)).trim()%></td>
                                                    <td><%=((String) datosUsuarios.get(i + 2)).trim()%></td>
                                                    <td><%=((String) datosUsuarios.get(i + 9)).trim()%></td>
                                                    <td><%=((String) datosUsuarios.get(i + 4)).trim()%></td>
                                                    <td><%=((String) datosUsuarios.get(i + 11)).trim()%></td>
                                                    <td><%=((String) datosUsuarios.get(i + 13)).trim()%></td>  
                                                    <td><%=estado%></td>  
                                                    <td>
                                                        <a class="visuaUsTable" title="Editar usuario" style="cursor:pointer;">
                                                            <i class="fas fa-user-edit"></i>
                                                        </a>                                          
                                                        <a href="#modalEliminarUsuario" class="deleteUsTable" data-toggle="modal" title="Eliminar usuario">
                                                            <i class="fas fa-user-minus"></i> 
                                                        </a>
                                                    </td>
                                                </tr> 
                                                <%
                                                } else {
                                                    estado = "Desactivado";
                                                %>
                                                <tr>                                                               
                                                    <td><%=((String) datosUsuarios.get(i)).trim()%></td>
                                                    <td><%=((String) datosUsuarios.get(i + 2)).trim()%></td>
                                                    <td><%=((String) datosUsuarios.get(i + 9)).trim()%></td>
                                                    <td><%=((String) datosUsuarios.get(i + 4)).trim()%></td>
                                                    <td><%=((String) datosUsuarios.get(i + 11)).trim()%></td>
                                                    <td><%=((String) datosUsuarios.get(i + 13)).trim()%></td>  
                                                    <td><%=estado%></td>  
                                                    <td>                                   
                                                        <a href="#modalReactivarUsuario" data-toggle="modal" title="Reactivar usuario" class="reactUsTable">
                                                            <i class="fas fa-user-check"></i> 
                                                        </a>
                                                    </td>
                                                </tr>
                                                <%
                                                            }
                                                            i = i + 17;
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

        <!-- INICIO MODAL NUEVO USUARIO -->
        <div class="modal fade" id="modalNuevoUsuario" tabindex="-1" role="dialog" aria-labelledby="modalNuevoUsuario" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
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
                                            <h4>Datos personales</h4>
                                        </div>
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-lg-12">

                                                    <!-- DATOS 1 -->                               
                                                    <div class="row ">                                    
                                                        <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                            <label>Nombres</label>
                                                            <input id="nombreUs" name="nombreUs" type="text" class="form-control" required >
                                                        </div>
                                                        <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                            <label>Apellidos</label>
                                                            <input id="apellidosUs" name="apellidosUs" type="text" class="form-control" required>
                                                        </div>
                                                    </div>
                                                    <hr>
                                                    <!-- DATOS 2 -->                               
                                                    <div class="row ">                                    
                                                        <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                            <label>Rut</label>
                                                            <input id="rutUs" name="rutUs" type="text" class="form-control" required>
                                                            <i class="fas fa-check-circle" id="checkRut"></i>
                                                            <i class="fas fa-times-circle" id="nocheckRut"></i>
                                                        </div>
                                                        <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                            <label>Sexo</label>
                                                            <select id="sexoUs" name="sexoUs" class="form-control" required>
                                                                <option value="M">Masculino</option>
                                                                <option value="F">Femenino</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <hr>
                                                    <!-- DATOS 3 -->                               
                                                    <div class="row ">                                    
                                                        <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                            <label>Correo electrónico</label>
                                                            <input id="emailUs" name="emailUs" type="email" class="form-control" required>
                                                            <i class="fas fa-check-circle" id="checkEmail"></i>
                                                            <i class="fas fa-times-circle" id="nocheckEmail"></i>
                                                        </div>
                                                    </div>
                                                    <!-- DATOS 4 -->                               
                                                    <div class="row ">                                    
                                                        <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                            <label>Fono fijo</label>
                                                            <input id="fonofijoUs" name="fonofijoUs" type="text" class="form-control" required>
                                                        </div>
                                                        <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                            <label>Teléfono celular</label>
                                                            <input id="telefonocelularUs" name="telefonocelularUs" type="text" class="form-control" required>
                                                        </div>
                                                    </div>
                                                    <hr>
                                                    <!-- DATOS 5 -->                               
                                                    <div class="row ">                                    
                                                        <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                            <label>Dirección</label>
                                                            <input id="direccionUs" name="direccionUs" type="text" class="form-control" required>
                                                        </div>
                                                        <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                            <label>Ciudad</label>
                                                            <input id="ciudadUs" name="ciudadUs" type="text" class="form-control" required>
                                                        </div>
                                                    </div>
                                                    <div class="row ">                                    
                                                        <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                            <label>Región</label>
                                                            <select id="regionUs" name="regionUs" required="" class="form-control"></select>
                                                            <input id="regionUsEditActual" type="hidden" class="form-control" value="1">
                                                        </div>
                                                        <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                            <label>Comuna</label>
                                                            <select id="comunaUs" name="comunaUs" required="" class="form-control"></select>
                                                            <input id="comunaUsEditActual" type="hidden" class="form-control" value="2">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div> 
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h4>Datos sistema</h4>
                                        </div>
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <!-- DATOS 1 -->                               
                                                    <div class="row "> 
                                                        <div class="col-xs-12 col-sm-4 col-md-4 col-xl-4 paddingDiv">
                                                            <label>Empresa</label>
                                                            <select id="empresaUs" name="empresaUs" class="form-control">
                                                                <option selected="true" disabled="disabled">**Seleccionar**</option>
                                                                <option value="Tekkon Ltda.">Tekkon Ltda.</option>
                                                                <option value="Otra">Otra</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-xs-12 col-sm-4 col-md-4 col-xl-4 paddingDiv">
                                                            <label>Rol</label>
                                                            <select id="rolUs" name="rolUs" class="form-control">
                                                                <option selected="true" disabled="disabled">**Seleccionar**</option>
                                                                <option value="2">ADMINISTRADOR</option>
                                                                <option value="3">SUPERVISOR</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-xs-12 col-sm-4 col-md-4 col-xl-4 paddingDiv">
                                                            <label>Cargo</label>
                                                            <%
                                                                if (datosCargos.get(0) == "null") {
                                                                    //POR DEFECTO CARGOS
                                                            %>
                                                            <label>Cargo</label>
                                                            <select id="cargoUs" name="cargoUs" class="form-control">
                                                                <option selected="true" disabled="disabled">**Seleccionar**</option>
                                                                <option value="1">Albañil</option>
                                                                <option value="2">Electricista</option>
                                                                <option value="3">Constructor civil</option>
                                                                <option value="4">Prevencionista</option>
                                                                <option value="5">Ingeniero</option>
                                                                <option value="6">Administrador</option>
                                                                <option value="7">Gasfiter</option>
                                                                <option value="8">Ingeniero en minas</option>
                                                                <option value="9">Ingeniero en construcciones</option>
                                                                <option value="10">Capataz</option>
                                                            </select>
                                                            <%
                                                            } else {
                                                            %>
                                                            <select id="cargoUs" name="cargoUs" class="form-control">
                                                                <option selected="true" disabled="disabled">**Seleccionar**</option>
                                                                <%
                                                                    int aux = 0;
                                                                    while (aux < datosCargos.size()) {
                                                                %>
                                                                <option value="<%=(aux + 1)%>"><%=((String) datosCargos.get(aux)).trim()%></option>

                                                                <%
                                                                            aux = aux + 1;
                                                                        }
                                                                    }
                                                                %>
                                                            </select>
                                                        </div>                                                       
                                                    </div>                                                   
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" name="opcion" value="crearNuevoUsuario">
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

        <!-- INICIO MODAL DELETE -->
        <div id="modalEliminarUsuario" class="modal fade">
            <div class="modal-dialog" id="meu" style="max-width: 400px;">
                <div class="modal-content">
                    <form method="post" action="servletPU" class="datosCuenta">
                        <div class="modal-header">						
                            <img id="imgLogo" src="media/imagenes/logo.png" alt="logoTekonn" />
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="container-fluid">
                                <p>¿Está seguro que desea eliminar al siguiente usuario?</p>
                                <hr>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">                                               
                                        <input type="text"  class="form-control" id="nombreUsuarioEliminar" disabled="" />
                                    </div>
                                </div>
                                <br>
                                <br>  
                                <p class="text-warning"><small>Esta acción no se puede deshacer</small></p>
                            </div>                                                                  
                        </div>
                        <input type="hidden" name="correoUsuarioEliminar" id="correoUsuarioEliminar"/>
                        <input type="hidden" name="opcion" value="eliminarUsuario">
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Salir">
                            <input type="submit" class="btn btn-danger" value="Eliminar">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- FIN MODAL DELETE -->

        <!-- INICIO MODAL REACTIVAR -->
        <div id="modalReactivarUsuario" class="modal fade">
            <div class="modal-dialog" id="meu" style="max-width: 400px;">
                <div class="modal-content">
                    <form method="post" action="servletPU" class="datosCuenta">
                        <div class="modal-header">						
                            <img id="imgLogo" src="media/imagenes/logo.png" alt="logoTekonn" />
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="container-fluid">
                                <p>¿Está seguro que desea reingresar al siguiente usuario?</p>
                                <hr>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">                                               
                                        <input type="text"  class="form-control" id="nombreUsuarioReactivar" disabled="" />
                                    </div>
                                </div>
                                <br>
                                <br>  
                                <p class="text-warning"><small>Esta acción no se puede deshacer</small></p>
                            </div>                                                                  
                        </div>
                        <input type="hidden" name="correoUsuarioReactivar" id="correoUsuarioReactivar"/>
                        <input type="hidden" name="opcion" value="reactivarUsuario">
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Salir">
                            <input type="submit" class="btn btn-danger" value="Reactivar">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- FIN MODAL REACTIVAR -->

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

        <input type="hidden" id="cantAdmAct" value="<%=cantAdmAct%>">
        <input type="hidden" id="cantAdmInac" value="<%=cantAdmInac%>">
        <input type="hidden" id="cantSuperAct" value="<%=cantSuperAct%>">
        <input type="hidden" id="cantSuperInac" value="<%=cantSuperInac%>">

        <form method="post" action="servletPU" name="mostrarDatosUsuarioPagNew" id="mostrarDatosUsuarioPagNew">
            <input type="hidden" name="opcion" value="mostrarDatosUsuarioPagNew">
            <input type="hidden" name="correoUsPagNew" id="correoUsPagNew">
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





