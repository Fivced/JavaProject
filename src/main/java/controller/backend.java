package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebInitParam;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import javaMail.Sendmail;
import myBeans.Conndb;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;

@WebServlet(
		name="backend",
		urlPatterns={"/checkemail", "/login", "/signup", "/verification", "/resend", "/forgetpwd", "/updatepwd", "/booking"}
		)
public class backend extends HttpServlet {
	private static final long serialVersionUID = 1L;
        
    public backend() {
        super();
    }

    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	String url = request.getContextPath();
    	String urlp = request.getServletPath();
    	
    	// 檢查帳號是否可用
    	if ( urlp.equals("/checkemail") ) {
    		String email = request.getParameter("email"); // 取得Email
    		
    		Conndb conndb = new Conndb(); // 產生資料庫連線的物件
    		String result = conndb.check(email); // 檢查Email是否已被其他人註冊
    		conndb.closeConn(); // 關閉資料庫連線
    		response.getWriter().append(result); // 取得檢查結果
    	}
    	
    	// 登入
    	else if ( urlp.equals("/login") ) {
    		String email = request.getParameter("email"); // 取得Email
    		String password = request.getParameter("password");// 取得password
    		
    		if ( !email.equals("") ) {
    			if ( !password.equals("") ) {
    	    		Conndb conndb = new Conndb(); // 產生資料庫連線的物件
    	    		String result = conndb.login(email, password); // 檢查是否已註冊
    	    		if ( result.equals("success")) {
    	    			String name = conndb.getName(email); // 取得資料庫中的名字
    	        		conndb.closeConn(); // 關閉資料庫連線
    	    			if ( !name.equals("Failed to retrieve data due to an unexpected error.")
    							|| !name.equals("Failed to retrieve data due to an unexpected error.") ) {
    	    				HttpSession session = request.getSession(); // 登入成功，設定session
    	        			session.setAttribute("name", name);
    	        			session.setAttribute("email", email);
    	        			session.setMaxInactiveInterval(1800); // 設定 60 * 30 秒 的session，時效過後即登出
    	        			response.getWriter().append(name);
    	    			}
    	    			else {
    	    				response.getWriter().append(name);
    	    			}
    	    		}
    	    		else {
    	        		conndb.closeConn(); // 關閉資料庫連線
    	    			response.getWriter().append(result);
    	    		}
    			}
    			else {
	    			response.getWriter().append("password_space");    				
    			}    			
    		}
    		else {
    			response.getWriter().append("email_space");    				
			}
    	}
    	
    	// 註冊
    	else if ( urlp.equals("/signup") ) {
    		String email = request.getParameter("email"); // 取得Email
    		String password = request.getParameter("password");// 取得password
    		String name = request.getParameter("name"); // 取得name
    		
    		Conndb conndb = new Conndb();
    		String result = conndb.check(email); // 先檢查Email是否已被其他人註冊
    		if ( result.equals("success") ) {
    			result = conndb.signup(email, password, name); // 再註冊
    			if ( result.equals("success") ) {
    				int v_code = (int)(( Math.random() * ( 999 - ( 100 - 1 )) ) + 100 ); // 隨機產生三位數
        			Sendmail sendmail = new Sendmail();
        			sendmail.setMessage(v_code); // 將驗證碼寫入Message
        			result = sendmail.send(email); // 寄送
    				if ( result.equals("success") ) { // 發送驗證信
    					result = conndb.u_v_code(email, v_code);
    		    		conndb.closeConn(); // 關閉資料庫連線
    					if ( result.equals("success") ) { // 將驗證碼儲存在資料庫
    	        			response.getWriter().append(email);
    					}
    					else {
    						response.getWriter().append(result); // 回覆錯誤結果
    					}
    				}
    				else {
    					conndb.closeConn(); // 關閉資料庫連線
    					response.getWriter().append(result); // 回覆錯誤結果
    				}
    			}
    			else {
					conndb.closeConn(); // 關閉資料庫連線
    				response.getWriter().append(result); // 回覆錯誤結果
    			}
    		}
    		else {
        		conndb.closeConn(); // 關閉資料庫連線
    			response.getWriter().append(result); // 回覆錯誤結果
    		}
    	}
    	
    	// 比對資料庫中的驗證碼
    	else if ( urlp.equals("/verification") ) {
    		String input = request.getParameter("mailverification"); // 取得輸入值
    		String email = request.getParameter("email"); // 取得Email
    		String encode_email = URLEncoder.encode(email, "UTF-8"); // 將Email進行URL編碼
    		
    		Conndb conndb = new Conndb();
    		String v_code = conndb.get_v_code(email);
    		if ( input.equals("") ) {
    			if ( !v_code.equals("0") ) {
    				if ( input.equals(v_code) ) {// input 比對 資料庫的v_code
    					String result = conndb.u_v_code(email, 1); // 正確，將v_code修改為1
        				if ( result.equals("success") ) {
        					String name = conndb.getName(email); // 取得資料庫中的名字
        		    		conndb.closeConn(); // 關閉資料庫連線
        					if ( !name.equals("Failed to retrieve data due to an unexpected error.")
        							|| !name.equals("Failed to retrieve data due to an unexpected error.") ) {
            	    			HttpSession session = request.getSession(); // 登入成功，設定session
            	    			session.setAttribute("name", name); // 將name 儲存在session
            	    			session.setAttribute("mail", email); // 將email 儲存在session
            	    			session.setMaxInactiveInterval(1800); // 設定 60 * 30 秒 的session，時效過後即登出
            					response.sendRedirect(url+"/index.jsp");
        					}
        					else {
        						response.sendRedirect(url+
        		        				"/mail_verification.jsp?meg="
        		        				+URLEncoder.encode(result, "UTF-8")
        		        				+"&email="+encode_email);
        					}
        				}
    		        	else {
    		        		conndb.closeConn(); // 關閉資料庫連線
    		        		response.sendRedirect(url+
    		        				"/mail_verification.jsp?meg="
    		        				+URLEncoder.encode(result, "UTF-8")
    		        				+"&email="+encode_email);
    		        	}
    		        }
    		        else {
    		        	conndb.closeConn(); // 關閉資料庫連線
    		        	response.sendRedirect(url+
    		        			"/mail_verification.jsp?meg=fail&email="+encode_email);
        		    }
    			}
    			else {
    				conndb.closeConn(); // 關閉資料庫連線
		        	response.sendRedirect(url+
		        			"/mail_verification.jsp?meg=databaseerror&email="+encode_email);
    			}    			
    		}
    		else {
				conndb.closeConn(); // 關閉資料庫連線
	        	response.sendRedirect(url+
	        			"/mail_verification.jsp?meg=fail_space&email="+encode_email);
    		}    		
    	}
    	
    	// 建立新驗證碼並重新發送
    	else if ( urlp.equals("/resend") ) {
    		String email =  request.getParameter("email");
    		String encode_email = URLEncoder.encode(email, "UTF-8"); // 將Email進行URL編碼
    		
    		int resend_v_code = (int)(( Math.random() * ( 999 - ( 100 - 1 )) ) + 100 ); // 隨機產生三位數
    		Conndb conndb = new Conndb();
    		String result = conndb.u_v_code(email, resend_v_code);
    		if ( result.equals("success") ) {
        		conndb.closeConn(); // 關閉資料庫連線
    			Sendmail sendmail = new Sendmail();
    			sendmail.setMessage(resend_v_code); // 將驗證碼寫入Message
    			result = sendmail.send(email); // 寄送
    			if ( result.equals("success") ) {
    				response.sendRedirect(url+
    	        			"/mail_verification.jsp?meg=resend&email="+encode_email);
    			}
    			else {
    				response.sendRedirect(url+
    	        			"/mail_verification.jsp?meg="
    	        			+URLEncoder.encode(result, "UTF-8")
    	        			+"&email="+encode_email);   				
    			}
    		}
			else {
	    		conndb.closeConn(); // 關閉資料庫連線
				response.sendRedirect(url+
	        			"/mail_verification.jsp?meg="
	        			+URLEncoder.encode(result, "UTF-8")
	        			+"&email="+encode_email);
			}
    	}
    	
    	// 忘記密碼
    	else if ( urlp.equals("/forgetpwd") ) {
    		String email =  request.getParameter("email");
    		String encode_email = URLEncoder.encode(email, "UTF-8");
    		
    		Conndb conndb = new Conndb(); // 產生資料庫連線的物件
    		String result = conndb.check(email);
    		conndb.closeConn(); // 關閉資料庫連線
    		if ( result.equals("false") ) { 
    			response.sendRedirect(url+
	        			"/forgetpwd.jsp?email="+encode_email);
    		}
    		else {
    			response.sendRedirect(url+
	        			"/member.jsp?meg="
	        			+URLEncoder.encode(result, "UTF-8")); 
    		}    		
    	}
    	
    	// 重設密碼
    	else if ( urlp.equals("/updatepwd") ) {
    		String email =  request.getParameter("email");
    		String pwd =  request.getParameter("Password");
    		
    		Conndb conndb = new Conndb();
    		String result = conndb.u_pwd(email, pwd); // 重設密碼
    		conndb.closeConn(); // 關閉資料庫連線
    		if ( result.equals("success") ) { // 重設密碼成功
				response.sendRedirect(url+"/index.jsp?meg=updatepwd"); // 跳轉至index.jsp並alert重新登入
    		}
    		else {
    			String encode_result = URLEncoder.encode(result, "UTF-8");
    			response.sendRedirect(url+"/forgetpwd.jsp?meg="+encode_result);
    		}
    	}
    	else if ( urlp.equals("/booking") ) {
    		String branch =  request.getParameter("branch");
    		String date =  request.getParameter("date");
    		String time =  request.getParameter("time");
    		String people =  request.getParameter("people");
    		String note =  request.getParameter("note");
    		
    		HttpSession session = request.getSession(false);
    		String email = (String)(session.getAttribute("email"));
			if ( email != null ) {
	    		Conndb conndb = new Conndb();
	    		String result = conndb.booking(email, branch, date, time, people, note); // 將booking資訊寫入資料庫
	    		if ( result.equals("success") ) {
	    			Sendmail sendmail = new Sendmail();
	    			sendmail.setMessage(branch, date, time, people, note); // 將booking資訊寫入Message
	    			result = sendmail.send(email); // 寄送
	    			response.sendRedirect(url+"/index.jsp");
	    		}
			}

    		response.sendRedirect(url+"/booking.jsp");
    	}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		doGet(request, response);
	}

}
