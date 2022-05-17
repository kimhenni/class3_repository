<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String pageNum = request.getParameter("page");
int num = Integer.parseInt(request.getParameter("num"));
String pass = request.getParameter("pass");

// BoardDAO 객체의 deleteBoard() 메서드를 호출하여 게시물 삭제 작업 요청
// => 파라미터 : 글번호(num), 패스워드(pass)    리턴타입 : int(deleteCount)
// => 패스워드를 조회하여 패스워드가 일치할 경우에만 레코드 삭제
BoardDAO boardDAO = new BoardDAO();
int deleteCount = boardDAO.deleteBoard(num, pass);

// 작업 작업 결과 판별 및 처리
// deleteCount > 0 일 경우 "notice.jsp" 페이지로 이동(페이지번호 전달)하고
// 아니면, 자바스크립트를 사용하여 "글 삭제 실패!" 출력 후 이전 페이지로 돌아가기
if(deleteCount > 0) {
	response.sendRedirect("notice.jsp?page=" + pageNum);
} else {
	%>
<script>
		alert("글 삭제 실패!");	
		history.back();
	</script>
<%
}
%>












