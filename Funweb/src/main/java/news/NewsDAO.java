package news;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import static db.JdbcUtil.*;

public class NewsDAO {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	PreparedStatement pstmt2 =null;
	ResultSet rs = null;
	

	// ----------- 글 쓰기 - insertNews() -----------------
	public int insertNews(NewsBean news) {
		int insertCount = 0;
		int num = 1;
		
		try {
			con = getConnection();
			
			//새 글 번호(num)
			String sql = "SELECT MAX(num) FROM news";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt(1) + 1;
			}
			
			//글 쓰기
			sql = "INSERT INTO news VALUES(?,?,?,?,?,now(),0)";
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, num);
			pstmt2.setString(2, news.getName());
			pstmt2.setString(3, news.getPass());
			pstmt2.setString(4, news.getSubject());
			pstmt2.setString(5, news.getContent());
			
			insertCount = pstmt2.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - insertNews()");
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
		return insertCount;
	}
	
	
	// --------- 게시물 목록 조회 : selectNewsList() -------------
	// => 파라미터 : 현재 페이지 번호(pageNum), 표시할 목록 갯수(listLimit)
	//  리턴타입 : java.util.ArrayList<NewsBean>(NewsList)
	
	public ArrayList<NewsBean> selectNewsList(int pageNum, int listLimit){
		ArrayList<NewsBean> newsList = null;
		
		try {
			con = getConnection();
			
			// 현재 페이지에서 불러올 목록의 첫번째(시작) 행번호 계산
			int startRow = (pageNum - 1) * listLimit;
			
			
			
			String sql = "SELECT * FROM news ORDER BY num DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, listLimit);
			
			rs = pstmt.executeQuery();
			
			// 전체 레코드를 저장할 ArrayList<BoardBean> 객체 생성
			newsList = new ArrayList<NewsBean>();
			
			while(rs.next()) {
				NewsBean news = new NewsBean();
				news.setNum(rs.getInt("num"));
				news.setName(rs.getString("name"));
				news.setPass(rs.getString("pass"));
				news.setSubject(rs.getString("subject"));
				news.setContent(rs.getString("content"));
				news.setDate(rs.getDate("date"));
				news.setReadcount(rs.getInt("readcount"));
				
				newsList.add(news);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectNewsList()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return newsList;
	}
	
	
	
	// --------- 전체 게시물 목록 갯수 조회 : selectListCount() ------------
	public int selectListCount() {
		int listCount  = 0;
		
		try {
			con = getConnection();
			
			String sql = "SELECT COUNT(num) FROM news";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// 조회된 결과값의 첫번째 값(1번 인덱스)을 listCount 변수에 저장
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectListCount()");
			e.printStackTrace();
		}  finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return listCount;
	}
	
	
	
	// --------- 게시물 상세 내용 조회 : selectNews() -------------------
	public NewsBean selectNews(int num) {
		NewsBean news = null;
		
		try {
			con = getConnection();
			
			String sql = "SELECT * FROM news WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// NewsBean 객체 생성 후 조회된 컬럼 데이터를 저장
				news = new NewsBean();
				news.setNum(rs.getInt("num"));
				news.setName(rs.getString("name"));
				news.setPass(rs.getString("pass"));
				news.setSubject(rs.getString("subject"));
				news.setContent(rs.getString("content"));
				news.setDate(rs.getDate("date"));
				news.setReadcount(rs.getInt("readcount"));
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectNews()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return news;
	}
	
	
	//----------------- 게시물 조회수 증가 : updateReadcount() -------------------
	public void updateReadCount(int num) {
		
		try {
			con = getConnection();
			
			String sql = "UPDATE news SET readcount=readcount+1 WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - updateReadcount()");
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(con);
		}
	}
	
	
	//-------------- 게시물 수정 작업 : updateNews() --------------
	public int updateNews(NewsBean news) {
		int updateCount = 0;
		
		try {
			con = getConnection();
			
			// 1. 패스워드 판별 작업
			String sql = "SELECT pass FROM news WHERE num=?";	//패스워드 조회 후 별도로 비교
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, news.getNum());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {		// 결과 존재
				//패스워드 판별
				if(rs.getString("pass").equals(news.getPass())) {
					// 2. 수정
					sql = "UPDATE news SET name=?,subject=?,content=? WHERE num=?";
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setString(1, news.getName());
					pstmt2.setString(2, news.getSubject());
					pstmt2.setString(3, news.getContent());
					pstmt2.setInt(4, news.getNum());
					
					updateCount = pstmt2.executeUpdate();
				}
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 구문오류 - updateNews()");
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(pstmt2);
			close(con);
		}
		
		return updateCount;
	}
	
	
	// ----------- 게시물 삭제 : deleteNews() --------------------
	public int deleteNews(int num, String pass) {
		int deleteCount = 0;
		
		try {
			con = getConnection();
			
			// 글번호와 패스워드가 모두 일치하는 게시물 조회
			String sql = "SELECT * FROM news WHERE num=? AND pass=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, pass);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				// 조회결과가 있는 경우(= 패스워드까지 일치할 경우)에만 삭제 작업 수행
				sql = "DELETE FROM news WHERE num=?";
				pstmt2 = con.prepareStatement(sql);
				pstmt2.setInt(1, num);
				deleteCount  = pstmt2.executeUpdate();
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - deleteNews()");
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(pstmt2);
			close(con);
		}
		
		return deleteCount;
	}
	
	
	//-------------- 최근 게시물 5개 조회 후 리턴 : selectRecentNewsList() --------
	// => 파라미터 : 없음    리턴타입 : ArrayList<NewsBean>(NewsList)
	public ArrayList<NewsBean> selectRecentNewsList(){
		ArrayList<NewsBean> NewsList = null;
		
		try {
			con = getConnection();
			
			String sql = "SELECT * FROM news ORDER BY num DESC LIMIT ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, 5);
			
			rs = pstmt.executeQuery();
			
			// 전체 레코드 저장할 ArrayList<NewsBean> 객체 생성
			NewsList = new ArrayList<NewsBean>();
			
			while(rs.next()) {
				// 1개의 레코드를 저장할 객체 생성
				NewsBean news = new NewsBean();
				// 조회된 1개 레코드 정보 저장
				news.setNum(rs.getInt("num"));
				news.setName(rs.getString("name"));
				news.setPass(rs.getString("pass"));
				news.setSubject(rs.getString("subject"));
				news.setContent(rs.getString("content"));
				news.setDate(rs.getDate("date"));
				news.setReadcount(rs.getInt("readcount"));
				
				// 전체 레코드를 저장하는 ArrayList 객체에 1개 레코드가 저장된 BoardBean 객체 추가
				NewsList.add(news);
			}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectRecentNewsList()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return NewsList;
	}
	
	
	//----------- 검색 목록 갯수 조회 : selectSearchListCount();----------
	public int selectSearchListCount(String search, String searchType) {
		int listCount = 0;
		
		try {
			con = getConnection();
			
			String sql = "SELECT COUNT(num) FROM news WHERE " + searchType + " LIKE ?";
			pstmt = con.prepareStatement(sql);
			// 검색어 생성
			pstmt.setString(1, "%" + search + "%");
			rs = pstmt.executeQuery();
			
			// 조회된 결과값의 첫번째 값(1번 인덱스)을 listCount 변수에 저장
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectSearchListCount()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return listCount;
	}
	
	//----------- 검색어에 해당하는 게시물 목록 조회(검색기능) : selectSearchNewsList() ------------
	// 파라미터 : 현재 페이지 번호(pageNum), 표시할 목록 갯수(listLimit), 검색어(search), 검색타입(searchType)
	// 리턴타입 : java.util.ArrayList<NewsBean>(newsList)
	public ArrayList<NewsBean> selectSearchNewsList(int pageNum, int listLimit, String search, String searchType){
		ArrayList<NewsBean> newsList = null;
		
		try {
			con = getConnection();
			
			//현재 페이지에서 불러올 목록의 첫번째(시작) 행번호 계산		
			int startRow = (pageNum - 1) * listLimit;
			
			String sql = "SELECT * FROM news WHERE " + searchType + " LIKE ? ORDER BY num DESC LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, listLimit);
			
			rs = pstmt.executeQuery();
			
			// 전체 레코드 저장할 ArrayList<NewsBean> 객체 생성
			newsList = new ArrayList<NewsBean>();
						
				while(rs.next()) {
					// 1개의 레코드를 저장할 객체 생성
					NewsBean news = new NewsBean();
					// 조회된 1개 레코드 정보 저장
					news.setNum(rs.getInt("num"));
					news.setName(rs.getString("name"));
					news.setPass(rs.getString("pass"));
					news.setSubject(rs.getString("subject"));
					news.setContent(rs.getString("content"));
					news.setDate(rs.getDate("date"));
					news.setReadcount(rs.getInt("readcount"));
							
					// 전체 레코드를 저장하는 ArrayList 객체에 1개 레코드가 저장된 BoardBean 객체 추가
					newsList.add(news);
				}
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - selectSearchNewsList()");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return newsList;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
