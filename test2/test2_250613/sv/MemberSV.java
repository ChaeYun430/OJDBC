package test2_250613.sv;

import java.sql.SQLException;
import java.util.Scanner;

import test2_250613.dao.MemberDAO;
import test2_250613.dto.MemberDTO;

public class MemberSV {
	static MemberDAO memberDAO = new MemberDAO();
	static MemberDTO mem;
	static Scanner scStr = new Scanner(System.in);

	// -1. login method
	static public MemberDTO login(MemberDTO session) throws SQLException {
		session = new MemberDTO();
		System.out.print("아이디: ");
		session.setId(scStr.next());
		System.out.print("비밀번호: ");
		session.setPw(scStr.next());
		session = memberDAO.login(session);
		if (session == null) {
			System.out.println("로그인에 실패했습니다.");
			return null;
		}
		System.out.println("로그인이 완료되었습니다.");
		return session;
	}

	// 0. searchOne method
	public void searchOne() throws SQLException {
		mem = new MemberDTO(); // 읽기용 개체
		System.out.println("찾으시는 회원의 아이디 또는 닉네임을 입력해주세요.");
		mem.setId(scStr.next());
		System.out.println("비밀번호를 입력해주세요.");
		mem.setPw(scStr.next());
		memberDAO.readOne(mem);
	}

	// 1. insert method
	static public void insert() throws SQLException {
		System.out.print("닉네임:	");
		String nick = scStr.next();
		System.out.print("이메일 주소:	"); // 계정 연동이므로 함부로 못 바꿈
		String eAdress = scStr.next();
		System.out.print("아이디:	");
		String id = scStr.next();
		mem = new MemberDTO(id, nick, eAdress); // 회원가입용 개체
		boolean emailId = memberDAO.emailIdCheck(mem);
		if (!emailId) {
			System.out.println("회원가입에 실패했습니다.");
			return;
		}
		//이메일, 아이디 확인 통과 후 실행
		System.out.print("비밀번호: ");
		mem.insertPw(scStr.next(), scStr); //비밀번호 확인 코드
		if (mem.getPw() == null) {
			System.out.println("회원가입에 실패했습니다.");
			return;
		}
		memberDAO.insert(mem);
	}

	// 2. update method
	static public void update(MemberDTO session) throws SQLException {
		boolean run = true;
		while (run) {
			System.out.println("변경하실 항목을 선택해주세요.");
			String[] Menu = { "1. 아이디", "2. 비밀번호", "3. 닉네임", "4. 회원정보 수정 종료" };
			for (int i = 0; i < Menu.length; i++) {
				System.out.println(Menu[i]);
			}
			System.out.print(">>>");
			String select = scStr.next();
			switch (select) {
			case "1":
				System.out.println("설정하실 아이디를 입력하세요.");
				System.out.print(">>>");
				session.setId(scStr.next());
				memberDAO.update(session);
				break;
			case "2":
				System.out.println("설정하실 비밀번호를 입력하세요.");
				System.out.print(">>>");
				session.insertPw(scStr.next(), scStr);
				memberDAO.update(session);
				break;
			case "3":
				System.out.println("설정하실 닉네임을 입력하세요.");
				System.out.print(">>>");
				session.setNick(scStr.next());
				memberDAO.update(session);
				break;
			case "4":
				System.out.println("회원정보 수정을 종료합니다.");
				run = false;
				break;
			default:
				System.out.println("다시 선택해주세요.");
				break;
			}
		}
	}
}
