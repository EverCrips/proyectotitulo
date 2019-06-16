/*
    *Diseñado y programado por Cristopher Pérez V.
    *Sistema Tekonn 2019
*/
package Controladores;

import Modelos.consultasPersonales;
import Modelos.CorreoElectronico;
import Modelos.consultasPanelUsuarios;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Cristopher
 */
public class servletPanelUsuarios extends HttpServlet {

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
                     PANEL USUARIOS
                     */
                    case "crearNuevoUsuario":

                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP
                        String nombreUs = request.getParameter("nombreUs");
                        String apellidosUs = request.getParameter("apellidosUs");
                        String rutUs = request.getParameter("rutUs");
                        String sexoUs = request.getParameter("sexoUs");

                        String emailUs = request.getParameter("emailUs");
                        String fonofijoUs = request.getParameter("fonofijoUs");
                        String telefonocelularUs = request.getParameter("telefonocelularUs");

                        String direccionUs = request.getParameter("direccionUs");
                        String ciudadUs = request.getParameter("ciudadUs");
                        String regionUs = request.getParameter("regionUs");
                        String comunaUs = request.getParameter("comunaUs");

                        String empresaUs = request.getParameter("empresaUs");
                        String cargoUs = request.getParameter("cargoUs");
                        String rolUs = request.getParameter("rolUs");

                        String nombreCompleto = nombreUs + " " + apellidosUs;

                        //CREACION NICK USUARIO UNICO
                        consultasPanelUsuarios cpu = new consultasPanelUsuarios();

                        String nickUs = cpu.crearNick(nombreUs, apellidosUs);

                        String nickAux = nickUs;

                        while (cpu.existeNick(nickUs)) {
                            //EL NICK EXISTE, HAY QUE CREAR OTRO
                            //RESET NICK
                            nickUs = nickAux;
                            Random random = new Random();
                            nickUs = nickUs + random.nextInt(9);
                            cpu = new consultasPanelUsuarios();
                        }

                        cpu = new consultasPanelUsuarios();
                        //REGISTRANDO NUEVO USUARIO DE SISTEMA
                        if (cpu.registrarUsSistema(nombreCompleto, rutUs, sexoUs, emailUs, fonofijoUs, telefonocelularUs, direccionUs, ciudadUs,
                                regionUs, comunaUs, empresaUs, nickUs, Integer.parseInt(cargoUs), Integer.parseInt(rolUs))) {

                            ArrayList datosUsuario = (ArrayList) sesion.getAttribute("datosUsuario");

                            cpu = new consultasPanelUsuarios();
                            //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS DE LOS USUARIOS DEL SISTEMA
                            ArrayList listaUsuarios = new ArrayList();
                            listaUsuarios = cpu.obtenerFullUsuarios((String) datosUsuario.get(3));

                            //LISTA CON LOS DATOS DE LOS USUARIOS DEL SISTEMA
                            sesion.setAttribute("datosUsuarios", listaUsuarios);

                            //EMAIL
                            CorreoElectronico cor;
                            cor = new CorreoElectronico();

                            consultasPersonales con = new consultasPersonales();

                            String plantilla = "¡Bienvenido al Sistema Innovación Tekonn!\nA continuación, se detalla el proceso y los datos necesarios para poder hacer ingreso al sistema web.\n"
                                    + "---------------------------------------------------------------------------------------\n*Ingresar a www.STekonn.cl\n*Nombre usuario: " + nickUs + "\n*Contraseña: 123456asdfg\n*Se recomienda utilizar navegador Firefox y modificar la contraseña en primer ingreso\n"
                                    + "---------------------------------------------------------------------------------------\n"
                                    + "El correo es enviado de forma automática, por favor no responder.\nAtte. Administración Tekonn";

                            if (cor.enviarCorreoIngreso(plantilla, emailUs)) {

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

                                //CORRECTO
                                request.setAttribute("msjAlertGreen", "Usuario creado correctamente.");
                                request.setAttribute("msjModalShow", "Valido");
                                request.getRequestDispatcher("moduloUsuarios.jsp").forward(request, response);
                            } else {
                                //INCORRECTO
                                request.setAttribute("msjAlertRed", "El usuario ha sido creado pero ocurrió un error al enviar el mensaje de confirmación.");
                                request.setAttribute("msjModalShow", "Valido");
                                request.getRequestDispatcher("moduloUsuarios.jsp").forward(request, response);
                            }
                        } else {
                            //NO SE REGISTRO  
                            request.setAttribute("msjAlertRed", "Ha ocurrido un error.");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("moduloUsuarios.jsp").forward(request, response);
                        }
                        break;

                    case "eliminarUsuario":

                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP                       
                        String correoUsEliminar = request.getParameter("correoUsuarioEliminar");

                        consultasPanelUsuarios cpu1 = new consultasPanelUsuarios();

                        //ELIMINACION ÉXITOSA
                        if (cpu1.modificarUsEliminar(correoUsEliminar)) {

                            ArrayList datosUsuario = (ArrayList) sesion.getAttribute("datosUsuario");

                            /*
                             **
                             **USUARIOS ACTIVOS DEL SISTEMA
                             **
                             */
                            cpu1 = new consultasPanelUsuarios();

                            //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS DE LOS USUARIOS DEL SISTEMA ACTIVOS
                            ArrayList listaUsuarios = new ArrayList();
                            listaUsuarios = cpu1.obtenerFullUsuarios((String) datosUsuario.get(3));

                            //LISTA CON LOS DATOS DE LOS USUARIOS DEL SISTEMA ACTIVOS
                            sesion.setAttribute("datosUsuarios", listaUsuarios);

                            request.setAttribute("msjAlertGreen", "Usuario eliminado correctamente.");
                            request.setAttribute("msjModalShow", "Valido");

                            cpu1 = new consultasPanelUsuarios();
                            int cantAdmAct = cpu1.cantAdminAct();
                            sesion.setAttribute("cantAdmAct", cantAdmAct);
                            cpu1 = new consultasPanelUsuarios();
                            int cantAdmInac = cpu1.cantAdminInac();
                            sesion.setAttribute("cantAdmInac", cantAdmInac);
                            cpu1 = new consultasPanelUsuarios();
                            int cantSuperAct = cpu1.cantSuperAct();
                            sesion.setAttribute("cantSuperAct", cantSuperAct);
                            cpu1 = new consultasPanelUsuarios();
                            int cantSuperInac = cpu1.cantSuperInac();
                            sesion.setAttribute("cantSuperInac", cantSuperInac);

                            //REDIRECCIONO A PÁGINA MODULO USUARIOS
                            request.getRequestDispatcher("moduloUsuarios.jsp").forward(request, response);
                            //ERROR
                        } else {
                            request.setAttribute("msjAlertRed", "Ha ocurrido un error.");
                            request.setAttribute("msjModalShow", "Valido");
                            //REDIRECCIONO A PÁGINA MODULO USUARIOS
                            request.getRequestDispatcher("moduloUsuarios.jsp").forward(request, response);
                        }
                        break;

                    case "reactivarUsuario":

                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP                       
                        String correoUsReactivar = request.getParameter("correoUsuarioReactivar");

                        consultasPanelUsuarios cpu2 = new consultasPanelUsuarios();

                        //REACTIVACIÓN ÉXITOSA
                        if (cpu2.modificarUsReingreso(correoUsReactivar)) {

                            ArrayList datosUsuario = (ArrayList) sesion.getAttribute("datosUsuario");

                            cpu2 = new consultasPanelUsuarios();

                            //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS DE LOS USUARIOS DEL SISTEMA ACTIVOS
                            ArrayList listaUsuarios = new ArrayList();
                            listaUsuarios = cpu2.obtenerFullUsuarios((String) datosUsuario.get(3));

                            //LISTA CON LOS DATOS DE LOS USUARIOS DEL SISTEMA ACTIVOS
                            sesion.setAttribute("datosUsuarios", listaUsuarios);

                            request.setAttribute("msjAlertGreen", "Usuario reactivado correctamente.");
                            request.setAttribute("msjModalShow", "Valido");

                            cpu2 = new consultasPanelUsuarios();
                            int cantAdmAct = cpu2.cantAdminAct();
                            sesion.setAttribute("cantAdmAct", cantAdmAct);
                            cpu2 = new consultasPanelUsuarios();
                            int cantAdmInac = cpu2.cantAdminInac();
                            sesion.setAttribute("cantAdmInac", cantAdmInac);
                            cpu2 = new consultasPanelUsuarios();
                            int cantSuperAct = cpu2.cantSuperAct();
                            sesion.setAttribute("cantSuperAct", cantSuperAct);
                            cpu2 = new consultasPanelUsuarios();
                            int cantSuperInac = cpu2.cantSuperInac();
                            sesion.setAttribute("cantSuperInac", cantSuperInac);

                            //REDIRECCIONO A PÁGINA MODULO USUARIOS
                            request.getRequestDispatcher("moduloUsuarios.jsp").forward(request, response);
                            //ERROR
                        } else {
                            request.setAttribute("msjAlertRed", "Ha ocurrido un error.");
                            request.setAttribute("msjModalShow", "Valido");
                            //REDIRECCIONO A PÁGINA MODULO USUARIOS
                            request.getRequestDispatcher("moduloUsuarios.jsp").forward(request, response);
                        }
                        break;

                    case "mostrarDatosUsuarioPagNew":

                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP        
                        String correoUsPagNew = request.getParameter("correoUsPagNew");

                        consultasPanelUsuarios cpu3 = new consultasPanelUsuarios();

                        //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS DEL USUARIO A EDITAR
                        ArrayList listaUsuarioEdit = new ArrayList();
                        listaUsuarioEdit = cpu3.obtenerFullUsuarioEdit(correoUsPagNew);

                        //LISTA CON LOS DATOS DE LOS USUARIOS DEL SISTEMA ACTIVOS
                        sesion.setAttribute("datosUsuarioEdit", listaUsuarioEdit);

                        //REDIRECCIONO A PÁGINA MODULO USUARIOS
                        request.getRequestDispatcher("moduloUsuariosEditar.jsp").forward(request, response);
                        //ERROR

                        break;

                    case "modificarUsSistemaDatosPersonales":

                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP     
                        String emailUsActualEdit = request.getParameter("emailUsActualEdit");
                        String emailUsActual4 = request.getParameter("emailUsActual");

                        String nombreUsEdit = request.getParameter("nombreUsEdit");
                        String rutUsEdit = request.getParameter("rutUsEdit");

                        String emailUsEdit = request.getParameter("emailUsEdit");
                        String fonofijoUsEdit = request.getParameter("fonofijoUsEdit");
                        String telefonocelularUsEdit = request.getParameter("telefonocelularUsEdit");

                        String direccionUsEdit = request.getParameter("direccionUsEdit");
                        String ciudadUsEdit = request.getParameter("ciudadUsEdit");
                        String regionUsEdit = request.getParameter("regionUsEdit");
                        String comunaUsEdit = request.getParameter("comunaUsEdit");

                        consultasPanelUsuarios cpu4 = new consultasPanelUsuarios();

                        //VALIDO QUE EL CORREO SEA EL MISMO
                        if (emailUsActualEdit.equals(emailUsEdit)) {
                            //MODIFICO
                            if (cpu4.modificarUsDatosPersonalesEdit(nombreUsEdit, rutUsEdit, emailUsEdit, fonofijoUsEdit, telefonocelularUsEdit, direccionUsEdit,
                                    ciudadUsEdit, regionUsEdit, comunaUsEdit, emailUsActualEdit)) {

                                cpu4 = new consultasPanelUsuarios();

                                //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS CON LA FUNCIÓN
                                ArrayList listaUsuario = new ArrayList();
                                listaUsuario = cpu4.obtenerFullUsuarioEdit(emailUsEdit);

                                //LISTA CON LOS DATOS PARA CUANDO SE INGRESE CON UNO USUARIO VERIDICO
                                sesion.setAttribute("datosUsuarioEdit", listaUsuario);

                                cpu = new consultasPanelUsuarios();
                                //USUARIOS DEL SISTEMA
                                ArrayList listaUsuarios = new ArrayList();
                                listaUsuarios = cpu.obtenerFullUsuarios(emailUsActual4);
                                sesion.setAttribute("datosUsuarios", listaUsuarios);

                                //ATRIBUTO MENSAJE ALERTA
                                request.setAttribute("msjAlertGreen", "Se han guardado los datos satisfactoriamente.");
                                request.setAttribute("msjModalShow", "Valido");

                                //REDIRECCIONO A PÁGINA PRINCIPAL
                                request.getRequestDispatcher("moduloUsuariosEditar.jsp").forward(request, response);

                            } else {
                                //ATRIBUTO MENSAJE ALERTA
                                request.setAttribute("msjModalShow", "Valido");
                                request.setAttribute("msjAlertRed", "Ha ocurrido un error al procesar los cambios.");
                                request.getRequestDispatcher("moduloUsuariosEditar.jsp").forward(request, response);
                            }
                            //NO SON EL MISMO
                        } else {
                            //EXISTE CORREO QUE SE DESEA MODIFICAR
                            if (cpu4.existeCorreo(emailUsEdit)) {
                                //ATRIBUTO MENSAJE ALERTA
                                request.setAttribute("msjAlertRed", "El correo ya está registrado en el sistema. ¡Utilice otro por favor!");
                                request.setAttribute("msjModalShow", "Valido");
                                request.getRequestDispatcher("moduloUsuariosEditar.jsp").forward(request, response);
                            } else {
                                //NO EXISTE
                                //MODIFICO
                                cpu4 = new consultasPanelUsuarios();
                                if (cpu4.modificarUsDatosPersonalesEdit(nombreUsEdit, rutUsEdit, emailUsEdit, fonofijoUsEdit, telefonocelularUsEdit, direccionUsEdit,
                                        ciudadUsEdit, regionUsEdit, comunaUsEdit, emailUsActualEdit)) {

                                    cpu4 = new consultasPanelUsuarios();

                                    //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS CON LA FUNCIÓN
                                    ArrayList listaUsuario = new ArrayList();
                                    listaUsuario = cpu4.obtenerFullUsuarioEdit(emailUsEdit);

                                    //LISTA CON LOS DATOS DEL USUARIO EDITADO
                                    sesion.setAttribute("datosUsuarioEdit", listaUsuario);

                                    cpu = new consultasPanelUsuarios();
                                    //USUARIOS DEL SISTEMA
                                    ArrayList listaUsuarios = new ArrayList();
                                    listaUsuarios = cpu.obtenerFullUsuarios(emailUsActual4);
                                    sesion.setAttribute("datosUsuarios", listaUsuarios);

                                    //ATRIBUTO MENSAJE ALERTA
                                    request.setAttribute("msjAlertGreen", "Se han guardado los datos satisfactoriamente.");
                                    request.setAttribute("msjModalShow", "Valido");

                                    //REDIRECCIONO A PÁGINA PRINCIPAL
                                    request.getRequestDispatcher("moduloUsuariosEditar.jsp").forward(request, response);

                                } else {
                                    //ATRIBUTO MENSAJE ALERTA
                                    request.setAttribute("msjAlertRed", "Ha ocurrido un error al procesar los cambios.");
                                    request.setAttribute("msjModalShow", "Valido");
                                    request.getRequestDispatcher("moduloUsuariosEditar.jsp").forward(request, response);
                                }
                            }
                        }
                        break;

                    case "modificarUsSistemaDatosSistema":

                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP 
                        String emailUsActualEdit3 = request.getParameter("emailUsActualEdit");
                        String emailUsActual5 = request.getParameter("emailUsActual");

                        String empresaUsEdit = request.getParameter("empresaUsEdit");

                        String cargoUsEdit = request.getParameter("cargoUsEdit");
                        String rolUsEdit = request.getParameter("rolUsEdit");

                        consultasPanelUsuarios cpu5 = new consultasPanelUsuarios();
                        String cargoNew = cpu5.obtenerCodigoCargo(cargoUsEdit);

                        cpu5 = new consultasPanelUsuarios();
                        String rolNew = cpu5.obtenerCodigoRol(rolUsEdit);

                        cpu5 = new consultasPanelUsuarios();

                        if (cpu5.modificarUsDatosSistemaEdit(cargoNew, rolNew, empresaUsEdit, emailUsActualEdit3)) {

                            cpu5 = new consultasPanelUsuarios();

                            //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS CON LA FUNCIÓN
                            ArrayList listaUsuario = new ArrayList();
                            listaUsuario = cpu5.obtenerFullUsuarioEdit(emailUsActualEdit3);

                            //LISTA CON LOS DATOS DEL USUARIO EDITADO
                            sesion.setAttribute("datosUsuarioEdit", listaUsuario);

                            cpu = new consultasPanelUsuarios();
                            //USUARIOS DEL SISTEMA
                            ArrayList listaUsuarios = new ArrayList();
                            listaUsuarios = cpu.obtenerFullUsuarios(emailUsActual5);
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

                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertGreen", "Se han guardado los datos satisfactoriamente.");
                            request.setAttribute("msjModalShow", "Valido");

                            //REDIRECCIONO A PÁGINA PRINCIPAL
                            request.getRequestDispatcher("moduloUsuariosEditar.jsp").forward(request, response);

                        } else {
                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertRed", "Ha ocurrido un error al procesar los cambios.");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("moduloUsuariosEditar.jsp").forward(request, response);
                        }

                        break;

                    case "modificarUsSistemaPass":

                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP
                        String emailUsActualEdit2 = request.getParameter("emailUsActualEdit");
                        String emailUsActual6 = request.getParameter("emailUsActual");

                        String pass1 = request.getParameter("pass1UsEdit");

                        consultasPanelUsuarios cpu6 = new consultasPanelUsuarios();

                        if (cpu6.modificarUsPassEdit(pass1, emailUsActualEdit2)) {

                            cpu6 = new consultasPanelUsuarios();

                            //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS CON LA FUNCIÓN
                            ArrayList listaUsuario = new ArrayList();
                            listaUsuario = cpu6.obtenerFullUsuarioEdit(emailUsActualEdit2);

                            //LISTA CON LOS DATOS DEL USUARIO EDITADO
                            sesion.setAttribute("datosUsuarioEdit", listaUsuario);

                            cpu = new consultasPanelUsuarios();
                            //USUARIOS DEL SISTEMA
                            ArrayList listaUsuarios = new ArrayList();
                            listaUsuarios = cpu.obtenerFullUsuarios(emailUsActual6);
                            sesion.setAttribute("datosUsuarios", listaUsuarios);

                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertGreen", "Se han guardado los datos satisfactoriamente.");
                            request.setAttribute("msjModalShow", "Valido");

                            //REDIRECCIONO A PÁGINA PRINCIPAL
                            request.getRequestDispatcher("moduloUsuariosEditar.jsp").forward(request, response);

                        } else {
                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertRed", "Ha ocurrido un error al procesar los cambios.");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("moduloUsuariosEditar.jsp").forward(request, response);
                        }

                        break;

                    /*
                     PANEL TRABAJADORES
                     */
                    case "crearNuevoTrabajador":

                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP
                        String nombreTra = request.getParameter("nombreUs");
                        String apellidosTra = request.getParameter("apellidosUs");
                        String rutTra = request.getParameter("rutUs");
                        String sexoTra = request.getParameter("sexoUs");

                        String emailTra = request.getParameter("emailUs");
                        String fonofijoTra = request.getParameter("fonofijoUs");
                        String telefonocelularTra = request.getParameter("telefonocelularUs");

                        String direccionTra = request.getParameter("direccionUs");
                        String ciudadTra = request.getParameter("ciudadUs");
                        String regionTra = request.getParameter("regionUs");
                        String comunaTra = request.getParameter("comunaUs");

                        String empresaTra = request.getParameter("empresaUs");
                        String cargoTra = request.getParameter("cargoUs");
                        String rolTra = request.getParameter("rolUs");

                        String nombreCompleto2 = nombreTra + " " + apellidosTra;

                        //CREACION NICK USUARIO UNICO
                        consultasPanelUsuarios cpu7 = new consultasPanelUsuarios();

                        String nickTra = cpu7.crearNick(nombreTra, apellidosTra);
                        String nickAux2 = nickTra;

                        while (cpu7.existeNick(nickTra)) {
                            //EL NICK EXISTE, HAY QUE CREAR OTRO
                            //RESET NICK
                            nickTra = nickAux2;
                            Random random = new Random();
                            nickTra = nickTra + random.nextInt(9);
                            cpu7 = new consultasPanelUsuarios();
                        }

                        cpu7 = new consultasPanelUsuarios();
                        //REGISTRANDO NUEVO USUARIO DE SISTEMA
                        if (cpu7.registrarNuevoTrabajadorSistema(nombreCompleto2, rutTra, sexoTra, emailTra, fonofijoTra, telefonocelularTra, direccionTra, ciudadTra,
                                regionTra, comunaTra, empresaTra, nickTra, Integer.parseInt(cargoTra), Integer.parseInt(rolTra))) {

                            ArrayList datosUsuario = (ArrayList) sesion.getAttribute("datosUsuario");

                            cpu7 = new consultasPanelUsuarios();

                            //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS DE LOS USUARIOS DEL SISTEMA ACTIVOS
                            ArrayList listaUsuarios = new ArrayList();
                            listaUsuarios = cpu7.ObtenerFullTrabajadores((String) datosUsuario.get(3));

                            //LISTA CON LOS DATOS DE LOS USUARIOS DEL SISTEMA ACTIVOS
                            sesion.setAttribute("datosTrabajadores", listaUsuarios);

                            //EMAIL
                            CorreoElectronico cor;
                            cor = new CorreoElectronico();

                            consultasPersonales con = new consultasPersonales();

                            String plantilla = "¡Bienvenido al Sistema Innovación Tekonn!\nA continuación, se detalla el proceso y los datos necesarios para poder hacer ingreso al sistema web.\n"
                                    + "---------------------------------------------------------------------------------------\n*Ingresar a www.STekonn.cl\n*Nombre usuario: " + nickTra + "\n*Contraseña: 123456asdfg\n*Se recomienda utilizar navegador Firefox y modificar la contraseña en primer ingreso\n"
                                    + "---------------------------------------------------------------------------------------\n"
                                    + "El correo es enviado de forma automática, por favor no responder.\nAtte. Administración Tekonn";

                            if (cor.enviarCorreoIngreso(plantilla, emailTra)) {

                                cpu7 = new consultasPanelUsuarios();
                                int cantCapaAct = cpu7.cantCapaAct();
                                sesion.setAttribute("cantCapaAct", cantCapaAct);
                                cpu7 = new consultasPanelUsuarios();
                                int cantCapaInac = cpu7.cantCapaInac();
                                sesion.setAttribute("cantCapaInac", cantCapaInac);
                                cpu7 = new consultasPanelUsuarios();
                                int cantTraAct = cpu7.cantTraAct();
                                sesion.setAttribute("cantTraAct", cantTraAct);
                                cpu7 = new consultasPanelUsuarios();
                                int cantTraInac = cpu7.cantTraInac();
                                sesion.setAttribute("cantTraInac", cantTraInac);

                                //CORRECTO
                                request.setAttribute("msjAlertGreen", "Trabajador creado correctamente.");
                                request.setAttribute("msjModalShow", "Valido");
                                request.getRequestDispatcher("moduloPersonal.jsp").forward(request, response);
                            } else {
                                //INCORRECTO
                                request.setAttribute("msjAlertRed", "El Trabajador ha sido ingresado pero ocurrió un error al enviar el mensaje de confirmación.");
                                request.setAttribute("msjModalShow", "Valido");
                                request.getRequestDispatcher("moduloPersonal.jsp").forward(request, response);
                            }
                        } else {
                            //NO SE REGISTRO  
                            request.setAttribute("msjAlertRed", "Ha ocurrido un error.");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("moduloPersonal.jsp").forward(request, response);
                        }

                        break;

                    case "eliminarTrabajador":

                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP
                        String correoUsEliminar2 = request.getParameter("correoUsuarioEliminar");

                        consultasPanelUsuarios cpu8 = new consultasPanelUsuarios();

                        //ELIMINACION EXITOSA
                        if (cpu8.modificarTraEliminar(correoUsEliminar2)) {

                            ArrayList datosUsuario = (ArrayList) sesion.getAttribute("datosUsuario");

                            cpu8 = new consultasPanelUsuarios();

                            //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS DE LOS USUARIOS DEL SISTEMA ACTIVOS
                            ArrayList listaUsuarios = new ArrayList();
                            listaUsuarios = cpu8.ObtenerFullTrabajadores((String) datosUsuario.get(3));

                            //LISTA CON LOS DATOS DE LOS TRABAJADORES DEL SISTEMA ACTIVOS
                            sesion.setAttribute("datosTrabajadores", listaUsuarios);

                            cpu8 = new consultasPanelUsuarios();
                            int cantCapaAct = cpu8.cantCapaAct();
                            sesion.setAttribute("cantCapaAct", cantCapaAct);
                            cpu8 = new consultasPanelUsuarios();
                            int cantCapaInac = cpu8.cantCapaInac();
                            sesion.setAttribute("cantCapaInac", cantCapaInac);
                            cpu8 = new consultasPanelUsuarios();
                            int cantTraAct = cpu8.cantTraAct();
                            sesion.setAttribute("cantTraAct", cantTraAct);
                            cpu8 = new consultasPanelUsuarios();
                            int cantTraInac = cpu8.cantTraInac();
                            sesion.setAttribute("cantTraInac", cantTraInac);

                            request.setAttribute("msjAlertGreen", "Se ha eliminado al usuario del sistema correctamente.");
                            request.setAttribute("msjModalShow", "Valido");

                            //REDIRECCIONO A PÁGINA MODULO USUARIOS
                            request.getRequestDispatcher("moduloPersonal.jsp").forward(request, response);
                            //ERROR
                        } else {
                            request.setAttribute("msjAlertRed", "Ha ocurrido un error al intentar eliminar al usuario. ¡Intente nuevamente por favor!");
                            request.setAttribute("msjModalShow", "Valido");
                            //REDIRECCIONO A PÁGINA MODULO USUARIOS
                            request.getRequestDispatcher("moduloPersonal.jsp").forward(request, response);
                        }
                        break;

                    case "reactivarTrabajador":

                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP
                        String correoUsReactivar2 = request.getParameter("correoUsuarioReactivar");

                        consultasPanelUsuarios cpu9 = new consultasPanelUsuarios();

                        //REACTIVACIÓN ÉXITOSA
                        if (cpu9.modificarTraReingreso(correoUsReactivar2)) {

                            ArrayList datosUsuario = (ArrayList) sesion.getAttribute("datosUsuario");

                            cpu9 = new consultasPanelUsuarios();

                            //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS DE LOS USUARIOS DEL SISTEMA ACTIVOS
                            ArrayList listaUsuarios = new ArrayList();
                            listaUsuarios = cpu9.ObtenerFullTrabajadores((String) datosUsuario.get(3));

                            //LISTA CON LOS DATOS DE LOS USUARIOS DEL SISTEMA ACTIVOS
                            sesion.setAttribute("datosTrabajadores", listaUsuarios);

                            cpu9 = new consultasPanelUsuarios();
                            int cantCapaAct = cpu9.cantCapaAct();
                            sesion.setAttribute("cantCapaAct", cantCapaAct);
                            cpu9 = new consultasPanelUsuarios();
                            int cantCapaInac = cpu9.cantCapaInac();
                            sesion.setAttribute("cantCapaInac", cantCapaInac);
                            cpu9 = new consultasPanelUsuarios();
                            int cantTraAct = cpu9.cantTraAct();
                            sesion.setAttribute("cantTraAct", cantTraAct);
                            cpu9 = new consultasPanelUsuarios();
                            int cantTraInac = cpu9.cantTraInac();
                            sesion.setAttribute("cantTraInac", cantTraInac);

                            request.setAttribute("msjAlertGreen", "Reingreso de usuario del sistema correctamente.");
                            request.setAttribute("msjModalShow", "Valido");

                            //REDIRECCIONO A PÁGINA MODULO USUARIOS
                            request.getRequestDispatcher("moduloPersonal.jsp").forward(request, response);
                            //ERROR
                        } else {
                            request.setAttribute("msjAlertRed", "Ha ocurrido un error al intentar reingresar el usuario. ¡Intente nuevamente por favor!");
                            request.setAttribute("msjModalShow", "Valido");
                            //REDIRECCIONO A PÁGINA MODULO USUARIOS
                            request.getRequestDispatcher("moduloPersonal.jsp").forward(request, response);
                        }
                        break;

                    case "mostrarDatosTrabajadorPagNew":

                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP
                        String correoUsPagNew2 = request.getParameter("correoUsPagNew");

                        consultasPanelUsuarios cpu10 = new consultasPanelUsuarios();

                        //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS DEL USUARIO A EDITAR
                        ArrayList listaTrabajadorEdit = new ArrayList();
                        listaTrabajadorEdit = cpu10.ObtenerFullTrabajadorEdit(correoUsPagNew2);

                        //LISTA CON LOS DATOS DE LOS USUARIOS DEL SISTEMA ACTIVOS
                        sesion.setAttribute("datosTrabajadoresEdit", listaTrabajadorEdit);

                        //REDIRECCIONO A PÁGINA MODULO USUARIOS
                        request.getRequestDispatcher("moduloPersonalEditar.jsp").forward(request, response);
                        //ERROR

                        break;

                    case "modificarTraSistemaDatos":

                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP
                        String emailTraActualEdit = request.getParameter("emailUsActualEdit");
                        String emailUsActual = request.getParameter("emailUsActual");

                        String nombreTraEdit = request.getParameter("nombreUsEdit");
                        String rutTraEdit = request.getParameter("rutUsEdit");

                        String emailTraEdit = request.getParameter("emailUsEdit");
                        String fonofijoTraEdit = request.getParameter("fonofijoUsEdit");
                        String telefonocelularTraEdit = request.getParameter("telefonocelularUsEdit");

                        String direccionTraEdit = request.getParameter("direccionUsEdit");
                        String ciudadTraEdit = request.getParameter("ciudadUsEdit");
                        String regionTraEdit = request.getParameter("regionUsEdit");
                        String comunaTraEdit = request.getParameter("comunaUsEdit");

                        consultasPanelUsuarios cpu11 = new consultasPanelUsuarios();

                        //VALIDO QUE EL CORREO SEA EL MISMO
                        if (emailTraActualEdit.equals(emailTraEdit)) {
                            //MODIFICO
                            if (cpu11.modificarTraDatosPersonalesEdit(nombreTraEdit, rutTraEdit, emailTraEdit, fonofijoTraEdit, telefonocelularTraEdit, direccionTraEdit,
                                    ciudadTraEdit, regionTraEdit, comunaTraEdit, emailTraActualEdit)) {

                                cpu11 = new consultasPanelUsuarios();

                                //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS CON LA FUNCIÓN
                                ArrayList listaUsuario = new ArrayList();
                                listaUsuario = cpu11.ObtenerFullTrabajadorEdit(emailTraEdit);

                                //LISTA CON LOS DATOS PARA CUANDO SE INGRESE CON UNO USUARIO VERIDICO
                                sesion.setAttribute("datosTrabajadoresEdit", listaUsuario);

                                cpu = new consultasPanelUsuarios();
                                //USUARIOS DEL SISTEMA
                                ArrayList listaTrabajadores = new ArrayList();
                                listaTrabajadores = cpu.ObtenerFullTrabajadores(emailUsActual);
                                sesion.setAttribute("datosTrabajadores", listaTrabajadores);

                                //ATRIBUTO MENSAJE ALERTA
                                request.setAttribute("msjAlertGreen", "Se han guardado los datos satisfactoriamente.");
                                request.setAttribute("msjModalShow", "Valido");

                                //REDIRECCIONO A PÁGINA PRINCIPAL
                                request.getRequestDispatcher("moduloPersonalEditar.jsp").forward(request, response);

                            } else {
                                //ATRIBUTO MENSAJE ALERTA
                                request.setAttribute("msjModalShow", "Valido");
                                request.setAttribute("msjAlertRed", "Ha ocurrido un error al procesar los cambios.");
                                request.getRequestDispatcher("moduloPersonalEditar.jsp").forward(request, response);
                            }
                            //NO SON EL MISMO
                        } else {
                            //EXISTE CORREO QUE SE DESEA MODIFICAR
                            if (cpu11.existeCorreo(emailTraEdit)) {
                                //ATRIBUTO MENSAJE ALERTA
                                request.setAttribute("msjAlertRed", "El correo ya está registrado en el sistema. ¡Utilice otro por favor!");
                                request.setAttribute("msjModalShow", "Valido");
                                request.getRequestDispatcher("moduloPersonalEditar.jsp").forward(request, response);
                            } else {
                                //NO EXISTE
                                //MODIFICO
                                cpu11 = new consultasPanelUsuarios();
                                if (cpu11.modificarTraDatosPersonalesEdit(nombreTraEdit, rutTraEdit, emailTraEdit, fonofijoTraEdit, telefonocelularTraEdit, direccionTraEdit,
                                        ciudadTraEdit, regionTraEdit, comunaTraEdit, emailTraActualEdit)) {

                                    cpu11 = new consultasPanelUsuarios();

                                    //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS CON LA FUNCIÓN
                                    ArrayList listaUsuario = new ArrayList();
                                    listaUsuario = cpu11.ObtenerFullTrabajadorEdit(emailTraEdit);

                                    //LISTA CON LOS DATOS DEL USUARIO EDITADO
                                    sesion.setAttribute("datosTrabajadoresEdit", listaUsuario);

                                    cpu = new consultasPanelUsuarios();
                                    //USUARIOS DEL SISTEMA
                                    ArrayList listaTrabajadores = new ArrayList();
                                    listaTrabajadores = cpu.ObtenerFullTrabajadores(emailUsActual);
                                    sesion.setAttribute("datosTrabajadores", listaTrabajadores);

                                    //ATRIBUTO MENSAJE ALERTA
                                    request.setAttribute("msjAlertGreen", "Se han guardado los datos satisfactoriamente.");
                                    request.setAttribute("msjModalShow", "Valido");

                                    //REDIRECCIONO A PÁGINA PRINCIPAL
                                    request.getRequestDispatcher("moduloPersonalEditar.jsp").forward(request, response);

                                } else {
                                    //ATRIBUTO MENSAJE ALERTA
                                    request.setAttribute("msjAlertRed", "Ha ocurrido un error al procesar los cambios.");
                                    request.setAttribute("msjModalShow", "Valido");
                                    request.getRequestDispatcher("moduloPersonalEditar.jsp").forward(request, response);
                                }
                            }
                        }
                        break;

                    case "modificarTraSistemaPass":

                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP
                        String emailUsActualEdit4 = request.getParameter("emailUsActualEdit");
                        String emailUsActual2 = request.getParameter("emailUsActual");

                        String pass2 = request.getParameter("pass1UsEdit");

                        cpu11 = new consultasPanelUsuarios();

                        if (cpu11.modificarTraPassEdit(pass2, emailUsActualEdit4)) {

                            cpu11 = new consultasPanelUsuarios();

                            //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS CON LA FUNCIÓN
                            ArrayList listaUsuario = new ArrayList();
                            listaUsuario = cpu11.ObtenerFullTrabajadorEdit(emailUsActualEdit4);

                            //LISTA CON LOS DATOS DEL USUARIO EDITADO
                            sesion.setAttribute("datosTrabajadoresEdit", listaUsuario);

                            cpu = new consultasPanelUsuarios();
                            //USUARIOS DEL SISTEMA
                            ArrayList listaTrabajadores = new ArrayList();
                            listaTrabajadores = cpu.ObtenerFullTrabajadores(emailUsActual2);
                            sesion.setAttribute("datosTrabajadores", listaTrabajadores);

                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertGreen", "Se han guardado los datos satisfactoriamente.");
                            request.setAttribute("msjModalShow", "Valido");

                            //REDIRECCIONO A PÁGINA PRINCIPAL
                            request.getRequestDispatcher("moduloPersonalEditar.jsp").forward(request, response);

                        } else {
                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertRed", "Ha ocurrido un error al procesar los cambios.");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("moduloPersonalEditar.jsp").forward(request, response);
                        }
                        break;

                    case "modificarTraSistemaDatosSistema":

                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP
                        String emailTraActualEdit4 = request.getParameter("emailUsActualEdit");
                        String emailUsActual3 = request.getParameter("emailUsActual");

                        String empresaTraEdit = request.getParameter("empresaUsEdit");

                        String cargoTraEdit = request.getParameter("cargoUsEdit");
                        String rolTraEdit = request.getParameter("rolUsEdit");

                        consultasPanelUsuarios cpu12 = new consultasPanelUsuarios();

                        String cargoNew2 = cpu12.obtenerCodigoCargo(cargoTraEdit);

                        cpu12 = new consultasPanelUsuarios();

                        String rolNew2 = cpu12.obtenerCodigoRol(rolTraEdit);

                        cpu12 = new consultasPanelUsuarios();

                        if (cpu12.modificarTraDatosSistemaEdit(cargoNew2, rolNew2, empresaTraEdit, emailTraActualEdit4)) {

                            cpu12 = new consultasPanelUsuarios();

                            //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS CON LA FUNCIÓN
                            ArrayList listaUsuario = new ArrayList();
                            listaUsuario = cpu12.ObtenerFullTrabajadorEdit(emailTraActualEdit4);

                            //LISTA CON LOS DATOS DEL USUARIO EDITADO
                            sesion.setAttribute("datosTrabajadoresEdit", listaUsuario);

                            cpu = new consultasPanelUsuarios();
                            //USUARIOS DEL SISTEMA
                            ArrayList listaTrabajadores = new ArrayList();
                            listaTrabajadores = cpu.ObtenerFullTrabajadores(emailUsActual3);
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

                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertGreen", "Se han guardado los datos satisfactoriamente.");
                            request.setAttribute("msjModalShow", "Valido");

                            //REDIRECCIONO A PÁGINA PRINCIPAL
                            request.getRequestDispatcher("moduloPersonalEditar.jsp").forward(request, response);

                        } else {
                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertRed", "Ha ocurrido un error al procesar los cambios.");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("moduloPersonalEditar.jsp").forward(request, response);
                        }

                        break;

                    /*
                     PANEL EQUIPOS
                     */
                    case "crearEquipo":

                        sesion = request.getSession();

                        String nomnreEq = request.getParameter("nombreEquipo");
                        String descripcionEq = request.getParameter("descripcionEquipo");
                        String liderEq = request.getParameter("liderEquipo");

                        consultasPanelUsuarios cpu13 = new consultasPanelUsuarios();

                        ArrayList nombre = new ArrayList();
                        nombre = cpu13.obtenerNombreCapataz(liderEq);

                        String nombreLider = nombre.get(0).toString();

                        cpu13 = new consultasPanelUsuarios();
                        //CREAR EQUIPO
                        if (cpu13.crearEquipo(nomnreEq, descripcionEq, nombreLider, liderEq)) {

                            //LISTA CON LOS EQUIPOS
                            cpu13 = new consultasPanelUsuarios();
                            ArrayList listaEquipos = new ArrayList();
                            listaEquipos = cpu13.obtenerDatosEquiposTrabajo();
                            sesion.setAttribute("datosEquipos", listaEquipos);

                            //MODIFICAR EQUIPO CAPATAZ
                            cpu13 = new consultasPanelUsuarios();
                            ArrayList codigo = new ArrayList();
                            codigo = cpu13.obtenerCodigoEq();
                            String codigoEquipo = codigo.get(0).toString();
                            cpu13 = new consultasPanelUsuarios();
                            cpu13.agregarTrabajadorDeEquipo(liderEq, codigoEquipo);

                            //CAPATAZ SIN EQUIPO
                            cpu13 = new consultasPanelUsuarios();
                            ArrayList listaCapatazSinEquipo = new ArrayList();
                            listaCapatazSinEquipo = cpu13.obtenerCapatazSinEquipo();
                            sesion.setAttribute("listaCapatazSinEquipo", listaCapatazSinEquipo);

                            request.setAttribute("msjAlertGreen", "Se ha creado satisfactoriamente el equipo.");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("moduloEquipos.jsp").forward(request, response);
                        } else {
                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertRed", "No se pudo crear el equipo debido a un error. ¡Intente nuevamente por favor!");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("moduloEquipos.jsp").forward(request, response);
                        }

                        break;

                    case "editarEquiSelec":
                        //OBTENER SESION
                        sesion = request.getSession(false);
                        String codigoEq = request.getParameter("codigoEq");

                        consultasPanelUsuarios conPU = new consultasPanelUsuarios();

                        //TRABAJADORES DEL EQUIPO SELECCIONADO
                        ArrayList listaTraSele = new ArrayList();
                        listaTraSele = conPU.obtenerTrabajadoresEquipoSelec(codigoEq);
                        sesion.setAttribute("datosTraEqSelec", listaTraSele);

                        //DATOS EQUIPO SELECCIONADO
                        conPU = new consultasPanelUsuarios();
                        ArrayList listaEqSele = new ArrayList();
                        listaEqSele = conPU.obtenerDatosEquipoSelec(codigoEq);
                        sesion.setAttribute("datosEquipoSelec", listaEqSele);

                        //DATOS TRABAJADORES SIN EQUIPO SELECCIONADO
                        conPU = new consultasPanelUsuarios();
                        ArrayList listaTraDispo = new ArrayList();
                        listaTraDispo = conPU.obtenerTrabajadoresSinEquipo();
                        sesion.setAttribute("datosTrabajadoresSinEquipo", listaTraDispo);

                        request.getRequestDispatcher("moduloEquiposEditar.jsp").forward(request, response);
                        break;

                    case "agregarTrabajadorEquipo":
                        //OBTENER SESION
                        sesion = request.getSession(false);
                        String correoTra = request.getParameter("correoTra");
                        String codigoEq2 = request.getParameter("codigoEq");

                        consultasPanelUsuarios conPU2 = new consultasPanelUsuarios();

                        if (conPU2.agregarTrabajadorDeEquipo(correoTra, codigoEq2)) {

                            //LISTA CON LOS DATOS DE US SIN EQUIPO
                            conPU2 = new consultasPanelUsuarios();
                            ArrayList listaUsSinEqui2 = new ArrayList();
                            listaUsSinEqui2 = conPU2.obtenerTrabajadoresSinEquipo();
                            sesion.setAttribute("datosTrabajadoresSinEquipo", listaUsSinEqui2);

                            //TRABAJADORES DEL EQUIPO SELECCIONADO
                            conPU2 = new consultasPanelUsuarios();
                            ArrayList listaTraSele2 = new ArrayList();
                            listaTraSele2 = conPU2.obtenerTrabajadoresEquipoSelec(codigoEq2);
                            sesion.setAttribute("datosTraEqSelec", listaTraSele2);

                            request.setAttribute("msjAlertGreen", "Se ha agregado correctamente al trabajador al equipo.");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("moduloEquiposEditar.jsp").forward(request, response);
                        } else {
                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertRed", "No se pudo agregar al trabajador al equipo. ¡Intente nuevamente por favor!");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("moduloEquiposEditar.jsp").forward(request, response);
                        }
                        break;

                    case "quitarTraEq":
                        //OBTENER SESION
                        sesion = request.getSession(false);
                        String correoQuiTraEq = request.getParameter("correoQuiTraEq");
                        String codigoEq3 = request.getParameter("codigoEq3Qui");

                        consultasPanelUsuarios conPU3 = new consultasPanelUsuarios();

                        if (conPU3.quitarTrabajadorDeEquipo(correoQuiTraEq)) {

                            //LISTA CON LOS DATOS DE US SIN EQUIPO
                            conPU3 = new consultasPanelUsuarios();
                            ArrayList listaUsSinEqui2 = new ArrayList();
                            listaUsSinEqui2 = conPU3.obtenerTrabajadoresSinEquipo();
                            sesion.setAttribute("datosTrabajadoresSinEquipo", listaUsSinEqui2);

                            //TRABAJADORES DEL EQUIPO SELECCIONADO
                            conPU3 = new consultasPanelUsuarios();
                            ArrayList listaTraSele2 = new ArrayList();
                            listaTraSele2 = conPU3.obtenerTrabajadoresEquipoSelec(codigoEq3);
                            sesion.setAttribute("datosTraEqSelec", listaTraSele2);

                            request.setAttribute("msjAlertGreen", "Se ha quitado al trabajador al equipo.");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("moduloEquiposEditar.jsp").forward(request, response);
                        } else {
                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertRed", "No se pudo quitar al trabajador al equipo. ¡Intente nuevamente por favor!");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("moduloEquiposEditar.jsp").forward(request, response);
                        }
                        break;

                    case "borrarEquipo":
                        //OBTENER SESION
                        sesion = request.getSession(false);
                        String codigoEquipoBorrar = request.getParameter("codigoEquipoBorrar");

                        consultasPanelUsuarios conPU4 = new consultasPanelUsuarios();

                        if (conPU4.modificarTrabajadoresBorrarEquipo(codigoEquipoBorrar)) {
                            
                                conPU4 = new consultasPanelUsuarios();
                            if (conPU4.borrarEquipoTrabajo(codigoEquipoBorrar)) {

                                //LISTA CON LOS EQUIPOS
                                conPU4 = new consultasPanelUsuarios();
                                ArrayList listaEquipos = new ArrayList();
                                listaEquipos = conPU4.obtenerDatosEquiposTrabajo();
                                sesion.setAttribute("datosEquipos", listaEquipos);

                                //LISTA CON LOS DATOS DE US SIN EQUIPO
                                conPU4 = new consultasPanelUsuarios();
                                ArrayList listaUsSinEqui2 = new ArrayList();
                                listaUsSinEqui2 = conPU4.obtenerTrabajadoresSinEquipo();
                                sesion.setAttribute("datosTrabajadoresSinEquipo", listaUsSinEqui2);

                                //CAPATAZ SIN EQUIPO
                                conPU4 = new consultasPanelUsuarios();
                                ArrayList listaCapatazSinEquipo = new ArrayList();
                                listaCapatazSinEquipo = conPU4.obtenerCapatazSinEquipo();
                                sesion.setAttribute("listaCapatazSinEquipo", listaCapatazSinEquipo);

                                request.setAttribute("msjAlertGreen", "Se ha desintegrado al equipo satisfactoriamente.");
                                request.setAttribute("msjModalShow", "Valido");
                                request.getRequestDispatcher("moduloEquipos.jsp").forward(request, response);
                            } else {
                                //ATRIBUTO MENSAJE ALERTA
                                request.setAttribute("msjAlertRed", "No se pudo desintegrar al equipo. ¡Intente nuevamente por favor!");
                                request.setAttribute("msjModalShow", "Valido");
                                request.getRequestDispatcher("moduloEquipos.jsp").forward(request, response);
                            }

                        } else {
                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertRed", "No se pudo sacar a los trabajadores del equipo. ¡Intente nuevamente por favor!");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("moduloEquipos.jsp").forward(request, response);
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
