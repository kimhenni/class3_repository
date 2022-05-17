package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

//JDBC 활용 시 데이터베이스 접근 관련 작업을 수행하는 용도의 클래스 정의
// =>DB 접속, DB 자원 반환, 커밋 또는 롤백 작업 등을 수행
public class JdbcUtil {
	
	
	public static Connection getConnection() {
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/funweb";
		String user = "root";
		String password = "1234";
		
		Connection con = null;
		
		try { //예외9=오류)가 발생할 것으로 예상되는 코드들을 모아놓는 곳
			// 1단계. JDBC 드라이버 클래스 로드
			Class.forName(driver);
			//2단계. DB 접속
			con = DriverManager.getConnection(url, user, password);
			
			//DB 접속이 실패했을 경우 SQLException 예외가 발생할 수 있음
		} catch (ClassNotFoundException e) {
			// 드라이버 클래스 위치가 잘못되었을 경우 자동으로 실행되는 코드 위치
			e.printStackTrace();
			System.out.println("드라이버 로드 실패!");
		} catch (SQLException e) {
			//DB 접속이 불가능할 경우(정보가 틀렸을 경우 자동으로 실행되는 코드 위치)
			e.printStackTrace();
			System.out.println("DB 접속 실패!");
		}
		
		// Connection 객체 리턴
		return con;			//DB에 접근 가능
		
	}
	
	//2. DB 자원을 반환하는 close() 메서드 정의
	// => 반환해야하는 대상 객체 : Connection, PreparedStatment, ResultSet
	// => 메서드 이름은 동일하고, 파라미터를 다르게 하는 메서드 오버로딩을 활용하여 메서드 정의
	//1) java.sql.Connection 객체를 전달받아 반환
	public static void close(Connection con) {
		if(con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	//2)java.sql.PreparedStatment 객체를 전달받아 반환
	public static void close(PreparedStatement pstmt) {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public static void close(ResultSet rs) {
		if(rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}

