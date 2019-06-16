/*
    *Diseñado y programado por Cristopher Pérez V.
    *Sistema Tekonn 2019
*/
package Modelos;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class consultasPersonales extends Conexion {

    /*
     MÉTODOS USUARIO
     */
    
    //MÉTODO PARA OBTENER TODOS LOS DATOS DEL USUARIO
    public ArrayList ObtenerFullDatosUsuario(String email, String contraseña) {
        ArrayList lista = new ArrayList();
        String nombreUs = "", rutUs = "", sexoUs = "", emailUs = "", fonoUs = "", celularUs = "", direccionUs = "", ciudadUs = "", regionUs = "", comunaUs = "", empresaUs = "", cargoUs = "", rolUs = "", passUs = "", imagenPerfil = "", nombre_equipo = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select us.nombre_usuario, us.rut_usuario, us.sexo_usuario, us.email_usuario, us.fono_usuario, us.celular_usuario, us.direccion_usuario, us.ciudad_usuario, "
                    + "us.region_usuario, us.comuna_usuario, us.empresa_usuario, car.nombre_cargo, ro.nombre_rol, us.pass_usuario, us.imagenPerfil, us.codigo_equipo from usuarios us, cargos car, roles ro, equipos eq where email_usuario=? and "
                    + "pass_usuario=? and activado_usuario=1 and us.codigo_cargo=car.id_cargo and us.codigo_rol=ro.id_rol and us.codigo_equipo=eq.id_equipo";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, email);
            pst.setString(2, contraseña);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    nombreUs = rs.getString("us.nombre_usuario"); //0
                    rutUs = rs.getString("us.rut_usuario"); //1
                    sexoUs = rs.getString("us.sexo_usuario"); //2
                    emailUs = rs.getString("us.email_usuario"); //3
                    fonoUs = rs.getString("us.fono_usuario"); //4
                    celularUs = rs.getString("us.celular_usuario"); //5
                    direccionUs = rs.getString("us.direccion_usuario"); //6
                    ciudadUs = rs.getString("us.ciudad_usuario"); //7
                    regionUs = rs.getString("us.region_usuario"); //8
                    comunaUs = rs.getString("us.comuna_usuario"); //9
                    empresaUs = rs.getString("us.empresa_usuario"); //10
                    cargoUs = rs.getString("car.nombre_cargo"); //11
                    rolUs = rs.getString("ro.nombre_rol"); //12
                    passUs = rs.getString("us.pass_usuario"); //13
                    imagenPerfil = rs.getString("us.imagenPerfil"); //14
                    nombre_equipo = rs.getString("us.codigo_equipo"); //15
                    lista.add(nombreUs);
                    lista.add(rutUs);
                    lista.add(sexoUs);
                    lista.add(emailUs);
                    lista.add(fonoUs);
                    lista.add(celularUs);
                    lista.add(direccionUs);
                    lista.add(ciudadUs);
                    lista.add(regionUs);
                    lista.add(comunaUs);
                    lista.add(empresaUs);
                    lista.add(cargoUs);
                    lista.add(rolUs);
                    lista.add(passUs);
                    lista.add(imagenPerfil);
                    lista.add(nombre_equipo);
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

    //MÉTODO PARA OBTENER TODOS LOS DATOS DEL USUARIO SIN UTILIZAR CONTRASEÑA
    public ArrayList ObtenerFullDatosUsuarioSinPass(String correo) {
        ArrayList lista = new ArrayList();
        String nombreUs = "", rutUs = "", sexoUs = "", emailUs = "", fonoUs = "", celularUs = "", direccionUs = "", ciudadUs = "", regionUs = "", comunaUs = "", empresaUs = "", cargoUs = "", rolUs = "", passUs = "", imagenPerfil = "", nombre_equipo = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select us.nombre_usuario, us.rut_usuario, us.sexo_usuario, us.email_usuario, us.fono_usuario, us.celular_usuario, us.direccion_usuario, us.ciudad_usuario, "
                    + "us.region_usuario, us.comuna_usuario, us.empresa_usuario, car.nombre_cargo, ro.nombre_rol, us.pass_usuario, us.imagenPerfil, eq.nombre_equipo from usuarios us, cargos car, roles ro, equipos eq where email_usuario=? "
                    + "and activado_usuario=1 and us.codigo_cargo=car.id_cargo and us.codigo_rol=ro.id_rol and us.codigo_equipo=eq.id_equipo";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, correo);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    nombreUs = rs.getString("us.nombre_usuario"); //0
                    rutUs = rs.getString("us.rut_usuario"); //1
                    sexoUs = rs.getString("us.sexo_usuario"); //2
                    emailUs = rs.getString("us.email_usuario"); //3
                    fonoUs = rs.getString("us.fono_usuario"); //4
                    celularUs = rs.getString("us.celular_usuario"); //5
                    direccionUs = rs.getString("us.direccion_usuario"); //6
                    ciudadUs = rs.getString("us.ciudad_usuario"); //7
                    regionUs = rs.getString("us.region_usuario"); //8
                    comunaUs = rs.getString("us.comuna_usuario"); //9
                    empresaUs = rs.getString("us.empresa_usuario"); //10
                    cargoUs = rs.getString("car.nombre_cargo"); //11
                    rolUs = rs.getString("ro.nombre_rol"); //12
                    passUs = rs.getString("us.pass_usuario"); //13
                    imagenPerfil = rs.getString("us.imagenPerfil"); //14
                    nombre_equipo = rs.getString("eq.nombre_equipo"); //15
                    lista.add(nombreUs);
                    lista.add(rutUs);
                    lista.add(sexoUs);
                    lista.add(emailUs);
                    lista.add(fonoUs);
                    lista.add(celularUs);
                    lista.add(direccionUs);
                    lista.add(ciudadUs);
                    lista.add(regionUs);
                    lista.add(comunaUs);
                    lista.add(empresaUs);
                    lista.add(cargoUs);
                    lista.add(rolUs);
                    lista.add(passUs);
                    lista.add(imagenPerfil);
                    lista.add(nombre_equipo);
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

    //MÉTODO PARA OBTENER EMAIL DEL US
    public ArrayList ObtenerEmailUs(String nick) {
        ArrayList lista = new ArrayList();
        String emailUs = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select us.email_usuario from usuarios us where nick_usuario=?";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, nick);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    emailUs = rs.getString("us.email_usuario"); //0
                    lista.add(emailUs);
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
    
    //MÉTODO PARA OBTENER EMAIL DEL US
    public ArrayList obtenerCodigoUs(String email) {
        ArrayList lista = new ArrayList();
        String codigo = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select us.id_usuario from usuarios us where us.email_usuario=?";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, email);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    codigo = rs.getString("us.id_usuario"); //0
                    lista.add(codigo);
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

    //MODIFICAR DATOS USUARIO
    public boolean modificarUsDatosPersonales(String correo, String fono, String celular, String dirección, String ciudad, String region, String comuna, String correoActual) {
        boolean modificar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "update usuarios set email_usuario=?, fono_usuario=?, celular_usuario=?, "
                    + "direccion_usuario=?, ciudad_usuario=?, region_usuario=?, comuna_usuario=? where email_usuario=? ";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, correo);
            pst.setString(2, fono);
            pst.setString(3, celular);
            pst.setString(4, dirección);
            pst.setString(5, ciudad);
            pst.setString(6, region);
            pst.setString(7, comuna);
            pst.setString(8, correoActual);

            if (pst.executeUpdate() == 1) {
                modificar = true;
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
        return modificar;
    }

    //MODIFICAR DATOS USUARIO PASS
    public boolean modificarUsPass(String pass, String correoActual) {
        boolean modificar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "update usuarios set pass_usuario=? where email_usuario=? ";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, pass);
            pst.setString(2, correoActual);

            if (pst.executeUpdate() == 1) {
                modificar = true;
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
        return modificar;
    }

    //MODIFICAR DATOS USUARIO
    public boolean modificarUsFotoPerfil(String imagen, String correo) {
        boolean modificar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "update usuarios set imagenPerfil=? where email_usuario=? ";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, imagen);
            pst.setString(2, correo);

            if (pst.executeUpdate() == 1) {
                modificar = true;
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
        return modificar;
    }

    /*
     MÉTODOS EXTRAS
     */
    
    //MÉTODO PARA OBTENER TODOS LOS DATOS DE LA CUENTA A RESETEAR PASS
    public ArrayList ObtenerDatosCuentaBusquedaPass(String correo) {
        ArrayList lista = new ArrayList();
        String nombreUs = "", emailUs = "", empresaUs = "", codigoRecpUs = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select us.nombre_usuario, us.email_usuario, us.empresa_usuario, us.codigoRecuperacion_usuario from usuarios us where email_usuario=? "
                    + "and activado_usuario=1 ";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, correo);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    nombreUs = rs.getString("us.nombre_usuario"); //0
                    emailUs = rs.getString("us.email_usuario"); //1
                    empresaUs = rs.getString("us.empresa_usuario"); //2
                    codigoRecpUs = rs.getString("us.codigoRecuperacion_usuario"); //3
                    lista.add(nombreUs);
                    lista.add(emailUs);
                    lista.add(empresaUs);
                    lista.add(codigoRecpUs);
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

    //MÉTODO PARA VERIFICAR SI EXISTE UN USUARIO CON DICHO NICK
    public boolean existeNickUsuarioLogin(String nick) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        boolean existe = false;

        try {
            String consulta = "select nick_usuario from usuarios us, roles ro where nick_usuario=? and activado_usuario=1 and us.codigo_rol=ro.id_rol";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, nick);

            //SE GUARDA LA CONEXION EN EL RESULSET
            rs = pst.executeQuery();
            //SI EXISTE UN REGISTRO CAMBIAMOS RETURN
            if (rs.absolute(1)) {
                existe = true;
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
        return existe;
    }

    //MÉTODO PARA VERIFICAR SI EXISTE UN CORREO O NO
    public boolean existeCorreo(String correo) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        boolean existe = false;

        try {
            String consulta = "select email_usuario from usuarios where email_usuario=?";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, correo);

            //SE GUARDA LA CONEXION EN EL RESULSET
            rs = pst.executeQuery();
            //SI EXISTE UN REGISTRO CAMBIAMOS RETURN
            if (rs.absolute(1)) {
                existe = true;
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
        return existe;
    }

    //MÉTODO PARA VERIFICAR SI EXISTE UN RUT O NO
    public boolean existeRut(String rut) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        boolean existe = false;

        try {
            String consulta = "select rut_usuario from usuarios where rut_usuario=?";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, rut);

            //SE GUARDA LA CONEXION EN EL RESULSET
            rs = pst.executeQuery();
            //SI EXISTE UN REGISTRO CAMBIAMOS RETURN
            if (rs.absolute(1)) {
                existe = true;
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
        return existe;
    }

    //MÉTODO PARA CONTRASTAR NICK CON CONTRASEÑA
    public boolean contrastarNickPass(String nick, String pass) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        boolean existe = false;

        try {
            String consulta = "select nick_usuario from usuarios where nick_usuario=? and pass_usuario=? ";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, nick);
            pst.setString(2, pass);

            //SE GUARDA LA CONEXION EN EL RESULSET
            rs = pst.executeQuery();
            //SI EXISTE UN REGISTRO CAMBIAMOS RETURN
            if (rs.absolute(1)) {
                existe = true;
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
        return existe;
    }

    /*
     RESETEAR CONTRASEÑA MEDIANTE CORREO
     */
    
    //MODIFICAR CODIGO VERIFICACION CUENTA VIA CORREO
    public boolean modificarCodigoVerificación(String correo, String codigo) {
        boolean modificar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "update usuarios set codigoRecuperacion_usuario=? where email_usuario=? ";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, codigo);
            pst.setString(2, correo);

            if (pst.executeUpdate() == 1) {
                modificar = true;
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
        return modificar;
    }

    //MÉTODO PARA VERIFICAR SI EL CODIGO INGRESADO POR EL USUARIO CONCUERDA CON EL DE LA CUENTA
    public boolean validarCodigoVerificar(String correo, String codigo) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        boolean existe = false;

        try {
            String consulta = "select codigoRecuperacion_usuario from usuarios where email_usuario=? and codigoRecuperacion_usuario=? and activado_usuario=1";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, correo);
            pst.setString(2, codigo);

            //SE GUARDA LA CONEXION EN EL RESULSET
            rs = pst.executeQuery();
            //SI EXISTE UN REGISTRO CAMBIAMOS RETURN
            if (rs.absolute(1)) {
                existe = true;
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
        return existe;
    }

    //MODIFICAR CONTRASEÑA DEL USUARIO
    public boolean modificarContraseñaUser(String correo, String pass1) {
        boolean modificar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "update usuarios set pass_usuario=? "
                    + "where email_usuario=? ";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, pass1);
            pst.setString(2, correo);

            if (pst.executeUpdate() == 1) {
                modificar = true;
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
        return modificar;
    }
    
    //MÉTODO PARA OBTENER EL CODIGO DEL EQUIPO DEL CAPATAZ
    public ArrayList obtenerCodigoEquipoCapt(String email) {
        ArrayList lista = new ArrayList();
        String codCap = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select codigo_equipo from usuarios where email_usuario=?";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, email);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    codCap = rs.getString("codigo_equipo"); //0
                    lista.add(codCap);
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

    //MÉTODO PARA OBTENER CODIGO EQUIPO
    public ArrayList obtenerCodigoEquipo(String us) {
        ArrayList lista = new ArrayList();
        String codigoEq = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select us.codigo_equipo from usuarios us where id_usuario=?";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, us);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    codigoEq = rs.getString("us.codigo_equipo"); //0
                    lista.add(codigoEq);
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
    
     //MÉTODO PARA OBTENER EMAIL DEL CAPATAZ
    public ArrayList obtenerEmailCapatazEquipo(String codiEq) {
        ArrayList lista = new ArrayList();
        String codigo = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select email_lider from equipos where id_equipo=?";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, codiEq);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    codigo = rs.getString("email_lider"); //0
                    lista.add(codigo);
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
    
    //PRUEBA
    public static void main(String[] args) {
        consultasPersonales con = new consultasPersonales();
        System.out.println(con.ObtenerFullDatosUsuario("ADMIN@ADMIN","ADMIN"));

    }

}
