/*
    *Diseñado y programado por Cristopher Pérez V.
    *Sistema Tekonn 2019
*/
package Modelos;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Cristopher
 */
public class consultasPanelExtra extends Conexion{
    
    /*
        MÉTODOS VISUALIZAR RIESGOS
    */
    
    //MÉTODO PARA OBTENER TODOS LOS RIESGOS CRITICOS 
    public ArrayList obtenerRMS(String rie) {
        ArrayList lista = new ArrayList();
        String nombreRMS = "", numeroRMS = "", imgRMS = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select rm.nombre_riesgo, rm.numero_riesgo, rm.rutaImagen_riesgo from rms rm "+
                    "where rm.id_riesgo=?";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, rie);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    nombreRMS = rs.getString("rm.nombre_riesgo"); //0
                    numeroRMS = rs.getString("rm.numero_riesgo"); //1
                    imgRMS = rs.getString("rm.rutaImagen_riesgo"); //
                    lista.add(nombreRMS);
                    lista.add(numeroRMS);
                    lista.add(imgRMS);
                } while (rs.next());
            } else {
                lista.add("null");
            }
        } catch (Exception e) {
            System.err.println("ERROR1: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
                }
                if (pst != null) {
                    pst.close();
                }
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                System.err.println("ERROR2 : " + e);
            }
        }

        return lista;
    }

    //MÉTODO PARA OBTENER TODOS COLUMNAS RIESGOS CRITICOS 
    public ArrayList obtenerRMSColumnas(String rie) {
        ArrayList lista = new ArrayList();
        String descriRMS = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select rmde.descripcion_rmsColumna from columnas rmde, rms rm where rmde.codigo_rms=? and rmde.codigo_rms=rm.id_riesgo";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, rie);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    descriRMS = rs.getString("rmde.descripcion_rmsColumna"); //0
                    lista.add(descriRMS);
                } while (rs.next());
            } else {
                lista.add("null");
            }
        } catch (Exception e) {
            System.err.println("ERROR1: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
                }
                if (pst != null) {
                    pst.close();
                }
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                System.err.println("ERROR2 : " + e);
            }
        }

        return lista;
    }
    
    /*
        MÉTODOS CONTENIDOS
    */
    
    /*
        AVISO
    */
     //MÉTODO PARA OBTENER TODOS LOS AVISOS
    public ArrayList obtenerAvisos() {
        ArrayList lista = new ArrayList();
        String nombreAv = "", descripAv = "", fechAv = "", usuAv="", imgAv="";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select av.nombre_aviso, av.descripcion_aviso, av.fecha_aviso, us.nombre_usuario, tip.nombre_tipoAv from avisos av, usuarios us, tipos tip where "
                    + "av.codigo_usuario=us.id_usuario and av.codigo_tipo=tip.id_tipoAv order by av.id_aviso desc limit 6";

            pst = getConexion().prepareStatement(consulta);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    nombreAv = rs.getString("av.nombre_aviso"); //0
                    descripAv = rs.getString("av.descripcion_aviso"); //1
                    fechAv = rs.getString("av.fecha_aviso"); //2
                    usuAv = rs.getString("us.nombre_usuario"); //3
                    imgAv = rs.getString("tip.nombre_tipoAv"); //4
                    lista.add(nombreAv);
                    lista.add(descripAv);
                    lista.add(fechAv);
                    lista.add(usuAv);
                    lista.add(imgAv);
                } while (rs.next());
            } else {
                lista.add("null");
            }
        } catch (Exception e) {
            System.err.println("ERROR1: " + e);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
                }
                if (pst != null) {
                    pst.close();
                }
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
                System.err.println("ERROR2 : " + e);
            }
        }

        return lista;
    }

    //AGREGAR NUEVO AVISOombre, 
    public boolean nuevaAviso(String nombreAv, String descripcionAv, String usCo, String coTi) {
        boolean registrar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "insert into avisos (nombre_aviso, descripcion_aviso, fecha_aviso, codigo_usuario, codigo_tipo) "
                    + "values(?, ?, now(), ?, ?)";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, nombreAv);
            pst.setString(2, descripcionAv);
            pst.setString(3, usCo);
            pst.setString(4, coTi);

            if (pst.executeUpdate() == 1) {
                registrar = true;
            }
        } catch (Exception ex) {
            System.err.println("Error: +" + ex);
        } finally {
            try {
                if (getConexion() != null) {
                    getConexion().close();
                }
                if (pst != null) {
                    pst.close();
                }
            } catch (Exception e) {
                System.err.println("ERROR : " + e);
            }
        }
        return registrar;
    }
    
     //MÉTODO PARA OBTENER TODOS LOS ARCHIVOS DE CONTENIDOS
    public ArrayList DatosContenidos() {
        ArrayList lista = new ArrayList();
        String nombreArch="", descripcionArch="", rutaArch="", autorArch="",tipoArch="";
        PreparedStatement pst =null;
        ResultSet rs = null;
        try {
            String consulta = "select cont.nombre_contenido, cont.descripcion_contenido, cont.ruta_contenido, cont.tipo_contenido, us.nombre_usuario from contenidos cont, usuarios us "
                    + "where cont.codigo_usuario=us.id_usuario ";
            
            pst = getConexion().prepareStatement(consulta);           
            
            rs = pst.executeQuery();
            if(rs.next()){
                do{
                    nombreArch = rs.getString("cont.nombre_contenido"); //0
                    descripcionArch = rs.getString("cont.descripcion_contenido"); //1
                    rutaArch = rs.getString("cont.ruta_contenido"); //2
                    tipoArch = rs.getString("cont.tipo_contenido"); //3
                    autorArch = rs.getString("us.nombre_usuario"); //4
                    lista.add(nombreArch);
                    lista.add(descripcionArch);
                    lista.add(rutaArch);
                    lista.add(tipoArch);
                    lista.add(autorArch);
                }while(rs.next());
            }else{
                lista.add("null");
            }
        } catch (Exception e) {
            System.err.println("ERROR1: "+e);
        }finally{
            try {
                if(getConexion() != null)getConexion().close();
                if(pst != null)pst.close();
                if(rs != null)rs.close();
            } catch (Exception e) {
                System.err.println("ERROR2 : "+e);
            }
        }
        
        return lista;
    }
    
    public static void main(String[] args) {
        consultasPanelExtra con = new consultasPanelExtra();
        System.out.println(con.obtenerAvisos());

    }
    
    
}
