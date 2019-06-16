/*
    *Diseñado y programado por Cristopher Pérez V.
    *Sistema Tekonn 2019
*/
package Modelos;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
    private String USERNAME="root";
    private String PASS="";
    private String HOST="localhost";
    private String DB="new tekonn";
    private String CLASSNAME="com.mysql.jdbc.Driver";
    
    private String URL="jdbc:mysql://"+HOST+"/"+DB;
    //"jdbc:mysql://localhost/new tekkon";
    
    private Connection con;
    
    //CONSTRUCTOR CONEXION, PARA REALIZAR LA CONEXION
    public Conexion(){
        try {
            Class.forName(CLASSNAME);
            con = DriverManager.getConnection(URL,USERNAME,PASS);
        } catch (ClassNotFoundException e) {
            System.err.println("ERROR : "+e);
        }catch (SQLException e){
            System.err.println("ERROR : "+e);
        }
    }//FIN CONSTRUCTOR CONEXION
    
    //METODO PARA OBTENER LA CONEXION
    public Connection getConexion(){
        return con;
    }//FIN METODO CONEXION
    
    //MAIN PARA VERIFICAR CONEXION
    public static void main(String[] args) {
        Conexion con = new Conexion();
    }//FIN MAIN
}
