package test2_250613;

import java.sql.SQLException;
import java.util.Scanner;

import test2_250613.dao.MemberDAO;
import test2_250613.dto.MemberDTO;
import test2_250613.sv.MemberMenuSV;
import test2_250613.sv.MemberSV;

public class MemberExam {
	public static Scanner scStr = new Scanner(System.in);
	public static MemberDTO session = null;
	
	public static void main(String[] args) throws SQLException {
		boolean run = true;
		while (run) {
			String[] Menu = {"1. 회원 가입", "2. 로그인", "3. 시스템 종료"};
			for (int i = 0; i < Menu.length; i++) {
				System.out.println(Menu[i]);
			}
			System.out.print(">>>");
			String select = scStr.next();
			switch (select) {
			case "1":
				MemberSV.insert();
				break;
			case "2":
				session  = MemberSV.login(session); //로그인 상태의 session 활용
				if (session == null) {
					break;
				}else if (session.getCtg().equals("ADMIN")) {
					MemberMenuSV.adminMenu(session);
				}else if(session.getCtg().equals("USER")){
					if (session.getActive().equals("NONE")) {
						System.out.println("존재하지 않는 계정입니다.");
						break;
					}
					MemberMenuSV.userMenu(session);
				}
				break;
			case "3":
			System.out.println("회원관리 프로그램을 종료합니다.");
			run = false;
			break;
			default:
				System.out.println("다시 선택해주세요.");
				break;
			}
		}
	}
}