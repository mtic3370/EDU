package chat5;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

//클라이언트로부터 얻은 문자열을 서버로 전송해주는 쓰레드
public class Sender extends Thread {

	Socket socket;
	PrintWriter out = null;
	String name;
	//생성자에서 output스트림을 생성한다.
	public Sender(Socket socket, String name) {
		this.socket = socket;
		try {
			out = new PrintWriter(this.socket.getOutputStream(), true);
			this.name = name;
		} 
		catch (Exception e) {
			System.out.println("예외>Sender>생성자:"+ e);
		}
	}
	
	@Override
	public void run() {
		Scanner s = new Scanner(System.in);
		
		try {
			//클라이언트가 서버로 입력한 사용자이름을 보내준다. 
			out.println(name);
			
			//Q입력하기전까지의 메세지를 서버로 전송.
			while(out != null) {
				try {
					String s2 = s.nextLine();
					if(s2.equalsIgnoreCase("Q")){
						break;
					}
					else {
						out.println(s2);
					}
				} 
				catch (Exception e) {
					System.out.println("예외>Sender>run1:"+ e);
				}
			}
			
			out.close();
			socket.close();
		} 
		catch (Exception e) {
			System.out.println("예외>Sender>run2:"+ e);
		}		
	}
}