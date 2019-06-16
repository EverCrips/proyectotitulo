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

<%
    //PRIMERO SE VALIDA QUE EL ROL SEA DISTINTO A NULL (SI ES NULL, NO HAY SESION ACTIVA)
    if (rolUs != null) {
        if (rolUs.equals("ADMINISTRADOR") || rolUs.equals("GENERAL")) {
            ArrayList datosUs = (ArrayList) sesion.getAttribute("datosUsuario");
            ArrayList datosUsuarioEdit = (ArrayList) sesion.getAttribute("datosUsuarioEdit");
            ArrayList datosCargos = (ArrayList) sesion.getAttribute("datosCargos");
            String nombreUs = (String) datosUsuarioEdit.get(0);
            String cargoUs = (String) datosUsuarioEdit.get(12);

            String sexoUs = ((String) datosUsuarioEdit.get(2)).trim();
            if (sexoUs.equals("M")) {
                sexoUs = "MASCULINO";
            } else {
                sexoUs = "FEMENINO";
            }

            //MANEJO DE ERROES
            String msjAlertGreen = (String) request.getAttribute("msjAlertGreen");
            String msjAlertRed = (String) request.getAttribute("msjAlertRed");
            String msjModalShow = (String) request.getAttribute("msjModalShow");

            int opcionModalShowJs = 0;
            String msjAlertStyleGreen = "";
            String msjAlertStyleRed = "";

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

        <title>Edición usuario</title>

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
                        <h1 class="page-header">Perfil usuario</h1>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="panelPrincipal.jsp">Inicio</a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="moduloUsuarios.jsp">Panel usuario - Gestión usuarios</a>
                            </li>
                            <li class="breadcrumb-item active">Panel usuario - Edición usuario</li>
                        </ol>
                    </div>
                </div>               

                <!-- INICIO CABECERA PANEL USUARIO -->
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-3 col-xl-3" id="imgPerfilDivPadre">
                        <div class="panel panel-primary" id="imgPerfilDivHija">                           
                            <div class="panel-heading">
                                <div class="row">
                                    <img src="<%=((String) datosUsuarioEdit.get(14)).trim()%>" alt="..." class="img-thumbnail" id="imgPPP"> 
                                </div>
                            </div> 
                            <a data-toggle="modal" data-target="#modalImagen">
                                <div class="panel-footer" id="cambiarImg" title="Modificar imagen">
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-6 col-xl-6">
                        <div class="panel panel-green divCumpleIngre">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="far fa-building fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">Tekonn Ltda.</div>
                                        <div>¡Un horizonte en cada vista!</div>
                                    </div>
                                </div>
                            </div>
                            <a href="#">
                                <div class="panel-footer">
                                    <span class="pull-left">Tu lealtad se valora</span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
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
                    <div class="col-lg-8">
                        <div class="panel panel-default datosCuenta">
                            <div class="panel-heading">
                                <i class="fas fa-user-circle"></i>  Datos personales
                                <div class="pull-right">
                                    <div class="btn-group">
                                    </div>
                                </div>
                                <i class="fas fa-edit" id="icoEditPer" title="Modificar datos" data-toggle="modal" data-target="#modalEditDatos"></i>
                            </div>
                            <div class="panel-body">
                                <!-- DATOS 1 -->                               
                                <div class="row ">                                    
                                    <div class="col-xs-12 col-sm-4 col-md-4 col-xl-4 paddingDiv">
                                        <label>Nombre</label>
                                        <input type="text" class="form-control" value="<%=((String) datosUsuarioEdit.get(0)).trim()%>" pattern="[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]{2,100}" disabled>
                                    </div>
                                    <div class="col-xs-12 col-sm-4 col-md-4 col-xl-4 paddingDiv">
                                        <label>Rut</label>
                                        <input type="text" class="form-control" value="<%=((String) datosUsuarioEdit.get(1)).trim()%>" disabled>
                                    </div>
                                    <div class="col-xs-12 col-sm-4 col-md-4 col-xl-4 paddingDiv">
                                        <label>Sexo</label>
                                        <input type="text" class="form-control" value="<%=sexoUs%>" disabled >
                                    </div>
                                </div>                                                                
                                <hr>  
                                <!-- DATOS 2 -->
                                <div class="row">
                                    <div class="col-xs-12 col-sm-4 col-md-4 col-xl-4 paddingDiv">
                                        <label>Correo electrónico</label>
                                        <input type="email" class="form-control" value="<%=((String) datosUsuarioEdit.get(3)).trim()%>" disabled>                                        
                                    </div> 
                                    <div class="col-xs-12 col-sm-4 col-md-4 col-xl-4 paddingDiv">
                                        <label>Fono fijo</label>
                                        <input type="text" class="form-control" value="<%=((String) datosUsuarioEdit.get(4)).trim()%>" pattern="[0-9]{2}\s?[0-9]{6}" title="Si no posee, rellenar con 00 000000" disabled>
                                    </div>
                                    <div class="col-xs-12 col-sm-4 col-md-4 col-xl-4 paddingDiv">
                                        <label>Teléfono celular</label>
                                        <input type="text" class="form-control" value="<%=((String) datosUsuarioEdit.get(5)).trim()%>" pattern="[(]\d{3}[\)]\s\d{8}" disabled>
                                    </div>
                                </div>
                                <hr>
                                <!-- DATOS 3 -->
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12 col-xl-12 paddingDiv">
                                        <label>Dirección</label>
                                        <input type="text" class="form-control" value="<%=((String) datosUsuarioEdit.get(6)).trim()%>" disabled>
                                    </div>
                                </div>
                                <hr>
                                <!-- DATOS 4 -->
                                <div class="row">
                                    <div class="col-xs-12 col-sm-4 col-md-4 col-xl-4 paddingDiv">
                                        <label>Ciudad</label>
                                        <input type="text" class="form-control" value="<%=((String) datosUsuarioEdit.get(7)).trim()%>" disabled>
                                    </div>
                                    <div class="col-xs-12 col-sm-4 col-md-4 col-xl-4 paddingDiv">
                                        <label>Región</label>
                                        <input type="text" class="form-control" value="<%=((String) datosUsuarioEdit.get(8)).trim()%>" disabled>
                                    </div>
                                    <div class="col-xs-12 col-sm-4 col-md-4 col-xl-4 paddingDiv">
                                        <label>Comuna</label>
                                        <input type="text" class="form-control" value="<%=((String) datosUsuarioEdit.get(9)).trim()%>" disabled>
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

                    <!-- ***** INICIO PANEL DERECHO ***** -->
                    <div class="col-lg-4">
                        <div class="panel panel-default datosCuenta">
                            <div class="panel-heading">
                                <i class="fas fa-building"></i>  Datos sistema
                                <i class="fas fa-edit" id="icoEditPer" title="Modificar datos" data-toggle="modal" data-target="#modalEditDatosSistema"></i>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                <label>Empresa</label>
                                                <input type="text" class="form-control" required value="<%=((String) datosUsuarioEdit.get(10)).trim()%>" disabled>
                                            </div>
                                            <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                <label>Equipo</label>
                                                <input type="text" class="form-control" required value="<%=((String) datosUsuarioEdit.get(15)).trim()%>" disabled>
                                            </div>
                                        </div>
                                        <hr>
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                <label>Cargo</label>
                                                <input type="text" class="form-control" required value="<%=((String) datosUsuarioEdit.get(11)).trim()%>" disabled>
                                            </div>
                                            <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                <label>Rol</label>
                                                <input type="text" class="form-control" required value="<%=((String) datosUsuarioEdit.get(12)).trim()%>" disabled>
                                            </div>
                                        </div>
                                        <hr>    
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel panel-default datosCuenta" >
                            <div class="panel-heading">
                                <i class="fas fa-key"></i>  Contraseña usuario
                                <i class="fas fa-edit" id="icoEditPer" title="Modificar datos" data-toggle="modal" data-target="#modalEditContraseña"></i>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                <label>Contraseña</label>
                                                <input type="password" class="form-control" disabled value="******">
                                            </div>
                                            <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                <label>Repetir contraseña</label>
                                                <input type="password" class="form-control" disabled value="******">
                                            </div>
                                        </div>  
                                    </div>
                                </div>
                            </div>
                        </div> 
                        <!-- PANEL DERECHO AUXILIAR 
                        <div class="panel panel-default"> 
                            <div class="panel-heading">
                                <i class="fa fa-bell fa-fw"></i> Notifications Panel
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
                        </div> -->
                    </div>
                    <!-- ***** FIN PANEL DERECHO ***** -->
                </div>
                <!-- ***** FIN FORMULARIO MODIFICAR DATOS ***** -->
                <hr>
                <hr>
                <br><br>
                <div class="row">
                    <div class="col-lg-12" id="datUsu">
                        <h4>
                            <%= (String) datosUs.get(0)%>
                        </h4>    
                    </div>
                </div> 
                <div class="row">
                    <div class="col-lg-12" id="datUsu"> 
                        <h5>
                            <%= (String) datosUs.get(12)%>
                        </h5> 
                    </div>
                </div> 
                <br><br>
            </div>
            <!-- ***** FIN CONTENIDO PÁGINA ***** -->

            <!-- INICIO MODAL EDITAR DATOS -->
            <div class="modal fade" id="modalEditDatos" tabindex="-1" role="dialog" aria-labelledby="modalEditDatos" aria-hidden="true" data-backdrop="static">
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
                                    <!-- ***** INICIO PANEL CENTRAL ***** -->
                                    <div class="col-lg-12">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <i class="fas fa-user-circle"></i>
                                            </div>
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="row ">                                    
                                                            <div class="col-xs-12 col-sm-4 col-md-4 col-xl-4 paddingDiv">
                                                                <label>Nombre</label>
                                                                <input id="nombreUsEdit" name="nombreUsEdit" type="text" class="form-control" value="<%=((String) datosUsuarioEdit.get(0)).trim()%>"required="">
                                                            </div>
                                                            <div class="col-xs-12 col-sm-4 col-md-4 col-xl-4 paddingDiv">
                                                                <label>Rut</label>
                                                                <input id="rutUs" name="rutUsEdit" type="text" class="form-control" required value="<%=((String) datosUsuarioEdit.get(1)).trim()%>">
                                                                <i class="fas fa-check-circle" id="checkRut"></i>
                                                                <i class="fas fa-times-circle" id="nocheckRut"></i>
                                                            </div>
                                                            <div class="col-xs-12 col-sm-4 col-md-4 col-xl-4 paddingDiv">
                                                                <label>Sexo</label>
                                                                <input id="sexoUs" name="sexoUs" type="text" class="form-control" value="<%=sexoUs%>" disabled>
                                                            </div>
                                                        </div>
                                                        <hr>
                                                        <div class="row">
                                                            <div class="col-xs-12 col-sm-4 col-md-4 col-xl-4 paddingDiv">
                                                                <label>Correo electrónico</label>
                                                                <input id="emailUs" name="emailUsEdit" type="email" class="form-control" value="<%=((String) datosUsuarioEdit.get(3)).trim()%>" required>  
                                                                <i class="fas fa-check-circle" id="checkEmail"></i>
                                                                <i class="fas fa-times-circle" id="nocheckEmail"></i>
                                                            </div> 
                                                            <div class="col-xs-12 col-sm-4 col-md-4 col-xl-4 paddingDiv">
                                                                <label>Fono fijo</label>
                                                                <input id="fonofijoUs" name="fonofijoUsEdit" type="text" class="form-control" value="<%=((String) datosUsuarioEdit.get(4)).trim()%>" title="Si no posee, rellenar con 00 000000" required>
                                                            </div>
                                                            <div class="col-xs-12 col-sm-4 col-md-4 col-xl-4 paddingDiv">
                                                                <label>Teléfono celular</label>
                                                                <input id="telefonocelularUs" name="telefonocelularUsEdit" type="text" class="form-control" value="<%=((String) datosUsuarioEdit.get(5)).trim()%>" required>
                                                            </div>
                                                        </div>
                                                        <hr>
                                                        <div class="row">
                                                            <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                                <label>Dirección</label>
                                                                <input id="direccionUsEdit" name="direccionUsEdit" type="text" class="form-control" value="<%=((String) datosUsuarioEdit.get(6)).trim()%>" required>
                                                            </div>
                                                            <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                                <label>Ciudad</label>
                                                                <input id="ciudadUsEdit" name="ciudadUsEdit" type="text" class="form-control"  value="<%=((String) datosUsuarioEdit.get(7)).trim()%>" required>
                                                            </div>
                                                        </div>
                                                        <hr>
                                                        <div class="row">
                                                            <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                                <label>Región</label>
                                                                <select id="regionUs" name="regionUsEdit" class="form-control"></select> 
                                                                <input id="regionUsEditActual" type="hidden" class="form-control" value="<%=((String) datosUsuarioEdit.get(8)).trim()%>">
                                                            </div>
                                                            <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                                <label>Comuna</label>
                                                                <select id="comunaUs" name="comunaUsEdit" class="form-control"></select>
                                                                <input id="comunaUsEditActual" type="hidden" class="form-control" value="<%=((String) datosUsuarioEdit.get(9)).trim()%>">
                                                            </div>
                                                        </div>    
                                                    </div>
                                                </div>                                              
                                            </div>
                                        </div>                        
                                        <!-- PANEL DERECHO AUXILIAR 
                                        <div class="panel panel-default"> 
                                            <div class="panel-heading">
                                                <i class="fa fa-bell fa-fw"></i> Notifications Panel
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
                                        </div> -->
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input type="hidden" name="opcion" value="modificarUsSistemaDatosPersonales">
                                <input type="hidden" name="emailUsActualEdit" value="<%=((String) datosUsuarioEdit.get(3)).trim()%>">
                                <input type="hidden" name="emailUsActual" value="<%=((String) datosUs.get(3)).trim()%>">
                                <input type="submit" class="btn btn-success" value="Guardar cambios">
                            </div>
                        </form>                      
                    </div>
                </div>
            </div>
            <!-- FIN MODAL EDITAR DATOS -->

            <!-- INICIO MODAL EDITAR DATOS SISTEMA -->
            <div class="modal fade" id="modalEditDatosSistema" tabindex="-1" role="dialog" aria-labelledby="modalEditDatosSistema" aria-hidden="true" data-backdrop="static">
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
                                    <!-- ***** INICIO PANEL CENTRAL ***** -->
                                    <div class="col-lg-12">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <i class="fas fa-building"></i>
                                            </div>
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="row">
                                                            <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                                <label>Empresa</label>
                                                                <select id="empresaUsEdit" name="empresaUsEdit" class="form-control">
                                                                    <option selected="true" value="<%=((String) datosUsuarioEdit.get(10)).trim()%>"><%=((String) datosUsuarioEdit.get(10)).trim()%></option>
                                                                    <option value="Tekkon Ltda.">Tekkon Ltda.</option>
                                                                    <option value="Otra">Otra</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">                                                
                                                                <label>Equipo</label>
                                                                <input type="text" class="form-control" id="eq" name="eq" required value="<%=((String) datosUsuarioEdit.get(15)).trim()%>" disabled>
                                                            </div>
                                                        </div>
                                                        <hr>
                                                        <div class="row">
                                                            <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                                <label>Cargo</label>
                                                                <%
                                                                    if (datosCargos.get(0) == "null") {
                                                                        //POR DEFECTO CARGOS
                                                                %>
                                                                <label>Cargo</label>
                                                                <select id="cargoUsEdit" name="cargoUsEdit" class="form-control">
                                                                    <option selected="true" value="<%=((String) datosUsuarioEdit.get(11)).trim()%>"><%=((String) datosUsuarioEdit.get(11)).trim()%></option>
                                                                    <option value="Albañil">Albañil</option>
                                                                    <option value="Electricista">Electricista</option>
                                                                    <option value="Constructor civil">Constructor civil</option>
                                                                    <option value="Prevencionista">Prevencionista</option>
                                                                    <option value="Ingeniero">Ingeniero</option>
                                                                    <option value="Administrador">Administrador</option>
                                                                    <option value="Gasfiter">Gasfiter</option>
                                                                    <option value="Ingeniero en minas">Ingeniero en minas</option>
                                                                    <option value="Ingeniero en construcciones">Ingeniero en construcciones</option>
                                                                    <option value="Capataz">Capataz</option>
                                                                </select>
                                                                <%
                                                                } else {
                                                                %>
                                                                <select id="cargoUsEdit" name="cargoUsEdit" class="form-control">
                                                                    <option selected="true" value="<%=((String) datosUsuarioEdit.get(11)).trim()%>"><%=((String) datosUsuarioEdit.get(11)).trim()%></option>
                                                                    <%
                                                                        int aux = 0;
                                                                        while (aux < datosCargos.size()) {
                                                                    %>
                                                                    <option value="<%=((String) datosCargos.get(aux)).trim()%>"><%=((String) datosCargos.get(aux)).trim()%></option>

                                                                    <%
                                                                                aux = aux + 1;
                                                                            }
                                                                        }
                                                                    %>
                                                                </select>
                                                            </div>
                                                            <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                                <label>Rol</label>
                                                                <select id="rolUsEdit" name="rolUsEdit" class="form-control">
                                                                    <option selected="true" value="<%=((String) datosUsuarioEdit.get(12)).trim()%>"><%=((String) datosUsuarioEdit.get(12)).trim()%></option>
                                                                    <option value="ADMINISTRADOR">ADMINISTRADOR</option>
                                                                    <option value="SUPERVISOR">SUPERVISOR</option>
                                                                </select>
                                                            </div>
                                                        </div>                                            
                                                    </div>
                                                </div>
                                            </div>
                                        </div>                        
                                        <!-- PANEL DERECHO AUXILIAR 
                                        <div class="panel panel-default"> 
                                            <div class="panel-heading">
                                                <i class="fa fa-bell fa-fw"></i> Notifications Panel
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
                                        </div> -->
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input type="hidden" name="opcion" value="modificarUsSistemaDatosSistema">
                                <input type="hidden" name="emailUsActualEdit" value="<%=((String) datosUsuarioEdit.get(3)).trim()%>">
                                <input type="hidden" name="emailUsActual" value="<%=((String) datosUs.get(3)).trim()%>">
                                <input type="submit" class="btn btn-success" value="Guardar cambios">
                            </div>
                        </form>                       
                    </div>
                </div>
            </div>
            <!-- FIN MODAL EDITAR DATOS SISTEMA -->

            <!-- INICIO MODAL EDITAR CONTRASEÑA -->
            <div class="modal fade" id="modalEditContraseña" tabindex="-1" role="dialog" aria-labelledby="modalEditContraseña" aria-hidden="true" data-backdrop="static">
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
                                    <!-- ***** INICIO PANEL CENTRAL ***** -->
                                    <div class="col-lg-12">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <i class="fas fa-key"></i>
                                            </div>
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="row">
                                                            <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                                <label>Contraseña</label>
                                                                <input autofocus="autofocus" id="pass1Us" name="pass1UsEdit" type="password" class="form-control" min="6" max="10" title="Entre 8 y 20 caracteres. Se aceptan mayúsculas, minúsculas, letras, números y !._%#@?-" required >
                                                                <i class="fas fa-check-circle" id="checkPass1"></i>
                                                                <i class="fas fa-times-circle" id="nocheckPass1"></i>
                                                            </div>
                                                            <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6 paddingDiv">
                                                                <label>Repetir contraseña</label>
                                                                <input id="pass2Us" name="pass2UsEdit" type="password" class="form-control" min="6" max="10" title="Entre 8 y 20 caracteres. Se aceptan mayúsculas, minúsculas, letras, números y !._%#@?-" required >
                                                                <i class="fas fa-check-circle" id="checkPass2"></i>
                                                                <i class="fas fa-times-circle" id="nocheckPass2"></i>
                                                            </div>
                                                        </div>                                                     
                                                    </div>
                                                </div>
                                            </div>
                                        </div>                        
                                        <!-- PANEL DERECHO AUXILIAR 
                                        <div class="panel panel-default"> 
                                            <div class="panel-heading">
                                                <i class="fa fa-bell fa-fw"></i> Notifications Panel
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
                                        </div> -->
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input type="hidden" name="opcion" value="modificarUsSistemaPass">
                                <input type="hidden" name="emailUsActualEdit" value="<%=((String) datosUsuarioEdit.get(3)).trim()%>">
                                <input type="hidden" name="emailUsActual" value="<%=((String) datosUs.get(3)).trim()%>">
                                <input type="submit" class="btn btn-success" value="Guardar cambios">
                            </div>
                        </form>                                       
                    </div>
                </div>
            </div>
            <!-- FIN MODAL EDITAR CONTRASEÑA -->

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
        </div>

        <!-- ***** INICIO FORMULARIO DESLOG ***** -->
        <form method="post" action="sesionServlet" name="deslogForm" id="deslogForm">
            <input type="hidden" name="opcion" value="deslog">
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
        <!-- MASK JQUERY -->
        <script type="text/javascript" src="js/principal/jquery.mask.js"></script>        
        <!-- QUERY PROPIAS - SELECT REGION & COMUNA -->
        <script src="js/querysPropias/regionYcomuna.js"></script>
        <!-- QUERY PROPIAS - VALIDACIÓN FORMULARIOS -->
        <script src="js/querysPropias/validacionForm.js"></script>
        <!-- QUERY PROPIAS - AJAX FORMULARIOS -->
        <script src="js/querysPropias/validacionesAjax.js"></script>
        <script src="js/querysPropias/imagen.js"></script>
        <!-- ********** FIN SCRIPTS ********** -->

    </body>
</html>  
<%

        } else {
            //OTRO ROL
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    } else {
        request.getRequestDispatcher("index.jsp").forward(request, response);

    }

    //NO HAY LOGIN
    request.removeAttribute("msjAlertGreen");
    request.removeAttribute("msjAlertRed");
    request.removeAttribute("msjModalShow");
%>