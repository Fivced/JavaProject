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
		  background-image: url('images/bg_5.jpg'); /* 替換成你的圖片路徑 */
		  background-size: cover;
		  background-position: center;
		  width: 100vw;
		  height: 100vh;
		  position: fixed;   /* <-- 加這一行才會蓋滿背景 */
		  top: 0;
		  left: 0;
		  z-index: 0;
		}
		.menu-section {
		  color: white;
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
	  .menu-card-img {
	    max-height: 300px;
	    width: 100%;
	    object-fit: contain;
	    padding: 10px;
	    background-color: #212529;
	    } /* 深色背景防止圖片空白突兀 */
	 #backToTopBtn {
	  position: fixed;
	  bottom: 30px;
	  right: 30px;
	  z-index: 999;
	  display: none; /* 預設隱藏，滑動後才出現 */
	  border-radius: 50%;
	  width: 50px;
	  height: 50px;
	  font-weight: bold;
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

	<!-- 外層：置中整塊 -->
	<div class="d-flex justify-content-center mt-5" style="z-index: 2; position: relative; margin-left: 20vw;">
	  <div class="container" style="max-width: 900px;">
	  
	    <!-- 分類按鈕：靠左對齊 -->
	    <div class="row mb-4">
	      <div class="col-auto">
	        <button class="btn btn-outline-yellow me-2 text-white" data-type="pizza" onclick="showMenu(this)">Pizza</button>
	        <button class="btn btn-outline-yellow me-2 text-white" data-type="drink" onclick="showMenu(this)">Soft Drinks</button>
	        <button class="btn btn-outline-yellow me-2 text-white" data-type="Sides" onclick="showMenu(this)">Sides</button>
	      </div>
	    </div>
	
		<!-- 披薩菜單 -->
		<div id="pizza" class="menu-section">
		  <h2 class="text-start mb-4">經典披薩系列 Classic Originals</h2>
		  <div class="row row-cols-1 row-cols-md-2 g-4 mt-3">
		    <div class="col">
		      <div class="card bg-dark text-white h-100">
		        <img src="images/Margherita w Pesto Drizzle.jpeg" class="card-img-top" alt="瑪格麗特披薩 Margherita w/ Pesto Drizzle">
		        <div class="card-body">
		          <h5 class="card-title">瑪格麗特 Margherita w/ Pesto Drizzle</h5>
		          <p class="card-text">(五辛素) 番茄、自製青醬。 最經典的美味， 最能吃出醬汁與餅皮的純粹。 Tomato Sauce, mozzarella, cherry tomatoes & pesto.</p>
		          <p class="card-price">NT$ 200</p>
		        </div>
		      </div>
		    </div>
		    <div class="col">
		      <div class="card bg-dark text-white h-100">
		        <img src="images/Hawaiian Pizza.jpeg" class="card-img-top" alt="夏威夷 Hawaiian Pizza">
		        <div class="card-body">
		          <h5 class="card-title">夏威夷 Hawaiian Pizza</h5>
		          <p class="card-text">培根、鳳梨。 鹹香培根加上香甜鳳梨，鹹甜好滋味大人小孩都超愛！ Tomato Sauce, mozzarella, bacon & pineapple.</p>
		          <p class="card-price">NT$ 260</p>
		        </div>
		      </div>
		    </div>
		  </div>
		
		  <h2 class="text-start mb-4 mt-5">主廚特製肉類&海鮮披薩 Meat & Seafood Pizza</h2>
		  <div class="row row-cols-1 row-cols-md-2 g-4 mt-3">
		    <div class="col">
		      <div class="card bg-dark text-white h-100">
		        <img src="images/Burger Pizza.jpeg" class="card-img-top" alt="美式起司牛肉 Burger Pizza">
		        <div class="card-body">
		          <h5 class="card-title">美式起司牛肉 Burger Pizza</h5>
		          <p class="card-text">充滿大麥克經典漢堡的超棒滋味，兩個願望一次滿足。烤牛肉, 酸黃瓜, 洋蔥, 英式芥末 Beef, Pickles, Onions & Mustard.</p>
		          <p class="card-price">NT$ 290</p>
		        </div>
		      </div>
		    </div>
		    <div class="col">
		      <div class="card bg-dark text-white h-100">
		        <img src="images/Garlic Butter Shrimp.jpeg" class="card-img-top" alt="蒜香奶油白蝦 Garlic Butter Shrimp">
		        <div class="card-body">
		          <h5 class="card-title">蒜香奶油白蝦 Garlic Butter Shrimp</h5>
		          <p class="card-text">滿滿的脆彈白蝦再淋上自製的大蒜奶油，香氣逼人！Shrimp/Onions/Garlic Butter/Parsley</p>
		          <p class="card-price">NT$ 330</p>
		        </div>
		      </div>
		    </div>
		  </div>
		
		  <h2 class="text-start mb-4 mt-5">Sweet Dessert Pizza</h2>
		  <div class="row row-cols-1 row-cols-md-2 g-4 mt-3">
		    <div class="col">
		      <div class="card bg-dark text-white h-100">
		        <img src="images/Caramel Apple Crumble Pizza.jpeg" class="card-img-top" alt="鹹焦糖蘋果派甜披薩 Caramel Apple Crumble Pizza">
		        <div class="card-body">
		          <h5 class="card-title">鹹焦糖蘋果派甜披薩 Caramel Apple Crumble Pizza</h5>
		          <p class="card-text">肉桂燉蘋果、鹹焦糖醬、酸奶、自製奶酥。</p>
		          <p class="card-price">NT$ 280</p>
		        </div>
		      </div>
		    </div>
		  </div>
		</div>
	
	    <!-- 飲料菜單 -->
	    <div id="drink" class="menu-section d-none">
	      <h2 class="text-start mb-4 mt-5">汽水</h2>
			  <div class="row row-cols-1 row-cols-md-2 g-4 mt-3">
			    <div class="col">
			      <div class="card bg-dark text-white h-100">
			        <img src="images/cola.jpg" class="card-img-top menu-card-img" alt="可口可樂 Coca Cola">
			        <div class="card-body">
			          <h5 class="card-title">可口可樂 Coca Cola</h5>
			          <p class="card-price">NT$ 60</p>
			        </div>
			      </div>
			    </div>
			    <div class="col">
			      <div class="card bg-dark text-white h-100">
			        <img src="images/sprite.jpg" class="card-img-top menu-card-img" alt="雪碧 Sprite">
			        <div class="card-body">
			          <h5 class="card-title">雪碧 Sprite</h5>
			          <p class="card-price">NT$ 60</p>
			        </div>
			      </div>
			    </div>
			  </div>
			  
	      <h2 class="text-start mb-4 mt-5">其他</h2>
		      <div class="row row-cols-1 row-cols-md-2 g-4 mt-3">
			    <div class="col">
			      <div class="card bg-dark text-white h-100">
			        <img src="images/Tree Top Apple Juice.jpg" class="card-img-top menu-card-img" alt="樹頂蘋果汁 Tree Top Apple Juice">
			        <div class="card-body">
			          <h5 class="card-title">樹頂蘋果汁 Tree Top Apple Juice</h5>
			          <p class="card-price">NT$ 70</p>
			        </div>
			      </div>
			    </div>
			  </div>
	    </div>
	
	    <!-- 甜點菜單 -->
	    <div id="Sides" class="menu-section d-none">
	      <h2 class="text-start mb-4">附餐單點 & 其他 Sides</h2>
	      	<div class="row row-cols-1 row-cols-md-2 g-4 mt-3">
			    <div class="col">
			      <div class="card bg-dark text-white h-100">
			        <img src="images/BBQ Chicken Wings.jpeg" class="card-img-top" alt="香草烤雞 (三腿三翅) BBQ Chicken Wings">
			        <div class="card-body">
			          <h5 class="card-title">香草烤雞 (三腿三翅) BBQ Chicken Wings</h5>
			          <p class="card-text">10多種香料醃製而成。</p>
			          <p class="card-price">NT$ 180</p>
			        </div>
			      </div>
			    </div>
			    <div class="col">
			      <div class="card bg-dark text-white h-100">
			        <img src="images/Caesar Salad.jpeg" class="card-img-top" alt="雞肉凱撒沙拉 Caesar Salad">
			        <div class="card-body">
			          <h5 class="card-title">雞肉凱撒沙拉 Caesar Salad</h5>
			          <p class="card-text">生菜、雞肉、特製凱薩醬、乾酪。</p>
			          <p class="card-price">NT$ 180</p>
			        </div>
			      </div>
			    </div>
		  </div>
	    </div>
	
	  </div>
	</div>

	<!-- 回到頂部按鈕 -->
	<button id="backToTopBtn" class="btn btn-warning text-white" title="回到最上層">
	  ↑ Top
	</button>

</body>
<script>
	function showMenu(clickedBtn) {
	    // 移除所有 active 樣式
	    document.querySelectorAll('.btn-outline-yellow').forEach(btn => {
	      btn.classList.remove('active');
	    });
	
	    // 加上被點擊的 active 樣式
	    clickedBtn.classList.add('active');
	
	    // 顯示對應的菜單區塊
	    const type = clickedBtn.getAttribute('data-type');
	    document.querySelectorAll('.menu-section').forEach(section => {
	      section.classList.add('d-none');
	    });
	    document.getElementById(type).classList.remove('d-none');
	  }
	
	  // 頁面載入後自動點選第一個按鈕
	  window.addEventListener('DOMContentLoaded', () => {
	    const firstBtn = document.querySelector('.btn-outline-yellow[data-type="pizza"]');
	    if (firstBtn) {
	      showMenu(firstBtn);
	    }
	  });
	  
	  // 滾動時顯示按鈕
	  window.onscroll = function () {
	    const btn = document.getElementById("backToTopBtn");
	    if (document.body.scrollTop > 200 || document.documentElement.scrollTop > 200) {
	      btn.style.display = "block";
	    } else {
	      btn.style.display = "none";
	    }
	  };

	  // 點擊按鈕回到頂部
	  document.getElementById("backToTopBtn").addEventListener("click", function () {
	    window.scrollTo({ top: 0, behavior: "smooth" });
	  });
</script>
</html>