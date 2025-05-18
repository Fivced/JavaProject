<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String email = (String)(session.getAttribute("email"));
    if (email == null) {
        session.setAttribute("msg", "請先登入再訂位");
        response.sendRedirect("member.jsp");
        return;
    }
%>
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
	/* 新增這段，讓 container 在背景圖上層 */
	.container {
	  position: relative;
	  z-index: 2;
	}
	.semi-black-bg {
	  background-color: rgba(0, 0, 0, 0.6); /* 半透明黑色 */
	  border-radius: 1rem;
	  padding: 1.5rem;
	}
</style>
<body>
<%
	String url = request.getContextPath();
	String url_booking = url +"/booking";
%>

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
  
	<div class="container py-5 text-white" style="max-width: 500px;">
	  <h2 class="mb-4">線上訂位</h2>
	
	  <form action="<%= url_booking %>" method="post" class="semi-black-bg text-white shadow">
	    <!-- 分店選擇 -->
	    <div class="mb-3">
	      <label for="branch" class="form-label">選擇分店</label>
	      <select class="form-select" id="branch" name="branch" required>
	        <option value="" disabled selected>請選擇分店</option>
	        <option value="永和仁愛店">永和仁愛店</option>
	        <option value="四號公園店">四號公園店</option>
	      </select>
	    </div>
	
	    <!-- 日期與時間 -->
	    <div class="mb-3">
	      <label for="datet" class="form-label">訂位時間</label>
	      <input type="date" class="form-control" id="date" name="date" required>
	    </div>

	    <!-- 時間選擇 -->
	    <div class="mb-3">
	      <label for="time" class="form-label">選擇時間</label>
	      <select class="form-select" id="time" name="time" required>
			<option value="" disabled selected>請選擇時間</option>
			<option value="11:30">11:30</option>
			<option value="12:00">12:00</option>
			<option value="12:30">12:30</option>
			<option value="13:00">13:00</option>
			<option value="13:30">13:30</option>
			<option value="14:00">14:00</option>
			<option value="14:30">14:30</option>
			<option value="15:00">15:00</option>
			<option value="15:30">15:30</option>
			<option value="16:00">16:00</option>
			<option value="16:30">16:30</option>
			<option value="17:00">17:00</option>
			<option value="17:30">17:30</option>
			<option value="18:00">18:00</option>
			<option value="18:30">18:30</option>
			<option value="19:00">19:00</option>
			<option value="19:30">19:30</option>
			<option value="20:00">20:00</option>
			<option value="20:30">20:30</option>
			<option value="21:00">21:00</option>
			<option value="21:30">21:30</option>
	      </select>
	    </div>
	
	    <!-- 人數 -->
	    <div class="mb-3">
	      <label for="people" class="form-label">人數</label>
	      <input type="number" class="form-control" id="people" name="people" min="1" max="20" required>
	    </div>
	
	    <!-- 備註 -->
	    <div class="mb-3">
	      <label for="note" class="form-label">備註</label>
	      <textarea class="form-control" id="note" name="note" rows="3" placeholder="例如：需要嬰兒座椅、靠窗座位等"></textarea>
	    </div>
	
	    <button type="submit" class="btn btn-warning w-100">送出訂位</button>
	  </form>
	</div>


</body>
<script>
  // 設定最小日期為今天
  const dateInput = document.getElementById('date');
  const timeSelect = document.getElementById('time');

  const today = new Date().toISOString().split('T')[0];
  dateInput.setAttribute('min', today);

  // 設定最小時段為現在
  window.addEventListener('DOMContentLoaded', () => {
	    const select = document.getElementById('time');
	    const now = new Date();
	    const nowMinutes = now.getHours() * 60 + now.getMinutes();

	    for (const option of select.options) {
	      if (option.value) {
	        // option.value 格式是 "HH:mm"
	        const [hour, minute] = option.value.split(':').map(Number);
	        const optionMinutes = hour * 60 + minute;

	        // 已經過去的時間設 disabled
	        if (optionMinutes <= nowMinutes) {
	          option.disabled = true;
	        }
	      }
	    }
	  });
</script>
</html>