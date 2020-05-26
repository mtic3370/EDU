package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NaverSearchAPI_Old extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, 
			HttpServletResponse resp) throws ServletException, IOException {
		
		String clientId = "5xH68oEyTMVhBKZEBC3I";//애플리케이션 클라이언트 아이디값";
        String clientSecret = "YXV6TEwPDR";//애플리케이션 클라이언트 시크릿값";
        
        //네이버에서 반환해주는 결과값을 저장하기 위한변수
        String returnVal = "";
        
        //검색API의 검색결과 시작번호
        int startNum = 
        	Integer.parseInt(req.getParameter("startNum"));
                
        try 
        {
            
        	String searchTxt = req.getParameter("keyword");
        	String text = URLEncoder.encode(searchTxt, "UTF-8");
        	
        	
            String apiURL = "https://openapi.naver.com/v1/search/blog?query="+ text +"&start="+ startNum +"&display=20"; // json 결과
            //String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // xml 결과
            
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            System.out.println(response.toString());
            
            //try문 밖에서 사용하기 위해 저장
            returnVal = response.toString();
        } 
        catch (Exception e) 
        {
            System.out.println(e);
        }
        
        //네이버에서 반환한 응답데이터를 화면에 즉시출력하기
        resp.setContentType("text/html; charset=utf-8;");
		resp.getWriter().write(returnVal);
	}	
}


/*
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class APIExamSearchBlog {

    public static void main(String[] args) {
        
    }
}

*/