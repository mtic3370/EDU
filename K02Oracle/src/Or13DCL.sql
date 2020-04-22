/*******************************
파일명 : Or13DCL.sql
사용자권한
설명 : 새로운 사용자계정을 생성하고 시스템권한을 부여하는 방법을 학습
*******************************/

/*
[사용자계정 생성 및 권한설정]
해당 내용은 DBA권한이 있는 최고관리자(sys, system)로 접속후 실행해야한다.
(사용자 계정 생성후 접속 테스트는 CMD(명령프롬프트)에서 진행한다.)
*/


/*
1] 사용자계정 생성 및 암호설정
형식]
    create user 아이디 identified by 패스워드;
*/
create user test_user1 identified by 1234;
--cmd에서 sqlplus명령으로 접속시 login denied 에러 발생됨.

/*
2] 생성된 사용자 계정에 권한 혹은 역할 부여
형식]
    grant 시스템권한1[,시스템권한2 .... ] | [역할1[,역할2....]
        to 사용자1[,사용자2....] | [역할1 [,역할2....]
        [with grant option] <- 부여받은 시스템권한을 다른 사용자에게
                                재부여할수 있는 권한.

*/
--접속권한 부여
grant create session to test_user1;

--테이블 생성 권한 부여
grant create table to test_user1;

/*
* sqlplus 에서 ED명령어
-쿼리문 작성시 메모장으로 작성후 실행 시키는 방법

1. ED 작성할파일이름
SQL> ED MYBOARD[엔터]
-> 이와같이 했을때 사용자계정 디렉토리에 MYBOARD.sql파일이 생성됨.

2. 메모장에서 BORAD테이블을 생성한다.
   마지막 문장에 / 를 꼭 붙여준다.
   작성후 저장 그리고 파일 닫기.

3. 실행
SQL> @MYBOARD

4.기존 내용 수정시에는 SQL>ED MYBOARD [엔터]치면 메모장이 나옴.
*/

--시스템 권한 목록 확인하기 : 전체 208개의 시스템 권한 있음. 
select * from system_privilege_map;
select * from system_privilege_map where name like upper('%select%');

/*
3] 암호변경
형식]
    alter user 사용자아이디 identified by 새로운암호;
*/
alter user test_user1 identified by 4321;


/*
[4] ROLE(롤)을 통한 여러가지 권한 동시에 부여하기
    : 여러 사용자가 다양한 권한을 효과적으로 관리할수 있도록 관련된
    권한끼리 묶어놓은것
※최초 사용자계정을 생성하면 기본적으로 Connect, Resource 롤을 부여한다.  
*/
--새로운 계정 생성
create user test_user2 identified by 1234;
--Role을 통한 권한부여
grant connect, resource to test_user2;


/*
4-1) 롤생성 : 사용자가 원하는 권한을 묶어 새로운 롤을 생성할 수 있다.
형식]
    create role 롤이름;
*/
create role kosmo_role;

/*
4-2) 롤에 권한 부여
형식]
    grant 권한1, 권한2......to 롤이름;
*/
grant create session, create table, create view to kosmo_role;
--새로운 계정 생성
create user test_user3 identified by 1234;
--우리가 생성한 롤을 통한 권한부여
grant kosmo_role to test_user3;
--데이터사전에서 확인하기
select * from role_sys_privs where role like upper('%kosmo_role%');
--롤 삭제하기
drop role kosmo_role;
/*
    test_user3 계정은 사용자가 생성한 롤을 통해 권한을 부여받았으므로
    해당 롤을 삭제하면 부여받았던 권한이 회수[제거]된다. 즉 롤 삭제후
    접속할 수 없다. 
*/


/*
[5]권한제거
    형식]
        revoke 권한 및 역할 from 사용자아이디;
*/
revoke create session from test_user1;

/*
[6]사용자계정 삭제
    형식] 
        drop user 사용자아이디 [cascade];
        
※cascade를 명시하면 사용자계정과 관련된 모든 데이터베이스 스키마가 
데이터사전으로 부터 삭제되고 모든 스키마 객체도 물리적으로 삭제된다. 
*/
drop user test_user1 cascade;

--데이터 사전에서 사용자 목록 확인하기
select * from dba_users;








