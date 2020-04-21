package chat5;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.Socket;
import java.net.SocketException;

public class Receiver  extends Thread {
	
	Socket socket;
	BufferedReader in = null;
	
	//Socket을 매개변수로 받는 생성자
	public Receiver(Socket socket) {
		this.socket = socket;
		
		try {
			in = new BufferedReader(new InputStreamReader(this.socket.getInputStream()));
		}
		catch(Exception e) {
			System.out.println("예외>receiver>생성자:"+ e);
		}
	}
	@Override
	public void run() {
		//소켓이 종료되면 while문을 벗어나서 input스트림을 종료.
		while(in !=null) {
			try {
				System.out.println("thread Receive :"+ in.readLine());
			}
			catch(SocketException ne) {
				System.out.println("SocketException발생");
				//소켓이 종료될경우 루프를 탈출한다.
				break;
			}
			catch (Exception e) {
				System.out.println("예외>Receiver>run1:"+ e);	
			}
		}
		
		try {
			in.close();
		} 
		catch (Exception e) {
			System.out.println("예외>Receiver>run2:"+ e);	
		}
	}	
}