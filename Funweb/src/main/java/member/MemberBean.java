package member;

import java.sql.Date;

/*
 [funweb 데이터베이스 생성 ]
 CREATE DATEBAES funweb;
 use funweb
 
 [ member 테이블 생성 ]
 CREATE TABLE member (
 	id VARCHAR(16) PRIMARY KEY,
 	pass VARCHAR(16) NOT NULL,
 	name VARCHAR(20) NOT NULL,
 	email VARCHAR(50) UNIQUE NOT NULL,
 	date DATE NOT NULL,
 	address VARCHAR(100) NOT NULL,
 	phone VARCHAR(20) NOT NULL,
 	mobile VARCHAR(20) NOT NULL
 );
 */

//1명의 회원 정보(레코드)를 관리하는 MemberBean 클래스 정의
//MemberBean = MemberDTO = MemberVO
public class MemberBean {	
	private String id;
	private String pass;
	private String name;
	private String email;
	private Date date;
	private String address;
	private String phone;
	private String mobile;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	
	
	
	
	
	
	
	
}
