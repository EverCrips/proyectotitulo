/*
    *Diseñado y programado por Cristopher Pérez V.
    *Sistema Tekonn 2019
*/
package Controladores;

import Modelos.consultasPanelOperaciones;
import Modelos.consultasPanelUsuarios;
import Modelos.consultasPersonales;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.TabSettings;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.draw.LineSeparator;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author MSI-EverCrips
 */
public class servletPdf extends HttpServlet {

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
        response.setContentType("application/pdf");
        OutputStream out = response.getOutputStream();

        //PARA QUE NO ACCEDAN A SERVLET POR URL
        String opcionJSP = request.getParameter("opcion");
        if (opcionJSP == null) {
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else {
            HttpSession sesion;
            switch (opcionJSP) {

                case "descargarPlanillaEquipo":

                    consultasPanelUsuarios cPU = new consultasPanelUsuarios();
                    String numEquiDescPlani = request.getParameter("numEquiDescPlani");
                    ArrayList planillaTra = new ArrayList();
                    planillaTra = cPU.obtenerTrabajadoresEquipoSelecMasJefe(numEquiDescPlani);
                    try {
                        try {
                            Document documento = new Document();
                            PdfWriter.getInstance(documento, out);

                            documento.open();

                            //Título
                            Paragraph par1 = new Paragraph();
                            Font fontTitulo = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD, BaseColor.BLACK);
                            par1.add(new Phrase("Reporte de equipo", fontTitulo));
                            par1.setAlignment(Element.ALIGN_CENTER);
                            par1.add(new Phrase(Chunk.NEWLINE));
                            par1.add(new Phrase(Chunk.NEWLINE));
                            documento.add(par1);

                            //IMAGEN
                            Image foto = Image.getInstance("C:/Users/MSI-EverCrips/Desktop/New Tekonn/web/media/imagenes/logo.png");
                            foto.scaleToFit(100, 100);
                            foto.setAlignment(Chunk.ALIGN_RIGHT);
                            documento.add(foto);

                            //LINEA
                            LineSeparator ls = new LineSeparator();
                            documento.add(new Chunk(ls));

                            ArrayList datosEqq = new ArrayList();
                            cPU = new consultasPanelUsuarios();
                            datosEqq = cPU.obtenerDatosEquipoSelec(numEquiDescPlani);
                            par1 = new Paragraph();
                            //FUENTES
                            Font fontDatosVccpPre = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, BaseColor.BLACK);
                            Font fontDatosVccpDat = new Font(Font.FontFamily.HELVETICA, 12, Font.NORMAL, BaseColor.BLACK);
                            //NUMERO Y ZONA
                            par1.add(new Phrase("Nº                     ", fontDatosVccpPre));
                            par1.add(Chunk.TABBING);
                            par1.add(new Phrase((String) datosEqq.get(0), fontDatosVccpDat));
                            par1.add(new Phrase(Chunk.NEWLINE));
                            //OPERACION
                            par1.add(new Phrase("Equipo                 ", fontDatosVccpPre));
                            par1.add(Chunk.TABBING);
                            par1.add(new Phrase((String) datosEqq.get(1), fontDatosVccpDat));
                            par1.add(new Phrase(Chunk.NEWLINE));
                            //DETALLE
                            par1.add(new Phrase("Descripción    ", fontDatosVccpPre));
                            par1.add(Chunk.TABBING);
                            par1.add(new Phrase((String) datosEqq.get(2), fontDatosVccpDat));
                            par1.add(new Phrase(Chunk.NEWLINE));
                            //DETALLE
                            par1.add(new Phrase("Lider                 ", fontDatosVccpPre));
                            par1.add(Chunk.TABBING);
                            par1.add(new Phrase((String) datosEqq.get(3) + " -- " + (String) datosEqq.get(4), fontDatosVccpDat));
                            par1.add(new Phrase(Chunk.NEWLINE));
                            par1.setTabSettings(new TabSettings(20f));
                            par1.setAlignment(Element.ALIGN_JUSTIFIED);
                            documento.add(par1);

                            //LINEA
                            ls = new LineSeparator();
                            documento.add(new Chunk(ls));

                            //DETALLE EQUIPO
                            par1 = new Paragraph();
                            fontTitulo = new Font(Font.FontFamily.HELVETICA, 14, Font.NORMAL, BaseColor.BLACK);
                            par1.add(new Phrase("Detalle trabajadores", fontTitulo));
                            par1.setAlignment(Element.ALIGN_JUSTIFIED);
                            par1.add(new Phrase(Chunk.NEWLINE));
                            par1.add(new Phrase(Chunk.NEWLINE));
                            documento.add(par1);

                            ArrayList codEq = new ArrayList();
                            consultasPanelUsuarios cpu = new consultasPanelUsuarios();
                            codEq = cpu.obtenerTrabajadoresEquipoSelec(numEquiDescPlani);

                            //TABLA CON LOS USUARIOS
                            PdfPTable tabla = new PdfPTable(8);
                            tabla.setWidths(new int[]{1, 2, 3, 1, 1, 1, 1, 2});
                            tabla.setWidthPercentage(100);
                            PdfPCell celda1 = new PdfPCell(new Paragraph("Rut", FontFactory.getFont("Arial", 8, Font.BOLD, BaseColor.BLACK)));
                            celda1.setHorizontalAlignment(Element.ALIGN_CENTER);
                            celda1.setBackgroundColor(BaseColor.LIGHT_GRAY);
                            PdfPCell celda2 = new PdfPCell(new Paragraph("Nombre", FontFactory.getFont("Arial", 8, Font.BOLD, BaseColor.BLACK)));
                            celda2.setHorizontalAlignment(Element.ALIGN_CENTER);
                            celda2.setBackgroundColor(BaseColor.LIGHT_GRAY);
                            PdfPCell celda3 = new PdfPCell(new Paragraph("Dirección", FontFactory.getFont("Arial", 8, Font.BOLD, BaseColor.BLACK)));
                            celda3.setHorizontalAlignment(Element.ALIGN_CENTER);
                            celda3.setBackgroundColor(BaseColor.LIGHT_GRAY);
                            PdfPCell celda4 = new PdfPCell(new Paragraph("Ciudad", FontFactory.getFont("Arial", 8, Font.BOLD, BaseColor.BLACK)));
                            celda4.setHorizontalAlignment(Element.ALIGN_CENTER);
                            celda4.setBackgroundColor(BaseColor.LIGHT_GRAY);
                            PdfPCell celda5 = new PdfPCell(new Paragraph("Email", FontFactory.getFont("Arial", 8, Font.BOLD, BaseColor.BLACK)));
                            celda5.setHorizontalAlignment(Element.ALIGN_CENTER);
                            celda5.setBackgroundColor(BaseColor.LIGHT_GRAY);
                            PdfPCell celda6 = new PdfPCell(new Paragraph("Teléfono celular", FontFactory.getFont("Arial", 8, Font.BOLD, BaseColor.BLACK)));
                            celda6.setHorizontalAlignment(Element.ALIGN_CENTER);
                            celda6.setBackgroundColor(BaseColor.LIGHT_GRAY);
                            PdfPCell celda7 = new PdfPCell(new Paragraph("Teléfono fijo", FontFactory.getFont("Arial", 8, Font.BOLD, BaseColor.BLACK)));
                            celda7.setHorizontalAlignment(Element.ALIGN_CENTER);
                            celda7.setBackgroundColor(BaseColor.LIGHT_GRAY);
                            PdfPCell celda8 = new PdfPCell(new Paragraph("Especialidad", FontFactory.getFont("Arial", 8, Font.BOLD, BaseColor.BLACK)));
                            celda8.setHorizontalAlignment(Element.ALIGN_CENTER);
                            celda8.setBackgroundColor(BaseColor.LIGHT_GRAY);

                            tabla.addCell(celda1);
                            tabla.addCell(celda2);
                            tabla.addCell(celda3);
                            tabla.addCell(celda4);
                            tabla.addCell(celda5);
                            tabla.addCell(celda6);
                            tabla.addCell(celda7);
                            tabla.addCell(celda8);

                            //LLENO CELDAS
                            for (int i = 0; i < codEq.size(); i = i + 8) {
                                PdfPCell celdaEq1 = new PdfPCell(new Paragraph((String) codEq.get(i + 1), FontFactory.getFont("Arial", 6, Font.NORMAL, BaseColor.BLACK)));
                                celdaEq1.setVerticalAlignment(Element.ALIGN_MIDDLE);
                                celdaEq1.setHorizontalAlignment(Element.ALIGN_CENTER);
                                tabla.addCell(celdaEq1);
                                PdfPCell celdaEq2 = new PdfPCell(new Paragraph((String) codEq.get(i), FontFactory.getFont("Arial", 6, Font.NORMAL, BaseColor.BLACK)));
                                celdaEq2.setVerticalAlignment(Element.ALIGN_MIDDLE);
                                celdaEq2.setHorizontalAlignment(Element.ALIGN_CENTER);
                                tabla.addCell(celdaEq2);
                                PdfPCell celdaEq3 = new PdfPCell(new Paragraph((String) codEq.get(i + 5), FontFactory.getFont("Arial", 6, Font.NORMAL, BaseColor.BLACK)));
                                celdaEq3.setVerticalAlignment(Element.ALIGN_MIDDLE);
                                celdaEq3.setHorizontalAlignment(Element.ALIGN_CENTER);
                                tabla.addCell(celdaEq3);
                                PdfPCell celdaEq4 = new PdfPCell(new Paragraph((String) codEq.get(i + 6), FontFactory.getFont("Arial", 6, Font.NORMAL, BaseColor.BLACK)));
                                celdaEq4.setVerticalAlignment(Element.ALIGN_MIDDLE);
                                celdaEq4.setHorizontalAlignment(Element.ALIGN_CENTER);
                                tabla.addCell(celdaEq4);
                                PdfPCell celdaEq5 = new PdfPCell(new Paragraph((String) codEq.get(i + 2), FontFactory.getFont("Arial", 6, Font.NORMAL, BaseColor.BLACK)));
                                celdaEq5.setVerticalAlignment(Element.ALIGN_MIDDLE);
                                celdaEq5.setHorizontalAlignment(Element.ALIGN_CENTER);
                                tabla.addCell(celdaEq5);
                                PdfPCell celdaEq6 = new PdfPCell(new Paragraph((String) codEq.get(i + 3), FontFactory.getFont("Arial", 6, Font.NORMAL, BaseColor.BLACK)));
                                celdaEq6.setVerticalAlignment(Element.ALIGN_MIDDLE);
                                celdaEq6.setHorizontalAlignment(Element.ALIGN_CENTER);
                                tabla.addCell(celdaEq6);
                                PdfPCell celdaEq7 = new PdfPCell(new Paragraph((String) codEq.get(i + 4), FontFactory.getFont("Arial", 6, Font.NORMAL, BaseColor.BLACK)));
                                celdaEq7.setVerticalAlignment(Element.ALIGN_MIDDLE);
                                celdaEq7.setHorizontalAlignment(Element.ALIGN_CENTER);
                                tabla.addCell(celdaEq7);
                                PdfPCell celdaEq8 = new PdfPCell(new Paragraph((String) codEq.get(i + 7), FontFactory.getFont("Arial", 6, Font.NORMAL, BaseColor.BLACK)));
                                celdaEq8.setVerticalAlignment(Element.ALIGN_MIDDLE);
                                celdaEq8.setHorizontalAlignment(Element.ALIGN_CENTER);
                                tabla.addCell(celdaEq8);
                            }

                            documento.add(tabla);

                            documento.close();
                        } catch (Exception ex) {
                            ex.getMessage();
                        }
                    } finally {
                        out.close();
                    }
                    break;

                case "descargarOperacion":

                    consultasPanelUsuarios cPU2 = new consultasPanelUsuarios();
                    String numOpeDesca = request.getParameter("numOpeDesca");

                    try {
                        try {
                            Document documento = new Document();
                            PdfWriter.getInstance(documento, out);

                            documento.open();

                            //Título
                            Paragraph par1 = new Paragraph();
                            Font fontTitulo = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD, BaseColor.BLACK);
                            par1.add(new Phrase("Planilla VCCP", fontTitulo));
                            par1.setAlignment(Element.ALIGN_CENTER);
                            par1.add(new Phrase(Chunk.NEWLINE));
                            par1.add(new Phrase(Chunk.NEWLINE));
                            documento.add(par1);

                            //IMAGEN
                            Image foto = Image.getInstance("C:/Users/MSI-EverCrips/Desktop/New Tekonn/web/media/imagenes/logo.png");
                            foto.scaleToFit(100, 100);
                            foto.setAlignment(Chunk.ALIGN_RIGHT);
                            documento.add(foto);

                            //LINEA
                            LineSeparator ls = new LineSeparator();
                            documento.add(new Chunk(ls));

                            //DATOS VCCP
                            consultasPanelOperaciones cpo = new consultasPanelOperaciones();
                            ArrayList datosVccp = new ArrayList();
                            datosVccp = cpo.obtenerOperacionSelec(numOpeDesca);

                            par1 = new Paragraph();
                            //FUENTES
                            Font fontDatosVccpPre = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, BaseColor.BLACK);
                            Font fontDatosVccpDat = new Font(Font.FontFamily.HELVETICA, 12, Font.NORMAL, BaseColor.BLACK);
                            //NUMERO Y ZONA
                            par1.add(new Phrase("Nº                      ", fontDatosVccpPre));
                            par1.add(Chunk.TABBING);
                            par1.add(new Phrase((String) datosVccp.get(0), fontDatosVccpDat));
                            par1.add(new Phrase(Chunk.NEWLINE));
                            //OPERACION
                            par1.add(new Phrase("Operación        ", fontDatosVccpPre));
                            par1.add(Chunk.TABBING);
                            par1.add(new Phrase((String) datosVccp.get(1), fontDatosVccpDat));
                            par1.add(new Phrase(Chunk.NEWLINE));
                            //DETALLE
                            par1.add(new Phrase("Descripción     ", fontDatosVccpPre));
                            par1.add(Chunk.TABBING);
                            par1.add(new Phrase((String) datosVccp.get(2), fontDatosVccpDat));
                            par1.add(new Phrase(Chunk.NEWLINE));
                            //FECHAS
                            par1.add(new Phrase("Inicio                ", fontDatosVccpPre));
                            par1.add(Chunk.TABBING);
                            par1.add(new Phrase((String) datosVccp.get(3), fontDatosVccpDat));
                            par1.add(new Phrase("           Término", fontDatosVccpPre));
                            par1.add(Chunk.TABBING);
                            par1.add(new Phrase((String) datosVccp.get(4), fontDatosVccpDat));
                            par1.add(new Phrase(Chunk.NEWLINE));
                            //OBSERVACIONES                            
                            par1.add(new Phrase("Zona                 ", fontDatosVccpPre));
                            par1.add(Chunk.TABBING);
                            par1.add(new Phrase((String) datosVccp.get(6), fontDatosVccpDat));
                            par1.add(new Phrase("                       Estado", fontDatosVccpPre));
                            par1.add(Chunk.TABBING);
                            par1.add(new Phrase((String) datosVccp.get(7), fontDatosVccpDat));
                            par1.add(new Phrase(Chunk.NEWLINE));
                            par1.add(new Phrase("Observación    ", fontDatosVccpPre));
                            par1.add(Chunk.TABBING);
                            par1.add(new Phrase((String) datosVccp.get(8), fontDatosVccpDat));
                            par1.setTabSettings(new TabSettings(20f));
                            par1.setAlignment(Element.ALIGN_JUSTIFIED);
                            documento.add(par1);

                            //LINEA
                            LineSeparator ls2 = new LineSeparator();
                            documento.add(new Chunk(ls2));

                            //DETALLE COLUMNA
                            Paragraph par2 = new Paragraph();
                            Font fontDescrip = new Font(Font.FontFamily.HELVETICA, 14, Font.NORMAL, BaseColor.BLACK);
                            par2.add(new Phrase("Detalle columnas", fontDescrip));
                            par2.setAlignment(Element.ALIGN_JUSTIFIED);
                            par2.add(new Phrase(Chunk.NEWLINE));
                            par2.add(new Phrase(Chunk.NEWLINE));
                            documento.add(par2);

                            /*
                             RMS
                             */
                            ArrayList datosRms = new ArrayList();
                            cpo = new consultasPanelOperaciones();
                            datosRms = cpo.rmsPlanilla(numOpeDesca);
                            //////////////////////////////////////////
                            int x = 0;
                            while (x < datosRms.size()) {
                                //RM
                                Paragraph par3 = new Paragraph();
                                fontDescrip = new Font(Font.FontFamily.HELVETICA, 14, Font.NORMAL, BaseColor.BLACK);
                                par3.add(new Phrase((String) datosRms.get(x + 1), fontDescrip));
                                par3.setAlignment(Element.ALIGN_CENTER);
                                par3.add(new Phrase(Chunk.NEWLINE));
                                par3.add(new Phrase(Chunk.NEWLINE));
                                documento.add(par3);
                                //IMAGEN
                                Image fotoRms = Image.getInstance("C:/Users/MSI-EverCrips/Desktop/New Tekonn/web/" + (String) datosRms.get(x + 2));
                                fotoRms.scaleToFit(100, 50);
                                fotoRms.setAlignment(Chunk.ALIGN_CENTER);
                                documento.add(fotoRms);

                                //DETALLE COLUMNA
                                ArrayList datosValoraciones = new ArrayList();
                                cpo = new consultasPanelOperaciones();
                                datosValoraciones = cpo.obtenerDetallesColumnas(numOpeDesca, (String) datosRms.get(x + 1));

                                int z = 0;
                                PdfPTable tabla = new PdfPTable(2);
                                tabla.setWidthPercentage(90);
                                tabla.setWidths(new int[]{10, 2});
                                PdfPCell celdaHeader1 = new PdfPCell(new Paragraph("Descripción columna", FontFactory.getFont("Arial", 10, Font.BOLD, BaseColor.BLACK)));
                                PdfPCell celdaHeader2 = new PdfPCell(new Paragraph("Valoración", FontFactory.getFont("Arial", 10, Font.BOLD, BaseColor.BLACK)));
                                celdaHeader1.setHorizontalAlignment(Element.ALIGN_CENTER);
                                celdaHeader1.setBackgroundColor(BaseColor.LIGHT_GRAY);
                                celdaHeader2.setHorizontalAlignment(Element.ALIGN_CENTER);
                                celdaHeader2.setBackgroundColor(BaseColor.LIGHT_GRAY);
                                tabla.addCell(celdaHeader1);
                                tabla.addCell(celdaHeader2);
                                //TABLA CON DETALLES DEL RMS
                                while (z < datosValoraciones.size()) {
                                    PdfPCell celdaDeta1 = new PdfPCell(new Paragraph((String) datosValoraciones.get(z), FontFactory.getFont("Arial", 8, Font.NORMAL, BaseColor.BLACK)));
                                    celdaDeta1.setVerticalAlignment(Element.ALIGN_JUSTIFIED);
                                    celdaDeta1.setHorizontalAlignment(Element.ALIGN_JUSTIFIED);
                                    PdfPCell celdaDeta2 = new PdfPCell(new Paragraph((String) datosValoraciones.get(z + 1), FontFactory.getFont("Arial", 8, Font.NORMAL, BaseColor.BLACK)));
                                    celdaDeta2.setVerticalAlignment(Element.ALIGN_MIDDLE);
                                    celdaDeta2.setHorizontalAlignment(Element.ALIGN_CENTER);
                                    tabla.addCell(celdaDeta1);
                                    tabla.addCell(celdaDeta2);
                                    z = z + 2;
                                }
                                documento.add(tabla);
                                x = x + 3;
                            }

                            //LINEA
                            ls2 = new LineSeparator();
                            documento.add(new Chunk(ls2));

                            //DETALLE EQUIPO
                            par2 = new Paragraph();
                            fontDescrip = new Font(Font.FontFamily.HELVETICA, 14, Font.NORMAL, BaseColor.BLACK);
                            par2.add(new Phrase("Detalle equipo", fontDescrip));
                            par2.setAlignment(Element.ALIGN_JUSTIFIED);
                            par2.add(new Phrase(Chunk.NEWLINE));
                            par2.add(new Phrase(Chunk.NEWLINE));
                            documento.add(par2);

                            ArrayList Ema = new ArrayList();
                            consultasPersonales cp = new consultasPersonales();
                            Ema = cp.obtenerCodigoEquipo((String) datosVccp.get(5));
                            ArrayList codEq = new ArrayList();
                            consultasPanelUsuarios cpu = new consultasPanelUsuarios();
                            codEq = cpu.obtenerTrabajadoresEquipoSelec((String) Ema.get(0));
                            
                            ArrayList datosEqq = new ArrayList();
                            cPU = new consultasPanelUsuarios();
                            datosEqq = cPU.obtenerDatosEquipoSelec((String)Ema.get(0));
                            par1 = new Paragraph();
                            //FUENTES
                            fontDatosVccpPre = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, BaseColor.BLACK);
                            fontDatosVccpDat = new Font(Font.FontFamily.HELVETICA, 12, Font.NORMAL, BaseColor.BLACK);
                            //NUMERO Y ZONA
                            par1.add(new Phrase("Nº                     ", fontDatosVccpPre));
                            par1.add(Chunk.TABBING);
                            par1.add(new Phrase((String) datosEqq.get(0), fontDatosVccpDat));
                            par1.add(new Phrase(Chunk.NEWLINE));
                            //OPERACION
                            par1.add(new Phrase("Equipo                 ", fontDatosVccpPre));
                            par1.add(Chunk.TABBING);
                            par1.add(new Phrase((String) datosEqq.get(1), fontDatosVccpDat));
                            par1.add(new Phrase(Chunk.NEWLINE));
                            //DETALLE
                            par1.add(new Phrase("Descripción    ", fontDatosVccpPre));
                            par1.add(Chunk.TABBING);
                            par1.add(new Phrase((String) datosEqq.get(2), fontDatosVccpDat));
                            par1.add(new Phrase(Chunk.NEWLINE));
                            //DETALLE
                            par1.add(new Phrase("Lider                 ", fontDatosVccpPre));
                            par1.add(Chunk.TABBING);
                            par1.add(new Phrase((String) datosEqq.get(3) + " -- " + (String) datosEqq.get(4), fontDatosVccpDat));
                            par1.add(new Phrase(Chunk.NEWLINE));
                            par1.setTabSettings(new TabSettings(20f));
                            par1.setAlignment(Element.ALIGN_JUSTIFIED);
                            documento.add(par1);

                            //LINEA
                            ls = new LineSeparator();
                            documento.add(new Chunk(ls));

                            //TABLA CON LOS USUARIOS
                            PdfPTable tabla = new PdfPTable(8);
                            tabla.setWidths(new int[]{1, 2, 3, 1, 1, 1, 1, 2});
                            tabla.setWidthPercentage(100);
                            PdfPCell celda1 = new PdfPCell(new Paragraph("Rut", FontFactory.getFont("Arial", 8, Font.BOLD, BaseColor.BLACK)));
                            celda1.setHorizontalAlignment(Element.ALIGN_CENTER);
                            celda1.setBackgroundColor(BaseColor.LIGHT_GRAY);
                            PdfPCell celda2 = new PdfPCell(new Paragraph("Nombre", FontFactory.getFont("Arial", 8, Font.BOLD, BaseColor.BLACK)));
                            celda2.setHorizontalAlignment(Element.ALIGN_CENTER);
                            celda2.setBackgroundColor(BaseColor.LIGHT_GRAY);
                            PdfPCell celda3 = new PdfPCell(new Paragraph("Dirección", FontFactory.getFont("Arial", 8, Font.BOLD, BaseColor.BLACK)));
                            celda3.setHorizontalAlignment(Element.ALIGN_CENTER);
                            celda3.setBackgroundColor(BaseColor.LIGHT_GRAY);
                            PdfPCell celda4 = new PdfPCell(new Paragraph("Ciudad", FontFactory.getFont("Arial", 8, Font.BOLD, BaseColor.BLACK)));
                            celda4.setHorizontalAlignment(Element.ALIGN_CENTER);
                            celda4.setBackgroundColor(BaseColor.LIGHT_GRAY);
                            PdfPCell celda5 = new PdfPCell(new Paragraph("Email", FontFactory.getFont("Arial", 8, Font.BOLD, BaseColor.BLACK)));
                            celda5.setHorizontalAlignment(Element.ALIGN_CENTER);
                            celda5.setBackgroundColor(BaseColor.LIGHT_GRAY);
                            PdfPCell celda6 = new PdfPCell(new Paragraph("Teléfono celular", FontFactory.getFont("Arial", 8, Font.BOLD, BaseColor.BLACK)));
                            celda6.setHorizontalAlignment(Element.ALIGN_CENTER);
                            celda6.setBackgroundColor(BaseColor.LIGHT_GRAY);
                            PdfPCell celda7 = new PdfPCell(new Paragraph("Teléfono fijo", FontFactory.getFont("Arial", 8, Font.BOLD, BaseColor.BLACK)));
                            celda7.setHorizontalAlignment(Element.ALIGN_CENTER);
                            celda7.setBackgroundColor(BaseColor.LIGHT_GRAY);
                            PdfPCell celda8 = new PdfPCell(new Paragraph("Especialidad", FontFactory.getFont("Arial", 8, Font.BOLD, BaseColor.BLACK)));
                            celda8.setHorizontalAlignment(Element.ALIGN_CENTER);
                            celda8.setBackgroundColor(BaseColor.LIGHT_GRAY);

                            tabla.addCell(celda1);
                            tabla.addCell(celda2);
                            tabla.addCell(celda3);
                            tabla.addCell(celda4);
                            tabla.addCell(celda5);
                            tabla.addCell(celda6);
                            tabla.addCell(celda7);
                            tabla.addCell(celda8);

                            //LLENO CELDAS
                            for (int i = 0; i < codEq.size(); i = i + 8) {
                                PdfPCell celdaEq1 = new PdfPCell(new Paragraph((String) codEq.get(i + 1), FontFactory.getFont("Arial", 6, Font.NORMAL, BaseColor.BLACK)));
                                celdaEq1.setVerticalAlignment(Element.ALIGN_MIDDLE);
                                celdaEq1.setHorizontalAlignment(Element.ALIGN_CENTER);
                                tabla.addCell(celdaEq1);
                                PdfPCell celdaEq2 = new PdfPCell(new Paragraph((String) codEq.get(i), FontFactory.getFont("Arial", 6, Font.NORMAL, BaseColor.BLACK)));
                                celdaEq2.setVerticalAlignment(Element.ALIGN_MIDDLE);
                                celdaEq2.setHorizontalAlignment(Element.ALIGN_CENTER);
                                tabla.addCell(celdaEq2);
                                PdfPCell celdaEq3 = new PdfPCell(new Paragraph((String) codEq.get(i + 5), FontFactory.getFont("Arial", 6, Font.NORMAL, BaseColor.BLACK)));
                                celdaEq3.setVerticalAlignment(Element.ALIGN_MIDDLE);
                                celdaEq3.setHorizontalAlignment(Element.ALIGN_CENTER);
                                tabla.addCell(celdaEq3);
                                PdfPCell celdaEq4 = new PdfPCell(new Paragraph((String) codEq.get(i + 6), FontFactory.getFont("Arial", 6, Font.NORMAL, BaseColor.BLACK)));
                                celdaEq4.setVerticalAlignment(Element.ALIGN_MIDDLE);
                                celdaEq4.setHorizontalAlignment(Element.ALIGN_CENTER);
                                tabla.addCell(celdaEq4);
                                PdfPCell celdaEq5 = new PdfPCell(new Paragraph((String) codEq.get(i + 2), FontFactory.getFont("Arial", 6, Font.NORMAL, BaseColor.BLACK)));
                                celdaEq5.setVerticalAlignment(Element.ALIGN_MIDDLE);
                                celdaEq5.setHorizontalAlignment(Element.ALIGN_CENTER);
                                tabla.addCell(celdaEq5);
                                PdfPCell celdaEq6 = new PdfPCell(new Paragraph((String) codEq.get(i + 3), FontFactory.getFont("Arial", 6, Font.NORMAL, BaseColor.BLACK)));
                                celdaEq6.setVerticalAlignment(Element.ALIGN_MIDDLE);
                                celdaEq6.setHorizontalAlignment(Element.ALIGN_CENTER);
                                tabla.addCell(celdaEq6);
                                PdfPCell celdaEq7 = new PdfPCell(new Paragraph((String) codEq.get(i + 4), FontFactory.getFont("Arial", 6, Font.NORMAL, BaseColor.BLACK)));
                                celdaEq7.setVerticalAlignment(Element.ALIGN_MIDDLE);
                                celdaEq7.setHorizontalAlignment(Element.ALIGN_CENTER);
                                tabla.addCell(celdaEq7);
                                PdfPCell celdaEq8 = new PdfPCell(new Paragraph((String) codEq.get(i + 7), FontFactory.getFont("Arial", 6, Font.NORMAL, BaseColor.BLACK)));
                                celdaEq8.setVerticalAlignment(Element.ALIGN_MIDDLE);
                                celdaEq8.setHorizontalAlignment(Element.ALIGN_CENTER);
                                tabla.addCell(celdaEq8);
                            }

                            documento.add(tabla);

                            //LINEA
                            ls2 = new LineSeparator();
                            documento.add(new Chunk(ls2));

                            //FINAL
                            //Título
                            par1 = new Paragraph();
                            fontTitulo = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD, BaseColor.BLACK);
                            par1.add(new Phrase("Documento válido para ser usado como respaldo ante las operaciones realizadas", fontTitulo));
                            par1.setAlignment(Element.ALIGN_CENTER);
                            par1.add(new Phrase(Chunk.NEWLINE));
                            par1.add(new Phrase(Chunk.NEWLINE));
                            documento.add(par1);

                            documento.close();
                        } catch (Exception ex) {
                            ex.getMessage();
                        }
                    } finally {
                        out.close();
                    }
                    break;
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
