<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/join.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	// 아이디 중복확인 여부와 패스워드 검사, 패스워드 확인 결과를 저장할 전역변수 선언
	var checkIdResult = false, checkPassResult = false, checkRetypePassResult = false
	
	function checkPass(pass) {
		// 패스워드 검사를 위한 정규표현식 패턴 작성 및 검사 결과에 따른 변수값 변경
		var spanElem = document.getElementById("checkPassResult");
		
		// 정규표현식 패턴 정의
		var lengthRegex = /^[A-Za-z0-9!@#$%]{8,16}$/; // 길이 및 사용 가능 문자 규칙
		var engUpperRegex = /[A-Z]/; // 대문자 규칙
		var engLowerRegex = /[a-z]/; // 소문자 규칙
		var numRegex = /[0-9]/; // 숫자 규칙
		var specRegex = /[!@#$%]/; // 특수문자 규칙
		
		var count = 0; // 각 규칙별 검사 결과를 카운팅 할 변수
		
		if(lengthRegex.exec(pass)) { // 패스워드 길이 및 사용 가능 문자 규칙 통과 시
// 			spanElem.innerHTML = "사용 가능한 패스워드";
// 			spanElem.style.color = "GREEN";
// 			checkPassResult = true;

			// 각 규칙별 검사 후 해당 항목이 포함되어 있을 경우 카운트 증가
			if(engUpperRegex.exec(pass)) count++;
			if(engLowerRegex.exec(pass)) count++;
			if(numRegex.exec(pass)) count++;
			if(specRegex.exec(pass)) count++;
			
			switch (count) {
				case 4 : 
					spanElem.innerHTML = "사용 가능한 패스워드(안전)";
					spanElem.style.color = "GREEN";
					checkPassResult = true;
					break;
				case 3 : 
					spanElem.innerHTML = "사용 가능한 패스워드(보통)";
					spanElem.style.color = "YELLOW";
					checkPassResult = true;
					break;
				case 2 : 
					spanElem.innerHTML = "사용 가능한 패스워드(위험)";
					spanElem.style.color = "ORANGE";
					checkPassResult = true;
					break;
				default:
					spanElem.innerHTML = "영문자,숫자,특수문자 중 2가지 이상 조합 필수!";
					spanElem.style.color = "RED";
					checkPassResult = false;
			}
			
		} else {
// 			spanElem.innerHTML = "사용 불가능한 패스워드";
			spanElem.innerHTML = "영문자,숫자,특수문자 조합 8 ~ 16자리 필수";
			spanElem.style.color = "RED";
			checkPassResult = false;
		}
		
	}

	function checkRetypePass(pass2) {
		/*
		함수에서 pass 와 pass2 의 항목 비교하여 일치하면 "패스워드 일치"(초록색) 표시하고
		아니면 "패스워드 불일치"(빨간색) 표시
		=> 패스워드 일치 시 checkRetypePassResult 를 true, 아니면 false 로 변경
		*/
		var pass = document.fr.pass.value;
		var spanElem = document.getElementById("checkRetypePassResult");
		
		if(pass == pass2) {
			spanElem.innerHTML = "패스워드 일치";
			spanElem.style.color = "GREEN";
			checkRetypePassResult = true;
		} else {
			spanElem.innerHTML = "패스워드 불일치";
			spanElem.style.color = "RED";
			checkRetypePassResult = false;
		}
	}
	
	function openCheckIdWindow() {
		window.open("check_id.jsp","","width=400,height=250");
	}
	
	function checkSubmit() {
		// 아이디 중복 확인 작업을 통해 아이디를 입력받았고(checkIdResult == true),
		// 정규표현식을 통해 패스워드 규칙이 올바르고(checkPassResult == true),
		// 패스워드 확인을 통해 두 패스워드가 동일하면(checkRetypePassResult == true) 이면
		// true 리턴, 아니면 false 리턴
		// => 아아디 중복 확인 작업과 패스워드 비교 작업 시 성공 여부를 저장할 변수 필요
		//    (이 변수는 다른 메서드에서도 접근해야하므로 함수 외부에 전역변수로 선언해야함)
		if(checkIdResult == false) { // 아이디 중복확인을 수행하지 않았을 경우
			// alert() 함수를 통해 "중복 확인 필수!" 메세지 출력 후 아이디 창에 포커스 요청
			alert("아이디 중복확인 필수!");
			document.fr.id.focus();
			return false; // 현재 함수 종료
		} else if(checkPassResult == false) { // 패스워드 확인을 수행하지 않았을 경우
			// alert() 함수를 통해 "올바른 패스워드 입력 필수!" 메세지 출력 후 아이디 창에 포커스 요청
			alert("올바른 패스워드 입력 필수!");
			document.fr.pass.focus();
			return false; // 현재 함수 종료
		} else if(checkRetypePassResult == false) { // 패스워드 확인을 수행하지 않았을 경우
			// alert() 함수를 통해 "패스워드 확인 필수!" 메세지 출력 후 아이디 창에 포커스 요청
			alert("패스워드 확인 필수!");
			document.fr.pass2.focus();
			return false; // 현재 함수 종료
		}
		
		
	}
</script>
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp"></jsp:include>
		<!-- 헤더 들어가는곳 -->
		  
		<!-- 본문들어가는 곳 -->
		  <!-- 본문 메인 이미지 -->
		  <div id="sub_img_member"></div>
		  <!-- 왼쪽 메뉴 -->
		  <nav id="sub_menu">
		  	<ul>
		  		<li><a href="#">Join us</a></li>
		  		<li><a href="#">Privacy policy</a></li>
		  	</ul>
		  </nav>
		  <!-- 본문 내용 -->
		  <article>
		  	<h1>Join Us</h1>
		  	<form action="joinPro.jsp" method="post" id="join" name="fr" onsubmit="return checkSubmit()">
		  		<fieldset>
		  			<legend>Basic Info</legend>
		  			<label>User Id</label>
		  			<input type="text" name="id" class="id" id="id" required="required" readonly="readonly" placeholder="중복체크 버튼 클릭">
		  			<input type="button" value="dup. check" class="dup" id="btn" onclick="openCheckIdWindow()"><br>
		  			<!-- 버튼 클릭 시 새 창 띄우기(크기 : 350 * 200, 파일 : check_id.jsp) -->
		  			
		  			<label>Password</label>
		  			<input type="password" name="pass" id="pass" required="required" placeholder="영문,숫자,특수문자 8~16글자"
		  						onkeyup="checkPass(this.value)">			
		  			<span id="checkPassResult"><!-- 패스워드 규칙 판별 결과 표시 영역 --></span><br>
		  			
		  			<label>Retype Password</label>
		  			<input type="password" name="pass2" required="required" onkeyup="checkRetypePass(this.value)">
		  			<span id="checkRetypePassResult"><!-- 패스워드 일치 여부 표시 영역 --></span><br>
		  			<!-- pass2 항목에 텍스트 입력할 때마다 자바스크립트의 checkRetypePass() 함수 호출 -->
		  			
		  			<label>Name</label>
		  			<input type="text" name="name" id="name" required="required"><br>
		  			
		  			<label>E-Mail</label>
		  			<input type="email" name="email" id="email" required="required"><br>
		  		</fieldset>
		  		
		  		<fieldset>
		  			<legend>Optional</legend>
		  			<label>Post code</label>
		  			<input type="text" name="post_code" id="post_code" readonly="readonly" placeholder="검색 버튼 클릭">
		  			<input type="button" value="search" class="dup"><br>
		  			<label>Address</label>
		  			<input type="text" name="address1" id="address1" readonly="readonly">
		  			<input type="text" name="address2" id="address2" placeholder="상세주소 입력"><br>
		  			<label>Phone Number</label>
		  			<input type="text" name="phone" ><br>
		  			<label>Mobile Phone Number</label>
		  			<input type="text" name="mobile" ><br>
		  		</fieldset>
		  		<div class="clear"></div>
		  		<div id="buttons">
		  			<input type="submit" value="Submit" class="submit">
		  			<input type="reset" value="Cancel" class="cancel">
		  		</div>
		  	</form>
		  </article>
		  
		  
		<div class="clear"></div>  
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp"></jsp:include>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


