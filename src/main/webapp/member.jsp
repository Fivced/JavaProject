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

  <!-- 導覽列 -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
      <a class="navbar-brand" href="#">Farina Pizza 法里娜披薩</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="index.jsp">首頁</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="menu.jsp">各類披薩</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="store.jsp">門市資訊</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="member.jsp">加入會員</a>
          </li>
          <li class="navS-item">
            <a class="nav-link" href="booking.jsp">餐廳訂位</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="navbar-bg"></div> <!-- 背景層 -->

	<div class="d-flex justify-content-center mt-5" style="z-index: 2; position: relative; margin-left: 5vw;">
	  <div class="container" style="max-width: 500px;">
	  
		<!-- 登入功能區塊 -->
		<div class="container my-5">
		
		  <!-- 分類按鈕（自訂切換） -->
		  <div class="row mb-4">
		    <div class="col-auto">
		      <button class="btn btn-outline-yellow me-2 text-white active" data-type="login" onclick="showAuthForm(this)">登入</button>
		      <button class="btn btn-outline-yellow me-2 text-white" data-type="register" onclick="showAuthForm(this)">註冊</button>
		      <button class="btn btn-outline-yellow me-2 text-white" data-type="forgot" onclick="showAuthForm(this)">忘記密碼</button>
		    </div>
		  </div>
		
		  <!-- 表單內容區塊 -->
		  <div class="bg-transparent text-white p-4 rounded shadow">
		    <!-- 登入 -->
		    <div class="auth-form" data-type="login">
		      <form action="login" method="post">
		        <div class="mb-3">
		          <label for="loginEmail" class="form-label">電子郵件</label>
					<input type="email" class="form-control" id="loginEmail" name="email" required>
					<div class="invalid-feedback" id="loginEmailError">請輸入有效的電子郵件地址</div>
		        </div>
		        <div class="mb-3">
		          <label for="loginPassword" class="form-label">密碼</label>
		          <div class="input-group">
		            <input type="password" class="form-control" id="loginPassword" name="password" required>
		            <button type="button" class="btn btn-outline-light" onclick="togglePassword('loginPassword', this)">顯示</button>
		          </div>
		        </div>
		        <button type="submit" class="btn btn-warning w-100">登入</button>
		      </form>
		    </div>
		
		    <!-- 註冊 -->
		    <div class="auth-form d-none" data-type="register">
		      <form action="register" method="post">
		        <div class="mb-3">
		          <label for="registerUsername" class="form-label">使用者名稱</label>
		          <input type="text" class="form-control" id="registerUsername" name="username" required>
		        </div>
		        <div class="mb-3">
		          <label for="registerEmail" class="form-label">電子郵件</label>
		            <input type="email" class="form-control" id="registerEmail" name="email" required>
					<div class="invalid-feedback" id="registerEmailError">請輸入有效的電子郵件地址</div>
		        </div>
		        <button type="submit" class="btn btn-warning w-100">檢查帳號是否可用</button>
		        
				<!-- 註冊密碼欄位 -->
				<div class="mb-3">
				  <label for="registerPassword" class="form-label">密碼</label>
				  <div class="input-group">
				    <input type="password" class="form-control" id="registerPassword" name="password" required>
				    <button type="button" class="btn btn-outline-light" onclick="togglePassword('registerPassword', this)">顯示</button>
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
		        <button type="submit" class="btn btn-warning w-100">註冊</button>
		      </form>
		    </div>
		
		    <!-- 忘記密碼 -->
		    <div class="auth-form d-none" data-type="forgot">
		      <form action="forgot" method="post">
		        <div class="mb-3">
		          <label for="forgotEmail" class="form-label">電子郵件</label>
		            <input type="email" class="form-control" id="forgotEmail" name="email" required>
					<div class="invalid-feedback" id="forgotEmailError">請輸入有效的電子郵件地址</div>
		        </div>
		        <button type="submit" class="btn btn-warning w-100">重設密碼連結</button>
		      </form>
		    </div>
		  </div>
		</div>	  
	  
	  
	  </div>
	</div>  


</body>
<script>
  function showAuthForm(button) {
    const type = button.getAttribute('data-type');

    // 切換按鈕樣式
    document.querySelectorAll('[onclick="showAuthForm(this)"]').forEach(btn => {
      btn.classList.remove('active');
    });
    button.classList.add('active');

    // 顯示對應表單
    document.querySelectorAll('.auth-form').forEach(form => {
      form.classList.add('d-none');
      if (form.getAttribute('data-type') === type) {
        form.classList.remove('d-none');
      }
    });
  }

  // 即時 email 驗證
	['loginEmail', 'registerEmail', 'forgotEmail'].forEach(id => {
	  const input = document.getElementById(id);
	  const errorMsg = document.getElementById(id + 'Error');
	
	  input.addEventListener('input', function () {
	    const pattern = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/;
	    if (pattern.test(this.value)) {
	      this.classList.remove('is-invalid');
	      errorMsg.style.display = 'none';
	    } else {
	      this.classList.add('is-invalid');
	      errorMsg.style.display = 'block';
	    }
	  });
	});

	// 密碼一致性檢查
	const registerPassword = document.getElementById('registerPassword');
	const confirmPassword = document.getElementById('confirmPassword');

	confirmPassword.addEventListener('input', function () {
	  if (registerPassword.value !== confirmPassword.value) {
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
</script>
</html>