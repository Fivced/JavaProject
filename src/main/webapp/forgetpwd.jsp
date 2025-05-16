<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
  <title>Farina Pizza</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> <!-- m -->
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

<body> <!-- m -->
<%
	String email =  request.getParameter("email");
	String meg =  request.getParameter("meg");
	String url = request.getContextPath();
	String url_updatepwd = url +"/updatepwd";
%>

  <div class="navbar-bg"></div> <!-- 背景層 -->

	<div class="d-flex justify-content-center mt-5" style="z-index: 2; position: relative; margin-left: 5vw;">
	  <div class="container" style="max-width: 500px;">
	  
		<!-- 登入功能區塊 -->
		<div class="container my-5">
		
		  <!-- 分類按鈕（自訂切換） -->
		  <div class="row mb-4">
		    <div class="col-auto">
		      <button class="btn btn-outline-yellow me-2 text-white active" onclick="showAuthForm(this)">重新設定密碼</button>
		    </div>
		  </div>
		
		  <!-- 表單內容區塊 -->
		  <div class="bg-transparent text-white p-4 rounded shadow">		
		    <!-- 註冊 -->
		    <div class="auth-form">
		      <form action="<%= url_updatepwd %>" id="forgetpwd" method="post"> <!-- m -->
		        <div class="mb-3">
		          <label for="mail" class="form-label">電子郵件</label>
		            <input type="email" class="form-control" id="email" name="email" readonly>
					<div class="invalid-feedback" id="registerEmailError">請輸入有效的電子郵件地址</div>
		        </div>
		        
				<!-- 註冊密碼欄位 -->
				<div class="mb-3">
				  <label for="Password" class="form-label">密碼</label>
				  <div class="input-group">
				    <input type="Password" class="form-control" id="Password" name="Password" required>
				    <button type="button" class="btn btn-outline-light" onclick="togglePassword('Password', this)">顯示</button>
				  </div>
				</div>
				
				<!-- 確認密碼欄位 -->
				<div class="mb-3">
				  <label for="confirmPassword" class="form-label">確認密碼</label>
				  <div class="input-group">
				    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
				    <button type="button" class="btn btn-outline-light" onclick="togglePassword('confirmPassword', this)">顯示</button>
				  </div>
				</div>
		        <button id="forgetpwd_button" type="submit" class="btn btn-warning w-100">認確</button>
		      </form>
		    </div>
		  </div>
		</div>
  
	  
	  
	  </div>
	</div>  


</body>
<script>
	// 密碼一致性檢查
	const Password = document.getElementById('Password');
	const confirmPassword = document.getElementById('confirmPassword');
	
	confirmPassword.addEventListener('input', function () {
	  if (Password.value !== confirmPassword.value) {
	    confirmPassword.setCustomValidity('密碼不一致');
	  } else {
	    confirmPassword.setCustomValidity('');
	  }
	});
	
	// 密碼顯示/隱藏切換（按鈕文字同步）
	function togglePassword(inputId, btn) {
	  const input = document.getElementById(inputId);
	  const isVisible = input.type === 'text';
	  input.type = isVisible ? 'password' : 'text';
	  btn.textContent = isVisible ? '顯示' : '隱藏';
	}
	
	$('#email').val("<%= email %>");
	let meg = "<%= meg %>";
	if ( meg != null ) {
		alert(meg);
	}
	
</script>