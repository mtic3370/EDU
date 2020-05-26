package controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

public class MysqlDAO {

	Connection con;
	PreparedStatement psmt;
	ResultSet rs;	
	
	public MysqlDAO()
	{
		try {
			String url = 
			"jdbc:mysql://localhost:3306/kosmo_db?characterEncoding=UTF-8";
			String id = "kosmo_user";
			String pw = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(url, id, pw);
			System.out.println("MySQL연결성공");
		}
		catch(Exception e) {
			System.out.println("MySQL연결실패");
			e.printStackTrace();
		}
	}
	
	//자원반납하기
	public void close() {
		try {
			if(rs!=null) rs.close();
			if(psmt!=null) psmt.close();
			if(con!=null) con.close();
		}
		catch(Exception e) {
			System.out.println("자원반납시 예외발생");
			e.printStackTrace();
		}
	}
	
	//회원아이디,패스워드를 통한 검증
	public boolean isMember(String id, String pass) {
		
		String sql = "SELECT COUNT(*) FROM member"
				+ " WHERE id=? AND pass=?";
		int isMember = 0;
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, pass);
			rs = psmt.executeQuery();
			rs.next();
			isMember = rs.getInt(1);
			System.out.println("affected:"+isMember);
			if(isMember==0) return false;
		}
		catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;		
	}
	
	//실시간 회원검색 구현하기
	public List<MemberDTO> searchName(String userName)
	{		
		List<MemberDTO> member = 
			new Vector<MemberDTO>();
		
		//비즈니즈 로직
		/*
		연습문제] 사용자가 입력한 검색어를 통해서 
		member테이블의 name컬럼을 검색하는 함수를 
		정의하시오. 검색된 결과는 List타입의 컬렉션에
		저장되어 서블릿으로 반환된다. 
		
		쿼리문 : 
		select * from member where name like '%볼%';
		*/
		
		String whereStr = "";
		
		//초성검색 추가부분
		if(userName.equals("ㄱ")){ 
			whereStr = " and id!=? and (name RLIKE '^(ㄱ|ㄲ)' OR ( name >= '가' AND name < '나' )) "; 
		}
		else if(userName.equals("ㄴ")){ 
			whereStr = " and id!=? and (name RLIKE '^ㄴ' OR ( name >= '나' AND name < '다' )) "; 
		}
		else if(userName.equals("ㄷ")){ 
			whereStr = " and id!=? and (name RLIKE '^(ㄷ|ㄸ)' OR ( name >= '다' AND name < '라' )) "; 
		}
		else if(userName.equals("ㄹ")){ 
			whereStr = " and id!=? and (name RLIKE '^ㄹ' OR ( name >= '라' AND name < '마' )) "; 
		}
		else if(userName.equals("ㅁ")){ 
			whereStr = " and id!=? and (name RLIKE '^ㅁ' OR ( name >= '마' AND name < '바' )) "; 
		}
		else if(userName.equals("ㅂ")){ 
			whereStr = " and id!=? and (name RLIKE '^ㅂ' OR ( name >= '바' AND name < '사' )) "; 
		}
		else if(userName.equals("ㅅ")){ 
			whereStr = " and id!=? and (name RLIKE '^(ㅅ|ㅆ)' OR ( name >= '사' AND name < '아' )) "; 
		}
		else if(userName.equals("ㅇ")){ 
			whereStr = " and id!=? and (name RLIKE '^ㅇ' OR ( name >= '아' AND name < '자' )) "; 
		}
		else if(userName.equals("ㅈ")){ 
			whereStr = " and id!=? and (name RLIKE '^(ㅈ|ㅉ)' OR ( name >= '자' AND name < '차' )) "; 
		}
		else if(userName.equals("ㅌ")){ 
			whereStr = " and id!=? and (name RLIKE '^ㅊ' OR ( name >= '차' AND name < '카' )) "; 
		}
		else if(userName.equals("ㅋ")){ 
			whereStr = " and id!=? and (name RLIKE '^ㅋ' OR ( name >= '카' AND name < '타' )) "; 
		}
		else if(userName.equals("ㅌ")){ 
			whereStr = " and id!=? and (name RLIKE '^ㅌ' OR ( name >= '타' AND name < '파' )) "; 
		}
		else if(userName.equals("ㅍ")){ 
			whereStr = " and id!=? and (name RLIKE '^ㅍ' OR ( name >= '파' AND name < '하' )) "; 
		}
		else if(userName.equals("ㅎ")){ 
			whereStr = " and id!=? and (name RLIKE '^ㅎ' OR ( name >= '하')) "; 
		}
		else {
			whereStr = " and name LIKE ? ";
		}
		
		
		//쿼리문
		String sql = "SELECT * FROM member "
			+ " WHERE 1=1 "+ whereStr
			+ " ORDER BY name ASC";
		System.out.println(sql);
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1,"%"+userName+"%");
			//psmt.setString(1,userName);
			rs = psmt.executeQuery();
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				
				dto.setId(rs.getString(1));
				dto.setPass(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setRegidate(rs.getString(4));
				
				member.add(dto);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}		
		
		return member;
	}
	
}





