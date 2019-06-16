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
        if (rolUs.equals("ADMINISTRADOR") || rolUs.equals("SUPERVISOR") || rolUs.equals("CAPATAZ") || rolUs.equals("TRABAJADOR")) {

            ArrayList datosAdm = (ArrayList) sesion.getAttribute("datosUsuario");
            ArrayList datosEquipos = (ArrayList) sesion.getAttribute("datosEquipos");
            ArrayList listaCapatazSinEquipo = (ArrayList) sesion.getAttribute("listaCapatazSinEquipo");
            ArrayList datosArchivos = (ArrayList) sesion.getAttribute("datosArchivos");

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
            String pls = "";
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

        <title>Contenidos Del Sistema</title>

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
        
        <!-- JQUERY -->
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"></script>

    </head>
    <script>
        $(document).ready(function () {          
            $(".add").click(function () {

                var valores = new Array();
                i = 0;

                $(this).parents("tr").find("td").each(function () {
                    valores[i] = $(this).html();
                    i++;
                });
                
                document.getElementById("idArchivo").value = valores[4];
                document.descargarArchivoCont.submit();
            });
        });
    </script>
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
                        <h1 class="page-header">Bienvenido al nuevo panel de Contenidos Descargables Del Sistema Tekonn</h1>                       
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="panelPrincipal.jsp">Inicio</a>
                            </li>
                            <li class="breadcrumb-item active">Contenidos</li>
                        </ol>
                    </div>
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
                                <i class="fas fa-paste"></i>Archivos Tekonn
                                <div class="pull-right">
                                    <div class="btn-group">
                                    </div>
                                </div>
                                <i class="fas fa-paper-plane" id="icoAddUs" data-toggle="modal" data-target="#agregarArchivo" title="Agregar nuevo Archivo"></i>
                            </div>
                            <div class="panel-body datosCuenta">                              
                                <div class="table-wrapper">
                                    <div class="table-title">
                                    </div>
                                    <div class="table-responsive">
                                        <table class="table table-striped table-hover" id="TablaContenidos" style="width:100%;">
                                            <thead>
                                                <tr>
                                                    <th>Nombre</th>
                                                    <th>Descripción</th>
                                                    <th>Tipo de archivo</th>
                                                    <th>Compartido por</th>
                                                    <th>Descargar</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    if (datosArchivos.get(0) == "null") {
                                                %>
                                                <tr>
                                                    <td style="display:none;"></td>
                                                </tr>                                    
                                                <%
                                                } else {
                                                    int i = 0;
                                                    while (i < datosArchivos.size()) {
                                                %>
                                                <tr>                                                               
                                                    <td><%=((String) datosArchivos.get(i)).trim()%></td>
                                                    <td><%=((String) datosArchivos.get(i + 1)).trim()%></td>
                                                    <td><%=((String) datosArchivos.get(i + 3)).trim()%></td>
                                                    <td><%=((String) datosArchivos.get(i + 4)).trim()%></td>
                                                    <td style="display:none;"><%=((String) datosArchivos.get(i + 2)).trim()%><td>
                                                        <a class="add" data-toggle="modal">
                                                            <i class="fas fa-share" data-toggle="tooltip" title="Descargar" style="cursor:pointer;">&#xE254;</i>
                                                        </a>
                                                    </td>
                                                </tr> 
                                                <%
                                                            i = i + 5;
                                                        }
                                                    }
                                                %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div> 
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

        <!-- MODAL SUBIR ARCHIVO -->
                <div id="agregarArchivo" class="modal fade">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <form method="post" action="conteServlet" enctype="multipart/form-data">
                                <div class="modal-header">						
                                    <h4 class="modal-title">Nuevo archivo</h4>
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                </div>
                                <div class="modal-body">
                                    <div class="container-fluid">
                                        <div class="row">
                                            <label for="archivoRutaSub" class="col-xs-12 col-sm-12 col-md-12 col-xl-12" style="text-align:center;">
                                                <div class="col-xs-12 col-sm-12 col-md-12 col-xl-12" id="subirArchivoDiv">
                                                    <i class="fas fa-upload"></i>
                                                    SUBIR ARCHIVO
                                                    <i class="fas fa-upload"></i>
                                                    <input type="file" style="display:none" id="archivoRutaSub" name="archivoRutaSub" required="">
                                                </div>
                                            </label>
                                        </div>
                                        <br>
                                        <!-- DATOS 1 -->
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6">
                                                <label>Nombre archivo</label>
                                                <input id="nombreArchivo" name="nombreArchivo" type="text" class="form-control" required="">
                                            </div>
                                            <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6">
                                            <label>Tipo archivo</label>
                                            <select id="tipoArchivo" name="tipoArchivo" class="form-control">
                                                <option value="IMAGEN">IMAGEN</option>
                                                <option value="AUDIO">AUDIO</option>
                                                <option value="VIDEO">VIDEO</option>
                                                <option value="PDF">PDF</option>
                                                <option value="WORD">WORD</option>
                                                <option value="POWERPOINT">POWERPOINT</option>
                                                <option value="EXCEL">EXCEL</option>
                                                <option value="OTROS">OTROS</option>
                                            </select>
                                            </div>
                                        </div>
                                        <br>
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-6 col-md-6 col-xl-6">
                                                <label>Descripción</label>
                                                <textarea class="form-control" rows="5" id="comment" required="" id="descripArchivo" name="descripArchivo"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <input type="hidden" name="emailUsActual" value="<%=((String) datosAdm.get(3)).trim()%>">
                                    <input type="hidden" name="opcion" value="crearArchivo">
                                </div>
                                <div class="modal-footer">
                                    <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancelar">
                                    <input type="submit" class="btn btn-success" value="Subir archivo">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
        <!-- FIN MODAL SUBIR ARCHIVO -->
        
        <!-- DESCARGAR ARCHIVO -->
        <form style="display:none;" method="post" action="conteServlet" name="descargarArchivoCont">
                    <input type="hidden" name="opcion" value="descargarArchivo">
                    <input type="hidden" id="idArchivo" name="idArchivo">
        </form>
        <!-- FIN DESCARGAR ARCHIVO -->

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
        
        <!-- MAIN JS -->    
        <script src="js/jsmodulosListas1.js"></script>

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





