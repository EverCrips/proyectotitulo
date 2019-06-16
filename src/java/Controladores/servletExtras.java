/*
    *Diseñado y programado por Cristopher Pérez V.
    *Sistema Tekonn 2019
*/
package Controladores;

import Modelos.CorreoElectronico;
import Modelos.consultasPanelExtra;
import Modelos.consultasPersonales;
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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Cristopher
 */
@MultipartConfig
public class servletExtras extends HttpServlet {

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
                    case "modificarPassNueva":
                        String auxemailUsRP = request.getParameter("auxemailUsRP");
                        String pass2UsEdit = request.getParameter("pass2UsEdit");

                        consultasPersonales cp = new consultasPersonales();
                        if (cp.modificarUsPass(pass2UsEdit, auxemailUsRP)) {
                            //ÉXITO
                            request.setAttribute("msjAlertGreen", "Contraseña reseteada con éxito");
                            request.getRequestDispatcher("index.jsp").forward(request, response);
                        } else {
                            request.setAttribute("msjAlertRed", "Ocurrió un error no controlado, intente nuevamente más tarde");
                            request.getRequestDispatcher("index.jsp").forward(request, response);
                        }
                        break;

                    case "enviarReporte":
                        String nombreUsReporte = request.getParameter("nombreUsReporte");
                        String rutUsReporte = request.getParameter("rutUsReporte");
                        String emailUsReporte = request.getParameter("emailUsReporte");
                        String tituloReporte = request.getParameter("tituloReporte");
                        String descripcionReporte = request.getParameter("descripcionReporte");
                        //IMAGEN
                        Part archivo = request.getPart("imgReporte");
                        String nombreArchivo = Paths.get(archivo.getSubmittedFileName()).getFileName().toString();
                        InputStream contenidoArchivo = archivo.getInputStream();

                        byte[] buffer = new byte[contenidoArchivo.available()];

                        contenidoArchivo.read(buffer);

                        File targetFile = new File("C:\\Users\\Cristopher\\Desktop\\Tekonn\\web\\media\\imagenes\\reportes\\" + nombreArchivo);

                        OutputStream outStream = new FileOutputStream(targetFile);

                        outStream.write(buffer);

                        String ruta = "C:/Users/Cristopher/Desktop/Tekonn/web/media/imagenes/reportes/" + nombreArchivo;

                        CorreoElectronico cor;
                        cor = new CorreoElectronico();

                        String plantilla = "Se ha recibido un nuevo reporte de bug/error por parte de: " + nombreUsReporte + ".\nA continuación, se detalla la descripción:\n"
                                + "---------------------------------------------------------------------------------------\nDescripción reporte: " + descripcionReporte + "\n---------------------------------------------------------------------------------------\n"
                                + "---------------------------------------------------------------------------------------\n"
                                + "Atender a la brevedad el reporte.\nAtte. Administración Tekonn";

                        if (cor.enviarCorreoReporte(plantilla, ruta, nombreArchivo)) {
                            //Envío correcto
                            request.setAttribute("msjAlertGreen", "Reporte enviado correctamente.");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("reportarBug.jsp").forward(request, response);
                        } else {
                            request.setAttribute("msjAlertRed", "Ha ocurrido un error al enviar el reporte.");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("reportarBug.jsp").forward(request, response);
                        }
                        break;

                    case "enviarAviso":
                        //CREAR LA SESION
                        sesion = request.getSession();
                        String emailUsAviso = request.getParameter("emailUsAviso");
                        String tituloAviso = request.getParameter("tituloAviso");
                        String descripcionAviso = request.getParameter("descripcionAviso");
                        String tipoAviso = request.getParameter("tipoAviso");

                        consultasPanelExtra cpe = new consultasPanelExtra();
                        consultasPersonales cp2 = new consultasPersonales();
                        ArrayList arr = new ArrayList();
                        arr = cp2.obtenerCodigoUs(emailUsAviso);

                        if (cpe.nuevaAviso(tituloAviso, descripcionAviso, (String) arr.get(0), tipoAviso)) {
                            //AVISOS
                            cpe = new consultasPanelExtra();
                            ArrayList listaAvisos = new ArrayList();
                            listaAvisos = cpe.obtenerAvisos();
                            sesion.setAttribute("listaAvisos", listaAvisos);

                            //Envío correcto
                            request.setAttribute("msjAlertGreen", "Aviso enviado correctamente.");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("avisos.jsp").forward(request, response);
                        } else {
                            request.setAttribute("msjAlertRed", "Ha ocurrido un error al procesar el aviso.");
                            request.setAttribute("msjModalShow", "Valido");
                            request.getRequestDispatcher("avisos.jsp").forward(request, response);
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
