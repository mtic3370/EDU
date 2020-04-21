package chat3;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.Socket;

//서버가 보내는 메세지를 읽어오는 쓰레드 클래스
public class Receiver extends Thread {

	Socket socket;
	BufferedReader in = null;
	
	//Socket을 매개변수로 받는 생성자
	public Receiver(Socket socket) {
		this.socket = socket;
		
		try {
			//바이트 스트림과 문자 스트림으로 상호 변환을 제공하는 입출력 스트림이다.
			in = new BufferedReader(new InputStreamReader(this.socket.getInputStream()));
		} 
		catch (Exception e) {
			System.out.println("예외1:"+ e);			
		}
	}
	/*
	 Thread에서 main()메소드 역할을 하는 함수로 직접 호출하면 안되고 반드시 start()를
	 통해 간접 호출해야 쓰레드가 생성된다.
	 */
	@Override
	public void run() {
		//스트림을 통해 서버가 보낸 내용을 라인 단위로 읽어온다. 
		while(in != null) {
			try {
				System.out.println("Thread Receive : "+ in.readLine());
			}			
			catch (Exception e) {	
				//접속을 종료할경우 SocketException이 발생하면서 무한루프에 빠지게 된다.  
				System.out.println("예외2:"+ e);
			}
		}
		
		try {
			in.close();
		} 
		catch (Exception e) {
			System.out.println("예외3:"+ e);
		}
	}	
}