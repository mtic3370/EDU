package chat1;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;

/*
소켓 송수신 과정 설명

ServerSocket, Socket 클래스를 이용한 서버-클라이언트 프로그램을 
이해하려면 다음과 같이 TCP/IP 송수신 과정을 이해 해야한다.

클라이언트의 요청을 받기 위한 준비를 한다.(ServerSocket)
	서버에 접속 요청을 한다. (Socket)
클라이언트의 요청을 받아 들인다. (accept)
	 서버에 메시지를 보낸다. ( BufferedWriter )
클라이언트가 보낸 데이터를 출력 한다. (BufferedReader)
클라이언트에 메시지를 보낸다. ( BufferedWriter )
	서버가 보낸 메시지를 출력한다. ( BufferedReader )
종료 한다. ( socket.close() )
	종료 한다. ( socket.close() )
*/
public class MultiServer {

	public static void main(String[] args) {
		
		ServerSocket serverSocket = null;
		Socket socket = null;
		PrintWriter out = null;
		BufferedReader in = null;
		String s = "";
		
		try {
			//9999번 port로 설정해 서버를 생성후 클라이언트의 접속을 대기...
			serverSocket = new ServerSocket(9999);
			System.out.println("서버가 시작되었습니다.");
			
			/////......접속 대기중.......
			
			//클라이언트 접속요청이 있으면 받아 들인다.
			socket = serverSocket.accept();
			/*
			getInetAddress() : 소켓이 연결되어있는 원격 IP주소를 얻음
			getPort() : 소켓이 연결되어있는 원격 포트번호를 얻음
			*/
			System.out.println(socket.getInetAddress() +":"+ socket.getPort());
			
			//서버->클라이언트 측으로 전송(출력)하기 위한 준비
			out = new PrintWriter(socket.getOutputStream(), true);
			//클라이언트로부터의 입력을 받기위한 준비...
			in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
			
			//클라이언트의 입력을 읽어온다.
			s = in.readLine();
			//콘솔에 출력
			System.out.println("Client에서읽어옴:"+ s);
			//클라이언트로 전송한다. 
			out.println("Server에서응답:"+ s);
			//콘솔에 출력
			System.out.println("Bye...!!!");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				//모든 스트림과 소켓을 종료한다. 
				in.close();
				out.close();
				//소켓종료
				socket.close();
				serverSocket.close();
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}