/*
 *Diseñado y programado por Cristopher Pérez V.
 *Sistema Tekonn 2019
 */
package Controladores;

import Modelos.consultasPersonales;
import Modelos.CorreoElectronico;
import Modelos.consultasPanelExtra;
import Modelos.consultasPanelOperaciones;
import Modelos.consultasPanelUsuarios;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author EverCrips
 */
@WebServlet("/ingresoysalida")
@MultipartConfig
public class ingresoysalida extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            /*
             **
             ** AGREGAR PARA NO TENER PROBLEMAS DE TILDES Y Ñ
             ** request.setCharacterEncoding("UTF-8");
             **
             */
            request.setCharacterEncoding("UTF-8");
            /*
             *********************************************************************************
             */

            //PARA QUE NO ACCEDAN A SERVLET POR URL
            String opcionJSP = request.getParameter("opcion");

            if (opcionJSP == null) {
                request.getRequestDispatcher("index.jsp").forward(request, response);
            } else {
                HttpSession sesion;
                switch (opcionJSP) {
                    /*
                     **
                     **      LOGIN
                     **
                     */
                    case "login":

                        //OBTENGO DATOS DEL JSP
                        String nickUs = request.getParameter("nickUs");
                        String passUs = request.getParameter("passUs");

                        //CLASE JAVA
                        consultasPersonales conGen = new consultasPersonales();

                        //EXISTE CORREO REGISTRADO SI
                        if (conGen.existeNickUsuarioLogin(nickUs)) {

                            conGen = new consultasPersonales();
                            //CONTRASEÑA CORRECTA SI

                            if (conGen.contrastarNickPass(nickUs, passUs)) {

                                conGen = new consultasPersonales();
                                ArrayList email = new ArrayList();
                                email = conGen.ObtenerEmailUs(nickUs);
                                String emailUs = (String) email.get(0);

                                //CREAR LA SESION
                                sesion = request.getSession();

                                /*
                                 **
                                 **USUARIO QUE INGRESARÁ AL SISTEMA
                                 **
                                 */
                                conGen = new consultasPersonales();
                                //DATOS USUARIO LOGEADO
                                ArrayList listaUsuario = new ArrayList();
                                listaUsuario = conGen.ObtenerFullDatosUsuario(emailUs, passUs);

                                String rolUs = (String) listaUsuario.get(12);

                                sesion.setAttribute("datosUsuario", listaUsuario);
                                sesion.setAttribute("rolUs", rolUs);

                                conGen = new consultasPersonales();
                                ArrayList codAux = conGen.obtenerCodigoUs(emailUs);

                                /*
                                 **
                                 **USUARIOS DEL SISTEMA - CANTIDAD DE USUARIOS SISTEMA
                                 **
                                 */
                                consultasPanelUsuarios cpu = new consultasPanelUsuarios();
                                //USUARIOS DEL SISTEMA
                                ArrayList listaUsuarios = new ArrayList();
                                listaUsuarios = cpu.obtenerFullUsuarios(emailUs);
                                sesion.setAttribute("datosUsuarios", listaUsuarios);

                                cpu = new consultasPanelUsuarios();
                                int cantAdmAct = cpu.cantAdminAct();
                                sesion.setAttribute("cantAdmAct", cantAdmAct);
                                cpu = new consultasPanelUsuarios();
                                int cantAdmInac = cpu.cantAdminInac();
                                sesion.setAttribute("cantAdmInac", cantAdmInac);
                                cpu = new consultasPanelUsuarios();
                                int cantSuperAct = cpu.cantSuperAct();
                                sesion.setAttribute("cantSuperAct", cantSuperAct);
                                cpu = new consultasPanelUsuarios();
                                int cantSuperInac = cpu.cantSuperInac();
                                sesion.setAttribute("cantSuperInac", cantSuperInac);
                                ;
                                /*
                                 **
                                 **TRABAJADORES DEL SISTEMA - CANTIDAD DE TRABAJADORES SISTEMA
                                 **
                                 */
                                cpu = new consultasPanelUsuarios();
                                //USUARIOS DEL SISTEMA
                                ArrayList listaTrabajadores = new ArrayList();
                                listaTrabajadores = cpu.ObtenerFullTrabajadores(emailUs);
                                sesion.setAttribute("datosTrabajadores", listaTrabajadores);

                                cpu = new consultasPanelUsuarios();
                                int cantCapaAct = cpu.cantCapaAct();
                                sesion.setAttribute("cantCapaAct", cantCapaAct);
                                cpu = new consultasPanelUsuarios();
                                int cantCapaInac = cpu.cantCapaInac();
                                sesion.setAttribute("cantCapaInac", cantCapaInac);
                                cpu = new consultasPanelUsuarios();
                                int cantTraAct = cpu.cantTraAct();
                                sesion.setAttribute("cantTraAct", cantTraAct);
                                cpu = new consultasPanelUsuarios();
                                int cantTraInac = cpu.cantTraInac();
                                sesion.setAttribute("cantTraInac", cantTraInac);

                                /*
                                 **
                                 **CARGOS Y ZONAS
                                 **
                                 */
                                //CARGOS
                                consultasPanelOperaciones cpo = new consultasPanelOperaciones();
                                ArrayList listaCargos = new ArrayList();
                                listaCargos = cpo.obtenerDatosCargos();
                                sesion.setAttribute("datosCargos", listaCargos);

                                //ZONAS
                                cpo = new consultasPanelOperaciones();
                                ArrayList listaZonas = new ArrayList();
                                listaZonas = cpo.obtenerZonasAccion();
                                sesion.setAttribute("datosZonasOperacion", listaZonas);

                                /*
                                 **
                                 **EQUIPOS DEL SISTEMA
                                 **
                                 */
                                //TODOS LOS EQUIPOS
                                cpu = new consultasPanelUsuarios();
                                ArrayList listaEquipos = new ArrayList();
                                listaEquipos = cpu.obtenerDatosEquiposTrabajo();
                                sesion.setAttribute("datosEquipos", listaEquipos);

                                //TODOS LOS CAPATAZ SIN EQUIPO
                                cpu = new consultasPanelUsuarios();
                                ArrayList listaCapatazSinEquipo = new ArrayList();
                                listaCapatazSinEquipo = cpu.obtenerCapatazSinEquipo();
                                sesion.setAttribute("listaCapatazSinEquipo", listaCapatazSinEquipo);

                                //TODOS LOS TRABAJADORES SIN EQUIPO
                                cpu = new consultasPanelUsuarios();
                                ArrayList listaTrabajadoresSinEquipo = new ArrayList();
                                listaTrabajadoresSinEquipo = cpu.obtenerTrabajadoresSinEquipo();
                                sesion.setAttribute("datosTrabajadoresSinEquipo", listaTrabajadoresSinEquipo);

                                /*
                                 **
                                 **OPERACIONES
                                 **
                                 */
                                cpo = new consultasPanelOperaciones();
                                ArrayList listaOperacionesCapataz = new ArrayList();
                                listaOperacionesCapataz = cpo.obtenerOperacionesCapataz((String) codAux.get(0));
                                sesion.setAttribute("datosOperacionesCapataz", listaOperacionesCapataz);
                                cpo = new consultasPanelOperaciones();
                                ArrayList listaOperacionesGeneral = new ArrayList();
                                listaOperacionesGeneral = cpo.obtenerOperacionesGeneral();
                                sesion.setAttribute("datosOperacionesGeneral", listaOperacionesGeneral);

                                //CANTIDAD OPERACIONES PENDIENTES, EN MARCHA, RECHAZADAS Y FINALIZADAS GENERAL
                                cpo = new consultasPanelOperaciones();
                                int cantOpePendiente = cpo.cantOpePendiente();
                                sesion.setAttribute("cantOpePendiente", cantOpePendiente);
                                cpo = new consultasPanelOperaciones();
                                int cantOpeEnMarcha = cpo.cantOpeEnMarcha();
                                sesion.setAttribute("cantOpeEnMarcha", cantOpeEnMarcha);
                                cpo = new consultasPanelOperaciones();
                                int cantOpeRechazada = cpo.cantOpeRechazada();
                                sesion.setAttribute("cantOpeRechazada", cantOpeRechazada);
                                cpo = new consultasPanelOperaciones();
                                int cantOpeFinalizada = cpo.cantOpeFinalizada();
                                sesion.setAttribute("cantOpeFinalizada", cantOpeFinalizada);

                                //CANTIDAD OPERACIONES PENDIENTES, EN MARCHA, RECHAZADAS Y FINALIZADAS CAPATAZ
                                cpo = new consultasPanelOperaciones();
                                int cantOpePendienteCapataz = cpo.cantOpePendienteCapataz((String) codAux.get(0));
                                sesion.setAttribute("cantOpePendienteCapataz", cantOpePendienteCapataz);
                                cpo = new consultasPanelOperaciones();
                                int cantOpeEnMarchaCapataz = cpo.cantOpeEnMarchaCapataz((String) codAux.get(0));
                                sesion.setAttribute("cantOpeEnMarchaCapataz", cantOpeEnMarchaCapataz);
                                cpo = new consultasPanelOperaciones();
                                int cantOpeRechazadaCapataz = cpo.cantOpeRechazadaCapataz((String) codAux.get(0));
                                sesion.setAttribute("cantOpeRechazadaCapataz", cantOpeRechazadaCapataz);
                                cpo = new consultasPanelOperaciones();
                                int cantOpeFinalizadaCapataz = cpo.cantOpeFinalizadaCapataz((String) codAux.get(0));
                                sesion.setAttribute("cantOpeFinalizadaCapataz", cantOpeFinalizadaCapataz);

                                //AVISOS
                                consultasPanelExtra cpe = new consultasPanelExtra();
                                ArrayList listaAvisos = new ArrayList();
                                listaAvisos = cpe.obtenerAvisos();
                                sesion.setAttribute("listaAvisos", listaAvisos);

                                //ROL CAPATAZ O TRABAJADOR
                                if (rolUs.equals("CAPATAZ") || rolUs.equals("TRABAJADOR")) {
                                    //EQUIPO
                                    consultasPersonales cpe2 = new consultasPersonales();
                                    ArrayList aux1 = new ArrayList();
                                    aux1 = cpe2.obtenerCodigoUs(emailUs);
                                    ArrayList auxCod = new ArrayList();
                                    cpe2 = new consultasPersonales();
                                    auxCod = cpe2.obtenerCodigoEquipo((String) aux1.get(0));
                                    consultasPanelUsuarios cpu2 = new consultasPanelUsuarios();
                                    ArrayList auxListDatEq = new ArrayList();
                                    auxListDatEq = cpu2.obtenerDatosEquipoSelec((String) auxCod.get(0));
                                    sesion.setAttribute("listaVisualizarTrabajadorDa", auxListDatEq);
                                    cpu2 = new consultasPanelUsuarios();
                                    ArrayList auxListUsEq = new ArrayList();
                                    auxListUsEq = cpu2.obtenerTrabajadoresEquipoSelec((String) auxCod.get(0));
                                    sesion.setAttribute("listaVisualizarTrabajadorUs", auxListUsEq);

                                    //OPERACIONES                                   
                                    cpe2 = new consultasPersonales();
                                    ArrayList auxEmCp = new ArrayList();
                                    auxEmCp = cpe2.obtenerEmailCapatazEquipo((String) auxCod.get(0));
                                    cpe2 = new consultasPersonales();
                                    ArrayList auxCodCap = new ArrayList();
                                    auxCodCap = cpe2.obtenerCodigoUs((String) auxEmCp.get(0));
                                    consultasPanelOperaciones cpo2 = new consultasPanelOperaciones();
                                    ArrayList listaVisualizarTrabajadorOpe = new ArrayList();
                                    listaVisualizarTrabajadorOpe = cpo2.obtenerOperacionesCapataz((String) auxCodCap.get(0));
                                    sesion.setAttribute("listaVisualizarTrabajadorOpe", listaVisualizarTrabajadorOpe);

                                }
                                
                                /*
                                ** TODOS LOS ARCHIVOS EN CONTENIDO
                                */
                                consultasPanelExtra cpl = new consultasPanelExtra();
                                ArrayList contenidos = new ArrayList();
                                contenidos = cpl.DatosContenidos(); // Revisar
                                sesion.setAttribute("datosArchivos", contenidos);

                                //REDIRECCIONO A PÁGINA PRINCIPAL
                                request.getRequestDispatcher("panelPrincipal.jsp").forward(request, response);
                            } else {
                                //ATRIBUTO MENSAJE ALERTA
                                request.setAttribute("msjAlertRed", "La contraseña con el correo no coinciden.");
                                request.getRequestDispatcher("index.jsp").forward(request, response);
                            }
                            //EXISTE CORREO REGISTRADO NO   
                        } else {
                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertRed", "No existe usuario registrado");
                            request.getRequestDispatcher("index.jsp").forward(request, response);
                        }
                        break;
                    /*
                     **
                     **      DESLOG
                     **
                     */
                    case "deslog":
                        //OBTENER SESION
                        sesion = request.getSession(false);
                        //SI ES DISTINTO DE NULL, EXISTE... POR ENDE SE DEBE ELIMINAR LOS ATRIBUTOS E INVALIDARLA
                        if (sesion != null) {

                            sesion.removeAttribute("datosUsuario");
                            sesion.removeAttribute("rolUs");
                            sesion.removeAttribute("datosUsuarios");
                            sesion.removeAttribute("cantAdmAct");
                            sesion.removeAttribute("cantAdmInac");
                            sesion.removeAttribute("cantSuperAct");
                            sesion.removeAttribute("cantSuperInac");
                            sesion.removeAttribute("datosTrabajadores");
                            sesion.removeAttribute("cantCapaAct");
                            sesion.removeAttribute("cantCapaInac");
                            sesion.removeAttribute("cantTraAct");
                            sesion.removeAttribute("cantTraInac");
                            sesion.removeAttribute("datosCargos");
                            sesion.removeAttribute("datosZonasOperacion");
                            sesion.removeAttribute("datosEquipos");
                            sesion.removeAttribute("listaCapatazSinEquipo");
                            sesion.removeAttribute("datosTrabajadoresSinEquipo");
                            sesion.removeAttribute("datosOperacionesCapataz");
                            sesion.removeAttribute("datosOperacionesGeneral");
                            sesion.removeAttribute("cantOpePendiente");
                            sesion.removeAttribute("cantOpeEnMarcha");
                            sesion.removeAttribute("cantOpeRechazada");
                            sesion.removeAttribute("cantOpeFinalizada");
                            sesion.removeAttribute("cantOpePendienteCapataz");
                            sesion.removeAttribute("cantOpeEnMarchaCapataz");
                            sesion.removeAttribute("cantOpeRechazadaCapataz");
                            sesion.removeAttribute("cantOpeFinalizadaCapataz");
                            sesion.removeAttribute("listaAvisos");
                            sesion.removeAttribute("listaVisualizarTrabajadorDa");
                            sesion.removeAttribute("listaVisualizarTrabajadorUs");
                            sesion.removeAttribute("listaVisualizarTrabajadorOpe");

                            sesion.invalidate();

                            //REDIRECCIONAR A INDEX
                            request.getRequestDispatcher("index.jsp").forward(request, response);
                        }
                        break;
                    /*
                     **
                     **      MODIFICAR DATOS CUENTA USUARIO ACTIVO
                     **
                     */
                    case "modificarDatosDatos":
                        //OBTENGO DATOS DEL JSP
                        String emailUsActual = request.getParameter("emailUsActual");
                        String emailUs2 = request.getParameter("emailUs");
                        String fonofijoUs2 = request.getParameter("fonofijoUs");
                        String telefonocelularUs2 = request.getParameter("telefonocelularUs");

                        String direccionUs2 = request.getParameter("direccionUs");
                        String ciudadUs2 = request.getParameter("ciudadUs");
                        String regionUs2 = request.getParameter("regionUs");
                        String comunaUs2 = request.getParameter("comunaUs");

                        //CLASE JAVA
                        consultasPersonales conGen2 = new consultasPersonales();

                        //VALIDO QUE EL CORREO SEA EL MISMO
                        if (emailUsActual.equals(emailUs2)) {
                            //MODIFICO
                            if (conGen2.modificarUsDatosPersonales(emailUs2, fonofijoUs2, telefonocelularUs2, direccionUs2, ciudadUs2, regionUs2, comunaUs2, emailUsActual)) {

                                //OBTENER SESION
                                sesion = request.getSession(false);

                                /*
                                 **
                                 **USUARIO QUE INGRESARÁ AL SISTEMA
                                 **
                                 */
                                conGen = new consultasPersonales();

                                //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS CON LA FUNCIÓN
                                ArrayList listaUsuario = new ArrayList();
                                listaUsuario = conGen.ObtenerFullDatosUsuarioSinPass(emailUs2);

                                //LISTA CON LOS DATOS PARA CUANDO SE INGRESE CON UNO USUARIO VERIDICO
                                sesion.setAttribute("datosUsuario", listaUsuario);

                                //CATEGORIA USUARIO
                                String rolUs = (String) listaUsuario.get(12);

                                //ROL SESION
                                sesion.setAttribute("rolUs", rolUs);

                                //ATRIBUTO MENSAJE ALERTA
                                request.setAttribute("msjAlertGreen", "Se han guardado los datos satisfactoriamente.");
                                request.setAttribute("msjModalShow", "Valido");

                                //REDIRECCIONO A PÁGINA PRINCIPAL
                                request.getRequestDispatcher("panelPrincipalDatosCuenta.jsp").forward(request, response);

                            } else {
                                //ATRIBUTO MENSAJE ALERTA
                                request.setAttribute("msjAlertRed", "Ha ocurrido un error al procesar los cambios.");
                                request.setAttribute("msjModalShow", "Valido");
                                request.getRequestDispatcher("panelPrincipalDatosCuenta.jsp").forward(request, response);
                            }
                            //NO SON EL MISMO
                        } else {

                            //MODIFICO
                            if (conGen2.modificarUsDatosPersonales(emailUs2, fonofijoUs2, telefonocelularUs2, direccionUs2, ciudadUs2, regionUs2, comunaUs2, emailUsActual)) {

                                //OBTENER SESION
                                sesion = request.getSession(false);

                                /*
                                 **
                                 **USUARIO QUE INGRESARÁ AL SISTEMA
                                 **
                                 */
                                conGen = new consultasPersonales();

                                //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS CON LA FUNCIÓN
                                ArrayList listaUsuario = new ArrayList();
                                listaUsuario = conGen.ObtenerFullDatosUsuarioSinPass(emailUs2);

                                //LISTA CON LOS DATOS PARA CUANDO SE INGRESE CON UNO USUARIO VERIDICO
                                sesion.setAttribute("datosUsuario", listaUsuario);

                                //CATEGORIA USUARIO
                                String rolUs = (String) listaUsuario.get(12);

                                //ROL SESION
                                sesion.setAttribute("rolUs", rolUs);

                                //ATRIBUTO MENSAJE ALERTA
                                request.setAttribute("msjAlertGreen", "Se han guardado los datos satisfactoriamente.");
                                request.setAttribute("msjModalShow", "Valido");

                                //REDIRECCIONO A PÁGINA PRINCIPAL
                                request.getRequestDispatcher("panelPrincipalDatosCuenta.jsp").forward(request, response);

                            } else {
                                //ATRIBUTO MENSAJE ALERTA
                                request.setAttribute("msjAlertRed", "Ha ocurrido un error al procesar los cambios.");
                                request.setAttribute("msjModalShow", "Valido");
                                request.getRequestDispatcher("panelPrincipalDatosCuenta.jsp").forward(request, response);
                            }
                        }

                        break;

                    case "modificarDatosPass":
                        //OBTENGO DATOS DEL JSP
                        String emailUsActual3 = request.getParameter("emailUsActual");

                        String pass1UsEdit = request.getParameter("pass1UsEdit");

                        //CLASE JAVA
                        consultasPersonales conGen3 = new consultasPersonales();

                        if (conGen3.modificarUsPass(pass1UsEdit, emailUsActual3)) {

                            //OBTENER SESION
                            sesion = request.getSession(false);

                            /*
                             **
                             **USUARIO QUE INGRESARÁ AL SISTEMA
                             **
                             */
                            conGen = new consultasPersonales();

                            //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS CON LA FUNCIÓN
                            ArrayList listaUsuario = new ArrayList();
                            listaUsuario = conGen.ObtenerFullDatosUsuarioSinPass(emailUsActual3);

                            //CATEGORIA USUARIO
                            String rolUs = (String) listaUsuario.get(12);

                            //LISTA CON LOS DATOS PARA CUANDO SE INGRESE CON UNO USUARIO VERIDICO
                            sesion.setAttribute("datosUsuario", listaUsuario);

                            //ROL SESION
                            sesion.setAttribute("rolUs", rolUs);

                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertGreen", "Se han guardado los datos satisfactoriamente.");
                            request.setAttribute("msjModalShow", "Valido");

                            //REDIRECCIONO A PÁGINA PRINCIPAL
                            request.getRequestDispatcher("panelPrincipalDatosCuenta.jsp").forward(request, response);

                        } else {
                            request.setAttribute("msjAlertRed", "Ha ocurrido un error al procesar los cambios.");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("panelPrincipalDatosCuenta.jsp").forward(request, response);
                        }

                        break;

                    case "modificarDatosImagen":

                        //OBTENGO DATOS DEL JSP
                        String emailUsActual4 = request.getParameter("emailUsActual");

                        // Obtiene <input type="file" name="imagenPerfilUser">
                        Part filePart = request.getPart("imagenPerfilUser"); // Retrieves <input type="file" name="file">

                        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.

                        //QUITAR .
                        String rutaNueva = emailUsActual4.replace(".", "");

                        fileName = "foto" + rutaNueva + "perfil.png";

                        InputStream fileContent = filePart.getInputStream();

                        byte[] buffer = new byte[fileContent.available()];

                        fileContent.read(buffer);

                        File targetFile = new File("C:\\Users\\MSI-EverCrips\\Desktop\\New Tekonn\\web\\media\\imagenes\\perfilFotos\\" + fileName);

                        OutputStream outStream = new FileOutputStream(targetFile);

                        outStream.write(buffer);

                        String ruta = "media/imagenes/perfilFotos/" + fileName;

                        consultasPersonales conGee = new consultasPersonales();

                        if (conGee.modificarUsFotoPerfil(ruta, emailUsActual4)) {//CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS CON LA FUNCIÓN
                            //OBTENER SESION
                            sesion = request.getSession(false);

                            conGee = new consultasPersonales();

                            ArrayList listaUsuario = new ArrayList();
                            listaUsuario = conGee.ObtenerFullDatosUsuarioSinPass(emailUsActual4);

                            //CATEGORIA USUARIO
                            String rolUs = (String) listaUsuario.get(12);

                            //LISTA CON LOS DATOS PARA CUANDO SE INGRESE CON UNO USUARIO VERIDICO
                            sesion.setAttribute("datosUsuario", listaUsuario);

                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertGreen", "Imagen modificada correctamente. Los cambios se verán reflejados dentro de unos minutos.");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("panelPrincipalDatosCuenta.jsp").forward(request, response);
                        } else {
                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertRed", "Ha ocurrido un error al procesar los cambios.");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("panelPrincipalDatosCuenta.jsp").forward(request, response);
                        }

                        break;
                    /*
                     **
                     **      BUSCAR CUENTA Y MODIFICAR PASS
                     **
                     */
                    case "buscarCuentaPass":
                        //OBTENGO DATOS DEL JSP
                        String busquedaPassEmail = request.getParameter("busquedaPassEmail");

                        consultasPersonales conGe = new consultasPersonales();

                        //Existe correo
                        if (conGe.existeCorreo(busquedaPassEmail)) {

                            conGe = new consultasPersonales();
                            //OBTENER DATOS
                            //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS DEL USUARIO
                            ArrayList cuentaBusquedaPass = new ArrayList();
                            cuentaBusquedaPass = conGe.ObtenerDatosCuentaBusquedaPass(busquedaPassEmail);

                            //OBTENER SESION
                            sesion = request.getSession(false);
                            //LISTA CON LOS DATOS DE LA CUENTA A BUSCAR
                            sesion.setAttribute("cuentaBusquedaPass", cuentaBusquedaPass);

                            //AUXILIAR
                            sesion.setAttribute("auxPassBusqueda", "auxiliar");
                            request.getRequestDispatcher("recuperarPassUser.jsp").forward(request, response);
                            //No existe correo
                        } else {
                            request.setAttribute("msjAlertRed", "Correo no existente.");
                            request.getRequestDispatcher("recuperarPassUser.jsp").forward(request, response);
                        }

                        break;

                    case "redireccionPagCod":
                        //OBTENGO DATOS DEL JSP
                        String busquedaPassEmail2 = request.getParameter("busquedaPassEmail");
                        CorreoElectronico cor;
                        cor = new CorreoElectronico();

                        String codiTemp = "";
                        codiTemp = cor.generarCodigoResetPass();

                        consultasPersonales con = new consultasPersonales();
                        //SI EXISTE
                        String plantilla = "Se ha recibido una petición para resetear la contraseña actual de la cuenta: " + busquedaPassEmail2 + ".\nA continuación, se otorga un código temporal para poder resetear la contrasela:\n"
                                + "---------------------------------------------------------------------------------------\nCODIGO TEMPORAL: " + codiTemp + "\n---------------------------------------------------------------------------------------\n"
                                + "---------------------------------------------------------------------------------------\n"
                                + "Si usted no ha solicitado un cambio de contraseña, ignorar dicho correo.\nAtte. Administración Tekonn";

                        con = new consultasPersonales();
                        //MODIFICO EL CODIGO DE LA CUENTA
                        if (con.modificarCodigoVerificación(busquedaPassEmail2, codiTemp)) {

                            cor = new CorreoElectronico();
                            //VERIFICAR QUE SE ENVIA EL CORREO CON EL CODIGO                           
                            if (cor.enviarCorreoContraseñaPerdidaUsuario(plantilla, busquedaPassEmail2)) {
                                conGe = new consultasPersonales();
                                //OBTENER DATOS
                                //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS DEL USUARIO
                                ArrayList cuentaBusquedaPass = new ArrayList();
                                cuentaBusquedaPass = conGe.ObtenerDatosCuentaBusquedaPass(busquedaPassEmail2);

                                //OBTENER SESION
                                sesion = request.getSession(false);
                                //LISTA CON LOS DATOS DE LA CUENTA A BUSCAR
                                sesion.setAttribute("cuentaBusquedaPass", cuentaBusquedaPass);

                                //AUXILIAR
                                sesion.setAttribute("auxPassBusqueda2", "auxiliar");

                                request.setAttribute("msjAlertGreen", "Un correo ha sido enviado a su casilla con su código temporal.");
                                request.getRequestDispatcher("recuperarPassUserNextPag.jsp").forward(request, response);
                            } else {
                                //NO SE MODIFICO
                                request.setAttribute("msjAlertRed", "Ha ocurrido un error al procesar el correo. Intente más tarde por favor.");
                                request.getRequestDispatcher("recuperarPassUser.jsp").forward(request, response);
                            }

                        } else {
                            //NO SE MODIFICO
                            request.setAttribute("msjAlertRed", "Ha ocurrido un error involuntario. Intente más tarde por favor.");
                            request.getRequestDispatcher("recuperarPassUser.jsp").forward(request, response);
                        }

                        break;
                    case "modificarPassCod":
                        //OBTENGO DATOS DEL JSP
                        String busquedaPassEmail3 = request.getParameter("correoCuentaMod");

                        String pass1 = request.getParameter("pass1");
                        String pass2 = request.getParameter("pass2");

                        String codigoVer = request.getParameter("codigoVer");

                        //OBTENER SESION
                        sesion = request.getSession(false);

                        //CONTRASEÑAS IGUALES
                        if (pass1.equals(pass2)) {
                            //SE VALIDA QUE EL CÓDIGO SEA EL QUE POSEA EL USUARIO
                            consultasPersonales conGe2 = new consultasPersonales();
                            if (conGe2.validarCodigoVerificar(busquedaPassEmail3, codigoVer)) {
                                //MODIFICO CONTRASEÑA
                                conGe2 = new consultasPersonales();
                                //ÉXITO
                                if (conGe2.modificarUsPass(busquedaPassEmail3, pass1)) {

                                    //AUXILIAR
                                    sesion.setAttribute("auxPassBusqueda3", "auxiliar");

                                    request.getRequestDispatcher("recuperarPassOkey.jsp").forward(request, response);

                                } else {
                                    //NO SE MODIFICO
                                    sesion.setAttribute("auxPassBusqueda2", "auxiliar");
                                    request.setAttribute("msjAlertRed", "Ha ocurrido un error al procesar la solicitud. Intente nuevamente por favor.");
                                    request.getRequestDispatcher("recuperarPassUserNextPag.jsp").forward(request, response);
                                }
                            } else {
                                //NO SE MODIFICO
                                sesion.setAttribute("auxPassBusqueda2", "auxiliar");
                                request.setAttribute("msjAlertRed", "El código ingresado no concuerda. Intente nuevamente por favor.");
                                request.getRequestDispatcher("recuperarPassUserNextPag.jsp").forward(request, response);
                            }
                        } else {
                            //NO SE MODIFICO                        
                            //AUXILIAR
                            sesion.setAttribute("auxPassBusqueda2", "auxiliar");
                            request.setAttribute("msjAlertRed", "Las contraseñas no concuerdan. Intente nuevamente por favor.");
                            request.getRequestDispatcher("recuperarPassUserNextPag.jsp").forward(request, response);
                        }

                        break;

                }

            }
        }
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
