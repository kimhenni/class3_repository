<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// id 파라미터 값을 가져와서 id 변수에 저장
String id = request.getParameter("id");

// duplicate 파라미터 값을 가져와서 duplicate 변수에 저장
// => 만약, 새 창을 연 상태일 경우 파라미터 자체가 없으므로 null 값이 리턴되고
//    check_id_pro.jsp 페이지를 통해 확인을 한 경우 "true" 또는 "false" 값이 리턴됨
String isDuplicate = request.getParameter("duplicate");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function useId(id) {
		// 자식창(나)에서 부모창(나를 연 창)을 제어하려면 window.opener.xxx 형태로 제어
		// => xxx 은 원래 해당 요소에 접근하는 문법 그대로 사용
		// 1. 사용 가능한 아이디를 부모창의 아이디 입력란에 표시
		window.opener.document.fr.id.value = id;
		// 2. 부모창의 전역변수 checkIdResult 값을 true 로 변경
		window.opener.checkIdResult = true;
		// 3. 자식창 닫기
		window.close();
	}
</script>
</head>
<body>
	<h1>아이디 중복 체크</h1>
	<form action="check_id_pro.jsp">
		<!-- id 파라미터가 존재할 경우 id 입력란에 id 값 표시 -->
		<input type="text" name="id" <%if(id != null) { %> value="<%=id %>" <%} %>required="required"  placeholder="영문,숫자 4~16글자">
		<input type="submit" value="중복확인">
	</form>
	<div id="checkIdResult">
	<!-- 중복체크 결과 표시 위치 -->
	<%if(isDuplicate != null && isDuplicate.equals("true")) {%>
		<br>이미 사용중인 아이디입니다.
	<%} else if(isDuplicate != null && isDuplicate.equals("false")) { %>
		<br>사용 가능한 아이디입니다.<br>
		<!-- 버튼 클릭 시 useId() 함수 호출(파라미터로 자바의 변수 id 값을 문자로 전달) -->
		<input type="button" value="아이디 사용" onclick="useId('<%=id%>')">
	<%} %>
	</div>
</body>
</html>











