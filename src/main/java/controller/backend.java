package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import javaMail.Sendmail;
import myBeans.Conndb;

import java.io.IOException;
import java.net.URLEncoder;

@WebServlet(
		name="backend",
		urlPatterns={"/checkemail", "/login", "/signup", "/send", "/resend", "/verification", "/forgetpwd", "/updatepwd", "/booking", "/logout"}
		)
public class backend extends HttpServlet {
	private static final long serialVersionUID = 1L;
        
    public backend() {
        super();
    }
    
    private String genert_v_code( Conndb conndb, String email ) {
		int resend_v_code = (int)(( Math.random() * ( 999 - ( 100 - 1 )) ) + 100 ); // 隨機產生三位數
		Sendmail sendmail = new Sendmail();
		sendmail.setMessage(resend_v_code); // 將驗證碼寫入Message
		String result = sendmail.send(email); // 發送	驗證信
		if ( result.equals("success") ) {
    		result = conndb.u_v_code(email, resend_v_code); // 更新資料庫的驗證碼
    		conndb.closeConn(); // 關閉資料庫連線
    		return result;
		}
		else {
			return result;
		}
    }

    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	String url = request.getContextPath();
    	String urlp = request.getServletPath();
    	
    	// 檢查帳號是否可用
    	if ( urlp.equals("/checkemail") ) {
    		String email = request.getParameter("email"); // 取得Email
    		
    		Conndb conndb = new Conndb(); // 產生資料庫連線的物件
    		String result = conndb.check(email); // 取得檢查結果
    		conndb.closeConn(); // 關閉資料庫連線
    		response.getWriter().append(result); // (AJAX回傳)檢查結果
    	}
    	
    	// 登入
    	else if ( urlp.equals("/login") ) {
    		String email = request.getParameter("email"); // 取得Email
    		String password = request.getParameter("password");// 取得password
    		
    		Conndb conndb = new Conndb(); // 產生資料庫連線的物件
    		String result = conndb.login(email, password); // 檢查是否已註冊
    		switch (result) {
    			case "success":
            		conndb.closeConn(); // 關閉資料庫連線
    				HttpSession session = request.getSession(); // 登入成功，設定session
        			session.setAttribute("name", conndb.getName()); // 名為name的session
        			session.setAttribute("email", email); // 名為email的session
        			session.setMaxInactiveInterval(1800); // 設定 60 * 30 秒 的session，時效過後即登出
        			response.getWriter().append(result); // (AJAX回傳)成功結果
        			break;
    			case "Email verification pending.":
    				result = genert_v_code(conndb, email); // 寄送驗證信並將驗證碼儲存在資料庫
    				switch (result) {
    					case "success":
    						response.getWriter().append("resend"); // (AJAX回傳)結果
    						break;
						default:
							response.getWriter().append(result); // (AJAX回傳)錯誤結果
    				}
    				break;
				default:
	        		conndb.closeConn(); // 關閉資料庫連線
	    			response.getWriter().append(result); // (AJAX回傳)錯誤結果
    		}    		  			
    	}
    	
    	// 註冊
    	else if ( urlp.equals("/signup") ) {
    		String email = request.getParameter("email"); // 取得Email
    		String password = request.getParameter("password");// 取得password
    		String name = request.getParameter("name"); // 取得name
    		
    		Conndb conndb = new Conndb(); // 產生資料庫連線的物件
    		String result = conndb.check(email); // 先檢查Email是否已被其他人註冊
    		switch (result) {
				case "success":
					result = conndb.signup(email, password, name); // 再註冊
					switch (result) {
						case "success":
		    				result = genert_v_code(conndb, email); // 寄送驗證信並將驗證碼儲存在資料庫
		    				response.getWriter().append(result); // (AJAX回傳)結果
		    				break;
	    				default:
	    					conndb.closeConn(); // 關閉資料庫連線
	        				response.getWriter().append(result); // (AJAX回傳)錯誤結果
					}
	    			break;
				default:
					conndb.closeConn(); // 關閉資料庫連線
	    			response.getWriter().append(result); // (AJAX回傳)錯誤結果
    		}
    	}
    	
    	// 比對資料庫中的驗證碼
    	else if ( urlp.equals("/verification") ) {
    		String input = request.getParameter("mailverification"); // 取得輸入值
    		String email = request.getParameter("email"); // 取得Email
    		
    		Conndb conndb = new Conndb();
    		String v_code = conndb.get_v_code(email); // 取得資料庫的驗證碼
    		switch (v_code) {
    			case "0":
    				conndb.closeConn(); // 關閉資料庫連線
    				response.getWriter().append("systemerror");
    				break;
				default:
					if ( input.equals(v_code) ) { // input 比對 資料庫的v_code
						String result = conndb.u_v_code(email, 1); // 正確，將v_code修改為1
						switch (result) {
		    				case "success":
		    					result = conndb.getName(email); // 取得資料庫中的名字
		    		    		conndb.closeConn(); // 關閉資料庫連線        					
		    	    			HttpSession session = request.getSession(); // 登入成功，設定session
		    	    			session.setAttribute("name", conndb.getName()); // 將name 儲存在session
		    	    			session.setAttribute("mail", email); // 將email 儲存在session
		    	    			session.setMaxInactiveInterval(1800); // 設定 60 * 30 秒 的session，時效過後即登出
		    	    			response.getWriter().append(result);
		    					break;
	    					default:
	    						conndb.closeConn(); // 關閉資料庫連線
	    						response.getWriter().append(result);
	    		        		break;
						}
					}
					else{
						conndb.closeConn(); // 關閉資料庫連線
						switch (v_code.length()) {
							case 3:
								response.getWriter().append("fail");
								break;
							default:
								response.getWriter().append(v_code);								
						}
					}
    		}			  		   		
    	}
    	
    	// 建立新驗證碼並重新發送
    	else if ( urlp.equals("/resend") ) {
    		String email =  request.getParameter("email"); // 取得Email
    		String encode_email = URLEncoder.encode(email, "UTF-8"); // 將Email進行URL編碼
    		
    		Conndb conndb = new Conndb();
    		String result = genert_v_code(conndb, email); // 寄送驗證信並儲存在資料庫
			if ( result.equals("success") ) {
				response.sendRedirect(url+
	        			"/transition.jsp?meg=resend&email="+encode_email);  // 轉跳至過場頁面顯示alert
			}
			else {
				response.sendRedirect(url+
	        			"/mail_verification.jsp?meg="
	        			+URLEncoder.encode(result, "UTF-8")
	        			+"&email="+encode_email);   				
			}    		
    	}
    	
    	// 忘記密碼
    	else if ( urlp.equals("/forgetpwd") ) {
    		String email =  request.getParameter("email"); // 取得Email
    		
    		Conndb conndb = new Conndb(); // 產生資料庫連線的物件
    		String result = conndb.check(email);
    		conndb.closeConn(); // 關閉資料庫連線
    		response.getWriter().append(result);
    	}
    	
    	// 重設密碼
    	else if ( urlp.equals("/updatepwd") ) {
    		String email =  request.getParameter("email"); // 取得Email
    		String pwd =  request.getParameter("password"); // 取得password
    		
    		Conndb conndb = new Conndb();
    		String result = conndb.u_pwd(email, pwd); // 重設密碼
    		conndb.closeConn(); // 關閉資料庫連線
    		response.getWriter().append(result);    		
    	}
    	
    	// 訂位
    	else if ( urlp.equals("/booking") ) {
    		String branch =  request.getParameter("branch");
    		String date =  request.getParameter("date");
    		String time =  request.getParameter("time");
    		String people =  request.getParameter("people");
    		String note =  request.getParameter("note");
    		if ( note == "" ) {
    			note = "None";
			}
    		
    		HttpSession session = request.getSession(false);
    		String email = (String)(session.getAttribute("email")); // 如有登入，取得儲存在session的Email
			if ( email != null ) {
	    		Conndb conndb = new Conndb();
	    		String result = conndb.booking(email, branch, date, time, people, note); // 將booking資訊寫入資料庫
	    		if ( result.equals("success") ) {
	    			Sendmail sendmail = new Sendmail();
	    			sendmail.setMessage(branch, date, time, people, note); // 將booking資訊寫入Message
	    			result = sendmail.send(email); // 寄送
	    			if ( result.equals("success") ) {
		    			response.sendRedirect(url+"/transition.jsp?meg=bookingsuccess"); // 轉跳至過場頁面顯示alert    				
	    			}
	    			else {
	    				response.sendRedirect(url+"/transition.jsp?meg=bookingerror"); // 轉跳至過場頁面顯示alert
	    			}
	    		}
	    		else {
	    			response.sendRedirect(url+"/transition.jsp?meg="
	    			+URLEncoder.encode(result, "UTF-8")); // 轉跳至過場頁面顯示alert
	    		}
			}
			else {
				response.sendRedirect(url+"/member.jsp?branch="+URLEncoder.encode(branch, "UTF-8")
						+"&date="+date+"&time="+time+"&people="+people+"&note="+note);
			}
    	}
    	else if (urlp.equals("/logout")) {
    	    HttpSession session = request.getSession(false); // 不建立新 session
    	    if (session != null) {
    	        session.invalidate(); // 直接清除所有 session
    	    }

    	    // 建立新 session 儲存提示訊息
    	    session = request.getSession(true);
    	    session.setAttribute("msg", "您已成功登出！");
    	    
    	    response.sendRedirect(url + "/index.jsp"); // 回到首頁
    	}  	else {
			HttpSession session = request.getSession(); // 登出，設定session
			session.setAttribute("name", "logout");
			session.setAttribute("mail", "logout");
			session.setMaxInactiveInterval(0); // session設定時效為0，即登出
			response.sendRedirect(url+"/transition.jsp?meg=logout"); // 轉跳至過場頁面顯示alert
    	}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		doGet(request, response);
	}

}
