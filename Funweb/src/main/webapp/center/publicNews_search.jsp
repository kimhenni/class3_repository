<%@page import="news.NewsBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="news.NewsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String search = request.getParameter("search");
String searchType = request.getParameter("searchType");

//페이징 처리
int pageNum = 1;

//현재 페이지 번호가 저장된 page 파라미터에서 값을 가져와서 pageNum 변수에 저장
if(request.getParameter("page") != null){
	pageNum = Integer.parseInt(request.getParameter("page"));
}

int listLimit = 10;
int pageLimit = 10;

//----------------------------------------------------------------------------------------
//NewsDAO 객체의 selectListCount() 메서드를 호출하여 게시물 전체 목록 갯수 조회 작업 요청
//=> 파라미터 : 없음, 리턴타입 : int(listCount)
NewsDAO newsDAO = new NewsDAO();
int listCount = newsDAO.selectSearchListCount(search, searchType);

//---------------------------------------------------------------------------
//페이징처리 계산 작업
//1. 현재 페이지 표시할 전체 페이지 수 계산

//java.lang.Math 클래스의 ceil() 메서드를 사용하여 반올림 가능
int maxPage = (int)Math.ceil((double)listCount / listLimit);

//2. 현재 페이지에서 보여줄 시작 페이지 번호(1, 11, 21 등의 시작 번호) 계산
int startPage = ((int)((double)pageNum / pageLimit + 0.9) - 1) * pageLimit + 1;

//3. 현재 페이지에서 보여줄 끝 페이지 번호(10, 20, 30 등의 끝 번호) 계산
int endPage = startPage + pageLimit - 1;

//4. 만약, 끝 페이지(endPage)가 현재 페이지에서 표시할 총 페이지 수(maxPage)보다 클 경우
// 끝 페이지 번호를 총 페이지 수로 대체
if(endPage > maxPage) {
	endPage = maxPage;
}

//--------------------------------------------------------------------------
//NewsDAO 객체의 selectBoardList() 메서드를 호출하여 게시물 목록 조회 작업 요청
//=> 파라미터 : 현재 페이지 번호(pageNum), 표시할 목록 갯수(listLimit), 검색어(search), 검색타입(searchType)
// 리턴타입 : java.util.ArrayList<BoardBean>(newsList)
ArrayList<NewsBean> newsList = newsDAO.selectSearchNewsList(pageNum, listLimit, search, searchType);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/Public News_search.jsp</title>
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
			<h1>Public News</h1>
			<table id="notice">
				<tr>
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Write</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>
				<%
				// 향상된 for문을 사용하여 반복 과정에서 즉시 BoardBean 꺼내기
				for(NewsBean news : newsList){
				
				%>
				<tr
					onclick="location.href='publicNews_content.jsp?num=<%=news.getNum() %>&page=<%=pageNum %>'">
					<td><%=news.getNum() %></td>
					<td class="left"><%=news.getSubject() %></td>
					<td><%=news.getName() %></td>
					<td><%=news.getDate() %></td>
					<td><%=news.getReadcount() %></td>
				</tr>
				<%
				}
				%>
			</table>
			<div id="table_search">
				<input type="button" value="글쓰기" class="btn"
					onclick="location.href='publicNews_write.jsp'">
			</div>
			<div id="table_search">
				<form action="publicNews_search.jsp" method="get">
					<select name="searchType">
						<option value="subject">제목</option>
						<option value="name" <%if(searchType.equals("name")){%>
							selected="selected" <%} %>>작성자</option>
					</select> <input type="text" name="search" class="input_box"
						value="<%=search%>"> <input type="submit" value="Search"
						class="btn">
				</form>
			</div>
			<!-- 페이징 처리 -->
			<div class="clear"></div>
			<div id="page_control">
				<!-- 현재 페이지 번호(pageNum)가 1보다 클 경우에만 Prev 링크 동작 -->
				<%if(pageNum > 1) {		// 이전페이지 존재O %>
				<a href="publicNews.jsp?page=<%=pageNum - 1%>">Prev</a>
				<%} else { 		// 이전페이지 존재 X%>
				Prev&nbsp;
				<%} %>

				<!-- 페이지 번호 목록은 시작 페이지(startPage)부터 끝 페이지(endPage) 까지 표시 -->
				<%for(int i = startPage; i <= endPage; i++){ %>
				<!-- 단, 현재 페이지 번호는 링크 없이 표시 -->
				<%if(pageNum == i){ %>
				&nbsp;&nbsp;<%=i %>&nbsp;&nbsp;
				<%} else { %>
				<a href="publicNews.jsp?page=<%=i%>"><%=i%></a>
				<%} %>
				<%} %>
				<!-- 현재 페이지 번호(pageNum)가 총 페이지 수보다 작을 때만 Next 링크 동작 -->
				<%if(pageNum < maxPage){ 		//다음페이지 O%>
				<a href="publicNews.jsp?page<%=pageNum + 1%>">Next</a>
				<%} else{ 		//다음페이지 X%>
				&nbsp;Next
				<%} %>
			</div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>
