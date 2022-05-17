<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// POST 방식 한글 처리
request.setCharacterEncoding("UTF-8");

// join.jsp 페이지로부터 전달받은 폼 파라미터 데이터 가져오기
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
String email = request.getParameter("email");
String address = request.getParameter("address");
String phone = request.getParameter("phone");
String mobile = request.getParameter("mobile");

// 회원가입에 필요한 파라미터 데이터를 하나의 객체로 관리하기 위해 MemberBean 객체 활용
// MemberBean 객체 생성 후 Setter 를 호출하여 폼 파라미터 데이터 저장
MemberBean member = new MemberBean();
member.setId(id);
member.setPass(pass);
member.setName(name);
member.setEmail(email);
member.setAddress(address);
member.setPhone(phone);
member.setMobile(mobile);

// MemberDAO 클래스 객체 생성
MemberDAO memberDAO = new MemberDAO();

// MemberDAO 객체의 insertMember() 메서드를 호출하여 회원 가입 처리
// => 파라미터 : MemberBean 객체,   리턴타입 : int(insertCount)
int insertCount = memberDAO.insertMember(member);

// insertMember() 작업 수행 후 리턴받은 값에 따른 처리
// => 성공 시(insertCount > 0) "member 폴더의 joinSucess.jsp" 페이지로 포워딩
// => 실패 시 자바스크립트를 사용하여 "회원 가입 실패!" 출력 후 이전페이지로 돌아가기
if(insertCount > 0) {
	response.sendRedirect("joinSuccess.jsp");
} else {
	%>
	<script>
		alert("회원 가입 실패!");
		history.back();
	</script>
	<%
}

%>













