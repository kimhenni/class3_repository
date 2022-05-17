<%@page import="news.NewsDAO"%>
<%@page import="news.NewsBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("page");

NewsBean news = new NewsBean();
news.setNum(num);
news.setName(request.getParameter("name"));
news.setPass(request.getParameter("pass"));
news.setSubject(request.getParameter("subject"));
news.setContent(request.getParameter("content"));


NewsDAO newsDAO = new NewsDAO();
int updateCount = newsDAO.updateNews(news);


if(updateCount > 0){
	response.sendRedirect("publicNews_content.jsp?num=" + num + "&page=" + pageNum);
} else {
%>
<script>
		alert("글 수정 실패!");
		history.back();
	</script>
<%	
}
%>