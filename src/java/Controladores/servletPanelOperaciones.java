/*
    *Diseñado y programado por Cristopher Pérez V.
    *Sistema Tekonn 2019
*/
package Controladores;

import Modelos.consultasPanelOperaciones;
import Modelos.consultasPanelUsuarios;
import Modelos.consultasPersonales;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Cristopher
 */
public class servletPanelOperaciones extends HttpServlet {

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

                    case "crearOperacion":
                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP
                        String nombreOperacion = request.getParameter("nombreOperacion");
                        String descripcionOperacion = request.getParameter("descripcionOperacion");
                        String zonaOperacion = request.getParameter("zonaOperacion");
                        String emailUs = request.getParameter("emailUs");

                        consultasPersonales cp = new consultasPersonales();
                        ArrayList codiUs = new ArrayList();
                        codiUs = cp.obtenerCodigoUs(emailUs);

                        consultasPanelOperaciones cpo = new consultasPanelOperaciones();
                        if (cpo.nuevaOperacion(nombreOperacion, descripcionOperacion, (String) codiUs.get(0), zonaOperacion)) {

                            //ÚLTIMA OPERACION
                            cpo = new consultasPanelOperaciones();
                            ArrayList codigoUltimaOperacion = new ArrayList();
                            codigoUltimaOperacion = cpo.obtenerUltimaOperacion();

                            //OBTENER OPERACION
                            cpo = new consultasPanelOperaciones();
                            ArrayList operacionSelec = new ArrayList();
                            operacionSelec = cpo.obtenerOperacionSelec((String) codigoUltimaOperacion.get(0));
                            sesion.setAttribute("operacionSelec", operacionSelec);

                            //DATOS EQUIPO 
                            consultasPersonales cp1 = new consultasPersonales();
                            ArrayList codEq = cp1.obtenerCodigoEquipo((String) operacionSelec.get(5));
                            consultasPanelUsuarios conPU1 = new consultasPanelUsuarios();
                            ArrayList listaEqSele = new ArrayList();
                            listaEqSele = conPU1.obtenerDatosEquipoSelec((String) codEq.get(0));
                            sesion.setAttribute("datosEquipoSelec", listaEqSele);

                            //OBTENER RMS
                            cpo = new consultasPanelOperaciones();
                            ArrayList rmsOperaSelec = new ArrayList();
                            rmsOperaSelec = cpo.obtenerDetallesRms((String) codigoUltimaOperacion.get(0));
                            sesion.setAttribute("rmsOperaSelec", rmsOperaSelec);

                            //OBTENER RMS DISPONIBLES
                            cpo = new consultasPanelOperaciones();
                            ArrayList rmsDisponibles = new ArrayList();
                            rmsDisponibles = cpo.obtenerRMSDisponibles();
                            sesion.setAttribute("rmsDisponibles", rmsDisponibles);

                            //OPERACIONES
                            consultasPersonales conGen = new consultasPersonales();
                            ArrayList codAux = conGen.obtenerCodigoUs(emailUs);
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

                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertGreen", "Registre rms al formulario.");
                            request.setAttribute("msjModalShow", "Valido");

                            //REDIRECCIONO A PÁGINA PRINCIPAL
                            request.getRequestDispatcher("moduloOperacionesEditar.jsp").forward(request, response);

                        } else {
                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertRed", "Ha ocurrido un error al procesar el registro.");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("moduloOperaciones.jsp").forward(request, response);
                        }
                        break;

                    case "agregarRmsOpe":

                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP
                        String auxOpe = request.getParameter("auxOpe");
                        String auxnumeroRmsOpe = request.getParameter("auxnumeroRmsOpe");
                        String codigoOpe = request.getParameter("codigoOpe");

                        //VALIDO QUE NO ESTE INGRESADO EL RMS
                        consultasPanelOperaciones cpo1 = new consultasPanelOperaciones();
                        if (cpo1.contrastarRms(auxnumeroRmsOpe, codigoOpe)) {

                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertRed", "Rms ya registrado");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("moduloOperacionesEditar.jsp").forward(request, response);
                        } else {
                            int aux = 0;
                            ArrayList auxValoracion = new ArrayList();

                            //RECUPERAR VALORACIONES
                            while (aux < Integer.parseInt(auxOpe)) {
                                String auxValor = request.getParameter("rmsSelec" + (aux + 1));
                                auxValoracion.add(auxValor);
                                aux++;
                            }

                            //RECUPERAR COLUMNAS
                            cpo1 = new consultasPanelOperaciones();
                            ArrayList auxCodigoColumnas = new ArrayList();
                            auxCodigoColumnas = cpo1.obtenerDetallesColumnasRmsSeleccionado(auxnumeroRmsOpe);
                            //CREADO DETALLES RMS

                            try {
                                int aux2 = 0;
                                while (aux2 < auxCodigoColumnas.size()) {
                                    cpo1 = new consultasPanelOperaciones();
                                    cpo1.agregarDetalleColumnas((String) auxValoracion.get(aux2), codigoOpe, (String) auxCodigoColumnas.get(aux2));
                                    aux2++;
                                }

                                //OBTENER RMS
                                cpo1 = new consultasPanelOperaciones();
                                ArrayList rmsOperaSelec = new ArrayList();
                                rmsOperaSelec = cpo1.obtenerDetallesRms(codigoOpe);
                                sesion.setAttribute("rmsOperaSelec", rmsOperaSelec);

                                //ATRIBUTO MENSAJE ALERTA
                                request.setAttribute("msjAlertGreen", "Rms agregado con éxito");
                                request.setAttribute("msjModalShow", "Valido");

                                //REDIRECCIONO A PÁGINA PRINCIPAL
                                request.getRequestDispatcher("moduloOperacionesEditar.jsp").forward(request, response);
                            } catch (Exception ex) {
                                //ATRIBUTO MENSAJE ALERTA
                                request.setAttribute("msjAlertRed", "Ha ocurrido un error al procesar el registro.");
                                request.setAttribute("msjModalShow", "Valido");
                            } finally {
                            }

                        }

                        break;

                    case "editarOperacionSelec":

                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP
                        String codigoOpeSele = request.getParameter("codigoOpeSele");

                        //OBTENER OPERACION
                        consultasPanelOperaciones cpo2 = new consultasPanelOperaciones();
                        ArrayList operacionSelec2 = new ArrayList();
                        operacionSelec2 = cpo2.obtenerOperacionSelec(codigoOpeSele);
                        sesion.setAttribute("operacionSelec", operacionSelec2);

                        //DATOS EQUIPO 
                        consultasPersonales cp2 = new consultasPersonales();
                        ArrayList codEq2 = cp2.obtenerCodigoEquipo((String) operacionSelec2.get(5));
                        consultasPanelUsuarios conPU2 = new consultasPanelUsuarios();
                        ArrayList listaEqSele2 = new ArrayList();
                        listaEqSele2 = conPU2.obtenerDatosEquipoSelec((String) codEq2.get(0));
                        sesion.setAttribute("datosEquipoSelec", listaEqSele2);

                        //OBTENER RMS
                        cpo2 = new consultasPanelOperaciones();
                        ArrayList rmsOperaSelec2 = new ArrayList();
                        rmsOperaSelec2 = cpo2.obtenerDetallesRms(codigoOpeSele);
                        sesion.setAttribute("rmsOperaSelec", rmsOperaSelec2);

                        //OBTENER RMS DISPONIBLES
                        cpo2 = new consultasPanelOperaciones();
                        ArrayList rmsDisponibles2 = new ArrayList();
                        rmsDisponibles2 = cpo2.obtenerRMSDisponibles();
                        sesion.setAttribute("rmsDisponibles", rmsDisponibles2);

                        //ATRIBUTO MENSAJE ALERTA
                        request.setAttribute("msjAlertGreen", "Edición de operación");
                        request.setAttribute("msjModalShow", "Valido");

                        //REDIRECCIONO A PÁGINA PRINCIPAL
                        request.getRequestDispatcher("moduloOperacionesEditar.jsp").forward(request, response);

                        break;

                    case "removerRmsOperacion":

                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP
                        String numeroRmsRemoverOperacion = request.getParameter("numeroRmsRemoverOperacion");
                        String codigoOperacionSelec = request.getParameter("codigoOperacionSelec");

                        //RECUPERAR COLUMNAS
                        consultasPanelOperaciones cpo3 = new consultasPanelOperaciones();
                        ArrayList auxCodigoColumnas3 = new ArrayList();
                        auxCodigoColumnas3 = cpo3.obtenerDetallesColumnasRmsSeleccionado(numeroRmsRemoverOperacion);

                        try {
                            //REMOVER COLUMNAS CON VALORACIONES
                            int aux3 = 0;
                            while (aux3 < auxCodigoColumnas3.size()) {
                                cpo3 = new consultasPanelOperaciones();
                                cpo3.removerDetalleColumnas(codigoOperacionSelec, (String) auxCodigoColumnas3.get(aux3));
                                aux3++;
                            }

                            //OBTENER RMS
                            cpo3 = new consultasPanelOperaciones();
                            ArrayList rmsOperaSelec3 = new ArrayList();
                            rmsOperaSelec3 = cpo3.obtenerDetallesRms(codigoOperacionSelec);
                            sesion.setAttribute("rmsOperaSelec", rmsOperaSelec3);

                            //OBTENER RMS DISPONIBLES
                            cpo3 = new consultasPanelOperaciones();
                            ArrayList rmsDisponibles3 = new ArrayList();
                            rmsDisponibles3 = cpo3.obtenerRMSDisponibles();
                            sesion.setAttribute("rmsDisponibles", rmsDisponibles3);

                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertGreen", "Rms removido correctamente");
                            request.setAttribute("msjModalShow", "Valido");

                            //REDIRECCIONO A PÁGINA PRINCIPAL
                            request.getRequestDispatcher("moduloOperacionesEditar.jsp").forward(request, response);
                        } catch (Exception ex) {
                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertRed", "Ha ocurrido un error al procesar la petición");
                            request.setAttribute("msjModalShow", "Valido");

                            //REDIRECCIONO A PÁGINA PRINCIPAL
                            request.getRequestDispatcher("moduloOperacionesEditar.jsp").forward(request, response);
                        } finally {
                        }

                        break;

                    case "editarRmsOpe":
                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP
                        String auxOpeSelec = request.getParameter("auxOpeSelec");
                        String auxnumeroRmsOpeSelec = request.getParameter("auxnumeroRmsOpeSelec");
                        String codigoOpeSelec = request.getParameter("codigoOpeSelec");

                        int aux2 = 0;
                        ArrayList auxValoracion2 = new ArrayList();

                        //RECUPERAR VALORACIONES
                        while (aux2 < Integer.parseInt(auxOpeSelec)) {
                            String auxValor2 = request.getParameter("rmsSelecEdit" + (aux2 + 1));
                            auxValoracion2.add(auxValor2);
                            aux2++;
                        }

                        //RECUPERAR COLUMNAS
                        consultasPanelOperaciones cpo4 = new consultasPanelOperaciones();
                        ArrayList auxCodigoColumnas2 = new ArrayList();
                        auxCodigoColumnas2 = cpo4.obtenerDetallesColumnasRmsSeleccionado(auxnumeroRmsOpeSelec);

                        cpo4 = new consultasPanelOperaciones();

                        int aux3 = 0;
                        while (aux3 < auxCodigoColumnas2.size()) {
                            cpo4 = new consultasPanelOperaciones();
                            cpo4.modificarDetallesColumnas((String) auxValoracion2.get(aux3), codigoOpeSelec, (String) auxCodigoColumnas2.get(aux3));
                            aux3++;
                        }

                        //OBTENER RMS
                        cpo4 = new consultasPanelOperaciones();
                        ArrayList rmsOperaSelec3 = new ArrayList();
                        rmsOperaSelec3 = cpo4.obtenerDetallesRms(codigoOpeSelec);
                        sesion.setAttribute("rmsOperaSelec", rmsOperaSelec3);

                        //ATRIBUTO MENSAJE ALERTA
                        request.setAttribute("msjAlertGreen", "Cambios guardados correctamente");
                        request.setAttribute("msjModalShow", "Valido");

                        //REDIRECCIONO A PÁGINA PRINCIPAL
                        request.getRequestDispatcher("moduloOperacionesEditar.jsp").forward(request, response);

                        break;

                    case "editarFormSelec":

                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP
                        String numeroFormEditSelec = request.getParameter("numeroFormEditSelec");
                        String observacionesOperacionSele = request.getParameter("observacionesOperacionSele");
                        String descripcionOperacionSele = request.getParameter("descripcionOperacionSele");

                        consultasPanelOperaciones cpo5 = new consultasPanelOperaciones();
                        if (cpo5.editarForm(numeroFormEditSelec, observacionesOperacionSele, descripcionOperacionSele)) {

                            //OBTENER OPERACION
                            consultasPanelOperaciones cpo6 = new consultasPanelOperaciones();
                            ArrayList operacionSelec3 = new ArrayList();
                            operacionSelec3 = cpo6.obtenerOperacionSelec(numeroFormEditSelec);
                            sesion.setAttribute("operacionSelec", operacionSelec3);

                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertGreen", "Cambios guardados correctamente");
                            request.setAttribute("msjModalShow", "Valido");

                            //REDIRECCIONO A PÁGINA PRINCIPAL
                            request.getRequestDispatcher("moduloOperacionesEditar.jsp").forward(request, response);
                        } else {
                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertRed", "Ha ocurrido un error al procesar la petición");
                            request.setAttribute("msjModalShow", "Valido");

                            //REDIRECCIONO A PÁGINA PRINCIPAL
                            request.getRequestDispatcher("moduloOperacionesEditar.jsp").forward(request, response);
                        }

                        break;
                    case "cerrarOperacion":
                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP
                        String codigoCerrarOperacion = request.getParameter("codigoCerrarOperacion");
                        String observacionesCerrarOperacion = request.getParameter("observacionesCerrarOperacion");
                        String emailUs2 = request.getParameter("emailUs2");

                        consultasPanelOperaciones cpo6 = new consultasPanelOperaciones();
                        if (cpo6.cerrarOperacion(codigoCerrarOperacion, observacionesCerrarOperacion)) {

                            //OBTENER RMS DISPONIBLES
                            cpo6 = new consultasPanelOperaciones();
                            ArrayList rmsDisponibles = new ArrayList();
                            rmsDisponibles = cpo6.obtenerRMSDisponibles();
                            sesion.setAttribute("rmsDisponibles", rmsDisponibles);

                            //OPERACIONES
                            consultasPersonales conGen1 = new consultasPersonales();
                            ArrayList codAux2 = conGen1.obtenerCodigoUs(emailUs2);
                            cpo6 = new consultasPanelOperaciones();
                            ArrayList listaOperacionesCapataz = new ArrayList();
                            listaOperacionesCapataz = cpo6.obtenerOperacionesCapataz((String) codAux2.get(0));
                            sesion.setAttribute("datosOperacionesCapataz", listaOperacionesCapataz);
                            cpo6 = new consultasPanelOperaciones();
                            ArrayList listaOperacionesGeneral = new ArrayList();
                            listaOperacionesGeneral = cpo6.obtenerOperacionesGeneral();
                            sesion.setAttribute("datosOperacionesGeneral", listaOperacionesGeneral);

                            //CANTIDAD OPERACIONES PENDIENTES, EN MARCHA, RECHAZADAS Y FINALIZADAS GENERAL
                            cpo6 = new consultasPanelOperaciones();
                            int cantOpePendiente = cpo6.cantOpePendiente();
                            sesion.setAttribute("cantOpePendiente", cantOpePendiente);
                            cpo6 = new consultasPanelOperaciones();
                            int cantOpeEnMarcha = cpo6.cantOpeEnMarcha();
                            sesion.setAttribute("cantOpeEnMarcha", cantOpeEnMarcha);
                            cpo6 = new consultasPanelOperaciones();
                            int cantOpeRechazada = cpo6.cantOpeRechazada();
                            sesion.setAttribute("cantOpeRechazada", cantOpeRechazada);
                            cpo6 = new consultasPanelOperaciones();
                            int cantOpeFinalizada = cpo6.cantOpeFinalizada();
                            sesion.setAttribute("cantOpeFinalizada", cantOpeFinalizada);

                            //CANTIDAD OPERACIONES PENDIENTES, EN MARCHA, RECHAZADAS Y FINALIZADAS CAPATAZ
                            cpo6 = new consultasPanelOperaciones();
                            int cantOpePendienteCapataz = cpo6.cantOpePendienteCapataz((String) codAux2.get(0));
                            sesion.setAttribute("cantOpePendienteCapataz", cantOpePendienteCapataz);
                            cpo6 = new consultasPanelOperaciones();
                            int cantOpeEnMarchaCapataz = cpo6.cantOpeEnMarchaCapataz((String) codAux2.get(0));
                            sesion.setAttribute("cantOpeEnMarchaCapataz", cantOpeEnMarchaCapataz);
                            cpo6 = new consultasPanelOperaciones();
                            int cantOpeRechazadaCapataz = cpo6.cantOpeRechazadaCapataz((String) codAux2.get(0));
                            sesion.setAttribute("cantOpeRechazadaCapataz", cantOpeRechazadaCapataz);
                            cpo6 = new consultasPanelOperaciones();
                            int cantOpeFinalizadaCapataz = cpo6.cantOpeFinalizadaCapataz((String) codAux2.get(0));
                            sesion.setAttribute("cantOpeFinalizadaCapataz", cantOpeFinalizadaCapataz);

                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertGreen", "Operación finalizada correctamente");
                            request.setAttribute("msjModalShow", "Valido");

                            //REDIRECCIONO A PÁGINA PRINCIPAL
                            request.getRequestDispatcher("moduloOperaciones.jsp").forward(request, response);
                        } else {
                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertRed", "Ha ocurrido un error al intentar cerrar la opración");
                            request.setAttribute("msjModalShow", "Valido");

                            //REDIRECCIONO A PÁGINA PRINCIPAL
                            request.getRequestDispatcher("moduloOperaciones.jsp").forward(request, response);
                        }

                        break;
                    case "aceptarOperacion":
                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP
                        String codigoAceptarOperacion = request.getParameter("codigoAceptarOperacion");
                        String observacionesAceptarOperacion = request.getParameter("observacionesAceptarOperacion");
                        String emailUs3 = request.getParameter("emailUs3");

                        consultasPanelOperaciones cpo8 = new consultasPanelOperaciones();
                        if (cpo8.aceptarOperacion(codigoAceptarOperacion, observacionesAceptarOperacion)) {

                            //OBTENER RMS DISPONIBLES
                            cpo8 = new consultasPanelOperaciones();
                            ArrayList rmsDisponibles = new ArrayList();
                            rmsDisponibles = cpo8.obtenerRMSDisponibles();
                            sesion.setAttribute("rmsDisponibles", rmsDisponibles);

                            //OPERACIONES
                            consultasPersonales conGen1 = new consultasPersonales();
                            ArrayList codAux3 = conGen1.obtenerCodigoUs(emailUs3);
                            cpo8 = new consultasPanelOperaciones();
                            ArrayList listaOperacionesCapataz = new ArrayList();
                            listaOperacionesCapataz = cpo8.obtenerOperacionesCapataz((String) codAux3.get(0));
                            sesion.setAttribute("datosOperacionesCapataz", listaOperacionesCapataz);
                            cpo8 = new consultasPanelOperaciones();
                            ArrayList listaOperacionesGeneral = new ArrayList();
                            listaOperacionesGeneral = cpo8.obtenerOperacionesGeneral();
                            sesion.setAttribute("datosOperacionesGeneral", listaOperacionesGeneral);

                            //CANTIDAD OPERACIONES PENDIENTES, EN MARCHA, RECHAZADAS Y FINALIZADAS GENERAL
                            cpo8 = new consultasPanelOperaciones();
                            int cantOpePendiente = cpo8.cantOpePendiente();
                            sesion.setAttribute("cantOpePendiente", cantOpePendiente);
                            cpo8 = new consultasPanelOperaciones();
                            int cantOpeEnMarcha = cpo8.cantOpeEnMarcha();
                            sesion.setAttribute("cantOpeEnMarcha", cantOpeEnMarcha);
                            cpo8 = new consultasPanelOperaciones();
                            int cantOpeRechazada = cpo8.cantOpeRechazada();
                            sesion.setAttribute("cantOpeRechazada", cantOpeRechazada);
                            cpo8 = new consultasPanelOperaciones();
                            int cantOpeFinalizada = cpo8.cantOpeFinalizada();
                            sesion.setAttribute("cantOpeFinalizada", cantOpeFinalizada);

                            //CANTIDAD OPERACIONES PENDIENTES, EN MARCHA, RECHAZADAS Y FINALIZADAS CAPATAZ
                            cpo8 = new consultasPanelOperaciones();
                            int cantOpePendienteCapataz = cpo8.cantOpePendienteCapataz((String) codAux3.get(0));
                            sesion.setAttribute("cantOpePendienteCapataz", cantOpePendienteCapataz);
                            cpo8 = new consultasPanelOperaciones();
                            int cantOpeEnMarchaCapataz = cpo8.cantOpeEnMarchaCapataz((String) codAux3.get(0));
                            sesion.setAttribute("cantOpeEnMarchaCapataz", cantOpeEnMarchaCapataz);
                            cpo8 = new consultasPanelOperaciones();
                            int cantOpeRechazadaCapataz = cpo8.cantOpeRechazadaCapataz((String) codAux3.get(0));
                            sesion.setAttribute("cantOpeRechazadaCapataz", cantOpeRechazadaCapataz);
                            cpo8 = new consultasPanelOperaciones();
                            int cantOpeFinalizadaCapataz = cpo8.cantOpeFinalizadaCapataz((String) codAux3.get(0));
                            sesion.setAttribute("cantOpeFinalizadaCapataz", cantOpeFinalizadaCapataz);

                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertGreen", "Operación aceptada correctamente");
                            request.setAttribute("msjModalShow", "Valido");

                            //REDIRECCIONO A PÁGINA PRINCIPAL
                            request.getRequestDispatcher("moduloOperaciones.jsp").forward(request, response);
                        } else {
                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertRed", "Ha ocurrido un error al intentar aceptar la opración");
                            request.setAttribute("msjModalShow", "Valido");

                            //REDIRECCIONO A PÁGINA PRINCIPAL
                            request.getRequestDispatcher("moduloOperaciones.jsp").forward(request, response);
                        }

                        break;
                    case "rechazarOperacion":
                        //OBTENER SESIÓN
                        sesion = request.getSession();

                        //DATOS DEL JSP
                        String codigoRechazarOperacion = request.getParameter("codigoRechazarOperacion");
                        String observacionesRechazarOperacion = request.getParameter("observacionesRechazarOperacion");
                        String emailUs4 = request.getParameter("emailUs4");

                        consultasPanelOperaciones cpo7 = new consultasPanelOperaciones();
                        if (cpo7.rechazarOperacion(codigoRechazarOperacion, observacionesRechazarOperacion)) {

                            //OBTENER RMS DISPONIBLES
                            cpo7 = new consultasPanelOperaciones();
                            ArrayList rmsDisponibles = new ArrayList();
                            rmsDisponibles = cpo7.obtenerRMSDisponibles();
                            sesion.setAttribute("rmsDisponibles", rmsDisponibles);

                            //OPERACIONES
                            consultasPersonales conGen1 = new consultasPersonales();
                            ArrayList codAux4 = conGen1.obtenerCodigoUs(emailUs4);
                            cpo7 = new consultasPanelOperaciones();
                            ArrayList listaOperacionesCapataz = new ArrayList();
                            listaOperacionesCapataz = cpo7.obtenerOperacionesCapataz((String) codAux4.get(0));
                            sesion.setAttribute("datosOperacionesCapataz", listaOperacionesCapataz);
                            cpo7 = new consultasPanelOperaciones();
                            ArrayList listaOperacionesGeneral = new ArrayList();
                            listaOperacionesGeneral = cpo7.obtenerOperacionesGeneral();
                            sesion.setAttribute("datosOperacionesGeneral", listaOperacionesGeneral);

                            //CANTIDAD OPERACIONES PENDIENTES, EN MARCHA, RECHAZADAS Y FINALIZADAS GENERAL
                            cpo7 = new consultasPanelOperaciones();
                            int cantOpePendiente = cpo7.cantOpePendiente();
                            sesion.setAttribute("cantOpePendiente", cantOpePendiente);
                            cpo7 = new consultasPanelOperaciones();
                            int cantOpeEnMarcha = cpo7.cantOpeEnMarcha();
                            sesion.setAttribute("cantOpeEnMarcha", cantOpeEnMarcha);
                            cpo7 = new consultasPanelOperaciones();
                            int cantOpeRechazada = cpo7.cantOpeRechazada();
                            sesion.setAttribute("cantOpeRechazada", cantOpeRechazada);
                            cpo7 = new consultasPanelOperaciones();
                            int cantOpeFinalizada = cpo7.cantOpeFinalizada();
                            sesion.setAttribute("cantOpeFinalizada", cantOpeFinalizada);

                            //CANTIDAD OPERACIONES PENDIENTES, EN MARCHA, RECHAZADAS Y FINALIZADAS CAPATAZ
                            cpo7 = new consultasPanelOperaciones();
                            int cantOpePendienteCapataz = cpo7.cantOpePendienteCapataz((String) codAux4.get(0));
                            sesion.setAttribute("cantOpePendienteCapataz", cantOpePendienteCapataz);
                            cpo7 = new consultasPanelOperaciones();
                            int cantOpeEnMarchaCapataz = cpo7.cantOpeEnMarchaCapataz((String) codAux4.get(0));
                            sesion.setAttribute("cantOpeEnMarchaCapataz", cantOpeEnMarchaCapataz);
                            cpo7 = new consultasPanelOperaciones();
                            int cantOpeRechazadaCapataz = cpo7.cantOpeRechazadaCapataz((String) codAux4.get(0));
                            sesion.setAttribute("cantOpeRechazadaCapataz", cantOpeRechazadaCapataz);
                            cpo7 = new consultasPanelOperaciones();
                            int cantOpeFinalizadaCapataz = cpo7.cantOpeFinalizadaCapataz((String) codAux4.get(0));
                            sesion.setAttribute("cantOpeFinalizadaCapataz", cantOpeFinalizadaCapataz);

                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertGreen", "Operación finalizada correctamente");
                            request.setAttribute("msjModalShow", "Valido");

                            //REDIRECCIONO A PÁGINA PRINCIPAL
                            request.getRequestDispatcher("moduloOperaciones.jsp").forward(request, response);
                        } else {
                            //ATRIBUTO MENSAJE ALERTA
                            request.setAttribute("msjAlertRed", "Ha ocurrido un error al intentar cerrar la opración");
                            request.setAttribute("msjModalShow", "Valido");

                            //REDIRECCIONO A PÁGINA PRINCIPAL
                            request.getRequestDispatcher("moduloOperaciones.jsp").forward(request, response);
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
