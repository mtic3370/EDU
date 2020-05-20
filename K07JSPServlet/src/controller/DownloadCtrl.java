package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.FileUtil;

public class DownloadCtrl extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String filename = req.getParameter("filename");
		String idx = req.getParameter("idx");
		
		//FileUtil.download(req, resp, "/Upload", filename, "원본파일명.jpg");
		FileUtil.download(req, resp, "/Upload", filename, filename);
		
		DataroomDAO dao = new DataroomDAO();
		dao.downCountPlus(idx);
		dao.close();
		
	}
	
}