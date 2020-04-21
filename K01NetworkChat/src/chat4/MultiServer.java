package chat4;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;

public class MultiServer {
		
	static ServerSocket serverSocket = null;
	static Socket socket = null;
	static PrintWriter out = null;
	static BufferedReader in = null;
	static String s = "";
	
	//생성자
	public MultiServer() {
		//실행부없음
	}
	
	//서버의 초기화를 담당할 메소드
	public static void init() {
		
		String name = ""; //클라이언트로부터 전송받은 이름을 저장할 변수
		
		try {
			//9999번를 열고 클라이언트의 접속을 대기...
			serverSocket = new ServerSocket(9999);
			System.out.println("서버가 시작되었습니다.");
			
			////.....접속 대기중.....
			
			//클라이언트 접속요청을 받아 들인다.
			socket = serverSocket.accept();
			System.out.println(socket.getInetAddress() +":"+ socket.getPort());
			
			//서버로의 출력을 위한 준비...(OutputStream)
			out = new PrintWriter(socket.getOutputStream(), true);
			//클라이언트로부터의 입력을 받기위한 준비...(inputStream)
			in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
			
			//최초 올라오는 메시지는 사용자 이름임
			if(in != null) {
				name = in.readLine();
				//이름을 콘솔에 출력
				System.out.println(name +" 접속");
				//클랄이언트로 Echo해 준다.
				out.println("> "+ name +"님이 접속했습니다.");
			}
						
			while(in != null) {
				//클라이언트가 보낸 메세지를 계속해서 읽어옴
				s = in.readLine();
				if(s==null) {
					break;
				}
				//읽어온 메세지를 콘솔에 출력하고....
				System.out.println(name +" ==> "+ s);	
				//클라이언트에게 Echo해 준다.
				sendAllMsg(name, s);
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
	
	//서버가 클라이언트에게 메세지를 Echo해 주는 메소드
	public static void sendAllMsg(String name, String msg) {
		try {
			out.println(">  "+ name +" ==> "+ msg);
		}
		catch (Exception e) {
			System.out.println("예외:"+ e);
		}
	}
	
	public static void main(String[] args) {
		init();
	}		
}