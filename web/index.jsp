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
                String msjAlertRed = (String) request.getAttribute("msjAlertRed");
                String msjAlertGreen = (String) request.getAttribute("msjAlertGreen");
                String msjAlertStyleRed = "";
                String msjAlertStyleGreen = "";

                if (msjAlertRed != null) {
                    msjAlertStyleRed = "display:block;";
                } else {
                    msjAlertStyleRed = "display:none;";
                }
                if (msjAlertGreen != null) {
                    msjAlertStyleGreen = "display:block;";
                } else {
                    msjAlertStyleGreen = "display:none;";
                }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>Login</title>
        
        <!-- ********** INICIO ESTILOS ********** --> 
        <!-- BOOSTSTRAP ESTILO -->
        <link rel="stylesheet" href="css/index/bootstrap.min.css">
        <!-- CND FONTAWESOME -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <!-- ESTILOS PROPIOS -->
        <link rel="stylesheet" href="css/index/index.css">
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
                                        <a href="http://linkedin.com/in/cristopher-perez-vargas-538916175">                                            
                                            <i class="fab fa-linkedin"></i>                                        
                                        </a>                                       
                                    </span>                                          
                                </li>
                                <li>
                                    <span>                                        
                                        <a href="https://www.facebook.com/EverCrips">                                            
                                            <i class="fab fa-facebook-f"></i>                                        
                                        </a>                                       
                                    </span>                                          
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="card-body">
                        <form action="sesionServlet" method="Post" id="formLogin">
                            <div id="msjAlert" class="alert alert-success" style="<%=msjAlertStyleGreen%>">
                                <i class="fas fa-times-circle"></i> <%=msjAlertGreen%>
                            </div>
                            <div id="msjAlert" class="alert alert-danger" style="<%=msjAlertStyleRed%>">
                                <i class="fas fa-times-circle"></i> <%=msjAlertRed%>
                            </div>
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-user-shield"></i></span>
                                </div>
                                <input id="emailUs" name="nickUs" type="text" class="form-control" placeholder="usuario" required>

                            </div>
                            <div class="input-group form-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                </div>
                                <input id="passUs" name="passUs" type="password" class="form-control" placeholder="contraseña" required>
                            </div>

                            <div class="form-group">
                                <input type="submit" value="Entrar" class="btn float-right login_btn">
                            </div>
                            <input type="hidden" name="opcion" value="login">
                        </form>
                    </div>
                    <div class="card-footer">
                        <div class="d-flex justify-content-center links">
                            ¿Cómo ingresar?
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
                            <li>Casilla usuario: ingresar nick empresa Tekkon</li>
                            <li>Casilla contraseña: ingresar contraseña asociada a la cuenta.</li>
                            <li>Entrar</li>
                            <hr>
                            <hr>
                            <li>Nombre de usuario y contraseña enviada a su casilla personal</li>
                            <hr>
                            <hr>
                            <li>¿No recuerda su cuenta? <a href="recuperarCuenta.jsp">click aquí</a></li>
                        </ul>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary login_btn" data-dismiss="modal">Listo</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- ********** INICIO SCRIPTS ********** -->       
        <!-- QUERY -->
        <script src="js/index/jquery.js"></script>          
        <!-- BOOSTSTRAP QUERY -->
        <script src="js/index/bootstrap.min.js"></script>
        <!-- QUERY PROPIAS -->
        <!-- ********** FIN SCRIPTS ********** -->
        
    </body>
</html>
<% }
%>
