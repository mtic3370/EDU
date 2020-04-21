package chat4;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

//작성해봅시다..ㅋ
public class MultiClient {

	public static void main(String[] args) {
		
		System.out.print("이름을 입력하세요:");
		Scanner scanner = new Scanner(System.in);
		String s_name = scanner.nextLine();
				
		PrintWriter out = null;
		//서버의 메세지를 읽어오는 기능이 리시버로 옮겨짐
		//BufferedReader in = null;
		
		try {/*
		c:\>java패키지명.MultiClient 접속할IP주소
		=>위아 같이 하면 해당 IP주소로 접속할 수 있다.
		만약 IP주소가 없으면 localhost(127.0.0.1)로 접속한다.
		*/
			String ServerIP = "localhost";
			//클라이언트 실행시 매개변수가 있는경우 아이피 설정
			if(args.length > 0) {
				ServerIP = args[0];
			}
			//소켓 객체 생성
			Socket socket = new Socket(ServerIP, 9999);			
			System.out.println("서버와 연결되었습니다...");
			
			//서버에서 보내는 메시지를 사용자의 콘솔에 출력하는 리시버 쓰레드
			Thread receiver = new Receiver(socket);
			//setDeamon(true)가 없으므로 독립쓰레드로 생성됨.
			receiver.start();
			
			out = new PrintWriter(socket.getOutputStream(), true);
			out.println(s_name);
			
			//클라이언트가 q(Q)를 입력하면 채팅이 종료된다. 
			while(out!=null) {
				try {
					//출력
					String s2 = scanner.nextLine();
					if(s2.equals("q") || s2.equals("Q")) {
						break;
					}
					//클라이언트 메세지를 서버로 전송.
					else {
						out.println(s2);
					}					
				} 
				catch (Exception e) {
					System.out.println("예외:"+ e);
				}
			}
						
			//채팅종료
			out.close();
			socket.close();
		} 
		catch (Exception e) {
			System.out.println("예외발생[MultiClient]"+ e);
		}
	}
}