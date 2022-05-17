<%@page import="news.NewsDAO"%>
<%@page import="news.NewsBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

NewsBean news = new NewsBean();
news.setName(request.getParameter("name"));
news.setPass(request.getParameter("pass"));
news.setSubject(request.getParameter("subject"));
news.setContent(request.getParameter("content"));

NewsDAO newsDAO = new NewsDAO();

int insertCount = newsDAO.insertNews(news);

if(insertCount  > 0)  {
	response.sendRedirect("publicNews.jsp");
} else {
%>
<script>
		alert("글쓰기  실패!");
		history.back();
	</script>
<%
}
%>