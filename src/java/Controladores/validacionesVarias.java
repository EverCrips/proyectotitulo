/*
    *Diseñado y programado por Cristopher Pérez V.
    *Sistema Tekonn 2019
*/
package Controladores;

import Modelos.CorreoElectronico;
import Modelos.consultasPersonales;
import Modelos.consultasPanelExtra;
import Modelos.consultasPanelOperaciones;
import Modelos.consultasPanelUsuarios;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.catalina.tribes.util.Arrays;

/**
 *
 * @author EverCrips
 */
public class validacionesVarias extends HttpServlet {

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

            String opcionValidaciones = request.getParameter("opcionValidaciones");
            if (opcionValidaciones == null) {
                request.getRequestDispatcher("index.jsp").forward(request, response);
            } else {
                HttpSession sesion;
                consultasPersonales con = new consultasPersonales();
                switch (opcionValidaciones) {
                    case "valiEmail":
                        con = new consultasPersonales();
                        String email = request.getParameter("email");
                        if (con.existeCorreo(email)) {
                            out.println(1);
                        } else {
                            out.println(2);
                        }
                        break;
                    case "valiRut":
                        con = new consultasPersonales();
                        String rut = request.getParameter("rut");
                        if (con.existeRut(rut)) {
                            out.println(1);
                        } else {
                            out.println(2);
                        }
                        break;
                    case "selectChange":
                        consultasPanelExtra cpe = new consultasPanelExtra();
                        String valor = request.getParameter("valor");

                        //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS RMS
                        ArrayList datosRMS = new ArrayList();
                        datosRMS = cpe.obtenerRMS(valor);

                        cpe = new consultasPanelExtra();
                        //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS RMS COLUMNAS
                        ArrayList datosRMSColumnas = new ArrayList();
                        datosRMSColumnas = cpe.obtenerRMSColumnas(valor);

                        ArrayList datos = new ArrayList();

                        int i = 0;
                        while (datosRMS.size() > i) {
                            datos.add(datosRMS.get(i));
                            i++;
                        }

                        int e = 0;
                        while (datosRMSColumnas.size() > e) {
                            String aux = (String) datosRMSColumnas.get(e);
                            datos.add(";" + aux);
                            e++;
                        }

                        out.println(datos);
                        break;
                    case "recupePass":
                        String emailUsPass = request.getParameter("valor");

                        consultasPersonales cP = new consultasPersonales();

                        if (cP.existeCorreo(emailUsPass)) {

                            CorreoElectronico cor;
                            cor = new CorreoElectronico();

                            String codiTemp = "";
                            codiTemp = cor.generarCodigoResetPass();

                            con = new consultasPersonales();
                            //SI EXISTE
                            String plantilla = "Se ha recibido una petición para resetear la contraseña actual de la cuenta: " + emailUsPass + ".\nA continuación, se otorga un código temporal para poder resetear la contrasela:\n"
                                    + "---------------------------------------------------------------------------------------\nCODIGO TEMPORAL: " + codiTemp + "\n---------------------------------------------------------------------------------------\n"
                                    + "---------------------------------------------------------------------------------------\n"
                                    + "Si usted no ha solicitado un cambio de contraseña, ignorar dicho correo.\nAtte. Administración Tekonn";

                            //MODIFICO EL CODIGO DE LA CUENTA
                            if (con.modificarCodigoVerificación(emailUsPass, codiTemp)) {

                                cor = new CorreoElectronico();
                                //VERIFICAR QUE SE ENVIA EL CORREO CON EL CODIGO                           
                                if (cor.enviarCorreoContraseñaPerdidaUsuario(plantilla, emailUsPass)) {
                                    //TODO OKEY
                                    out.println(1);
                                } else {
                                    out.println(2);
                                }

                            } else {
                                out.println(3);
                            }
                        } else {
                            //NO EXISTE CORREO
                            out.println(4);
                        }
                        break;

                    case "recupePassCod":
                        String emailUsPass2 = request.getParameter("email");
                        String cod = request.getParameter("codigo");

                        consultasPersonales conGe2 = new consultasPersonales();
                        if (conGe2.validarCodigoVerificar(emailUsPass2, cod)) {
                            //CONCUERDA EL CODIGO EN EL CORREO
                            out.println(1);
                        } else {
                            //NO CONCUERDA
                            out.println(2);
                        }
                        break;

                    case "selectVisuaEqui":
                        String numEq = request.getParameter("numEq");
                        
                        consultasPanelUsuarios cpu = new consultasPanelUsuarios();
                        ArrayList listaDatosEquiSelec = new ArrayList();
                        listaDatosEquiSelec = cpu.obtenerTrabajadoresEquipoSelec(numEq);

                        ArrayList datosEqSe = new ArrayList();
                        int x = 0;
                        while (listaDatosEquiSelec.size() > x) {
                            String aux = (String)listaDatosEquiSelec.get(x);
                            aux = aux +"*"+ (String)listaDatosEquiSelec.get(x+1);
                            aux = aux +"*"+ (String)listaDatosEquiSelec.get(x+2);
                            aux = aux +"*"+ (String)listaDatosEquiSelec.get(x+3);
                            aux = aux +"*"+ (String)listaDatosEquiSelec.get(x+5)+", "+(String)listaDatosEquiSelec.get(x+6);
                            datosEqSe.add(";"+aux);
                            x=x+8;
                        }
                        out.println(datosEqSe); 
                        break;
                    case "selectRmsOpe":
                        
                        consultasPanelExtra cpe1 = new consultasPanelExtra();
                        consultasPanelOperaciones cpo = new consultasPanelOperaciones();
                        String codigoRms = request.getParameter("valor");

                        //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS RMS
                        ArrayList datosRMSOpe = new ArrayList();
                        datosRMSOpe = cpe1.obtenerRMS(codigoRms);

                        cpe = new consultasPanelExtra();
                        //CREO UNA LISTA NUEVA PARA OBTENER LOS DATOS RMS COLUMNAS
                        ArrayList datosRMSColumnasOpe = new ArrayList();
                        datosRMSColumnasOpe = cpe.obtenerRMSColumnas(codigoRms);

                        ArrayList datosOpe = new ArrayList();

                        int z = 0;
                        while (datosRMSOpe.size() > z) {
                            datosOpe.add(datosRMSOpe.get(z));
                            z++;
                        }

                        int o = 0;
                        while (datosRMSColumnasOpe.size() > o) {
                            String aux = (String) datosRMSColumnasOpe.get(o);
                            datosOpe.add(";" + aux);
                            o++;
                        }

                        out.println(datosOpe);
                        
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
