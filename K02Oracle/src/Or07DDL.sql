/***********************
파일명 : Or07DDL.sql
DDL : Data Definition Language
설명 : 테이블, 뷰와 같은 객체를 생성 및 변경하는 쿼리문을 말한다.
************************/

--system계정으로 연결한후 아래 명령어를 실행한다. 
--새로운 계정에 대한 생성은 system계정 즉 관리자계정만 가능하다. 
create user study identified by 1234; --study계정을 생성한다.
grant connect, resource to study;--생성한 계정에 권한을 부여한다. 

--------------------------------------------
---study계정에서 실습합니다.

select * from dual; --모든 계정에 자동으로 생성되는 임시테이블

/*
[테이블생성]
형식] 
    create table 테이블명 (
        컬럼1 자료형 [not null ...] ,
        컬럼2 자료형 [제약조건 ...],
        .....
        primary key (컬럼명) 등 제약조건 ...
    );
*/
--테이블 생성하기
create table tb_member (
    member_idx number(10),
    userid varchar2(30),
    passwd varchar2(50),
    username varchar2(30),
    mileage number(7,2)
);

/*
desc : 생성된 테이블의 속성(레이아웃 혹은 스키마)을 확인하기
    위한 명령어
*/
desc tb_member;

/*
기존 생성된 테이블에 새로운 컬럼 추가하기
    -> tb_member 테이블에 email 컬럼을 추가하시오
    
    형식] alter table 테이블명 add 추가할컬럼 자료형(크기) 제약조건;
*/
alter table tb_member add email varchar2(100);
desc tb_member;

/*
기존 생성된 테이블의 컬럼 수정하기
    -> tb_member테이블의 email 컬럼의 사이즈를 200으로 확장하시오.
    또한 이름이 저장되는 username컬럼도 60으로 확장하시오.
    
    형식] alter table 테이블명 modify 수정할컬럼명 자료형(크기);
*/
alter table tb_member modify email varchar2(200);
alter table tb_member modify username varchar2(60);
desc tb_member;


/*
테이블에서 컬럼 삭제하기
    -> tb_member 테이블의 mileage컬럼을 삭제하시오.
    
    형식] alter table 테이블명 drop column 삭제할컬럼명;
*/
alter table tb_member drop column mileage;
desc tb_member;

/*
[테이블 삭제하기]
    -> tb_member 테이블은 더이상 사용하지 않으므로 삭제하시오.
    
    형식] drop table 삭제할테이블명;
*/
select * from tab; --현재 접속된 계정에 생성된 테이블의 목록을 확인하는 명령
drop table tb_member;
select * from tab;--삭제된 테이블이 있는경우 recyclebin 이 확인된다. 

--휴지통에 삭제된 테이블 목록 확인
show recyclebin;

--휴지통 비우기
purge recyclebin;
show recyclebin;--휴지통에 출력할 내용이 없으면 에러메세지가 출력된다. 
select * from tab;--현재 계정에 생성된 테이블이 하나도 없다. 


------------
--위 create 쿼리문을 재실행하여 테이블을 생성한다. 

--테이블삭제
drop table tb_member;  
--휴지통 확인하기
show recyclebin;
--휴지통에서 테이블 복원하기
flashback table tb_member to before drop;

show recyclebin;--에러메세지 출력됨
select * from tab; --테이블이 복원되었는지 확인


--레코드 입력하기
insert into tb_member values (1, 'hong', '1234', '홍길동', 1000);
insert into tb_member values (2, 'gasan', '9876', '가디', 2000);
--레코드 확인하기
select * from tb_member;

--테이블을 레코드까지 복사하기
create table tb_member_copy
as
select * from tb_member where 1=1;

desc tb_member_copy;
select * from tb_member_copy;


--테이블의 속성만 복사하기(레코드는 제외)
create table tb_member_empty
as
select * from tb_member where 1=0;

desc tb_member_empty;
select * from tb_member_empty;


--------------------------------------------------------
---------------연 습 문 제 ----------------------------
--------------------------------------------------------

/*
1. 다음 조건에 맞는 “pr_dept” 테이블을 생성하시오.
*/
create table pr_dept (
    dno number(2),
    dname varchar2(20),
    loc varchar2(35)
);

/*
2. 다음 조건에 맞는 “pr_emp” 테이블을 생성하시오.
*/
create table pr_emp (
    eno number(4) ,
    ename varchar2(10) ,
    job varchar2(30) ,
    regist_date date
);

/*
3. pr_emp 테이블의 ename 컬럼을 varchar2(50) 로 수정하시오.
*/
desc pr_emp;
alter table pr_emp modify ename varchar2(50);
desc pr_emp;

/*
4. emp 테이블을 복사해서 pr_emp_clone 테이블을 생성하되 
EMPNO, ENAME, SAL, DEPTNO만 복사하고 새로 생성된 
칼럼명은 emp_id, name, salary, dept_id 로 지정하시오. 레코드까지 복사하시오.
*/
create table pr_emp_clone (
    emp_id, name, salary, dept_id
)
as
select 
    EMPNO, ENAME, SAL, DEPTNO
from emp where 1=1;
/*
    create table 다음에는 컬럼과 자료형 제약조건이 기술되어야 하지만
    테이블을 복사하는 경우에는 원본테이블을 참조하므로 컬럼명만 
    기술하면 된다. 
*/
desc pr_emp_clone;
select * from pr_emp_clone;


/*
5. 위에서 복사한 pr_emp_clone 테이블의 
이름을 pr_emp_clone_rename 으로 변경하시오.
*/
--형식 :  rename 원본테이블명 to 변경할테이블명
rename pr_emp_clone to pr_emp_clone_rename;
desc pr_emp_clone;
desc pr_emp_clone_rename;

/*
6. 1번에서 생성한 pr_dept 테이블에서 dname 칼럼을 삭제하시오.
*/
alter table pr_dept drop column dname;
desc pr_dept;

/*
7. “pr_emp” 테이블의 job 컬럼을 varchar2(50) 으로 수정하시오.
*/
alter table pr_emp modify job varchar2(50);

/*
8. 5번의 pr_emp_clone_rename 테이블을 삭제하시오
*/
drop table pr_emp_clone_rename;

/*
9. 8번에서 삭제한 pr_emp_clone_rename 테이블이 휴지통에 있는지 확인하고, 
복원할 수 없도록 휴지통에서 완전히 삭제하시오.
*/
show recyclebin;
purge table pr_emp_clone_rename;
show recyclebin;













