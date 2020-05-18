package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DataroomDAO {
	
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	public DataroomDAO() {
		try {
			Context initCtx = new InitialContext();
			
			/*
			Context ctx = (Context)initCtx.lookup("java:comp/env"); 
			DataSource source = (DataSource)ctx.lookup("jdbc/myoracle");
			*/
			//위 2줄의 소스를 아래 한줄로 병합할수 있다. 
			DataSource source = 
				(DataSource)initCtx.lookup("java:comp/env/jdbc/myoracle");
						
			con = source.getConnection();
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

	//게시판테이블의 전체 레코드 갯수 얻기
	public int getTotalRecordCount(Map map)
	{
		int totalCount = 0;
		try{
			String sql = "SELECT COUNT(*) FROM dataroom ";
			if(map.get("Word")!=null){
				sql +=" WHERE "+map.get("Column")+" "
					+ " LIKE '%"+map.get("Word")+"%' ";
			}

			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			rs.next();
			totalCount = rs.getInt(1);
		}
		catch(Exception e){}
		return totalCount;
	}

	//게시물 리스트 출력하기(list)
	public List<DataroomDTO> selectList(Map map)
	{
		//1.결과 레코드셋을 담기위한 컬렉션 생성
		List<DataroomDTO> bbs = new Vector<DataroomDTO>();

		//2.게시물을 가져오기 위한 쿼리작성
		String sql = "SELECT * FROM dataroom ";
		if(map.get("Word")!=null){
			sql +=" WHERE "+map.get("Column")+" "
				+ " LIKE '%"+map.get("Word")+"%' ";
		}
		sql += " ORDER BY idx DESC";

		try{
			//3.prepare 객체생성 및 실행
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next())
			{
				//4.결과셋을 DTO객체에 담는다.
				DataroomDTO dto = new DataroomDTO();

				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setAttachedfile(rs.getString(6));
				dto.setDowncount(rs.getInt(7));
				dto.setPass(rs.getString(8));
				dto.setVisitcount(rs.getInt(9));

				//5.DTO객체를 컬렉션에 추가한다.
				bbs.add(dto);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		//6.DTO객체를 담은 List컬렉션을 반환
		return bbs;
	}
	
	
	//게시물 읽기(view)
	public DataroomDTO selectView(String idx)
	{
		DataroomDTO dto = null;

		String sql = "SELECT * FROM dataroom "
			+ " WHERE idx=?";
		try{
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			rs = psmt.executeQuery();
			if(rs.next()){
				dto = new DataroomDTO();

				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setAttachedfile(rs.getString(6));
				dto.setDowncount(rs.getInt(7));
				dto.setPass(rs.getString(8));
				dto.setVisitcount(rs.getInt(9));//조회수추가
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}

		return dto;
	}
	//게시물 조회수 증가시키기
	public void updateVisitCount(String idx)
	{
		String sql = "UPDATE dataroom SET "
			+ " visitcount=visitcount+1 "
			+ " WHERE idx=? ";
		try{
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			psmt.executeUpdate();
		}
		catch(Exception e){}
	}
	
	
	public int insert(DataroomDTO dto)
	{
		int affected = 0;//적용된 행의갯수
		try{
			String sql = "INSERT INTO dataroom ("
				+ " idx,title,name,content,attachedfile,pass,downcount) "
				+ " VALUES ("
				+ " SEQ_BBS_NUM.NEXTVAL,?,?,?,?,?,0)";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getAttachedfile());
			psmt.setString(5, dto.getPass());

			affected = psmt.executeUpdate();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return affected;
	}
	
	
	public boolean isCorrectPassword(String pass, String idx) {
		boolean isCorr = true;
		try {
			String sql = "SELECT COUNT(*) FROM dataroom "
					+ " WHERE pass=? AND idx=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, pass);
			psmt.setString(2, idx);
			rs = psmt.executeQuery();
			rs.next();
			if(rs.getInt(1)==0) {
				/*
				만약 만족하는 레코드가 없다면 false반환
				 */
				isCorr = false;
			}
		}
		catch(Exception e) {
			isCorr = false;
			e.printStackTrace();
		}
		return isCorr;
	}
	
	
	public int update(DataroomDTO dto) {
		int affected = 0;
		try {
			String query = "UPDATE dataroom SET"
					+ " title=?, name=?, content=? " 
					+ " , attachedfile=? "
					+ " WHERE idx=?";

			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getAttachedfile());			

			//게시물수정을 위한 추가부분
			psmt.setString(5, dto.getIdx());

			affected = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("update중 예외발생");
			e.printStackTrace();
		}

		return affected;
	}

	public int delete(String idx) {
		int affected = 0;
		try {
			String query = "DELETE FROM dataroom "
					+ " WHERE idx=?";

			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);

			affected = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("delete중 예외발생");
			e.printStackTrace();
		}

		return affected;
	}
	
/*	public List<DataroomDTO> selectListPage(Map map)
	{
		List<DataroomDTO> bbs = new Vector<DataroomDTO>();

		String sql = ""
			+"SELECT * FROM ("
			+"    SELECT Tb.*, rownum rNum FROM ("
			+"        SELECT * FROM dataroom ";

		if(map.get("Word")!=null){
			sql +=" WHERE "+map.get("Column")+" "
				+ " LIKE '%"+map.get("Word")+"%' ";
		}
		sql += " ORDER BY idx DESC"
		+"    ) Tb"
		+")"
		+" WHERE rNum BETWEEN ? and ?";

		System.out.println("쿼리문:"+sql);

		try{
			//3.prepare 객체생성 및 실행
			psmt = con.prepareStatement(sql);

			psmt.setInt(1,
				Integer.parseInt(map.get("start").toString()));
			psmt.setInt(2,
				Integer.parseInt(map.get("end").toString()));

			rs = psmt.executeQuery();
			while(rs.next())
			{
				//4.결과셋을 DTO객체에 담는다.
				DataroomDTO dto = new DataroomDTO();

				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setAttachedfile(rs.getString(6));
				dto.setDowncount(rs.getInt(7));
				dto.setPass(rs.getString(8));
				dto.setVisitcount(rs.getInt(9));

				bbs.add(dto);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}

		return bbs;
	}
	
	//페이지처리O, 답변글처리O
	public List<DataroomDTO> selectListPageReply(Map map)
	{
		List<DataroomDTO> bbs = new Vector<DataroomDTO>();
		
		String sql = ""
				+"SELECT * FROM ("
				+"    SELECT Tb.*, rownum rNum FROM ("
				+"        SELECT * FROM dataroom ";
		
		if(map.get("Word")!=null){
			sql +=" WHERE "+map.get("Column")+" "
					+ " LIKE '%"+map.get("Word")+"%' ";
		}
				 
			
			답변글 기능 있는경우 정렬
				그룹번호를 내림차순으로 1차정렬
				bstep 컬럼을 통해 오름차순으로 2차정렬
			 
			sql += " ORDER BY bgroup DESC, bstep ASC"
					
				+"    ) Tb"
				+")"
				+" WHERE rNum BETWEEN ? and ?";
		
		System.out.println("쿼리문:"+sql);
		
		try{
			//3.prepare 객체생성 및 실행
			psmt = con.prepareStatement(sql);
			
			psmt.setInt(1,
					Integer.parseInt(map.get("start").toString()));
			psmt.setInt(2,
					Integer.parseInt(map.get("end").toString()));
			
			rs = psmt.executeQuery();
			while(rs.next())
			{
				//4.결과셋을 DTO객체에 담는다.
				DataroomDTO dto = new DataroomDTO();

				 답변글 처리를 위한 로직 추가 부분 s
				int indentNum = rs.getInt(12);			
				String spacer = "";			
				dto.setBgroup(rs.getInt(10));
				dto.setBstep(rs.getInt(11));
				dto.setBindent(indentNum);				
				if(indentNum>0) {					
					for(int i=1 ; i<=indentNum ; i++) {						
						spacer += "&nbsp;&nbsp;";
					}					
					spacer += spacer+"<img src='../images/re2.gif'>";
				}
				 답변글 처리를 위한 로직 추가 부분 e
				
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));				
				//위에서 추가한 아이콘을 제목앞에 연결함
				dto.setTitle(spacer + rs.getString(3));
				
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setAttachedfile(rs.getString(6));
				dto.setDowncount(rs.getInt(7));
				dto.setPass(rs.getString(8));
				dto.setVisitcount(rs.getInt(9));
				
				bbs.add(dto);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		return bbs;
	}
	
	//답변형게시판 글쓰기 처리(컬럼3개 추가됨)
	public int insertReply(DataroomDTO dto)
	{
		int affected = 0;//적용된 행의갯수
		try{
			
			답변글 처리를 위한 컬럼 추가
			:  답변형 게시판에서 원글의 경우에는 일련번호와 동일한 
				그룹번호를 부여하게 된다. 즉 idx에 입력될 값과 동일한
				값을 bgroup에 입력한다. bstep, bindent는 0을 입력한다. 
				
			※NextVal의 경우 현재 시퀀스에 +1 처리한 값을 반환하지만, 
			하나의 문장내에서 실행하게되면 동일한 값을 반환한다. 
			 
			String sql = "INSERT INTO dataroom ("
				+ " idx,title,name,content,attachedfile,pass,downcount, "
				+ " bgroup, bstep, bindent) "
				+ " VALUES ("
				+ " SEQ_BBS_NUM.NEXTVAL,?,?,?,?,?,0,"
				+ " SEQ_BBS_NUM.NEXTVAL,0,0)";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getAttachedfile());
			psmt.setString(5, dto.getPass());

			affected = psmt.executeUpdate();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return affected;
	}
	
	//답변형 게시판 상세보기 및 답변글달기에서 사용
	public DataroomDTO selectViewReply(String idx)
	{
		DataroomDTO dto = null;

		String sql = "SELECT * FROM dataroom "
			+ " WHERE idx=?";
		try{
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			rs = psmt.executeQuery();
			if(rs.next()){
				dto = new DataroomDTO();

				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setAttachedfile(rs.getString(6));
				dto.setDowncount(rs.getInt(7));
				dto.setPass(rs.getString(8));
				dto.setVisitcount(rs.getInt(9));//조회수추가
				
				//답변글 추가하기
				dto.setBgroup(rs.getInt("bgroup"));
				dto.setBstep(rs.getInt("bstep"));
				dto.setBindent(rs.getInt("bindent"));
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}

		return dto;
	}
	
	public int reply(DataroomDTO dto)
	{		
		
		답변글을 입력하기전에 내가 부여받은 step과 같거나 큰 번호가 
		이미 있다면 +1해서 뒤로 밀어준다.
		 
		replyStepUpdate(dto.getBgroup(), dto.getBstep());		
		
		int affected = 0;//적용된 행의갯수
		try{			
			String sql = "INSERT INTO dataroom ("
				+ " idx,title,name,content,attachedfile,pass,downcount "
				+ " ,bgroup, bstep, bindent) "
				+ " VALUES ("
				+ " SEQ_BBS_NUM.NEXTVAL,?,?,?,?,?,0,"
				+ "	?,?,?)";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getAttachedfile());
			psmt.setString(5, dto.getPass());
			
			답변형게시판은 원글의 경우 일련번호(idx)와 bgroup(그룹번호)
			는 항상 동일한 값을 가진다. 
			답변글인 경우 원글의 bgroup 번호를 동일하게 부여받는다. 
			정렬(bstep)과 bindent(깊이,들여쓰기)는 원본글에서 +1 값을
			부여받는다.
			 
			psmt.setInt(6, dto.getBgroup());
			psmt.setInt(7, dto.getBstep()+1);
			psmt.setInt(8, dto.getBindent()+1);

			affected = psmt.executeUpdate();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		return affected;
	}
	
	//답변글 입력전 해당 그룹내 레코드 일괄 업데이트
	public void replyStepUpdate(int groupNum, int stepNum) {
		try {
			String sql = "UPDATE dataroom "
				+ " SET bstep=bstep+1 "
				+ " WHERE bgroup=? AND bstep>?";

			psmt = con.prepareStatement(sql);
			psmt.setInt(1, groupNum);
			psmt.setInt(2, stepNum);
			psmt.executeUpdate();
		}
		catch(Exception e) {
			e.printStackTrace();

		}
	}
	
	//파일 다운로드 수 증가
	public void downCountPlus(String idx){
		String sql = "UPDATE dataroom SET "
			+ " downcount=downcount+1 "
			+ " WHERE idx=? ";
		try{
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			psmt.executeUpdate();
		}
		catch(Exception e){}
	}*/	
}