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
	  background-image: url('images/bg_1.jpg'); /* 替換成你的圖片路徑 */
	  background-size: cover;
	  background-position: center;
	  width: 100vw;
	  height: 100vh;
	  position: fixed;   /* <-- 加這一行才會蓋滿背景 */
	  top: 0;
	  left: 0;
	  z-index: 0
	}
	/* 加這段讓導覽列在最上層 */
	  nav.navbar {
	    position: relative;
	    z-index: 3;
	  }
	.card-img-top {
    height: 200px;
    object-fit: cover;
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
          <li class="nav-item">
            <a class="nav-link" href="booking.jsp">餐廳訂位</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- 背景圖區塊 -->
  <div class="navbar-bg"></div>
  
	  <!-- 區塊：分店資訊 -->
	<div id="store" class="container mt-5 text-white">
	  <h2 class="text-center mb-4">門市資訊 Store Locations</h2>
	  <div class="row row-cols-1 row-cols-md-2 g-4">
	    
	    <!-- 台北店 -->
	    <div class="col">
	      <div class="card bg-dark text-white h-100">
	        <div class="card-body">
	          <h5 class="card-title">永和仁愛店</h5>
	          <p class="card-text">
	            地址：234009新北市永和區仁愛路162號<br>
	            電話：02-29256062<br>
	            營業時間：11:30 - 20:30
	          </p>
	          <div class="ratio ratio-4x3">
                 <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3615.624387705065!2d121.51044639999999!3d25.0128761!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3442a96d5f00e0c3%3A0x29ca324eeb16de11!2zRmFyaW5hIFBpenphIOazlemHjOWonOaKq-iWqSDmsLjlkozku4HmhJvlupc!5e0!3m2!1szh-TW!2stw!4v1746685856084!5m2!1szh-TW!2stw" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
	          </div>
	        </div>
	      </div>
	    </div>
	
	    <!-- 台中店 -->
	    <div class="col">
	      <div class="card bg-dark text-white h-100">
	        <div class="card-body">
	          <h5 class="card-title">四號公園店</h5>
	          <p class="card-text">
	            地址：235605新北市中和區中安街54號<br>
	            電話：02-29290062<br>
	            營業時間：11:30 - 20:30
	          </p>
	          <div class="ratio ratio-4x3">
	            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3615.9302128262443!2d121.512637!3d25.002487199999997!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3442a9622a57e3d9%3A0xe7169ad26af7de7!2zRmFyaW5hIFBpenphIOazlemHjOWonOaKq-iWqSDlm5vomZ_lhazlnJLlupc!5e0!3m2!1szh-TW!2stw!4v1746685748542!5m2!1szh-TW!2stw" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>"
	          </div>
	        </div>
	      </div>
	    </div>
	
	  </div>
	</div>

</body>
</html>