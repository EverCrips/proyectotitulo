/*
    *Diseñado y programado por Cristopher Pérez V.
    *Sistema Tekonn 2019
*/
package Modelos;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.Normalizer;
import java.util.ArrayList;

/**
 *
 * @author Cristopher
 */
public class consultasPanelUsuarios extends Conexion {

    /*
     MÉTODOS GESTIONAR USUARIOS
     */
    //MÉTODO PARA REGISTRAR UN NUEVO USUARIO DE SISTEMA
    public Boolean registrarUsSistema(String nombreUs, String rutUs, String sexoUs, String emailUs, String fonoUs, String celularUs,
            String direccionUs, String ciudadUs, String regionUs, String comunaUs, String empresaUs, String nickUs,
            int cargoUs, int rolUs) {
        boolean registrar = false;
        PreparedStatement pst = null;
        String pass = "123456asdfg";
        String imagen = "";
        if (sexoUs.equals("M")) {
            imagen = "media/imagenes/perfilFotos/fotodefectohombreperfil.png";
        } else {
            imagen = "media/imagenes/perfilFotos/fotodefectomujerperfil.png";
        }
        try {
            String consulta = "insert into usuarios (activado_usuario, nombre_usuario, rut_usuario, sexo_usuario, email_usuario, fono_usuario, celular_usuario, direccion_usuario, "
                    + "ciudad_usuario, region_usuario, comuna_usuario, empresa_usuario, nick_usuario, codigo_cargo, codigo_rol, pass_usuario, imagenPerfil, codigo_equipo) values (1, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1)";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, nombreUs);
            pst.setString(2, rutUs);
            pst.setString(3, sexoUs);
            pst.setString(4, emailUs);
            pst.setString(5, fonoUs);
            pst.setString(6, celularUs);
            pst.setString(7, direccionUs);
            pst.setString(8, ciudadUs);
            pst.setString(9, regionUs);
            pst.setString(10, comunaUs);
            pst.setString(11, empresaUs);
            pst.setString(12, nickUs);
            pst.setInt(13, cargoUs);
            pst.setInt(14, rolUs);
            pst.setString(15, pass);
            pst.setString(16, imagen);

            if (pst.executeUpdate() == 1) {
                registrar = true;
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
            } catch (Exception e) {
                System.err.println("ERROR : " + e);
            }
        }
        return registrar;
    }

    //MÉTODO PARA OBTENER TODOS LOS DATOS DE LOS USUARIOS DEL SISTEMA
    public ArrayList obtenerFullUsuarios(String correoUsActual) {
        ArrayList lista = new ArrayList();
        String nombreUs = "", activoUs = "", rutUs = "", sexoUs = "", emailUs = "", fonoUs = "", celularUs = "", direccionUs = "", ciudadUs = "", regionUs = "", comunaUs = "", empresaUs = "", cargoUs = "", rolUs = "", passUs = "", imagenUs = "", nombre_equipo = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select us.nombre_usuario, us.activado_usuario, us.rut_usuario, us.sexo_usuario, us.email_usuario, us.fono_usuario, us.celular_usuario, us.direccion_usuario, us.ciudad_usuario, "
                    + "us.region_usuario, us.comuna_usuario, us.empresa_usuario, car.nombre_cargo, ro.nombre_rol, us.pass_usuario, us.imagenPerfil, eq.nombre_equipo from usuarios us, cargos car, roles ro, equipos eq where "
                    + " us.codigo_cargo=car.id_cargo and us.codigo_rol=ro.id_rol and (ro.nombre_rol='ADMINISTRADOR' or ro.nombre_rol='SUPERVISOR') and us.email_usuario <> ? and us.codigo_equipo=eq.id_equipo ";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, correoUsActual);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    nombreUs = rs.getString("us.nombre_usuario"); //0
                    activoUs = rs.getString("us.activado_usuario");//1
                    rutUs = rs.getString("us.rut_usuario"); //2
                    sexoUs = rs.getString("us.sexo_usuario"); //3
                    emailUs = rs.getString("us.email_usuario"); //4
                    fonoUs = rs.getString("us.fono_usuario"); //5
                    celularUs = rs.getString("us.celular_usuario"); //6
                    direccionUs = rs.getString("us.direccion_usuario"); //7
                    ciudadUs = rs.getString("us.ciudad_usuario"); //8
                    regionUs = rs.getString("us.region_usuario"); //9
                    comunaUs = rs.getString("us.comuna_usuario"); //10
                    empresaUs = rs.getString("us.empresa_usuario"); //11
                    cargoUs = rs.getString("car.nombre_cargo"); //12
                    rolUs = rs.getString("ro.nombre_rol"); //13
                    passUs = rs.getString("us.pass_usuario"); //14
                    imagenUs = rs.getString("us.imagenPerfil"); //15
                    nombre_equipo = rs.getString("eq.nombre_equipo"); //16
                    lista.add(nombreUs);
                    lista.add(activoUs);
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
                    lista.add(imagenUs);
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

    //MÉTODO PARA OBTENER TODOS LOS DATOS DEL USUARIO A EDITAR
    public ArrayList obtenerFullUsuarioEdit(String correo) {
        ArrayList lista = new ArrayList();
        String nombreUs = "", rutUs = "", sexoUs = "", emailUs = "", fonoUs = "", celularUs = "", direccionUs = "", ciudadUs = "", regionUs = "", comunaUs = "", empresaUs = "", cargoUs = "", rolUs = "", passUs = "", imagenUs = "", nombre_equipo = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select us.nombre_usuario, us.rut_usuario, us.sexo_usuario, us.email_usuario, us.fono_usuario, us.celular_usuario, us.direccion_usuario, us.ciudad_usuario, "
                    + "us.region_usuario, us.comuna_usuario, us.empresa_usuario, car.nombre_cargo, ro.nombre_rol, us.pass_usuario, us.imagenPerfil, eq.nombre_equipo from usuarios us, cargos car, roles ro, equipos eq where email_usuario=? and "
                    + "activado_usuario=1 and us.codigo_cargo=car.id_cargo and us.codigo_rol=ro.id_rol and us.codigo_equipo=eq.id_equipo";

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
                    imagenUs = rs.getString("us.imagenPerfil"); //14
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
                    lista.add(imagenUs);
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

    //MODIFICAR USUARIO DEL SISTEMA (ELIMINACIÓN)
    public boolean modificarUsEliminar(String correo) {
        boolean modificar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "update usuarios set activado_usuario='0' where email_usuario=? ";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, correo);

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

    //MODIFICAR USUARIO DEL SISTEMA (REINGRESO)
    public boolean modificarUsReingreso(String correo) {
        boolean modificar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "update usuarios set activado_usuario='1' where email_usuario=? ";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, correo);

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

    //MODIFICAR DATOS PERSONALES DEL USUARIO SELECCIONADO
    public boolean modificarUsDatosPersonalesEdit(String nombre, String rut, String correo, String fono, String celular, String dirección, String ciudad, String region, String comuna,
            String correoActual) {
        boolean modificar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "update usuarios set nombre_usuario=?, rut_usuario=?, email_usuario=?, fono_usuario=?, celular_usuario=?, direccion_usuario=?, ciudad_usuario=?, "
                    + "region_usuario=?, comuna_usuario=? where email_usuario=? ";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, nombre);
            pst.setString(2, rut);
            pst.setString(3, correo);
            pst.setString(4, fono);
            pst.setString(5, celular);
            pst.setString(6, dirección);
            pst.setString(7, ciudad);
            pst.setString(8, region);
            pst.setString(9, comuna);
            pst.setString(10, correoActual);

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

    //MODIFICAR PASS DEL USUARIO SELECCIONADO
    public boolean modificarUsPassEdit(String pass, String correoActual) {
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

    //MODIFICAR DATOS SISTEMA USUARIO SELECCIONADO
    public boolean modificarUsDatosSistemaEdit(String cargo, String rol, String empresa, String email) {
        boolean modificar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "update usuarios set codigo_cargo=?, codigo_rol=?, empresa_usuario=? where email_usuario=? ";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, cargo);
            pst.setString(2, rol);
            pst.setString(3, empresa);
            pst.setString(4, email);

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
     MÉTODOS GESTIONAR TRABAJADORES
     */
    //MÉTODO PARA REGISTRAR UN NUEVO USUARIO DE SISTEMA
    public Boolean registrarNuevoTrabajadorSistema(String nombreUs, String rutUs, String sexoUs, String emailUs, String fonoUs, String celularUs,
            String direccionUs, String ciudadUs, String regionUs, String comunaUs, String empresaUs, String nickUs,
            int cargoUs, int rolUs) {
        boolean registrar = false;
        PreparedStatement pst = null;
        String pass = "123456asdfg";
        String imagen = "";
        if (sexoUs.equals("M")) {
            imagen = "media/imagenes/perfilFotos/fotodefectohombreperfil.png";
        } else {
            imagen = "media/imagenes/perfilFotos/fotodefectomujerperfil.png";
        }
        try {
            String consulta = "insert into usuarios (activado_usuario, nombre_usuario, rut_usuario, sexo_usuario, email_usuario, fono_usuario, celular_usuario, direccion_usuario, "
                    + "ciudad_usuario, region_usuario, comuna_usuario, empresa_usuario, nick_usuario, codigo_cargo, codigo_rol, pass_usuario, imagenPerfil, codigo_equipo) values (1, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1)";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, nombreUs);
            pst.setString(2, rutUs);
            pst.setString(3, sexoUs);
            pst.setString(4, emailUs);
            pst.setString(5, fonoUs);
            pst.setString(6, celularUs);
            pst.setString(7, direccionUs);
            pst.setString(8, ciudadUs);
            pst.setString(9, regionUs);
            pst.setString(10, comunaUs);
            pst.setString(11, empresaUs);
            pst.setString(12, nickUs);
            pst.setInt(13, cargoUs);
            pst.setInt(14, rolUs);
            pst.setString(15, pass);
            pst.setString(16, imagen);

            if (pst.executeUpdate() == 1) {
                registrar = true;
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
            } catch (Exception e) {
                System.err.println("ERROR : " + e);
            }
        }
        return registrar;
    }

    //MÉTODO PARA OBTENER TODOS LOS DATOS DE LOS TRABAJDORES DEL SISTEMA ACTIVOS PARA SER MOSTRADOS EN UNA TABLA
    public ArrayList ObtenerFullTrabajadores(String correoUsActual) {
        ArrayList lista = new ArrayList();
        String nombreUs = "", activoUs = "", rutUs = "", sexoUs = "", emailUs = "", fonoUs = "", celularUs = "", direccionUs = "", ciudadUs = "", regionUs = "", comunaUs = "", empresaUs = "", cargoUs = "", rolUs = "", passUs = "", imagen = "", nombre_equipo = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select us.nombre_usuario, us.activado_usuario, us.rut_usuario, us.sexo_usuario, us.email_usuario, us.fono_usuario, us.celular_usuario, us.direccion_usuario, us.ciudad_usuario, "
                    + "us.region_usuario, us.comuna_usuario, us.empresa_usuario, car.nombre_cargo, ro.nombre_rol, us.pass_usuario, us.imagenPerfil, eq.nombre_equipo from usuarios us, cargos car, roles ro, equipos eq where "
                    + "us.codigo_cargo=car.id_cargo and us.codigo_rol=ro.id_rol and (ro.nombre_rol='CAPATAZ' or ro.nombre_rol='TRABAJADOR') and us.email_usuario <> ? and us.codigo_equipo=eq.id_equipo";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, correoUsActual);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    nombreUs = rs.getString("us.nombre_usuario"); //0
                    activoUs = rs.getString("us.activado_usuario");//1
                    rutUs = rs.getString("us.rut_usuario"); //2
                    sexoUs = rs.getString("us.sexo_usuario"); //3
                    emailUs = rs.getString("us.email_usuario"); //4
                    fonoUs = rs.getString("us.fono_usuario"); //5
                    celularUs = rs.getString("us.celular_usuario"); //6
                    direccionUs = rs.getString("us.direccion_usuario"); //7
                    ciudadUs = rs.getString("us.ciudad_usuario"); //8
                    regionUs = rs.getString("us.region_usuario"); //9
                    comunaUs = rs.getString("us.comuna_usuario"); //10
                    empresaUs = rs.getString("us.empresa_usuario"); //11
                    cargoUs = rs.getString("car.nombre_cargo"); //12
                    rolUs = rs.getString("ro.nombre_rol"); //13
                    passUs = rs.getString("us.pass_usuario"); //14
                    imagen = rs.getString("us.imagenPerfil"); //15
                    nombre_equipo = rs.getString("eq.nombre_equipo"); //16
                    lista.add(nombreUs);
                    lista.add(activoUs);
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
                    lista.add(imagen);
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

    //MÉTODO PARA OBTENER TODOS LOS DATOS DEL TRABAJADOR A EDITAR
    public ArrayList ObtenerFullTrabajadorEdit(String correo) {
        ArrayList lista = new ArrayList();
        String nombreUs = "", rutUs = "", sexoUs = "", emailUs = "", fonoUs = "", celularUs = "", direccionUs = "", ciudadUs = "", regionUs = "", comunaUs = "", empresaUs = "", cargoUs = "", rolUs = "", passUs = "", imagenUs = "", nombre_equipo = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select us.nombre_usuario, us.rut_usuario, us.sexo_usuario, us.email_usuario, us.fono_usuario, us.celular_usuario, us.direccion_usuario, us.ciudad_usuario, "
                    + "us.region_usuario, us.comuna_usuario, us.empresa_usuario, car.nombre_cargo, ro.nombre_rol, us.pass_usuario, us.imagenPerfil, eq.nombre_equipo from usuarios us, cargos car, roles ro, equipos eq where email_usuario=? and "
                    + "activado_usuario=1 and us.codigo_cargo=car.id_cargo and us.codigo_rol=ro.id_rol and us.codigo_equipo=eq.id_equipo";

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
                    imagenUs = rs.getString("us.imagenPerfil"); //14
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
                    lista.add(imagenUs);
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

    //MODIFICAR TRABAJADOR DEL SISTEMA (ELIMINACIÓN)
    public boolean modificarTraEliminar(String correo) {
        boolean modificar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "update usuarios set activado_usuario='0' where email_usuario=? ";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, correo);

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

    //MODIFICAR TRABAJADOR DEL SISTEMA (REINGRESO)
    public boolean modificarTraReingreso(String correo) {
        boolean modificar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "update usuarios set activado_usuario='1' where email_usuario=? ";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, correo);

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

    //MODIFICAR DATOS TRABAJADOR SELECCIONADO DEL SISTEMA
    public boolean modificarTraDatosPersonalesEdit(String nombre, String rut, String correo, String fono, String celular, String dirección, String ciudad, String region, String comuna,
            String correoActual) {
        boolean modificar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "update usuarios set nombre_usuario=?, rut_usuario=?, email_usuario=?, fono_usuario=?, celular_usuario=?, direccion_usuario=?, ciudad_usuario=?, "
                    + "region_usuario=?, comuna_usuario=? where email_usuario=? ";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, nombre);
            pst.setString(2, rut);
            pst.setString(3, correo);
            pst.setString(4, fono);
            pst.setString(5, celular);
            pst.setString(6, dirección);
            pst.setString(7, ciudad);
            pst.setString(8, region);
            pst.setString(9, comuna);
            pst.setString(10, correoActual);

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

    //MODIFICAR PASS USUARIO SELECCIONADO DEL SISTEMA
    public boolean modificarTraPassEdit(String pass, String correoActual) {
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

    //MODIFICAR DATOS SISTEMA USUARIO SELECCIONADO DEL SISTEMA
    public boolean modificarTraDatosSistemaEdit(String cargo, String rol, String empresa, String email) {
        boolean modificar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "update usuarios set codigo_cargo=?, codigo_rol=?, empresa_usuario=? where email_usuario=? ";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, cargo);
            pst.setString(2, rol);
            pst.setString(3, empresa);
            pst.setString(4, email);

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
     **ANEXOS -- ANEXOS -- ANEXOS -- ANEXOS -- ANEXOS -- ANEXOS
     **ANEXOS -- ANEXOS -- ANEXOS -- ANEXOS -- ANEXOS -- ANEXOS
     */
    //MÉTODO PARA CONTADORES - ADMINISTRADORES ACTIVOS
    public int cantAdminAct() {
        PreparedStatement pst = null;
        ResultSet rs = null;
        int cont = 0;

        try {
            String consulta = "select count(*)from usuarios where codigo_rol=2 and activado_usuario=1";
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

    //MÉTODO PARA CONTADORES - ADMINISTRADORES INACTIVOS
    public int cantAdminInac() {
        PreparedStatement pst = null;
        ResultSet rs = null;
        int cont = 0;

        try {
            String consulta = "select count(*)from usuarios where codigo_rol=2 and activado_usuario=0";
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

    //MÉTODO PARA CONTADORES - SUPERVISORES ACTIVOS
    public int cantSuperAct() {
        PreparedStatement pst = null;
        ResultSet rs = null;
        int cont = 0;

        try {
            String consulta = "select count(*)from usuarios where codigo_rol=3 and activado_usuario=1";
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

    //MÉTODO PARA CONTADORES - SUPERVISORES INACTIVOS
    public int cantSuperInac() {
        PreparedStatement pst = null;
        ResultSet rs = null;
        int cont = 0;

        try {
            String consulta = "select count(*)from usuarios where codigo_rol=3 and activado_usuario=0";
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

    //MÉTODO PARA CONTADORES - CAPATACES ACTIVOS
    public int cantCapaAct() {
        PreparedStatement pst = null;
        ResultSet rs = null;
        int cont = 0;

        try {
            String consulta = "select count(*)from usuarios where codigo_rol=4 and activado_usuario=1";
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

    //MÉTODO PARA CONTADORES - CAPATACES INACTIVOS
    public int cantCapaInac() {
        PreparedStatement pst = null;
        ResultSet rs = null;
        int cont = 0;

        try {
            String consulta = "select count(*)from usuarios where codigo_rol=4 and activado_usuario=0";
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

    //MÉTODO PARA CONTADORES - TRABAJADORES ACTIVOS
    public int cantTraAct() {
        PreparedStatement pst = null;
        ResultSet rs = null;
        int cont = 0;

        try {
            String consulta = "select count(*)from usuarios where codigo_rol=5 and activado_usuario=1";
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

    //MÉTODO PARA CONTADORES - TRABAJADORES INACTIVOS
    public int cantTraInac() {
        PreparedStatement pst = null;
        ResultSet rs = null;
        int cont = 0;

        try {
            String consulta = "select count(*)from usuarios where codigo_rol=5 and activado_usuario=0";
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

    //MÉTODO PARA CREAR UN NICK DE USUARIOs
    public String crearNick(String nombre, String apellido) {
        String nick = "";

        //SEPARAR NOMBRES Y APELLIDOS
        String[] nombres = nombre.split(" ");
        String[] apellidos = apellido.split(" ");

        //OBTENER CARACTERES DEL APELLIDO
        String apellidoCarac = apellidos[0];
        char[] caracteres = apellidoCarac.toCharArray();

        //CREAR NICK
        nick = apellidos[1] + "." + nombres[0] + caracteres[0] + caracteres[1];

        //LIMPIAR NICK DE ACENTOS Y TILDES
        String cadenaNormalize = Normalizer.normalize(nick, Normalizer.Form.NFD);
        String cadenaSinAcentos = cadenaNormalize.replaceAll("[^\\p{ASCII}]", "");

        return cadenaSinAcentos.toLowerCase();
    }

    //MÉTODO PARA VERIFICAR SI EXISTE NICK
    public boolean existeNick(String nick) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        boolean existe = false;

        try {
            String consulta = "select nick_usuario from usuarios where nick_usuario=?";

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

    //MÉTODO PARA OBTENER CODIGO CARGO Y ROL   
    public String obtenerCodigoRol(String nombreRol) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String rol = "";

        try {
            String consulta = "select id_rol from roles where nombre_rol=?";
            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, nombreRol);

            //SE GUARDA LA CONEXION EN EL RESULSET
            rs = pst.executeQuery();
            //SI EXISTE UN REGISTRO CAMBIAMOS RETURN
            if (rs.next()) {
                //Si hay resultados obtengo el valor. 
                rol = rs.getString("id_rol");
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
        return rol;
    }

    public String obtenerCodigoCargo(String nombreCargo) {
        PreparedStatement pst = null;
        ResultSet rs = null;
        String cargo = "";

        try {
            String consulta = "select id_cargo from cargos where nombre_cargo=?";
            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, nombreCargo);

            //SE GUARDA LA CONEXION EN EL RESULSET
            rs = pst.executeQuery();
            //SI EXISTE UN REGISTRO CAMBIAMOS RETURN
            if (rs.next()) {
                //Si hay resultados obtengo el valor. 
                cargo = rs.getString("id_cargo");
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
        return cargo;
    }

    /*
     MÉTODOS GESTIONAR EQUIPOS
     */
    
    //MÉTODO PARA CREAR UN NUEVO EQUIPO
    public Boolean crearEquipo(String nombreEquipo, String descripcionEquipo, String lider, String email) {
        boolean registrar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "insert into equipos (nombre_equipo, descripcion_equipo, lider_equipo, email_lider) values (?, ?, ?, ?)";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, nombreEquipo);
            pst.setString(2, descripcionEquipo);
            pst.setString(3, lider);
            pst.setString(4, email);

            if (pst.executeUpdate() == 1) {
                registrar = true;
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
            } catch (Exception e) {
                System.err.println("ERROR : " + e);
            }
        }
        return registrar;
    }

    //MÉTODO PARA OBTENER TODOS LOS DATOS DE TODOS LOS EQUIPOS REGISTRADOS
    public ArrayList obtenerDatosEquiposTrabajo() {
        ArrayList lista = new ArrayList();
        String nombre_equipo = "", descripcion_equipo = "", numero_equipo, lider_equipo = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select eq.nombre_equipo, eq.descripcion_equipo, eq.id_equipo, eq.lider_equipo from equipos eq where eq.id_equipo<>1";

            pst = getConexion().prepareStatement(consulta);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    nombre_equipo = rs.getString("eq.nombre_equipo"); //0
                    descripcion_equipo = rs.getString("eq.descripcion_equipo"); //1
                    numero_equipo = rs.getString("eq.id_equipo"); //2
                    lider_equipo = rs.getString("eq.lider_equipo"); //3
                    lista.add(nombre_equipo);
                    lista.add(descripcion_equipo);
                    lista.add(numero_equipo);
                    lista.add(lider_equipo);
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

    //MÉTODO PARA OBTENER EL ULTIMO CODIGO DEL EQUIPO
    public ArrayList obtenerCodigoEq() {
        ArrayList lista = new ArrayList();
        String cod = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select id_equipo from equipos order by id_equipo desc limit 1";

            pst = getConexion().prepareStatement(consulta);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    cod = rs.getString("id_equipo"); //0
                    lista.add(cod);
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

    //MÉTODO PARA OBTENER LOS TRABAJADORES SIN EQUIPO
    public ArrayList obtenerTrabajadoresSinEquipo() {
        ArrayList lista = new ArrayList();
        String nombreUs = "", rutUs = "", emailUs = "", celularUs = "", cargoUs = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select us.nombre_usuario, us.rut_usuario, us.email_usuario, us.celular_usuario, ca.nombre_cargo from usuarios us, cargos ca "
                    + "where us.activado_usuario=1 and us.codigo_equipo=1 and us.codigo_cargo=ca.id_cargo and us.codigo_rol=5";

            pst = getConexion().prepareStatement(consulta);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    nombreUs = rs.getString("us.nombre_usuario"); //0
                    rutUs = rs.getString("us.rut_usuario"); //1
                    emailUs = rs.getString("us.email_usuario"); //2
                    celularUs = rs.getString("us.celular_usuario"); //3
                    cargoUs = rs.getString("ca.nombre_cargo"); //4
                    lista.add(nombreUs);
                    lista.add(rutUs);
                    lista.add(emailUs);
                    lista.add(celularUs);
                    lista.add(cargoUs);
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

    //MÉTODO PARA OBTENER TODOS LOS CAPATAZ SIN EQUIPO
    public ArrayList obtenerCapatazSinEquipo() {
        ArrayList lista = new ArrayList();
        String email_capataz = "", nombre_capataz = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select email_usuario, nombre_usuario from usuarios where activado_usuario=1 and codigo_rol=4 and codigo_equipo=1 ";

            pst = getConexion().prepareStatement(consulta);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    email_capataz = rs.getString("email_usuario"); //0
                    nombre_capataz = rs.getString("nombre_usuario"); //1
                    lista.add(email_capataz);
                    lista.add(nombre_capataz);
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

    //MÉTODO PARA OBTENER LOS DATOS DEL EQUIPO SELECCIONADO
    public ArrayList obtenerDatosEquipoSelec(String codigoSel) {
        ArrayList lista = new ArrayList();
        String cod = "", nombreEq = "", descripcionEq = "", liderEq = "", emailLiEq = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select id_equipo, nombre_equipo, descripcion_equipo, lider_equipo, email_lider from equipos where id_equipo=?";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, codigoSel);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    cod = rs.getString("id_equipo"); //0
                    nombreEq = rs.getString("nombre_equipo"); //1
                    descripcionEq = rs.getString("descripcion_equipo"); //2
                    liderEq = rs.getString("lider_equipo"); //3
                    emailLiEq = rs.getString("email_lider"); //4
                    lista.add(cod);
                    lista.add(nombreEq);
                    lista.add(descripcionEq);
                    lista.add(liderEq);
                    lista.add(emailLiEq);
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
    
    //MÉTODO PARA OBTENER LOS TRABAJADORES DEL EQUIPO SELECCIONADO
    public ArrayList obtenerTrabajadoresEquipoSelec(String cod) {
        ArrayList lista = new ArrayList();
        String nombreUs = "", rutUs = "", emailUs = "", celularUs = "", cargo = "", fonoUs = "", direccionUs = "", ciudadUs = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select us.nombre_usuario, us.rut_usuario, us.email_usuario, us.celular_usuario, us.fono_usuario, us.direccion_usuario, us.ciudad_usuario, ca.nombre_cargo from usuarios us, cargos ca "
                    + "where us.activado_usuario=1 and us.codigo_equipo=? and us.codigo_cargo=ca.id_cargo";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, cod);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    nombreUs = rs.getString("us.nombre_usuario"); //0
                    rutUs = rs.getString("us.rut_usuario"); //1
                    emailUs = rs.getString("us.email_usuario"); //2
                    celularUs = rs.getString("us.celular_usuario"); //3
                    fonoUs = rs.getString("us.fono_usuario"); //4
                    direccionUs = rs.getString("us.direccion_usuario"); //5
                    ciudadUs = rs.getString("us.ciudad_usuario"); //6
                    cargo = rs.getString("ca.nombre_cargo"); //7
                    lista.add(nombreUs);
                    lista.add(rutUs);
                    lista.add(emailUs);
                    lista.add(celularUs);
                    lista.add(fonoUs);
                    lista.add(direccionUs);
                    lista.add(ciudadUs);
                    lista.add(cargo);
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

    //MÉTODO PARA OBTENER LOS TRABAJADORES DEL EQUIPO SELECCIONADO
    public ArrayList obtenerTrabajadoresEquipoSelecMasJefe(String cod) {
        ArrayList lista = new ArrayList();
        String nombreUs = "", rutUs = "", emailUs = "", celularUs = "", cargo = "", fonoUs = "", direccionUs = "", ciudadUs = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select us.nombre_usuario, us.rut_usuario, us.email_usuario, us.celular_usuario, us.fono_usuario, us.direccion_usuario, us.ciudad_usuario, ca.nombre_cargo from usuarios us, cargos ca "
                    + "where us.activado_usuario=1 and us.codigo_equipo=? and us.codigo_cargo=ca.id_cargo";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, cod);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    nombreUs = rs.getString("us.nombre_usuario"); //0
                    rutUs = rs.getString("us.rut_usuario"); //1
                    emailUs = rs.getString("us.email_usuario"); //2
                    celularUs = rs.getString("us.celular_usuario"); //3
                    fonoUs = rs.getString("us.fono_usuario"); //4
                    direccionUs = rs.getString("us.direccion_usuario"); //5
                    ciudadUs = rs.getString("us.ciudad_usuario"); //6
                    cargo = rs.getString("ca.nombre_cargo"); //7
                    lista.add(nombreUs);
                    lista.add(rutUs);
                    lista.add(emailUs);
                    lista.add(celularUs);
                    lista.add(fonoUs);
                    lista.add(direccionUs);
                    lista.add(ciudadUs);
                    lista.add(cargo);
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
    
    //MÉTODO PARA OBTENER EL NOMBRE DEL CAPATAZ
    public ArrayList obtenerNombreCapataz(String correo) {
        ArrayList lista = new ArrayList();
        String nombre_capataz = "";
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            String consulta = "select nombre_usuario from usuarios where activado_usuario=1 and email_usuario=?";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, correo);

            rs = pst.executeQuery();
            if (rs.next()) {
                do {
                    nombre_capataz = rs.getString("nombre_usuario"); //0
                    lista.add(nombre_capataz);
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

    //AGREGAR TRABAJADOR AL EQUIPO
    public boolean agregarTrabajadorDeEquipo(String correo, String codigo) {
        boolean modificar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "update usuarios set codigo_equipo=? where email_usuario=? ";

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

    //QUITAR TRABAJADOR DEL EQUIPO
    public boolean quitarTrabajadorDeEquipo(String correo) {
        boolean modificar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "update usuarios set codigo_equipo=1 where email_usuario=? ";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, correo);

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

    //MODIFICAR USUARIO EQUIPO DE TRABAJO (REVISAR, ME ARROJA FALSE PERO REALIZA CORRECTAMENTE LA CONSULTA)
    public boolean modificarTrabajadoresBorrarEquipo(String codigo) {
        boolean modificar = true;
        PreparedStatement pst = null;
        try {
            String consulta = "update usuarios set codigo_equipo=1 where codigo_equipo=?";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, codigo);

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

    //BORRAR EQUIPO DE TRABAJO
    public boolean borrarEquipoTrabajo(String codigo) {
        boolean modificar = false;
        PreparedStatement pst = null;
        try {
            String consulta = "delete from Equipos where id_equipo=? ";

            pst = getConexion().prepareStatement(consulta);

            pst.setString(1, codigo);

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

    public static void main(String[] args) {
        consultasPanelUsuarios con = new consultasPanelUsuarios();
        //System.out.println(con.ObtenerFullDatosUsuario("vargas.cristopher@hotmail.com", "ever1995"));
        System.out.println(con.modificarTrabajadoresBorrarEquipo("7"));
    }
}
