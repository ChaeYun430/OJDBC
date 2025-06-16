package test2_250613.sv;

import java.sql.SQLException;
import java.util.Scanner;

import test2_250613.dao.MemberDAO;
import test2_250613.dto.MemberDTO;

public class MemberMenuSV {
	static MemberDAO memberDAO = new MemberDAO();
	static Scanner scStr = new Scanner(System.in);

	// 1. userMenu method
	static public void userMenu(MemberDTO session) throws SQLException {
		boolean run = true;
		while (run) {
			String[] UserMenu = { "1. 내 회원 정보 조회", "2. 회원 정보 수정", "3. 계정 상태 전환", "4. 로그아웃" };
			for (int i = 0; i < UserMenu.length; i++) {
				System.out.println(UserMenu[i]);
			}
			System.out.print(">>>");
			String select = scStr.next();
			switch (select) {
			case "1":
				if (!session.getActive().equals("ACTIVE")) {
					System.out.println("계정 상태를 변경해주세요");
					break;
				}
				memberDAO.readOne(session);
				break;
			case "2":
				if (!session.getActive().equals("ACTIVE")) {
					System.out.println("계정 상태를 변경해주세요");
					break;
				}
				MemberSV.update(session);
				break;
			case "3":
				accountStateMenu(session);
				break;
			case "4":
				System.out.println("로그아웃되었습니다.");
				run = false;
				break;
			default:
				System.out.println("다시 선택해주세요.");
				break;
			}
		}
	}

	// 2. adminMenu method
	static public void adminMenu(MemberDTO session) throws SQLException {
		boolean run = true;
		while (run) {
			String[] adminMenu = { "1. 전체 회원 정보 조회", "2. 회원 정보 조회", "3. 로그아웃" };
			for (int i = 0; i < adminMenu.length; i++) {
				System.out.println(adminMenu[i]);
			}
			System.out.print(">>>");
			String select = scStr.next();
			switch (select) {
			case "1":
				memberDAO.readAll();
				break;
			case "2":
				System.out.println();
				memberDAO.readOne(session);
				break;
			case "3":
				System.out.println("로그아웃되었습니다.");
				run = false;
				break;
			default:
				System.out.println("다시 선택해주세요.");
				break;
			}
		}
	}

	// 3. accountStateMenu method
	private static void accountStateMenu(MemberDTO session) throws SQLException {
		String[] UserMenu = { "1. 계정 활성화", "2. 계정 비활성화", "3. 계정 탈퇴", "4. 계정관리 종료" };
		for (int i = 0; i < UserMenu.length; i++) {
			System.out.println(UserMenu[i]);
		}
		System.out.print(">>>");
		memberDAO.accountState(session, scStr.next());

	}
}