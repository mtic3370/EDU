/****
파일명 : Or12Sequence.sql
시퀀스
설명 : 테이블의 기본키 필드에 순차적인 일련번호를 부여하는 시퀀스와 검색속도를 향상시킬수 있는 인덱스
****/

/*
시퀀스 
:테이블의 컬럼에 중복되지 않는 순차적인 일련번호를 부여하는 역할을 한다.
항상 증가만 되고 감소는 되지 않는 특징가지고 있다. 
*/
--상품테이블생성
Create table tb_goods(
g_idx number(10) primary key,
g_name varchar2(30)
);
--상품테이블에 레코드 입력
insert into tb_goods values(1, '초코렛');
insert into tb_goods values(1, '새우깡');--입력실패(중복된 PK값)
--max()그룹함수를 이용 일련번호 최대값 확인
select max(g_idx)+1 from tb_goods;
--레코드 삽입전 항상 max함수를 통해 확인하는것은 번거럽기 때문에 아래와 같이 시퀀스를 생성하여 입력시 사용.

--시퀀스 생성
create sequence seq_serial_num
increment by 1 /* 증가치 */
start with 100 /* 시작값 */
maxvalue 110  /* 시퀀스의 최대값 */
minvalue 99  /* 최소값 */
cycle   /* 사이클 사용 여부 */
nocache; /*cache 사용 여부 */

--데이터 사전에서 생성된 시퀀스 확인
select*from user_sequences;
--시퀀스를 이용 레코드 삽입
insert into tb_goods VALUES(seq_serial_num.nextval,'초코렛1');

--nextval:다음시퀀스 반환
select seq_serial_num.nextval from dual;
--currtval:현재시퀀스 반환
select seq_serial_num.currval from dual;
/*
시퀀스의 사이클옵션에 의해 최대값에 도달하면 도달하면 다시 처음부터 일련번호가 생성됨으로 무결성 제약조건에 위배된다.
즉, 기본키(PK)에 사용할 시퀀스는 사이클옵션을 절대 사용하면 안된다.
*/
insert into tb_goods values (seq_serial_num.nextval,'여러초코렛');
SELECT_from tb_goods; 

--시퀀스 수정하기
alter sequence seq_serial_num
increment by 10
nomaxvalue /* 시퀀스가 표현할수 있는 최대치를 사용하겠다는 의미.*/
minvalue 1
nocycle
nocache;
SELECT*FROM user_sequences;
/*
시퀀스 수정시 start with N값은 수정할수없다.
*/

--시퀀스 수정후 삽입
insert into tb_goods values (seq_serial_num.nextval,'여러초코렛');

select seq_serial_num.currval from dual;

--시퀀스삭제
drop sequence seq_serial_num;

--일반적인 시퀀스 생성->start와 min은 1부터, 증가치도 1, 최대값은 사용안함.
create sequence seq_serial_num
increment by 1
start with 1
nomaxvalue 
minvalue 1
nocycle
nocache;
/*
시퀀스 생성후 최초 실행시에는 currval은 에러가 발생.
nextval을 먼저 실행하여 다음 시퀀스를 얻어온후 cullval실행햇을때 정상 작동.
*/
select seq_serial_num.currval from dual;
select seq_serial_num.nextval from dual;
select seq_serial_num.currval from dual;

/*
시퀀스 생성시 주의사항
 -Start with에 Minvalue보다 작은값을 지정할수 없다. 즉 Start with값은 Minvalue와 같거나 Minvalue보다 커야한다.
 -NoCycle로 설정하고 시퀀스를 계속 얻어올때 MaxValue에 지정값을 초과하면 오류가 발생된다.
 -Primary key에 Cycle옵션은 절대로 지정하면 안된다.

nextval과 currval을 사용할수 있는 구문
SubQuery가 아닌 select절
-Insert문의 values절
-Update문의 set절
*/
--tb_goods테이블에 컬럼추가
alter table tb_goods add re_idx number;
desc tb_goods;
/*
같은절안에서 nextval을 여러번 사용해도 항상 같은 값을 반환.
차후 답변형 게시판에 사용할 예정
*/
insert into tb_goods values(seq_serial_num.nextval,'노트북', seq_serial_num.nextval);
SELECT*FROM tb_goods;

/*
인덱스 : 행의 검색속도를 향상시킬목적으로 생성하는 객체
primary key, unique로 지정된 컬럼에는 자동으로 index가 생성됨.
*/
--인덱스 생성
create index tb_goods_name_idx on tb_goods(g_name);

--데이터 사전에서 확인하기
SELECT*FROM user_ind_columns;

--인덱스 삭제
drop index tb_goods_name_idx;

