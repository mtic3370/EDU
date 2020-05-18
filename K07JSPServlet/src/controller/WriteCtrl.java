package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.oreilly.servlet.MultipartRequest;
import util.FileUtil;



public class WriteCtrl extends HttpServlet {

	/*
	글쓰기 페이지의 경우
		doGet()메소드는 글쓰기 폼으로 이동할때의 요청을 처리하고
		doPost()메소드는 글쓰기를 완료할때의 요청을 처리한다.
	 */
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		/*
		글쓰기 페이지로 진입하는 경우 JSP페이지와 매핑만 시켜주면 된다.
		 */
		req.getRequestDispatcher("/14Dataroom/DataWrite.jsp")
			.forward(req, resp);
	}
	
	//게시물 내용 작성후 submit했을때 요청을 처리함.
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//글쓰기 관련 폼값에 대한 한글처리
		req.setCharacterEncoding("UTF-8");
		
		//해당 메소드는 MultipartRequest객체를 생성하면서 파일업로드를 처리한다.
		
		MultipartRequest mr = FileUtil.upload(req,
			req.getServletContext().getRealPath("/Upload"));
		
		int sucOrFail;
		
		if(mr != null){
			
			/*파일업로드를 위해 나머지 폼값을 받기 위해 MR참조 변수를 이용한다.
			 enctype을 "multipart/form-data"로 설정했으므로
			폼값은 request객체가 아닌 MultipartRequest객체를 통해서 
			받아야 한다. 
			*/ 
			String name = mr.getParameter("name");
			String title = mr.getParameter("title");
			String pass = mr.getParameter("pass");
			String content = mr.getParameter("content");
			//서버에 저장된 실제파일명을 가져온다. 
			String attachedfile = mr.getFilesystemName("attachedfile");
			
			System.out.println(attachedfile);
			//DTO객체에 폼값 저장
			DataroomDTO dto = new DataroomDTO();
			dto.setAttachedfile(attachedfile);
			dto.setContent(content);
			dto.setTitle(title);
			dto.setName(name);
			dto.setPass(pass);
			
			//DAO객체 생성 및 DB연결...insert처리
			DataroomDAO dao = new DataroomDAO();
			
			//파일첨부형 게시판 구현시 사용(답변글X)
			//sucOrFail = dao.insert(dto);
			//파일첨부형 + 답변형 게시판 구현시 사용
			sucOrFail = dao.insert(dto);
			dao.close();
		}
		else{
			
			//mr객체가 생성되지 않았을때(업로드 실패시)
			sucOrFail = -1;
		}
		
		if(sucOrFail==1){
			
			//파일 업로드 성공 및 글쓰기 성공일때
			//글쓰기와 파일업로드를 성공했을때는 게시판 리스트로 이동
//			req.getRequestDispatcher("/DataRoom/DataList")
//				.forward(req,resp);
			
			
			/*post로 요청된 상태에서 forward를 걸게되면 해당페이지에서 
			새로고침 하는경우 폼값을 다시 전송할지 물어보게 되므로
			여러번 전송되는 문제가 발생할수 있다. 이런 경우에는 
			새로운 페이지에 요청을 위해 redirect하는것이 좋다.  
			 */
			resp.sendRedirect("../DataRoom/DataList");
		}
		else{
			//실패했을때는 다시 글쓰기 페이지로 돌아감.
			req.getRequestDispatcher("/14Dataroom/DataWrite.jsp")
				.forward(req,resp);
		}
	}
	
}