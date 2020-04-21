package chat2;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

public class MultiClient {

	public static void main(String[] args) {
		
		System.out.print("이름을 입력하세요:");
		Scanner scanner = new Scanner(System.in);
		String s_name = scanner.nextLine();

		PrintWriter out = null;
		BufferedReader in = null;
		
		try {
			//localhost대신 127.0.0.1로 접속해도 무방하다.
			String ServerIP = "localhost";
			//클라이언트 실행시 매개변수가 있는경우 아이피 설정
			if(args.length > 0) {
				ServerIP = args[0];
			}
			//소켓 객체 생성
			Socket socket = new Socket(ServerIP, 9999);			
			System.out.println("서버와 연결되었습니다...");
			
			//클라이언트->서버 측으로 전송(출력)하기 위한 준비
			out = new PrintWriter(socket.getOutputStream(), true);
			//바이트스트림을 문자스트림으로 변환하기 위한 준비
			in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
			
			//접속자의 "대화명"을 서버측으로 최초 전송한다. 
			out.println(s_name);	
			//소켓이 close되기전이라면 클라이언트는 지속적으로 메세지를 보낼수있다.
			while(out!=null) {
				try {
					//서버가 echo해준 내용 라인단위로 읽어와 콘솔출력
					if(in!=null) {
						System.out.println("Receive : "+ in.readLine());
					}
					
					//클라이언트는 내용을 입력후 서버로 전송
					String s2 = scanner.nextLine();
					//입력값이 q(Q)이면while루프 탈출 
					if(s2.equals("q") || s2.equals("Q")) {						
						break;
					}
					else {
						//q가 아니면 계속 유지
						out.println(s2);
					}					
				} 
				catch (Exception e) {
					System.out.println("예외:"+ e);
				}
			}
						
			//채팅종료
			in.close();
			out.close();
			socket.close();
		} 
		catch (Exception e) {
			System.out.println("예외발생[MultiClient]"+ e);
		}
	}
}