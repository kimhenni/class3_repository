package news;

import java.sql.Date;

public class NewsBean {
	/*
	
	 CREATE TABLE news (
	 num Int PRIMARY KEY,
	 name VARCHAR(16) NOT NULL,
	 pass VARCHAR(16) NOT NULL,
	 subject VARCHAR(50)  NOT NULL,
	 content VARCHAR(200) NOT NULL,
	 date DATE NOT NULL,
	 readcount Int NOT NULL
 	 );
	 */
	
	private int num;
	private String name;
	private String pass;
	private String subject;
	private String content;
	private Date date;
	private int readcount;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	
	@Override
	public String toString() {
		return "NewsBean [num=" + num + ", name=" + name + ", pass=" + pass + ", subject=" + subject + ", content="
				+ content + ", date=" + date + ", readcount=" + readcount + "]";
	}
	
	
	
	
	
	
}
