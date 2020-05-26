package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;
import java.util.concurrent.ExecutionException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

 

public class OracleDAO {

	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	//커넥션풀을 통한 DB연결
	public OracleDAO() {		
		try {
			Context ctx = new InitialContext();
 
			DataSource source = 
			  (DataSource)
			  ctx.lookup("java:comp/env/jdbc/myoracle");
			
			con = source.getConnection();
			System.out.println("DBCP연결성공");
		}
		catch(Exception e) {
			System.out.println("DBCP연결실패");
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
		
		//쿼리문
		String sql = "SELECT * FROM member "
			+ " WHERE name LIKE ? "
			+ " ORDER BY name ASC";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1,"%"+userName+"%");
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







