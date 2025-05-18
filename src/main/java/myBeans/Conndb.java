package myBeans;

import java.sql.*;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;

public class Conndb {	

    private String name;
    
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    
    static final String JDBC_DRIVER = "org.mariadb.jdbc.Driver"; // JDBC driver name
    static final String DB_URL = "jdbc:mariadb://127.0.0.1:3307/farina_pizza"; // database URL
    
    static final String USER = "root"; // Database credentials
    static final String PASS = "cs456789"; // Database credentials
    
    public Conndb() { // 由於資料庫一開始的建立需要的均是相同資訊，因此把這些資訊撰寫在建構子，即可在創建物件的當下，執行以下程式碼。
    	try {
			Class.forName(JDBC_DRIVER); // STEP 2: Register JDBC driver
            conn = DriverManager.getConnection(DB_URL, USER, PASS); // STEP 3: Open a connection
		}
    	catch (ClassNotFoundException | SQLException e) { // 當Class.forName(JDBC_DRIVER)沒有try/catch時，顯示編譯錯誤(紅波浪底線)，游標移至該編譯錯誤的字，點擊Surround with try/catch即可。
			e.printStackTrace();
		}
    }
	
	public String getName() {
		return name;
	}
	
	// get name
	public String getName( String email ) {
		String meg;
		try {
			pstmt = conn.prepareStatement("SELECT `name` FROM `member` WHERE ( `email` = ? )");
        	pstmt.setString(1, email);
        	rs = pstmt.executeQuery();
			if(rs.next()) { // 如果有值，取得name
				meg = "success";
				this.name = (rs.getString(1)+"");
			}
			else {
				meg = "Failed to retrieve data due to an unexpected error.";
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
			meg = "Failed to retrieve data due to an unexpected error.";
		}
		return meg;
	}
	
	// email check
    public String check( String checkemail ) {
    	String meg;    	
		try {
            InternetAddress address = new InternetAddress(checkemail);
            address.validate(); // 如果格式錯誤，會丟出例外
            pstmt = conn.prepareStatement("SELECT `email` FROM `member` WHERE ( `email` = ? )");
			pstmt.setString( 1, checkemail );
			rs = pstmt.executeQuery();
			if(rs.next()) { // 如果有值，代表此Email已有人註冊，顯示false
				meg = "false";
	        }
	        else {
	        	meg = "success";
	        }
        }
		catch (AddressException e) {
			meg = "error";
        }
		catch (SQLException e) {
			e.printStackTrace();
			meg = "check failed due to an unexpected error.";
		}    	
    	return meg;
    }
	
	// Sign in	
    public String login( String email, String password ) {
    	String meg;
    	try {
			pstmt = conn.prepareStatement("SELECT * FROM `member` WHERE ( `email` = ? )");
			pstmt.setString( 1, email );
			rs = pstmt.executeQuery();
			if(rs.next()) { // 如果有值，代表Email正確
				if (  password.equals(rs.getString(4)) ) {  // 接著先檢查密碼
		            if ( rs.getInt(5) != 1 ) { // 接著檢查Email是否有驗證，資料庫的欄位從1開始累加，非0開始
		            	meg = "Email verification pending.";
		            }
		            else {
		            	meg = "success";
		            	this.name = rs.getString(2);
		            }
				}
	            else {
	            	meg = "The password is incorrect.";
	            }
	        }
	        else { // 如果沒有值，代表帳號錯誤
	        	meg = "The email does not exist.";
	        }
		}
		catch (SQLException e) {
			e.printStackTrace();
			meg = "Login failed due to an unexpected error.";
		}
    	return meg;
    }
    
    // Sign up step1
    public String signup( String email, String password, String name ) {
    	String meg;    	
		try {
			pstmt = conn.prepareStatement("INSERT INTO `member` ( `email`, `password`, `name` ) VALUES ( ?, ?, ? )");
        	pstmt.setString(1, email);
        	pstmt.setString(2, password);
        	pstmt.setString(3, name);
        	pstmt.executeUpdate();
        	meg = "success";
		}
		catch (SQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
	        meg = "Violation of data integrity constraints."; // 不符資料表建立的限制
	    }
		catch (SQLException e) {
			e.printStackTrace();
			meg = "Registration failed due to an unexpected error.";
		}
		return meg;
    }
    
 // Sign up step2 - verification
    public String u_v_code( String email,  int v_code ) {
    	String meg;
    	try {
			pstmt = conn.prepareStatement("UPDATE `member` SET `registered` = ? WHERE ( `email` = ? )");
        	pstmt.setInt(1, v_code);
        	pstmt.setString(2, email);
        	pstmt.executeUpdate();
        	meg = "success";
		}
		catch (SQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
	        meg = "Violation of data integrity constraints."; // 不符資料表建立的限制
	    }
		catch (SQLException e) {
			e.printStackTrace();
			meg = "Write operation failed due to an unexpected error.";
		}
    	return meg;
    }
    
    // Sign up step3 - get v_code
    public String get_v_code( String email ) {
    	String meg;
		try {
			pstmt = conn.prepareStatement("SELECT `registered` FROM `member` WHERE ( `email` = ? )");
        	pstmt.setString(1, email);rs = pstmt.executeQuery();
			if(rs.next()) { // 如果有值，取得驗證碼
				meg = (rs.getInt(1)+"");
			}
			else {
				meg = "Failed to retrieve data due to an unexpected error.";
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
			meg = "Failed to retrieve data due to an unexpected error.";
		}
		return meg;
    }
    
    // modify password
    public String u_pwd( String email,  String pwd ) {
    	String meg;
    	try {
			pstmt = conn.prepareStatement("UPDATE `member` SET `password` = ? WHERE ( `email` = ? )");
        	pstmt.setString(1, pwd);
        	pstmt.setString(2, email);
        	pstmt.executeUpdate();
        	meg = "success";
		}
		catch (SQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
	        meg = "Violation of data integrity constraints."; // 不符資料表建立的限制
	    }
		catch (SQLException e) {
			e.printStackTrace();
			meg = "Write operation failed due to an unexpected error.";
		}
    	return meg;
    }
    
    // new a booking info
    public String booking( String email, String branch, String date, String time, String people, String note ) {
    	String meg;    	
		try {
			pstmt = conn.prepareStatement("INSERT INTO `order` ( `email`, `branch`, `date`, `time`, `people`, `note` ) VALUES ( ?, ?, ?, ?, ?, ? )");
        	pstmt.setString(1, email);
        	pstmt.setString(2, branch);
        	pstmt.setString(3, date);
        	pstmt.setString(4, time);
        	pstmt.setString(5, people);
        	pstmt.setString(6, note);
        	pstmt.executeUpdate();
        	meg = "success";
		}
		catch (SQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
	        meg = "Violation of data integrity constraints."; // 不符資料表建立的限制
	    }
		catch (SQLException e) {
			e.printStackTrace();
			meg = "Write operation failed due to an unexpected error.";
		}
		return meg;
    }
    
    //close database
    public String closeConn( ) {
    	String meg;
    	if ( conn != null) {
			try {
				conn.close(); // 關閉資料庫連接
				meg = "Connection closed successfully.";
			}
			catch (SQLException e) {
				e.printStackTrace();
				meg = "Failed to close the database connection due to an unexpected error.";
			}
		}
    	else {
    		meg = "No database connection established.";
    	}
    	return meg;
    }
}    