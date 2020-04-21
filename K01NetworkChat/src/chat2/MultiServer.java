package chat2;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;

public class MultiServer {

	public static void main(String[] args) {
		
		ServerSocket serverSocket = null;
		Socket socket = null;
		PrintWriter out = null;
		BufferedReader in = null;
		String s = "";
		String name = ""; //클라이언트로부터 받은 이름을 저장할 변수
		
		try {
			//9999번 port로 설정해 서버를 생성후 클라이언트의 접속을 대기...
			serverSocket = new ServerSocket(9999);
			System.out.println("서버가 시작되었습니다.");
			
			/////......접속 대기중.......
			
			//클라이언트 접속요청이 있으면 받아 들인다.
			socket = serverSocket.accept();
			//System.out.println(socket.getInetAddress() +":"+ socket.getPort());
			
			//서버->클라이언트 측으로 전송(출력)하기 위한 준비
			out = new PrintWriter(socket.getOutputStream(), true);
			//클라이언트로부터의 입력을 받기위한 준비...
			in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
			
			/*
			 클라이언트가 서버로 전송하는 최초의 메세지는 "대화명"임으로 메세지를 읽은후
			 변수에 저장하고 클라잉언트쪽으로 Echo해준다.
			 */
			if(in != null) {
				name = in.readLine();
				System.out.println(name +" 접속");
				out.println("> "+ name +"님이 접속했습니다.");
			}
						
			/*
			두번째 메세지부터는 실제 대화 내용임으로 읽어와서 로그로 출력하고 동시에 클라이언트로 Echo한다.
			*/
			while(in != null) {
				s = in.readLine();
				if(s==null) {
					break;
				}
				//클라이언트가 입력한 메세지 출력
				System.out.println(name +" ==> "+ s);
				//클라이언트로 echo 함
				out.println(">  "+ name +" ==> "+ s);			
			}
			
			System.out.println("Bye...!!!");
		}
		catch (Exception e) {
			System.out.println("예외1:"+ e);
			//e.printStackTrace();
		}
		finally {
			try {
				in.close();
				out.close();
				socket.close();
				serverSocket.close();
			}
			catch (Exception e) {
				System.out.println("예외2:"+ e);
				//e.printStackTrace();
			}
		}
	}
}