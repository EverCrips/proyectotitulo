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
public class consultasPanelOperaciones extends Conexion {

    /*
        **ZONAS Y CARGOS**
    */
    
    //MÉTODO PARA OBTENER TODAS LAS ZONAS DE ACCIÓN
    public ArrayList obtenerZonasAccion() {
        ArrayList lista = new ArrayList();
        String numero_zona = "", nombre_zona = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select id_zona, nombre_zona from zonasdeoperaciones order by nombre_zona asc";

            pst = getConexion().prepareStatement(consulta);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    numero_zona = rs.getString("id_zona"); //0
                    nombre_zona = rs.getString("nombre_zona"); //1
                    lista.add(numero_zona);
                    lista.add(nombre_zona);
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

    //MÉTODO PARA OBTENER TODOS LOS DATOS CARGOS DISPONIBLES
    public ArrayList obtenerDatosCargos() {
        ArrayList lista = new ArrayList();
        String nombreCargo = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select cr.nombre_cargo from cargos cr order by nombre_cargo asc";

            pst = getConexion().prepareStatement(consulta);
            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    nombreCargo = rs.getString("cr.nombre_cargo"); //0
                    lista.add(nombreCargo);
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
        **OPERACIONES**
    */
    //VCCP FORMULARIO
    //MÉTODO PARA OBTENER TODAS LAS OPERACIONES REALIZADAS POR EL CAPATAZ
    public ArrayList obtenerOperacionesCapataz(String capataz) {
        ArrayList lista = new ArrayList();
        String numeroOperacion = "", nombre_operacion="", descripcion_operacion="", fechainicio="", fechatermino="", estado="";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select id_operacion, nombre_operacion, descripcion_operacion, fechainicio_operacion, fechatermino_operacion, estado_operacion from vccpformularios "
                    + "where codigo_usuario=?";

            pst = getConexion().prepareStatement(consulta);
            pst.setString(1, capataz);
            
            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    numeroOperacion = rs.getString("id_operacion"); //0
                    nombre_operacion = rs.getString("nombre_operacion"); //1
                    descripcion_operacion = rs.getString("descripcion_operacion"); //2
                    fechainicio = rs.getString("fechainicio_operacion"); //3
                    fechatermino = rs.getString("fechatermino_operacion"); //4
                    estado = rs.getString("estado_operacion"); //5
                    lista.add(numeroOperacion);
                    lista.add(nombre_operacion);
                    lista.add(descripcion_operacion);
                    lista.add(fechainicio);
                    lista.add(fechatermino);
                    lista.add(estado);
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
    
    //MÉTODO PARA OBTENER TODAS LAS OPERACIONES 
    public ArrayList obtenerOperacionesGeneral() {
        ArrayList lista = new ArrayList();
        String numeroOperacion = "", nombre_operacion="", descripcion_operacion="", fechainicio="", fechatermino="", estado="";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select id_operacion, nombre_operacion, descripcion_operacion, fechainicio_operacion, fechatermino_operacion, estado_operacion from vccpformularios";

            pst = getConexion().prepareStatement(consulta);
            
            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    numeroOperacion = rs.getString("id_operacion"); //0
                    nombre_operacion = rs.getString("nombre_operacion"); //1
                    descripcion_operacion = rs.getString("descripcion_operacion"); //2
                    fechainicio = rs.getString("fechainicio_operacion"); //3
                    fechatermino = rs.getString("fechatermino_operacion"); //4
                    estado = rs.getString("estado_operacion"); //5
                    lista.add(numeroOperacion);
                    lista.add(nombre_operacion);
                    lista.add(descripcion_operacion);
                    lista.add(fechainicio);
                    lista.add(fechatermino);
                    lista.add(estado);
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
    
    //MÉTODO PARA OBTENER OPERACION SELECCIONADA
    public ArrayList obtenerOperacionSelec(String codigo) {
        ArrayList lista = new ArrayList();
        String numeroOperacion = "", nombre_operacion="", descripcion_operacion="", fechainicio="", fechatermino="", estado="", observaciones="", zona="", usuario="";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select op.id_operacion, op.nombre_operacion, op.descripcion_operacion, op.fechainicio_operacion, op.fechatermino_operacion, op.codigo_usuario, "
                    + "zo.nombre_zona, op.estado_operacion, op.observaciones_operacion from vccpformularios op, zonasdeoperaciones zo where op.id_operacion=? "
                    + "and op.codigo_zonadeoperacion=zo.id_zona";

            pst = getConexion().prepareStatement(consulta);
            
            pst.setString(1, codigo);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    numeroOperacion = rs.getString("op.id_operacion"); //0
                    nombre_operacion = rs.getString("op.nombre_operacion"); //1
                    descripcion_operacion = rs.getString("op.descripcion_operacion"); //2
                    fechainicio = rs.getString("op.fechainicio_operacion"); //3
                    fechatermino = rs.getString("op.fechatermino_operacion"); //4
                    usuario = rs.getString("op.codigo_usuario"); //5
                    zona = rs.getString("zo.nombre_zona"); //6
                    estado = rs.getString("op.estado_operacion"); //7
                    observaciones = rs.getString("op.observaciones_operacion"); //8
                    lista.add(numeroOperacion);
                    lista.add(nombre_operacion);
                    lista.add(descripcion_operacion);
                    lista.add(fechainicio);
                    lista.add(fechatermino);
                    lista.add(usuario);
                    lista.add(zona);
                    lista.add(estado);
                    lista.add(observaciones);
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
    
    //MÉTODO PARA OBTENER LA ULTIMA OPERACIÓN
    public ArrayList obtenerUltimaOperacion() {
        ArrayList lista = new ArrayList();
        String numeroOperacion = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select id_operacion from vccpformularios order by id_operacion desc limit 1";

            pst = getConexion().prepareStatement(consulta);
            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    numeroOperacion = rs.getString("id_operacion"); //0
                    lista.add(numeroOperacion);
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
    
    //AGREGAR NUEVA OPERACION
    public boolean nuevaOperacion(String nombre, String descripcion, String usuario, String zona) {
        boolean registrar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "insert into vccpformularios (estado_operacion, nombre_operacion, descripcion_operacion, fechainicio_operacion, fechatermino_operacion, "
                    + "codigo_usuario, codigo_zonadeoperacion, observaciones_operacion) values('PENDIENTE', ?, ?, now(), now(), ?, ?, 'A la espera de edición')";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, nombre);
            pst.setString(2, descripcion);
            pst.setString(3, usuario);
            pst.setString(4, zona);

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
    
    //MODIFICAR OBSERVACIONES Y DESCRIPCION FORMULARIO
    public boolean editarForm(String codigoForm, String observaciones, String descripcion) {
        boolean registrar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "update vccpformularios set descripcion_operacion=?, observaciones_operacion=? where id_operacion=?";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, descripcion);
            pst.setString(2, observaciones);
            pst.setString(3, codigoForm);

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
    
    //CERRAR OPERACION
    public boolean cerrarOperacion(String codigoForm, String obs) {
        boolean registrar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "update vccpformularios set estado_operacion='FINALIZADA', observaciones_operacion=? where id_operacion=?";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, obs);
            pst.setString(2, codigoForm);

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
    
    //ACEPTAR OPERACION
    public boolean aceptarOperacion(String codigoForm, String obs) {
        boolean registrar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "update vccpformularios set estado_operacion='EN MARCHA', observaciones_operacion=? where id_operacion=?";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, obs);
            pst.setString(2, codigoForm);

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
    
    //RECHAZAR OPERACION
    public boolean rechazarOperacion(String codigoForm, String obs) {
        boolean registrar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "update vccpformularios set estado_operacion='RECHAZADA', observaciones_operacion=? where id_operacion=?";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, obs);
            pst.setString(2, codigoForm);

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
    
    //RMS
    //MÉTODO PARA OBTENER LOS RMS DE LA OPERACIÓN
    public ArrayList obtenerDetallesRms(String codigo) {
        ArrayList lista = new ArrayList();
        String nombreRiesgo="", numeroRiesgo="";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select DISTINCT rm.numero_riesgo, rm.nombre_riesgo from rms rm, columnas col, vccpdetallescolumnas det "
                    + "where det.codigo_operacion=? and rm.id_riesgo=col.codigo_rms and col.id_rmsColumna=det.codigo_columna";

            pst = getConexion().prepareStatement(consulta);
            
            pst.setString(1, codigo);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    
                    numeroRiesgo = rs.getString("rm.numero_riesgo"); //0
                    nombreRiesgo = rs.getString("rm.nombre_riesgo"); //1
                    
                    lista.add(numeroRiesgo);
                    lista.add(nombreRiesgo);
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
    
    //MÉTODO PARA OBTENER LOS RMS CON IMAGEN
    public ArrayList rmsPlanilla(String codigo) {
        ArrayList lista = new ArrayList();
        String nombreRiesgo="", numeroRiesgo="", imgRms;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select DISTINCT rm.numero_riesgo, rm.nombre_riesgo, rm.rutaImagen_riesgo from rms rm, columnas col, vccpdetallescolumnas det "
                    + "where det.codigo_operacion=? and rm.id_riesgo=col.codigo_rms and col.id_rmsColumna=det.codigo_columna";

            pst = getConexion().prepareStatement(consulta);
            
            pst.setString(1, codigo);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    
                    numeroRiesgo = rs.getString("rm.numero_riesgo"); //0
                    nombreRiesgo = rs.getString("rm.nombre_riesgo"); //1
                    imgRms = rs.getString("rm.rutaImagen_riesgo"); //2
                    
                    lista.add(numeroRiesgo);
                    lista.add(nombreRiesgo);
                    lista.add(imgRms);
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
    
    //CONTRASTAR SI EXISTE EL RMS EN EL FORMULARIO
    public boolean contrastarRms(String codigoRms, String codigoOpe) {
        boolean existe = false;
        ResultSet rs = null;
        PreparedStatement pst = null;
        try {
            String consulta = "select rm.id_riesgo from rms rm, columnas col, vccpdetallescolumnas det where rm.id_riesgo=? and det.codigo_operacion=?"
                    + " and rm.id_riesgo=col.codigo_rms and col.id_rmsColumna=det.codigo_columna";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, codigoRms);
            pst.setString(2, codigoOpe);

            //SE GUARDA LA CONEXION EN EL RESULSET
            rs = pst.executeQuery();
            //SI EXISTE UN REGISTRO CAMBIAMOS RETURN
            if (rs.absolute(1)) {
                existe = true;
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
        return existe;
    }
    
    //MÉTODO PARA OBTENER COLUMNAS Y NIVELES RMS
    public ArrayList obtenerDetallesColumnas(String codigo, String rms) {
        ArrayList lista = new ArrayList();
        String valoracion = "", nombreColumna="";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select col.descripcion_rmsColumna, dc.valoracion from vccpdetallescolumnas dc, columnas col, rms rm where dc.codigo_operacion=? "
                    + "and rm.nombre_riesgo=? and col.codigo_rms=rm.id_riesgo and col.id_rmscolumna=dc.codigo_columna";

            pst = getConexion().prepareStatement(consulta);
            
            pst.setString(1, codigo);
            pst.setString(2, rms);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    nombreColumna = rs.getString("col.descripcion_rmsColumna"); //0
                    valoracion = rs.getString("dc.valoracion"); //0
                    lista.add(nombreColumna);
                    lista.add(valoracion);
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
    
    //MÉTODO PARA OBTENER COLUMNAS Y NIVELES RMS
    public ArrayList obtenerDetallesColumnasRmsSeleccionado(String rms) {
        ArrayList lista = new ArrayList();
        String idColumna="";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select col.id_rmscolumna from columnas col, rms rm where "
                    + "col.codigo_rms=? and col.codigo_rms=rm.id_riesgo";

            pst = getConexion().prepareStatement(consulta);
            
            pst.setString(1, rms);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    idColumna = rs.getString("col.id_rmscolumna"); //0
                    lista.add(idColumna);
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
    
    //MÉTODO PARA OBTENER TODOS LOS RIESGOS CRITICOS DISPONIBLES 
    public ArrayList obtenerRMSDisponibles() {
        ArrayList lista = new ArrayList();
        String nombreRMS = "", numeroRMS = "", imgRMS = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select rm.nombre_riesgo, rm.numero_riesgo, rm.rutaImagen_riesgo from rms rm";

            pst = getConexion().prepareStatement(consulta);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    nombreRMS = rs.getString("rm.nombre_riesgo"); //0
                    numeroRMS = rs.getString("rm.numero_riesgo"); //1
                    imgRMS = rs.getString("rm.rutaImagen_riesgo"); //2
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
    
    //AGREGAR DETALLE RMS
    public boolean agregarDetalleColumnas(String valoracion, String codiOperacion, String codiColumna) {
        boolean registrar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "insert into vccpdetallescolumnas (valoracion, codigo_operacion, codigo_columna) "
                    + "values(?,?,?)";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, valoracion);
            pst.setString(2, codiOperacion);
            pst.setString(3, codiColumna);

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
    
    //REMOVER DETALLE COLUMNAS
    public boolean removerDetalleColumnas(String codiOperacion, String codiColumna) {
        boolean registrar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "delete from vccpdetallescolumnas where codigo_operacion=? and codigo_columna=?";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, codiOperacion);
            pst.setString(2, codiColumna);

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
    
    //REMOVER DETALLE RMS
    public boolean removerDetalleRms(String codiOperacion, String rms) {
        boolean registrar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "delete from vccpdetallesrms where codigo_operacion=? and codigo_rms=?";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, codiOperacion);
            pst.setString(2, rms);

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
    
    //MODIFICAR VALOR RMS
    public boolean modificarDetallesColumnas(String valoracion, String codiOperacion, String codiColumna) {
        boolean registrar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "update vccpdetallescolumnas set valoracion=? where codigo_operacion=? and codigo_columna=?";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, valoracion);
            pst.setString(2, codiOperacion);
            pst.setString(3, codiColumna);

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
    
    /*
     **ANEXOS -- ANEXOS -- ANEXOS -- ANEXOS -- ANEXOS -- ANEXOS
     **ANEXOS -- ANEXOS -- ANEXOS -- ANEXOS -- ANEXOS -- ANEXOS
     */
    //MÉTODO PARA CONTADORES - OPERACIONES FINALIZADAS, EN MARCHA Y RECHAZADAS
    public int cantOpeEnMarcha() {
        PreparedStatement pst = null;
        ResultSet rs = null;
        int cont = 0;

        try {
            String consulta = "select count(*)from vccpformularios where estado_operacion='EN MARCHA'";
            pst = getConexion().prepareStatement(consulta);

            //SE GUARDA LA CONEXION EN EL RESULSET
            rs = pst.executeQuery();
            //SI EXISTE UN REGISTRO CAMBIAMOS RETURN
            if (rs.next()) {
                //Si hay resultados obtengo el valor. 
                cont = rs.getInt(1);
            }

        } catch (Exception e) {
            System.err.println("ERROR : " + e);
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
                System.err.println("ERROR : " + e);
            }
        }
        return cont;
    }
    
    public int cantOpeFinalizada() {
        PreparedStatement pst = null;
        ResultSet rs = null;
        int cont = 0;

        try {
            String consulta = "select count(*)from vccpformularios where estado_operacion='FINALIZADA'";
            pst = getConexion().prepareStatement(consulta);

            //SE GUARDA LA CONEXION EN EL RESULSET
            rs = pst.executeQuery();
            //SI EXISTE UN REGISTRO CAMBIAMOS RETURN
            if (rs.next()) {
                //Si hay resultados obtengo el valor. 
                cont = rs.getInt(1);
            }

        } catch (Exception e) {
            System.err.println("ERROR : " + e);
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
                System.err.println("ERROR : " + e);
            }
        }
        return cont;
    }
    
    public int cantOpeRechazada() {
        PreparedStatement pst = null;
        ResultSet rs = null;
        int cont = 0;

        try {
            String consulta = "select count(*)from vccpformularios where estado_operacion='RECHAZADA'";
            pst = getConexion().prepareStatement(consulta);

            //SE GUARDA LA CONEXION EN EL RESULSET
            rs = pst.executeQuery();
            //SI EXISTE UN REGISTRO CAMBIAMOS RETURN
            if (rs.next()) {
                //Si hay resultados obtengo el valor. 
                cont = rs.getInt(1);
            }

        } catch (Exception e) {
            System.err.println("ERROR : " + e);
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
                System.err.println("ERROR : " + e);
            }
        }
        return cont;
    }
    
    public int cantOpePendiente() {
        PreparedStatement pst = null;
        ResultSet rs = null;
        int cont = 0;

        try {
            String consulta = "select count(*)from vccpformularios where estado_operacion='PENDIENTE'";
            pst = getConexion().prepareStatement(consulta);

            //SE GUARDA LA CONEXION EN EL RESULSET
            rs = pst.executeQuery();
            //SI EXISTE UN REGISTRO CAMBIAMOS RETURN
            if (rs.next()) {
                //Si hay resultados obtengo el valor. 
                cont = rs.getInt(1);
            }

        } catch (Exception e) {
            System.err.println("ERROR : " + e);
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
                System.err.println("ERROR : " + e);
            }
        }
        return cont;
    }
    
    public int cantOpeEnMarchaCapataz(String codigo) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        int cont = 0;

        try {
            String consulta = "select count(*)from vccpformularios where estado_operacion='EN MARCHA' and codigo_usuario=?";
            pst = getConexion().prepareStatement(consulta);
            
            pst.setString(1, codigo);

            //SE GUARDA LA CONEXION EN EL RESULSET
            rs = pst.executeQuery();
            //SI EXISTE UN REGISTRO CAMBIAMOS RETURN
            if (rs.next()) {
                //Si hay resultados obtengo el valor. 
                cont = rs.getInt(1);
            }

        } catch (Exception e) {
            System.err.println("ERROR : " + e);
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
                System.err.println("ERROR : " + e);
            }
        }
        return cont;
    }
    
    public int cantOpeFinalizadaCapataz(String codigo) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        int cont = 0;

        try {
            String consulta = "select count(*)from vccpformularios where estado_operacion='FINALIZADA' and codigo_usuario=?";
            pst = getConexion().prepareStatement(consulta);
            
            pst.setString(1, codigo);

            //SE GUARDA LA CONEXION EN EL RESULSET
            rs = pst.executeQuery();
            //SI EXISTE UN REGISTRO CAMBIAMOS RETURN
            if (rs.next()) {
                //Si hay resultados obtengo el valor. 
                cont = rs.getInt(1);
            }

        } catch (Exception e) {
            System.err.println("ERROR : " + e);
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
                System.err.println("ERROR : " + e);
            }
        }
        return cont;
    }
    
    public int cantOpeRechazadaCapataz(String codigo) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        int cont = 0;

        try {
            String consulta = "select count(*)from vccpformularios where estado_operacion='RECHAZADA' and codigo_usuario=?";
            pst = getConexion().prepareStatement(consulta);
            
            pst.setString(1, codigo);

            //SE GUARDA LA CONEXION EN EL RESULSET
            rs = pst.executeQuery();
            //SI EXISTE UN REGISTRO CAMBIAMOS RETURN
            if (rs.next()) {
                //Si hay resultados obtengo el valor. 
                cont = rs.getInt(1);
            }

        } catch (Exception e) {
            System.err.println("ERROR : " + e);
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
                System.err.println("ERROR : " + e);
            }
        }
        return cont;
    }
    
    public int cantOpePendienteCapataz(String codigo) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        int cont = 0;

        try {
            String consulta = "select count(*)from vccpformularios where estado_operacion='PENDIENTE' and codigo_usuario=?";
            pst = getConexion().prepareStatement(consulta);
            
            pst.setString(1, codigo);

            //SE GUARDA LA CONEXION EN EL RESULSET
            rs = pst.executeQuery();
            //SI EXISTE UN REGISTRO CAMBIAMOS RETURN
            if (rs.next()) {
                //Si hay resultados obtengo el valor. 
                cont = rs.getInt(1);
            }

        } catch (Exception e) {
            System.err.println("ERROR : " + e);
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
                System.err.println("ERROR : " + e);
            }
        }
        return cont;
    }
    
    public static void main(String[] args) {
        consultasPanelOperaciones con = new consultasPanelOperaciones();
        System.out.println(con.contrastarRms("2", "3"));

    }

    
}
