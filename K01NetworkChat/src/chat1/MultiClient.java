package chat1;

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
		//문자 필터 스트림으로 printf, println등 문자열단위의 출력이 필요할때 사용
		PrintWriter out = null;
		//문자열 입력을 위한 문자스트림
		BufferedReader in = null;
		
		try {
			//별도의 매개변수가 없으면 IP는 localhost로 고정됨
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
			/*
			InputStreamReader / OutputStreamWriter는 
			바이트 스트림과 문자 스트림으로 상호 변환을 제공하는 입출력 스트림이다.
			바이트를 읽어서 지정된 문자 인코딩에 따라 문자로 변환하는데 사용한다.
			 */
			in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
			
			//서버로 이름을 전송한다. 
			out.println(s_name);	
			//서버로 보내준 메세지를 라인단위로 읽어 콘솔에 출력
			System.out.println("Receive:"+ in.readLine());
			
			//자원반납
			in.close();
			out.close();
			socket.close();
		} 
		catch (Exception e) {
			System.out.println("예외발생[MultiClient]"+ e);
		}
	}
}