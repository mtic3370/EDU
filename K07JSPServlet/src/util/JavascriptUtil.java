package util;

import javax.servlet.jsp.JspWriter;

public class JavascriptUtil {
	
	//문자열만 반환하고 JSP페이지에서 출력하는 방식
	public static String jsAlertLocation(String msg, String url) {		
		String str = ""
				+ "<script>"
				+ "  alert('"+msg+"');  "
				+ "  location.href='"+url+"';  "
				+ "</script>";
			
		return str;
	}
	public static String jsAlertBack(String msg) {
		
		String str = ""
				+ "<script>"
				+ "  alert('"+msg+"');  "
				+ "  history.back(); "
				+ "</script>";
		return str;
	}	
	
	//출력까지 처리하는 방식 : JSP페이지에서 out내장객체를 매개변수로 전달한후
	//		해당 메소드에서는 JspWriter타입으로 받은후 문자열을 출력한다.
	public static void jsAlertLocation(String msg,
			String url, JspWriter out) {
		try {
			String str = ""
					+ "<script>"
					+ "  alert('"+msg+"');  "
					+ "  location.href='"+url+"';  "
					+ "</script>";
			out.println(str);
		}
		catch(Exception e) {}
	}
	public static void jsAlertBack(String msg, JspWriter out) {
		try {
			String str = ""
					+ "<script>"
					+ "  alert('"+msg+"');  "
					+ "  history.back(); "
					+ "</script>";
			out.println(str);
		}
		catch(Exception e) {}
	}
}
