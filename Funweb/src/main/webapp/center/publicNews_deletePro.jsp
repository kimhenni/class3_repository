<%@page import="news.NewsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("page");
String pass = request.getParameter("pass");

NewsDAO newsDAO = new NewsDAO();
int deleteCount = newsDAO.deleteNews(num, pass);


//작업 결과 판별 및 처리
if(deleteCount > 0){
	response.sendRedirect("publicNews.jsp?page=" + pageNum);
} else {
	%>
<script>
		alert("글 삭제 실패!");
		history.back();
	</script>
<%
}
%>