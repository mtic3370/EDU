package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import util.FileUtil;

public class EditCtrl extends HttpServlet {
	
	/*
	 수정폼으로 진입할때는 doGet(), 수정완료시 doPost() 메소드가 처리함.
	 */
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//수정페이지 띄워주기
		String idx = req.getParameter("idx");
		
		ServletContext app = this.getServletContext();				
		DataroomDAO dao = new DataroomDAO(app);
		
		//전달된 일련번호에 해당하는 레코드를 가져와서 dto객체에 저장
		DataroomDTO dto = dao.selectView(idx);
		//request영역에 속성 저장
		req.setAttribute("dto", dto);
		
		req.getRequestDispatcher("/14Dataroom/DataEdit.jsp").forward(req, resp);
	}

	
	//수정폼을 입력한후 submit했을때 수정 및 파일업로드 처리
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		MultipartRequest mr = FileUtil.upload(req,
			req.getServletContext().getRealPath("/Upload"));
		
		int sucOrFail;
		//MultipartRequest객체가 정상적으로 생성되면 나머지 폼값을 받아온다.
		if(mr != null){
			String idx = mr.getParameter("idx");
			String nowPage = mr.getParameter("nowPage");
			String originalfile = mr.getParameter("originalfile");
			
			//수정처리후 상세보기로 이동하므로 영역에 속성을 저장한다. 
			req.setAttribute("idx", idx);
			req.setAttribute("nowPage", nowPage);
			
			String name = mr.getParameter("name");
			String title = mr.getParameter("title");
			String content = mr.getParameter("content");
			String pass = mr.getParameter("pass");	
			
			/*
			만약 수정폼에서 첨부한 파일이 있다면 기존 파일은 삭제해야하고 확인후 만약 없다면 기존파일명으로 유지함.
			 */
			String attachedfile = mr.getFilesystemName("attachedfile");
			if(attachedfile==null) {
				attachedfile = originalfile;
			}
			
			//폼값을 dto객체에 저장
			DataroomDTO dto = new DataroomDTO();
			dto.setAttachedfile(attachedfile);
			dto.setContent(content);
			dto.setTitle(title);
			dto.setName(name);
			dto.setPass(pass);
			//게시물 수정을 위한 idx 세팅
			dto.setIdx(idx);

			//DB처리(update)
			ServletContext app = this.getServletContext();				
			DataroomDAO dao = new DataroomDAO(app);
			sucOrFail = dao.update(dto);
			
			//레코드의 업데이트가 성공이고, 동시에 개로운 파일을 업로드 완료했다면 기존의 파일은 삭제처리
			//첨부한 파일이 없으면 기존 파일 유지
			if(sucOrFail==1 && mr.getFilesystemName("attachedfile")!=null)
			{
				FileUtil.deleteFile(req, "/Upload", originalfile);
			}
			
			dao.close();
		}
		else{
			//MultipartRequest객체가 생성되지 않았다면 파일 업로드 실패로 처리
			sucOrFail = -1;
		}
		
		//리퀘스트영역에 메세지 출력을 위한 저장
		req.setAttribute("SUC_FAIL", sucOrFail);
		req.setAttribute("WHEREIS", "UPDATE");
						
		req.getRequestDispatcher("/14Dataroom/Message.jsp")
			.forward(req, resp);
		
	}
}