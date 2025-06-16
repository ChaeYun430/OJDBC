package test2_250613.dto;

import java.sql.Date;
import java.util.Scanner;

public class MemberDTO {
	private int mno;
	private String id;
	private String pw;
	private String nick;
	private String eAdress;
	private String active;
	private String ctg;
	private Date regiDate;
	
	public MemberDTO() {

	}

	//초기값은 자유롭게 집어 넣되 수정이나 검증코드는 getter setter로
	public MemberDTO(String id, String nick, String eAdress) {
		this.id = id;
		this.nick = nick;
		this.eAdress = eAdress;
		active = "ACTIVE";
	}

	public int getMno() {
		return mno;
	}

	public void setMno(int mno) {
		this.mno = mno;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}
	 
	public void insertPw(String pw, Scanner scStr) {
		//dto에 검증 코드를 넣으면 필드 수송시 제약이 걸림 
		//검증 코드와 운송용 나누어서 만듦(setter)
		System.out.println("설정하신 비밀번호를 다시 입력해주세요.");
		System.out.print(">>>");
		String check = scStr.next();
		if (check.equals(pw)) {
			this.pw = pw;
		}
		System.out.println("설정하신 비밀번호와 일치하지 않습니다.");
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public String geteAdress() {
		return eAdress;
	}

	public void seteAdress(String eAdress) {
		this.eAdress = eAdress;
	}

	public String getActive() {
		return active;
	}

	public void setActive(String active) {
		this.active = active;
	}

	
	public String getCtg() {
		return ctg;
	}

	public void setCtg(String ctg) {
		this.ctg = ctg;
	}

	public Date getRegiDate() {
		return regiDate;
	}

	public void setRegiDate(Date regiDate) {
		this.regiDate = regiDate;
	}




	
	
	
}
