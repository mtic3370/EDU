package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class MySQLRealtimeSearch extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//서블릿에서 폼값 한글 처리
		req.setCharacterEncoding("UTF-8");
		//서블릿에서 즉시 컨텐츠를 출력할 경우 한글처리
		resp.setContentType("text/html;charset=utf-8;");
		
		String searchName = 
			req.getParameter("searchName");
		//resp.getWriter().write("검색어:"+searchName);
		
			
		//검색어를 파라미터로 DAO호출후 JSON출력을 담당
		//하는 메소드 호출
		String resultJSON = getJSON(searchName);
		
		//화면상에 출력
		resp.getWriter().write(resultJSON);
	}
	
	public String getJSON(String searchName) {
		
		//JSON배열을 만들기 위한 선언
		JSONArray jsonArr = new JSONArray();
		
		//dao에서 회원정보 검색후 결과 반환
		MysqlDAO dao = new MysqlDAO();
		List<MemberDTO> members = 
				dao.searchName(searchName);
		
		for(MemberDTO m : members) {
			JSONObject jsonObj = new JSONObject();
			
			jsonObj.put("id", m.getId());
			jsonObj.put("pass", m.getPass());
			jsonObj.put("name", m.getName());
			jsonObj.put("regidate", m.getRegidate());
			
			jsonArr.add(jsonObj);
		}
		return jsonArr.toString();
	}
}
