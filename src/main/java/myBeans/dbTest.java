package myBeans;
import java.sql.*;

public class dbTest {
    // JDBC driver name and database URL

    static final String JDBC_DRIVER = "org.mariadb.jdbc.Driver";
    static final String DB_URL = "jdbc:mariadb://127.0.0.1:3307/test3";

    //  Database credentials
    static final String USER = "root";
    static final String PASS = "cs456789";
    
	public dbTest() {}
	
    public String create(String checkuser,String password) {
    	
        Connection conn = null;
        Statement stmt = null;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            stmt = conn.createStatement();

            String sql = "INSERT INTO account (user,password, name,email) VALUES ('ccc', '66666', 'cccc', 'ddd')";
//
//
//            
//            ResultSet rs = stmt.executeQuery(sql);
//            while(rs.next()){
            
            stmt.executeUpdate(sql);
            
//	            if(rs.next()) {
//	            	if(password.equals(rs.getString(1))) {
//	            		System.out.print("success");
//	            	}else {
//	            		System.out.print("password fail");
//	            	}
//	            }else {
//	            	System.out.print("user fail");
//	            }
	     
//	            }
            
        } catch (SQLException se) {
            //Handle errors for JDBC
            se.printStackTrace();
        } catch (Exception e) {
            //Handle errors for Class.forName
            e.printStackTrace();
        } finally {
            //finally block used to close resources
            try {
                if (stmt != null) {
                    conn.close();
                }
            } catch (SQLException se) {
            }// do nothing
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }//end finally try
        }//end try
        return "success";
//        System.out.println("Goodbye!");
    }//end main
}
