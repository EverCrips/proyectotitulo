<!--
    *Diseñado y programado por Cristopher Pérez V.
    *Sistema Tekonn 2019
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //SE OBTIENE LA SESION
    HttpSession sesion = request.getSession(false);
    String rolUs = (String) sesion.getAttribute("rolUs");
    //SI EL ROL ES DISTINTO DE NULL, SE ESCOJE LA VISTA CORRESPONDIENTE
    if (rolUs != null) {
        request.getRequestDispatcher("panelPrincipal.jsp").forward(request, response);
    } else {
        //MANEJO DE ERROES
        String msjModalShow = (String) request.getAttribute("msjModalShow");

        int opcionModalShowJs = 0;

        if (msjModalShow != null) {
            opcionModalShowJs = 1;
        }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Login - Aux</title>

        <!-- ********** INICIO ESTILOS ********** --> 
        <!-- BOOSTSTRAP ESTILO -->
        <link rel="stylesheet" href="css/index/bootstrap.min.css">
        <!-- CND FONTAWESOME -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <!-- ESTILOS PROPIOS -->
        <link rel="stylesheet" href="css/index/index.css">
        <link rel="stylesheet" href="css/estilosPropios/propios.css">
        <!-- ********** FIN ESTILOS ********** -->

    </head>
    <body>

        <div class="container">
            <div class="d-flex justify-content-center h-100">
                <div class="card">
                    <div class="card-header">
                        <img id="imgLogo" src="media/imagenes/logo.png" alt="logoTekonn" style="max-width: 200px; max-height: 100px;"/>
                        <div class="d-flex justify-content-end social_icon">
                            <ul> 
                                <li>
                                    <span>                                        
                                        <a href="index.jsp">                                            
                                            <i class="fas fa-undo-alt"></i>                                        
                                        </a>                                       
                                    </span>                                          
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="card-body">

                        <div class="input-group form-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-at"></i></span>
                            </div>
                            <input id="emailUsRP" name="emailUsRP" type="text" class="form-control" placeholder="Correo electrónico asociado a tu cuenta" required="">
                        </div>
                        <div id="divcodigoUsRP" class="input-group form-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-code-branch"></i></i></span>
                            </div>
                            <input id="codigoUsRP" name="codigoUsRP" type="text" class="form-control" placeholder="Código único asociado a tu cuenta" required="" >
                        </div>   

                    </div>   
                    <div class="card-footer">
                        <div class="d-flex justify-content-center links">
                            ¿Cómo funciona?
                        </div>
                        <div class="d-flex justify-content-center">
                            <a data-toggle="modal" href="#modallog" id="alogin" >Click acá</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>     

        <!-- Modal -->
        <div class="modal fade" id="modallog" tabindex="-1" role="dialog" aria-labelledby="modallog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <img id="imgLogo" src="media/imagenes/logo.png" alt="logoTekonn" style="max-width: 200px; max-height: 100px;"/>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Pasos a seguir
                        <ul> 
                            <li>Ingresar dirección de correo electrónico asociado a la cuenta.</li>
                            <li>Si el correo está registrado y es fidedigno, se enviará un código para restablecer la contraseña a dicha casilla.</li>
                            <li>Con el código en mano, rellenar las casillas que aparecen para poder restablecer la contraseña.</li>
                            <hr>
                            <hr>
                            <li>Si no recuerda la dirección de correo electrónico, contactar con la administración
                                enviando un correo con el asunto "TKN Pass" o acercarse a una de las oficinas de administración.</li>
                            <hr>
                            <hr>
                        </ul>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary login_btn" data-dismiss="modal">Listo</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- INICIO DIV AVISOS EXITO ERROR -->
        <input type="hidden" name="modalShowJs" value="<%=opcionModalShowJs%>" id="modalShowJs">       
        <div id="modalExitoError" class="modal fade" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog" id="meu" style="max-width: 400px;">
                <div class="modal-content">     
                    <form action="servletEx" method="post" id="divNewPC">
                        <div class="modal-header">
                            <img id="imgLogo" src="media/imagenes/logo.png" alt="logoTekonn" style="max-width: 200px; max-height: 100px;"/>
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
                                                    <p id="pExitoErrorRP">

                                                    </p>

                                                    <div id="auxauxDiv">
                                                        <div class="row">
                                                            <div class="col-xs-12 col-sm-12 col-md-12"> 
                                                                <input value="contraseña nueva" autofocus="autofocus" id="pass1Us" name="pass1UsEdit" type="password" class="form-control" min="6" max="10" title="Entre 8 y 20 caracteres. Se aceptan mayúsculas, minúsculas, letras, números y !._%#@?-" required >
                                                                <i class="fas fa-check-circle" id="checkPass1"></i>
                                                                <i class="fas fa-times-circle" id="nocheckPass1"></i>
                                                            </div>
                                                        </div>
                                                        <br>
                                                        <div class="row">
                                                            <div class="col-xs-12 col-sm-12 col-md-12">                                               
                                                                <input value="reingresar contraseña nueva" id="pass2Us" name="pass2UsEdit" type="password" class="form-control" min="6" max="10" title="Entre 8 y 20 caracteres. Se aceptan mayúsculas, minúsculas, letras, números y !._%#@?-" required >
                                                                <i class="fas fa-check-circle" id="checkPass2"></i>
                                                                <i class="fas fa-times-circle" id="nocheckPass2"></i>
                                                            </div>
                                                        </div>
                                                        <hr>
                                                        <p class="text-warning"><small>¡Guarde su contraseña para posterior uso!</small></p>
                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                    </div> 
                                </div>
                            </div>
                            <input type="hidden" name="opcion" value="modificarPassNueva">
                            <input type="hidden" name="auxemailUsRP" id="auxemailUsRP">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-dismiss="modal" id="buttonARP" >Aceptar</button>
                            <input type="submit" class="btn btn-danger" value="Modificar contraseña" id="buttonMRP">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- FIN DIV AVISOS EXITO ERROR -->

        <!-- ********** INICIO SCRIPTS ********** -->       
        <!-- QUERY -->
        <script src="js/principal/jquery.js"></script>          
        <!-- BOOSTSTRAP QUERY -->
        <script src="js/index/bootstrap.min.js"></script>
        <!-- MASK JQUERY -->
        <script type="text/javascript" src="js/principal/jquery.mask.js"></script>
        <!-- QUERY PROPIAS -->
        <script src="js/querysPropias/validacionesAjax.js"></script>
        <script src="js/querysPropias/validacionForm.js"></script>
        <!-- ********** FIN SCRIPTS ********** -->

    </body>
</html>
<% }
%>
