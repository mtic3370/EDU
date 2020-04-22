/********************************
파일명 : Or08DML.sql
DML : Data Manipulation Language
설명 : 레코드를 조작할때 사용하는 쿼리문. 앞에서 학습했던
     select문을 비롯하여 update(레코드수정), delete(레코드삭제),
     insert(레코드입력)가 있다.
*********************************/     

--study계정에서 실습합니다. 

/*
레코드 입력하기 : insert문
    레코드 입력을 위한 쿼리로 문자형은 반드시 '로 감싸야한다. 
    숫자형은 '없이 그냥 쓴다. 만약 숫자형을 '로 감싸면 자동으로
    형변환되어 입력된다. 
*/

--실습을 위한 새로운 테이블 생성
create table tb_sample (
    deptNo number(10),            --부서번호
    deptName varchar2(20),      --부서명
    deptLoc varchar2(15),          --지역
    deptManager varchar2(30)  --메니져이름
);
desc tb_sample;

--방식1을 통한 레코드 입력
insert into tb_sample (deptno, deptname, deptloc, deptmanager)
    values (10, '기획실', '서울', '나연');
insert into tb_sample (deptno, deptname, deptloc, deptmanager)
    values (20, '전산팀', '수원', '쯔위');

select * from tb_sample;-- 입력된 레코드 확인    

--방식2을 통한 레코드 입력
insert into tb_sample values (30, '영업팀', '대구', '모모');
insert into tb_sample values (40, '인사팀', '부산', '지효');

select * from tb_sample;
    
commit;
/*
    지금까지의 작업(트랜잭션)을 그대로 유지하겠다는 명령으로
    커밋을 수행하지 않으면 외부에서는 변경된 레코드를 확인할 수 없다. 
    여기서 말하는 외부란 Java / JSP 와 같은 Oracle 이외의 프로그램을
    말한다. 
*/

--오라클에서 insert 했으므로 임시테이블에 저장되어 외부에서는 확인되지 않는다.
insert into tb_sample values (50, '금융팀', '제주', '아이린');
select * from tb_sample;

--롤백하면 방금 입력한 50번 레코드는 사라지게 된다. 
rollback;
/*
모든 레코드를 마지막 커밋 이후의 상태로 되돌려 준다. 
즉, commit한 이전의 상태로는 rollback 할수 없다. 
*/

select * from tb_sample;

/*
레코드 수정하기 : update문
    형식] 
        update 테이블명 
        set  컬럼1=값1, 컬럼2=값2, ....
        where 조건;
    ※조건이 없는경우 모든 레코드가 한꺼번에 수정된다. 
*/
--부서번호 40인 레코드의 지역을 미국으로 수정하시오.
update tb_sample
    set  deptloc='미국'
    where deptno=40;
select * from tb_sample;

--지역이 서울인 레코드의 메니져명을 '박진영'으로 수정하시오
update tb_sample set deptmanager='박진영' where deptloc='서울';
select * from tb_sample;

--where절 없이 모든 레코드를 대상으로 지역을 '가산디지털'로 변경하시오.
update tb_sample set deptloc='가산디지털';
select * from tb_sample;


/*
데이터 삭제하기 : delete문
    형식]
        delete from 테이블명 where 조건;
        ※레코드를 삭제하므로 delete 뒤에 컬럼을 명시하지 않는다. 
*/
--부서번호가 10인 레코드를 삭제하시오
delete from tb_sample where deptno=10;
select * from tb_sample;

--where절 없이 실행하면 모든 레코드 삭제됨(주의요망)
delete from tb_sample;
select * from tb_sample;

rollback;--마지막 commit 상태로 되돌린다.
select * from tb_sample;

--where절은 아래와 같이 다양하게 적용가능하다. 
--특히 number타입인 경우에는 연산도 가능하다. 
update tb_sample set deptname='코스모' where deptno>=30;
select * from tb_sample;
update tb_sample set deptno=deptno+1 ;
select * from tb_sample;

commit;



--------------------------------------------------------
---------------연 습 문 제 ----------------------------
--------------------------------------------------------

/*
1. DDL문 연습문제 2번에서 만든 “pr_emp” 테이블에 다음과 같이 레코드를 삽입하시오. 
단, 날짜는 sysdate를 이용해서 오늘 날짜를 입력하시오.
*/
insert into pr_emp (eno, ename, job, regist_date)
    values (1, '엄태웅', '어른 승민', sysdate);
insert into pr_emp (eno, ename, job, regist_date)
    values (2, '이제훈', '대학생 승민', sysdate);
insert into pr_emp values (3, '한가인', '어른 서연', sysdate);    
insert into pr_emp values (4, '배수지', '대학생 서연', sysdate);    

/*
2. 위 테이블에 다음 조건에 맞는 레코드를 삽입하시오.
이름 : 조정석
직책 : 납뜩이
등록날짜 : to_date함수를 이용해서 7일전 날짜를 입력하시오.
(현재날짜를 기준으로 7일전임)
*/
insert into pr_emp values (5, '조정석', '납뜩이', to_date(sysdate - 7, 'yy/mm/dd'));
select * from pr_emp;


/*
3. eno가 짝수인 레코드를 찾아서 job 컬럼의 내용을 다음과 같이 변경하시오.
“난짝수레코드” 과 같이 괄호의 문자열을 추가한다.
*/
update pr_emp set job='난짝수레코드' where mod(eno,2)=0;
select * from pr_emp;

/*
※ 다음 사항을 진행후 4~6번 문제를 진행하도록 한다.
“emp” 테이블을  “pr_employees” 테이블로 데이터까지 복사한다.
테이블 컬럼의 크기가 문제가 된다면 alter명령을 이용하여 변경후 진행하도록 한다.
*/
create table pr_employees
as 
select * from emp where 1=1;

/*
4. pr_employees 테이블에서 
사원번호 7900번과 동일한 메니져를 가진 사원의 부서번호를 
이름이 SCOTT인 사원의 부서번호로 업데이트 하시오.
*/
--사원번호 7900 레코드 확인
select * from pr_employees where empno=7900;--메니저가 7698임을 확인. 

--메니져가 7698인 사원을 확인
select * from pr_employees where mgr=7698;--부서번호가 30임을 확인

--위의 2개의 쿼리를 하나의 서브쿼리로 합친다.
select empno, deptno from pr_employees where mgr=(
    select mgr from pr_employees where empno=7900
);

--SCOTT의 부서번호 확인
select * from pr_employees where ename='SCOTT';--부서번호 20임을 확인

--최종 업데이트 : 사원번호 7499, 7521, 7654, 7844, 7900의 부서번호를 20으로 업데이트
update pr_employees
set 
    deptno=(select deptno from pr_employees where ename='SCOTT')
where empno in (
    select empno from pr_employees where mgr=(
        select mgr from pr_employees where empno=7900
    )
);

/*
5.  pr_employees 테이블에서 입사일이 12월인 모든 직원을 삭제하시오.
*/
--입사일이 12월인 사원 확인하기
select * from pr_employees where to_char(hiredate, 'mm')=12;
select * from pr_employees where substr(hiredate,4,2)=12;
select * from pr_employees where substr(to_char(hiredate),4,2)=12;
--레코드 삭제하기
delete from pr_employees where to_char(hiredate, 'mm')=12;

/*
6. pr_employees 테이블에서 입사일자가 가장 늦은 직원을 찾아서 ename 컬럼을 
“기존의이름(신입사원)” 이 될수 있도록 업데이트 하시오. 
예) KING(신입사원)
*/
--입사일이 가장 늦은 직원
select max(hiredate) from pr_employees; --결과 : 87/05/23

--위 결과를 통해 사원 정보 확인
select * from pr_employees where hiredate=(
    select max(hiredate) from pr_employees
);

--업데이트
update pr_employees
set ename=concat(ename, '(신입사원)')
where hiredate=(
    select max(hiredate) from pr_employees
);

--컬럼의 크기를 확장
alter table pr_employees modify ename varchar2(100);

--위 업데이트문을 재실행
update pr_employees
set ename=concat(ename, '(신입사원)')
where hiredate=(
    select max(hiredate) from pr_employees
);

select * from pr_employees;



/********************
DDL문 -> 테이블을 생성 및 조작하는 SQL문 
    테이블생성 : create table 테이블명
    컬럼추가 : alter table 테이블명 add 컬럼명
    컬럼수정 : alter table 테이블명 modify 컬럼명
    컬럼삭제 : alter table 테이블명 drop column 컬럼명
    테이블삭제 : drop table 테이블명

DML문 -> 레코드를 입력 및 조작하는 SQL문
    레코드입력 : insert into 테이블명 [(컬럼명)] values (값)
    레코드수정 : update 테이블명 set 컬럼명='값' where 조건
    레코드삭제 : delete from 테이블명 where 조건
    레코드조회 : select 컬럼 from 테이블명 where 조건 
                            group by 그룹 having 그룹의조건 
                            order by 오름차순(내림차순)
********************/
----------------------------------------------------------
----------------연습문제
----------------------------------------------------------
/*
1. 각 부서에 대해 부서번호, 부서이름, 지역명, 사원수, 부서내의 
모든 사원의 평균급여를 출력하시오. 평균급여는 정수로 반올림하고 
세자리마다 컴마를 출력하시오.
-출력항목 : 사원번호, 사원수, 평균급여, 부서번호, 부서명, 지역명(도시)
(조인, 서브쿼리, 그룹절을 사용해서 문제해결)
*/ 
--정답1)
select department_id"부서번호", count(*)"사원수",
    to_char(round(avg(salary)),'999,000')"평균급여",  department_name"부서명", city"도시"
from employees
    inner join departments using(department_id)
    inner join locations using(location_id)
group by department_id, department_name, city 
order by department_id asc;


--정답2)
select D.department_id"부서번호", count(*)"사원수", to_char(round(avg(salary)), '999,000')"평균급여",  
(select department_name from departments D2 
 where D2.department_id=D.department_id)"부서명",
(select city from locations L2
  inner join departments D2
  on L2.location_id=D2.location_id
  where D2.department_id=D.department_id)"도시명"
 
from employees E
    inner join departments D 
     on E.department_id=D.department_id 
    inner join locations L 
     on D.location_id=L.location_id
where 1=1
group by D.department_id
order by D.department_id asc;