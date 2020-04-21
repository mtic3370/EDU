package chat7;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Scanner;

public class JeaYoungMultiServer {
	static ServerSocket serverSocket = null;
	static Socket socket = null;
	DBHandler dbHandler;

	// 클라이언트 정보 저장을 위한 Map컬렉션 정의
	Map<String, PrintWriter> clientMap;

	//클라이언트의 IP주소를 저장할 set컬렉션
	HashSet<InetAddress>blacklist;
	InetAddress address;
			
	HashSet<String>banWords = new HashSet<String>();

	public JeaYoungMultiServer() {
		clientMap = new HashMap<String, PrintWriter>();
		Collections.synchronizedMap(clientMap);

		blacklist = new HashSet<InetAddress>();
	}

	// 서버 초기화
	public void init() {
			try {
				serverSocket = new ServerSocket(9999);
				
				//서버시작후 DB테이블 생성 및 연동 준비
				dbHandler = new DBHandler();
				
				InetAddress address;
				Scanner scan = new Scanner(System.in);
				
				/*
				클라이언트의 메세지를 모든 클라이언트에게 전달하기 위한 
				쓰레드 생성및 start.
				*/
				while (true) {
					socket = serverSocket.accept();
					System.out.println("신규접속IP"+socket.getInetAddress());

					address = socket.getInetAddress();
					
					System.out.println("블랙리스트 추가 : 1");
					System.out.println("블랙리스트 추가 : 2");
					System.out.println("접속허용은 아무키 누르시오");

					String input = scan.nextLine();
					
					if(input.equals("1")) {
						System.out.println("블랙리스트 추가"+blacklist.add(address));
					}
					if(input.equals("2")) {
						System.out.println("블랙리스트 명단");
						System.out.println(blacklist);
					}	
					if(blacklist.contains(address)) {
						System.out.println("2");
						socket = null;
						System.out.println(address+"는 차단되었습니다.");
						continue;
					}
					
					Thread mst = new jeaYoungMultiServerT(socket);
					mst.start();
				}
			} 
			catch (Exception e) {
				e.printStackTrace();
			}
			finally {
				try {
					serverSocket.close();
					dbHandler.close();
				} 
				catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

	// 메인메소드 : Server객체를 생성하고 초기화한다
	public static void main(String[] args) {
		new JeaYoungMultiServer().init();

	}

	// 접속된 모든 클라이언트에게 서버의 메세지를 echo해줌
	public void sendAllMsg(String name, String msg) {

		// Map에 저장된 객체의 키값(이름)을 먼저 얻어온다.
		Iterator<String> it = clientMap.keySet().iterator();

		while (it.hasNext()) {
			try {
				// 각 클라이언트의 PrintWriter객체를 얻어온다.
				String who = it.next();
				PrintWriter it_out = (PrintWriter) clientMap.get(who);

				// 클라이언트에게 메세지를 전달한다.

				/*
				 * 매개변수로 전달된이름이 없는경우에는 메세지만 echo한다. 있는경우에는 이름+메세지를 전달한다.
				 */

				if (name.equals("")) {
					// 해쉬맵에 저장되어있는 클라이언트들에게 메세지를 전달한다.
					// 따라서 접속자를 제외한 나머지 클라이언트만 입장메세지를 받는다.
					it_out.println(URLEncoder.encode(msg, "UTF-8"));
				} 
				else if (name.equals(who)) {
					it_out.println(msg);
				} 
				else {
					it_out.println("[" + name + "]: " + msg);
				}
			} 
			catch (Exception e) {
				System.out.println("예외3: " + e);
				e.printStackTrace();
			}

		}
	}

	public String checkDuplicate(String name) {
		int addName = 1;
		String copy = name;
		while (clientMap.containsKey(copy)) {
			System.out.println("중복발견");
			copy += addName++;

		}
		System.out.println("중복체크 최종결과  " + copy);// ee1
		return copy;

	}

	public String banWords(String str) {

		Iterator<String> it = banWords.iterator();
		String text = str;
		while(it.hasNext()) {
			String word = it.next();
			if(str.contentEquals(word)) {
				text = str.replace(word, "***");
			}
		}
		return text;
		
	}

	// 내부크래스
	public class jeaYoungMultiServerT extends Thread {

		// 멤버변수
		Socket socket;
		PrintWriter out = null;
		BufferedReader in = null;
		boolean setWhisper = false;
		boolean setQuiet = false;
		String toWhisper = "";
		String toQuiet = "";
		Commands commands = null;
		
		// 생성자 : Socket을 기반으로 입출력 스트림을 생성한다.
		public jeaYoungMultiServerT(Socket socket) {
			this.socket = socket;
			try {
				out = new PrintWriter(this.socket.getOutputStream(), true);

				in = new BufferedReader(new InputStreamReader(this.socket.
						getInputStream(), "UTF-8"));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		@Override
		public void run() {
			String name = "";
			String s = "";

			try {

				name = in.readLine();
				name = URLDecoder.decode(name, "UTF-8");
				name = checkDuplicate(name);

				sendAllMsg("", name + " 님이 입장하셨습니다.");
				// 현재 접속한 클라이언트를 HashMap에 저장한다.
				clientMap.put(name, out);
				dbHandler.execute(name, "[입장]");

				// HashMap에 저장된 객체의 수로 접속자수를 파악할 수 있다.
				System.out.println(name + " 접속");
				System.out.println("현재 접속자수는" + clientMap.size() + "명입니다.");

				// 입력한 메세지는 모든 클라이언트에게 echo된다.
				// 클라이언트의 메세지를 읽어온후 콘솔에 출력하고 echo한다.
				while (in != null) {
					s = in.readLine();
					s = URLDecoder.decode(s, "UTF-8");

					dbHandler.execute(name, s);
					System.out.println(name + "> " + s);
					
					s = banWords(s);

					if (s == null)
						break;
					
					if(s.length()>1 && s.charAt(0)=='/') {
						commands = new Commands(name, s, socket);
						continue;
					}
					
					else if (setWhisper == true) {
						commands.whisper(s);

						continue;
					}
					else if (setQuiet == true) {
						commands.quiet();
					}

					sendAllMsg(name, s);

				}
			} 
			catch (Exception e) {
				e.printStackTrace();
			} 
			finally {
				/*
				 * 클라이언트가 접속을 종료하면 예외가 발생하게 되어 finally로 넘어온다. 이때 대화명을 통해 해당 객체를 찾아 remove()시킨다.
				 */
				clientMap.remove(name);
				sendAllMsg("", name + "님이 퇴장하셨습니다.");
				dbHandler.execute(name, "[퇴장]");

				// 퇴장하는 클라이언트의 쓰레드명을 보여준다.
				System.out.println("[" + name + "] 퇴장");

				System.out.println("현재 접속자수는 " + clientMap.size() + "명입니다.");

				try {
					in.close();
					out.close();
					socket.close();
				} 
				catch (Exception e) {
					e.printStackTrace();
				}
			}
		}// run()

		public class Commands extends jeaYoungMultiServerT{

			String[] msgArr;
			String commander;
			String order;
			String toName="";
			StringBuffer msg = new StringBuffer("");

			public Commands(Socket socket) {
				super(socket);
			}
			
			public Commands(String name, String fullmsg, Socket socket) {

				super(socket);
				commander = name;
				msgArr = fullmsg.split(" ");
				order = msgArr[0];
				toName = (msgArr.length >= 2) ? msgArr[1] : "";

				// 공백으로 쪼개진 스트링 배열의 메세지 부분을 다시 합침
				for (int i = 2; i < msgArr.length; i++) {
					msg = msg.append(" " + msgArr[i]);
				}

				switch (order) {
				case "/list":
					showList();
					break;
				case "/to":
					whisper();
					break;// 귓속말을 셋팅하고 다시보낼때는 메세지만 입력하는데
				// 이경우에도 split이 실행되는 문제
				case "/quiet":
					quiet();
					
					break;
					
				default:
					System.out.println("잘못된 명령어입니다.");
					System.out.println("/list : 접속자 리스트 보기");
					System.out.println("/to [이름] [메세지] : 귓속말보내기");
					System.out.println("/to [이름] : 귓속말 설정 고정/해제");
					break;
				}

			}

			void showList() {
				Iterator<String> it = clientMap.keySet().iterator();
				while (it.hasNext()) {
					out.println(it.next());
				}
			}

			void whisper() {
				if (msg.toString().equals("")) {
					if (setWhisper == true) {
						setWhisper = false;
						clientMap.get(commander).println(toName + "에게 귓속말 고정 해제");
					} 
					else if (setWhisper == false) {
						setWhisper = true;
						clientMap.get(commander).println(toName + "에게 귓속말 고정 설정");
					}
				} 
				else {
					clientMap.get(toName).println("[" + commander + "] : " + msg);
				}
			}

			void whisper(String msg) {
				clientMap.get(toName).println("[" + commander + "] : " + msg);
			}
			
			void quiet() {
				
				Iterator<String>it = clientMap.keySet().iterator();
				
				while(it.hasNext()) {
					
					String who = it.next();
					PrintWriter it_out = (PrintWriter)clientMap.get(who);
					
					if(toName.equals(who) && msg.toString().equals("")) {
						setQuiet = setQuiet ? false : true;
					}
					
					if(commander.equals(who)) {
						//보낸사람과 보낼대상(who)과  같은경우 echo 설정
						it_out.println(msg);
					}
					else if(toName.equals(who)) {
						//특정사용자 차단
						it_out.println("["+who+"]:****");
					}
					else {
						it_out.println("["+commander+"]:"+msg);
					}
				}
			}
		}// Command

	}// 내부클래스 : MultiServerT

}

// 대화내용을 DB에 저장할수있도록. 대화명 + 대화내용 + 현재 시각