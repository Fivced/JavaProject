<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
  <title>Farina Pizza</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
 <style>
	   /* 背景圖區塊樣式，使用 vw 和 vh 來設置大小 */
		.navbar-bg {
		  background-image: url('images/bg_7.jpg'); /* 替換成你的圖片路徑 */
		  background-size: cover;
		  background-position: center;
		  width: 100vw;
		  height: 100vh;
		  position: fixed;   /* <-- 加這一行才會蓋滿背景 */
		  top: 0;
		  left: 0;
		  z-index: 0;
		}

		  /* 加這段讓導覽列在最上層 */
		  nav.navbar {
		    position: relative;
		    z-index: 3;
		  }
	  .btn-outline-yellow {
	    border: 2px solid #ffc107;
	    color: white;
	    background-color: transparent;
	    min-width: 140px;        /* 固定寬度讓按鈕一致 */
	    padding: 10px 20px;      /* 固定 padding 避免跳動 */
	    transition: background-color 0.3s, color 0.3s;
	  }
	
	  .btn-outline-yellow:hover {
	    background-color: #ffc107;
	    color: black;
	  }
	
	  .btn-outline-yellow.active {
	    background-color: #ffc107 !important;
	    color: black !important;
	  }

 </style>

<body>
<%
	String email =  request.getParameter("email");
	String encoded = URLEncoder.encode(email, "UTF-8");
	
	String url = request.getContextPath();
	String url_verification = url +"/verification";
	String url_resend = url +"/resend"+"?email="+encoded;
%>
  <div class="navbar-bg"></div> <!-- 背景層 -->
	<div class="d-flex justify-content-center mt-5" style="z-index: 2; position: relative; margin-left: 5vw;">
	  <div class="container" style="max-width: 500px;">
	  
		<!-- 登入功能區塊 -->
		<div class="container my-5">
		
		  <!-- 分類按鈕（自訂切換） -->
		  <div class="row mb-4">
		    <div class="col-auto">
		      <button class="btn btn-outline-yellow me-2 text-white active" onclick="showAuthForm(this)">驗證信</button>
		    </div>
		  </div>
		  
		  <!-- 表單內容區塊 -->
		  <div class="bg-transparent text-white p-4 rounded shadow">
		    <!-- 驗證碼 -->
		    <div class="auth-form">
		      <form id="verification" method="post">
		        <div class="mb-3">
		          <label for="mailverification" class="form-label">請至您的E-mail收取驗證碼</label>
					<input type="text" class="form-control" id="mailverification" name="mailverification" required>
					<div id="verificationError" style="color: red;"></div>
					<input type="hidden" class="form-control" id="email" name="email">
		        </div>
		        
		        <button type="submit" class="btn btn-warning w-100">確認</button>
		        <div>
		        	<a href="<%= url_resend %>">沒有收到驗證信?重新發送驗證碼</a>
		        </div>
		      </form>
		    </div>
		  </div>
		</div>
	  </div>
	</div>

</body>
<script>
	// (AJAX回傳)驗證結果
	function verification_result(data) {	    
	    switch (data.trim()) {
	    	case "success":
	    		window.location.href = "transition.jsp?meg=newlogin";  // 轉跳至過場頁面顯示alert
	    	    break;
	        case "fail":
	          	$('#verificationError').html(`請輸入正確驗證碼`);
	          	break;
	        case "systemerror":
	        	alert(`伺服器錯誤，請點擊重新發送驗證信`);
	          	break;
	        default:
	        	alert(data.trim());
	    }
	}
	  
	// (AJAX傳送)驗證
	function verification() {
	    $.ajax({
	        url: "<%= url_verification %>", // 欲請求的API或網址
	        type: 'POST',
	        data: { // 欲傳遞的資料，使用JSON格式(鍵值對)
	            mailverification: $('#mailverification').val(),
	            email: $('#email').val()
	        },
	        success: data => verification_result(data), // success 代表請求成功(status:200)，data為回傳回來的資料，並送到自定義的function
	        error: err => console.log(err) // 若發生請求失敗，會執行console.log(err)
	    })
	}

	$('#email').val("<%= email %>");
	
	$('#verification').on("submit", (event) => {
		event.preventDefault();
		$('#verificationError').html(``);
		if ( $('#mailverification').val() == "" ) {			
			$('#verificationError').html("請輸入驗證碼");
		}
		else {
			verification();
		}
	});
	
	// 當按下鍵盤任意鍵，清空錯誤訊息
	function key_down(e) {
		$('#verificationError').html(``);
    }
	
	// 將key_down(e)綁定以下事件中(輸入框)
	$(document).ready( function () {		
	    $('#mailverification').on('keydown', key_down);
	});
</script>
</html>