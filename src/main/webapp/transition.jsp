<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String meg = request.getParameter("meg");
	String name = (String)(session.getAttribute("name"));
	String email = request.getParameter("email");
	String url = request.getContextPath();
%>

</body>
</html>
<Script>
	let name = "<%= name %>";
	let meg = "<%= meg %>";
	let email = "<%= email %>" ;
	
	switch (meg) {
		case "newlogin":
			switch (name) {
				case "null":
					alert(`none`);
					window.location.href = "index.jsp";
					break;
				default:
					if ( name != "Failed to retrieve data due to an unexpected error."
						|| data.trim() != "Failed to retrieve data due to an unexpected error." ) {
						let megg = name+"，顧客您好!"+"歡迎使用本服務平台!";
						alert(megg);
						window.location.href = "index.jsp";
					}
					else {
						alert(name); // 錯誤訊息
						window.location.href = "index.jsp";
					}
			}
			break;
		case "send":
			alert("驗證信已發送。");
            encoded = encodeURIComponent(email);
			window.location.href = "mail_verification.jsp?email="+encoded;
			break;
		case "resend":
			alert("驗證信已重新發送。");
            encoded = encodeURIComponent(email);
			window.location.href = "mail_verification.jsp?email="+encoded;
			break;
		case "updatepwd":
			alert("密碼重設完成!請重新登入");
			window.location.href = "index.jsp";
			break;
		case "bookingsuccess":
			alert("訂位成功!");
			window.location.href = "index.jsp";
			break;
		case "bookingerror":
			alert("訂位失敗!請致電餐廳門市。");
			window.location.href = "booking.jsp";
			break;
		case "bookingsuccess":
			alert("訂位成功!");
			window.location.href = "index.jsp";
			break;
		case "logout":
			alert("您已登出");
			window.location.href = "index.jsp";
			break;
		default:
			alert(meg);
	}
</Script>