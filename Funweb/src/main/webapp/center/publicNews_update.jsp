<%@page import="news.NewsBean"%>
<%@page import="news.NewsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("page");

//게시물 상세정보를 조회 후 편집창에 표시
//=> NewsDAO 객체의 selectBoard() 메서드 재사용
NewsDAO newsDAO = new NewsDAO();
NewsBean news = newsDAO.selectNews(num);


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/publicNews_update.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img_center"></div>
		<!-- 왼쪽 메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="notice.jsp">Notice</a></li>
				<li><a href="publicNews.jsp">Public News</a></li>
				<li><a href="driver_download.jsp">Driver Download</a></li>
				<li><a href="#">Service Policy</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>Public News Update</h1>
			<form action="publicNews_updatePro.jsp" method="post">
				<!-- input type="hiddem" 속성을 사용하여 글번호와 페이지번호도 전달 -->
				<input type="hidden" name="num" value="<%=num %>"> <input
					type="hidden" name="pageNum" value="<%=pageNum %>">

				<table id="notice">
					<tr>
						<td>글쓴이</td>
						<td><input type="text" name="name"
							value="<%=news.getName() %>" required="required"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="pass" required="required"></td>
					</tr>
					<tr>
						<td>제목</td>
						<td><input type="text" name="subject"
							value="<%=news.getSubject() %>" required="required"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea rows="10" cols="20" name="content"
								required="required"><%=news.getContent() %></textarea></td>
					</tr>
				</table>

				<div id="table_search">
					<input type="submit" value="글수정" class="btn">
				</div>
			</form>
			<div class="clear"></div>
		</article>


		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>
