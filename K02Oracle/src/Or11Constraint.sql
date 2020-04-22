/*
파일명 : Or11Constraint.sql
제약조건
설명 : 테이블 생성시 필요한 여러가지 제약조건에 대해 학습한다.
*/

-- study 계정에서 실습합니다. 

/*
Primary key : 기본키
-참조무결성을 유지하기 위한 제약조건이다.
-하나의 테이블에 하나의 기본키만 설정할수 있다.
-기본키로 설정되면 그 컬럼은 중복된값이나 NULL값을 입력할수 없다.
*/

/*
형식1] 인라인방식
    create table 테이블명 (
        컬럼명 자료형 [constraint 제약명] primary key
    );
*/
create table tb_primary1 (
    idx number(10) primary key,
    user_id varchar2(30),
    user_name varchar2(50)
);
desc tb_primary1;

/*
형식2] 아웃라인 방식
    create table 테이블명 (
        컬럼명 자료형, 
        [constraint 제약명] primary key (컬럼명)
    );    
*/
create table tb_primary2 (
    idx number,
    user_id varchar2(30),
    user_name varchar2(50),
    primary key (user_id)
);
desc tb_primary2;

/*
형식3] 테이블 생성후 alter문으로 제약조건 추가
    alter table 테이블명 add [constraint 제약명] primary key (컬럼명);
*/
create table tb_primary3 (
    idx number,
    user_id varchar2(30),
    user_name varchar2(50)
);
alter table tb_primary3 add constraint tb_primary3_pk
    primary key (user_name);
desc tb_primary3;

/*
제약조건 확인하기
    user_cons_columns : 테이블에 지정된 제약조건명과 컬럼명의
        간략한 정보를 확인할 수 있다.    
    user_constraints : 테이블에 지정된 제약조건의 상세한 정보를
        확인할 수 있다. 

※ 이와같이 제약조건이나 뷰, 프로시져등의 정보를 저장하고 있는
시스템 테이블을 "데이터사전"이라고 한다. 
*/
select * from user_cons_columns;
select * from user_constraints;

--레코드 삽입하기
insert into tb_primary1 (idx, user_id, user_name) 
    values(1, 'kosmo', '코스모');
insert into tb_primary1 (idx, user_id, user_name) 
    values(1, 'gasmo', '가스모');    /*
            ORA-00001: 무결성 제약 조건(STUDY.SYS_C0011872)에 위배됩니다
            PK로 지정된 idx컬럼에 중복된 값을 입력하여 오류 발생됨.
    */
insert into tb_primary1 values (2, 'black', '블렉');
insert into tb_primary1 values ('', 'white', '화이트');/*
            ORA-01400: NULL을 ("STUDY"."TB_PRIMARY1"."IDX") 안에 삽입할 수 없습니다
            PK로 지정된 컬럼에는 빈값(NULL)을 삽입할 수 없다. 
    */
select * from tb_primary1;
update tb_primary1 set idx=2 where user_name='코스모';/*
            update문은 정상이지만 idx값이 이미 존재하는 2로 변경했으므로
            제약조건 위배로 오류발생됨.
    */


/*
Unique : 유니크
-값의 중복을 허용하지 않는 제약조건
-숫자, 문자열은 중복을 허용하지 않으나, NULL값에 대해서는 
중복을 허용한다. 
-unique는 한 테이블에 2개이상 적용할 수 있다.
*/
create table tb_unique1(
    idx number unique not null,
    name varchar2(30),
    telephone varchar2(20),
    nickname varchar2(30),
    unique(telephone, nickname)
);
select * from user_cons_columns;
select * from user_constraints;

insert into tb_unique1 (idx, name, telephone, nickname)
    values (1, '아이린', '010-1111-2222', '레드벨벳');
insert into tb_unique1 (idx, name, telephone, nickname)
    values (2, '웬디', '010-1111-3333', '');
insert into tb_unique1 (idx, name, telephone, nickname)
    values (3, '슬기', '', '');    
select * from tb_unique1;    
    
insert into tb_unique1 (idx, name, telephone, nickname)
    values (1, '예리', '', '');   -- 에러발생. 중복된 값 있음.

insert into tb_unique1 values (4, '정우성', '010-3333-3333', '비트');--입력성공
insert into tb_unique1 values (5, '이정재', '010-4444-4444', '비트');--입력성공
insert into tb_unique1 values (6, '김민종', '010-3333-3333', '비트');--에러
/*
    telephone과 nickname컬럼이 동일한 제약명으로 설정되었으므로 
    두개의 컬럼이 동시에 동일한 값으로 입력되는 경우가 아니라면
    중복된 값이 허용된다. 
    즉, 4번과 5번은 서로 다른 데이터로 인식하고
    4번과 6번은 동일한 데이터로 인식한다. 
*/


/*
Foreign key : 외래키, 참조키
-외래키는 참조무결성을 유지하기 위한 제약조건이다.
-만약 테이블간에 외래키가 설정되어 있다면 자식테이블에 참조값이
존재할경우 부모테이블의 레코드는 삭제되지 않는다. 
*/

/*
형식1] 인라인방식
    create table 테이블명 (
        컬럼명 자료형 [constraint 제약명] 
            references 부모테이블명 (부모테이블의 PK컬럼명)                    
    );
*/

-- 테이블 생성시 tb_primary2 테이블의 user_id컬럼을 참조하는 외래키 생성함.
create table tb_foreign1 (
    f_idx number(10) primary key,
    f_name varchar2(50),
    f_id varchar2(30) constraint tb_foreign1_fk
        references tb_primary2 (user_id)
);
--부모테이블인 tb_primary2에는 레코드가 없는 상태임.
select * from tb_primary2;
--부모테이블에 참조할 레코드가 없으므로 자식테이블에 입력 불가함.
insert into tb_foreign1 values (1, '워너원', 'WannerOne');--입력실패
--부모테이블에 레코드 삽입
insert into tb_primary2 values (1, 'WannerOne', '워너원');
--부모테이블의 참조할 레코드를 기반으로 자식테이블에 레코드 입력됨.
insert into tb_foreign1 values (1, '워너원', 'WannerOne');
insert into tb_foreign1 values (2, '트와이스', 'Twice');--부모키 없으므로 입력실패

select * from tb_primary2;
select * from tb_foreign1;

/*
자식테이블에서 참조하는 레코드가 있으므로, 부모테이블의 레코드를 
삭제할 수 없다. 이경우에는 반드시 자식테이블의 레코드를 먼저 삭제한후
부모테이블의 레코드를 삭제해야 한다. 
*/
delete from tb_primary2 where idx=1;--에러발생

delete from tb_foreign1 where f_idx=1;--자식테이블의 레코드 먼저 삭제 후
delete from tb_primary2 where idx=1;--부모테이블의 레코드 삭제 -> 문제없음.

/*
형식2] 아웃라인방식
    create table 테이블명 (
        컬럼명 자료형 , 
        
        [constraint 제약명] foreign key (컬럼명)
            references 부모테이블 (부모테이블의 참조할컬럼)
    )
*/
create table tb_foreign2 (
    f_id number(10) primary key,
    f_name varchar2(30),
    f_date date,
    
    constraint tb_foreign2_fk foreign key (f_name)
        references tb_primary3 (user_name)
);
select * from user_constraints;
/*
데이터 사전에서 제약조건 확인시 플레그 
P : Primary key
R : Reference integrity 즉 Foreign key를 뜻함
C : Check 혹은 Not Null
U : Unique
*/

/*
외래키 삭제시 옵션
[on delete cascade]
	-> 부모레코드 삭제시 자식레코드까지 같이 삭제됨
	형식] 
		컬럼명 자료형 references 부모테이블(PK컬럼)
			on delete cascade;
[on delete set null]
	-> 부모레코드 삭제시 자식레코드값이 null로 변경됨
	형식]
		컬럼명 자료형 references 부모테이블(PK컬럼)
			on delete set null

※ 실무에서 스팸게시물을 남긴 회원과 그 게시글을 일괄적으로 삭제해야 할때
사용가능한 옵션이다. 단, 자식의 모든 레코드가 삭제되므로 사용에 
주의해야 한다. 
*/

--on delete cascade 옵션 테스트
--테이블생성 및 cascade옵션 부여
create table tb_primary4 (
    user_id varchar2(20) primary key,
    user_name varchar2(100)
);
create table tb_foreign4 (
    f_id number(10) primary key, 
    f_name varchar2(20),
    user_id varchar2(20) constraint tb_foreign4_fk
        references tb_primary4 (user_id) on delete cascade
);
desc tb_primary4;
desc tb_foreign4;
--부모테이블과 자식테이블에 레코드 입력
insert into tb_primary4 values ('kosmo', '코스모');
insert into tb_foreign4 values (1, '1번입니다', 'kosmo');
insert into tb_foreign4 values (2, '2번입니다', 'kosmo');
insert into tb_foreign4 values (3, '3번입니다', 'kosmo');
insert into tb_foreign4 values (4, '4번입니다', 'kosmo');
insert into tb_foreign4 values (5, '5번입니다', 'kosmo');
insert into tb_foreign4 values (6, '6번입니다', 'gosma');--입력실패(부모키 없음)
--입력된 레코드 확인
select * from tb_primary4;
select * from tb_foreign4;
--부모테이블에서 레코드 삭제
--on delete cascade 옵션때문에 부모쪽뿐만 아니라 자식테이블까지 레코드 모두 삭제됨.
delete from tb_primary4;
--삭제후 레코드 확인
select * from tb_primary4;
select * from tb_foreign4;





--on delete set null 옵션 테스트
--테이블생성 및 set null 옵션 부여
create table tb_primary5 (
    user_id varchar2(20) primary key,
    user_name varchar2(100)
);
create table tb_foreign5 (
    f_id number(10) primary key, 
    f_name varchar2(20),
    user_id varchar2(20) constraint tb_foreign5_fk
        references tb_primary5 (user_id) on delete set null
);
desc tb_primary5;
desc tb_foreign5;
--부모테이블과 자식테이블에 레코드 입력
insert into tb_primary5 values ('kosmo', '코스모');
insert into tb_foreign5 values (1, '1번입니다', 'kosmo');
insert into tb_foreign5 values (2, '2번입니다', 'kosmo');
insert into tb_foreign5 values (3, '3번입니다', 'kosmo');
insert into tb_foreign5 values (4, '4번입니다', 'kosmo');
insert into tb_foreign5 values (5, '5번입니다', 'kosmo');
insert into tb_foreign5 values (6, '6번입니다', 'gosma');--입력실패(부모키 없음)
--입력된 레코드 확인
select * from tb_primary5;
select * from tb_foreign5;
--부모테이블에서 레코드 삭제
--on delete set null 옵션으로 자식테이블의 레코드는 삭제되지 않고 참조키부분만 null
--값으로 변경된다. 
delete from tb_primary5;
--삭제후 레코드 확인
select * from tb_primary5;
select * from tb_foreign5;


/*
not null :  null값을 허용하지 않는 제약조건.
    형식] 
         create table  테이블명 (
            컬럼명 자료형 not null,
            컬럼명 자료형 null, <- 사용하지 않음
         );
*/
/*
    m_idx : primary key로 지정했으므로 not null
    m_id : not null로 지정
    m_pw : null허용(단, null을 허용하는 컬럼인 경우 선언시 null을 쓰지않는것이 좋다)
    m_name : null허용
*/
create table tb_not_null (
    m_idx number(10) primary key, 
    m_id varchar2(30) not null,  
    m_pw varchar2(40) null,  
    m_name varchar2(50) 
);
desc tb_not_null;

insert into tb_not_null values (10, 'hong1', '1111', '홍길동');
insert into tb_not_null values (20, 'hong2', '2222', '김길동');
insert into tb_not_null values (30, 'hong3', '', '');
insert into tb_not_null values (40, '', '4444', '차길동');--입력실패(m_id컬럼에 null값 입력)
insert into tb_not_null (m_idx, m_pw, m_name) 
    values (50, '4444', '차길동');--입력실패(m_id컬럼에 null값 입력)
insert into tb_not_null values (60, ' ', '4444', '차길동');--입력성공.(space도 문자임)

select * from tb_not_null;--입력에 성공한 4개의 레코드만 확인된다. 


/*
Default : insert시 아무런 값도 입력하지 않을때 자동으로 삽입되는
    데이터를 말한다. 
*/
create table tb_default (
    id varchar2(30) not null,
    pw varchar2(30) default 'qwer'
);  
desc tb_default;
select * from tb_default;

insert into tb_default values ('aaaa', '1234');
insert into tb_default values ('bbbb', ''); -- null값이 입력됨. (※주의요망)
insert into tb_default (id) values ('cccc'); --default값 입력
insert into tb_default (id,pw) values ('dddd',default); --default값 입력
insert into tb_default values ('eeee',default); --default값 입력
/*
    위에서 보듯이 default값을 입력하려면 insert시 컬럼자체를 제외하거나 
    default키워드를 사용해야 한다. 
*/
select * from tb_default;



/*
Check : Domain(자료형) 무결성을 유지하기 위한 제약조건으로 
    해당 컬럼에 잘못된 데이터가 입력되지 않도록 유지하는 제약조건이다.
*/
create table tb_check1 (
    gender varchar2(20) not null
        constraint check_gender
            check (gender in ('M', 'F'))
);
insert into tb_check1 values ('M'); 
insert into tb_check1 values ('F'); 
insert into tb_check1 values ('Male'); -- 입력실패
insert into tb_check1 values ('여자'); -- 입력실패


create table tb_check2 (
    ticketCnt number(10) not null
        check (ticketCnt <= 5)
);
insert into tb_check2 values (4);
insert into tb_check2 values (5);
insert into tb_check2 values (6);--입력실패(제약조건 위배)


----------------------------------------------------------
-----------------연 습 문 제------------------------
----------------------------------------------------------
/*
1. emp 테이블의 구조를 복사하여 pr_emp_const 테이블을 만드시오. 
복사된 테이블의 사원번호 칼럼에 pr_emp_pk 라는 이름으로 primary key 
제약조건을 지정하시오.
*/
--테이블복사
create table pr_emp_const
as
select * from emp where 1=0;

--기본키(PK) 지정하기
alter table pr_emp_const add constraint pr_emp_pk
    primary key (empno);

--데이터사전에서 확인하기
select * from user_cons_columns;
select * from user_cons_columns where constraint_name=upper('pr_emp_pk');


/*
2. dept 테이블의 구조를 복사해서 pr_dept_const 테이블을 만드시오. 
부서번호에 pr_dept_pk 라는 제약조건명으로 primary_key를 생성하시오.
*/
--테이블 레이아웃만 복사
create table pr_dept_const
as
select * from dept where 1=0;

--기본키 제약조건 추가
alter table pr_dept_const add constraint pr_dept_pk 
    primary key (deptno);


/*
3. pr_dept_const 테이블에 존재하지 않는 부서의 사원이 배정되지 않도록 
외래키 제약조건을 지정하되 제약조건 이름은 pr_emp_dept_fk 로 지정하시오.
*/
alter table pr_emp_const
    add constraint pr_emp_dept_fk
    foreign key (deptno)   /* 자식테이블의 외래키 컬럼 */
        references pr_dept_const (deptno); /* 부모테이블의 기본키 컬럼 */


/*
4. pr_emp_const 테이블의 comm 칼럼에 0보다 큰 값만을 입력할수 있도록 
제약조건을 지정하시오. 제약조건명은 지정하지 않아도 된다
*/
alter table pr_emp_const add check( comm > 0 );

insert into pr_emp_const values 
    (100, '코스모', '에러1', null, sysdate, 1000, 0, 10);--check제약조건 위배(0이 입력됨)
insert into pr_emp_const values 
    (100, '코스모', '에러2', null, sysdate, 1000, 0.5, 10);--부모키 없음. 외래키 제약조건 위배

--부모테이블에 레코드 먼저 입력
insert into pr_dept_const values (10, '꿈의방', '가산');
insert into pr_dept_const values (20, '열정의방', '디지털');
--자식테이블에 레코드 입력
insert into pr_emp_const values 
    (100, '코스모', '좋아', null, sysdate, 1000, 0.5, 10);


/*
5. 위 3번에서는 두 테이블간에 외래키가 설정되어서 
pr_dept_const 테이블에서 레코드를 삭제할 수 없었다. 
이 경우 부모 레코드를 삭제할 경우 자식까지 같이 삭제될수 있도록 
외래키를 지정하시오.
*/
select * from pr_dept_const;
select * from pr_emp_const;

--부모테이블의 레코드 삭제
delete from pr_dept_const where deptno=10;--삭제불가(자식레코드 발견됨)

--기존에 설정된 외래키 삭제하기
alter table pr_emp_const drop constraint pr_emp_dept_fk;

--외래키 재설정 : 부모레코드 삭제시 자식레코드까지 동시에 삭제되도록
--                         cascade 옵션 추가
alter table pr_emp_const
    add constraint pr_emp_dept_fk
    foreign key (deptno)
    references pr_dept_const (deptno)
    on delete cascade ; 
delete from pr_dept_const where deptno=10;
select * from pr_dept_const;
select * from pr_emp_const;





