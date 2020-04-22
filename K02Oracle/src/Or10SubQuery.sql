/******************
파일명 : Or10SubQuery.sql
서브쿼리
설명 : 쿼리문안에 또 다른 쿼리문이 들어가는 형태의 select문
*******************/

/*
단일행 서브쿼리
    형식]
        select * from 테이블명 where 컬럼=(
            select 컬럼 from 테이블명 where 조건
        );
    ※ 괄호안의 서브쿼리는 반드시 하나의 결과를 인출해야 한다. 
*/

/*
시나리오] 사원테이블에서 전체사원의 평균급여보다 낮은 급여를 받는 사원들을 
추출하여 출력하시오.
    출력항목 : 사원번호, 이름, 이메일, 연락처, 급여
*/
select first_name, email, salary
from employees
where salary < round(avg(salary)) ;/*
    ORA-00934: 그룹 함수는 허가되지 않습니다
    해당 쿼리문은 문맥상 맞는듯하나 위와같은 오류가 발생된다. 
    그룹함수를 단일행에 적용한 잘못된 쿼리문이다. 
*/
--1단계 : 전체직원의 평균 급여를 구한다. 
select round(avg(salary)) from employees;
--2단계 : 6462보다 적은 급여를 받는 직원을 가져온다. 
select * from employees where salary<6462;
--3단계 : 위 2개의 쿼리를 하나의 서버쿼리문으로 합침.
/*
    -서브쿼리는 반드시 () 소괄호 안에 기술해야 한다.
    -서브쿼리는 독립적으로 실행되어야 한다. 
*/
select first_name, last_name, email, salary 
    from employees where salary<(
        select round(avg(salary)) from employees
    );

/*
시나리오] 전체 사원중 급여가 가장적은 사원의 이름과 급여를 출력하는 
서브쿼리문을 작성하시오.
출력항목 : 이름1, 이름2, 이메일, 급여
*/
select first_name, last_name, email, salary from employees 
where salary=min(salary); -- 에러발생

--1단계 : 최소급여를 찾는다. -> 2100
select min(salary) from employees;
--2단계 : 2100달러를 급여로 받는 직원을 인출한다.
select * from employees where salary=2100;
--3단계 :  쿼리를 합친다.
select first_name, last_name, email, salary from employees where salary=(
    select min(salary) from employees
);

/*
시나리오] 평균급여보다 많은 급여를 받는 사원들의 명단을 조회할수 있는 
서브쿼리문을 작성하시오.
출력내용 : 이름1, 이름2, 담당업무명, 급여
※ 담당업무명은 jobs 테이블에 있으므로 join해야 한다. 
*/
--1.평균급여
select round(avg(salary)) from employees;
--2.6462이상의 급여를 받는 사원을 인출
select
    first_name, last_name, J.job_id, job_title, salary
from employees E inner join jobs J
    on E.job_id=J.job_id
where
    salary>=6462;
--3.서브쿼리
select
    first_name, last_name, J.job_id, job_title, salary
from employees E inner join jobs J
    on E.job_id=J.job_id
where
    salary>=(select round(avg(salary)) from employees);




/*
복수행 서브쿼리
    형식]
        select * from 테이블명 where 컬럼 in (
            select 컬럼 from 테이블명 where 조건
        );
    ※ 괄호안의 서브쿼리는 2개 이상의 결과를 인출해야 한다.
*/

--복수행연산자 : in

/*
시나리오] 담당업무별로 가장 높은 급여를 받는 사원의 명단을 조회하시오.
    출력목록 : 사원아이디, 이름, 담당업무아이디, 급여 
*/
-- 1. 사원테이블에서 단순 정렬을 통해 업무별 고액연봉자 확인
select job_id, salary from employees
order by job_id, salary desc;
-- 2. 1번에서 확인한 레코드를  group by절로 그룹화하여 각 직종별
--     최대급여를 확인
select job_id, max(salary)
from employees
group by job_id
order by job_id asc;
-- 3. 2단계의 결과를 대상으로 단순 쿼리문 작성
/*
    2단계에서 19개의 인출결과가 나왔으므로 이를 단순 쿼리로 작성하면
    19개의 조건을 or연산자로 연결해야 한다. 쿼리의 양이 많아지므로
    비효율적이다. 
*/
select 
    employee_id, first_name, job_id, salary
from employees
where
    (job_id='AC_ACCOUNT' and salary=8300) or
    (job_id='AC_MGR' and salary=12008) or
    (job_id='AD_ASST' and salary=4400);    
--4. 3번 쿼리문을 서브쿼리로 변경. 서브쿼리의 결과가 복수행이므로 in을 사용한다. 
select 
    employee_id, first_name, job_id, salary
from employees
where
    (job_id, salary) in (
        select job_id, max(salary)
        from employees
        group by job_id
    );

/*
복수행연산자 : any
    메인쿼리의 비교조건이 서브쿼리의 검색결과와 하나이상
    일치하면 참이 되는 연산자. 즉 둘중 하나만 만족하면
    해당 레코드를 가져온다. 
*/

/*
시나리오] 전체사원중에서 부서번호가 20인 사원들의 급여보다 높은 급여를 받는 직원들을 
추출하는 서브쿼리문을 작성하시오. 
-> 6000 혹은 13000보다 높은 급여를 받는 레코드를 인출
즉, 6000달러 이상인 직원들만 추출하면 문제의 조건에 만족함.
*/
--20번 부서의 급여 확인
select salary from employees where department_id=20;
--서브쿼리
select employee_id, department_id, first_name, salary
from employees
where salary >= any (
    select salary from employees where department_id=20
); -- 6000 or 13000 이상인 레코드만 인출된다. 


/*
복수행 연산자 : all
    메인쿼리의 비교조건이 서브쿼리의 검색결과와 모두 일치해야
    참이된다. 
*/
--위의 서브쿼리를 all 로 변경한다. 
select employee_id, department_id, first_name, salary
from employees
where salary >= all (
    select salary from employees where department_id=20
); -- 13000 이상의 결과만 인출됨.



/*
Top쿼리 : 조회된 결과에서 구간을 정해 레코드를 가져올때 사용한다. 
    주로 게시판의 페이징에 사용된다. 
    
    rownum : 테이블에서 레코드를 조회한 순서대로 순번이 부여되는
        가상의 컬럼을 말한다. 해당 컬럼은 모든 테이블에 존재한다. 
*/
select * from employees;
select employee_id, first_name, rownum from employees;
select employee_id, first_name, rownum from (
    select * from employees order by first_name 
);
--사원번호의 역순으로 조회된 레코드중 위에서 5개 가져오기
select
    rownum No, employee_id, first_name, salary
from
    ( select * from employees order by employee_id desc )
where rownum<=5;


/*
조회된 결과에서 구간을 정해 레코드 가져오기(게시판의 paging기능
구현을 위한 쿼리문)
*/
select * from (
    select Tb.*, rownum rNum from (
        select * from employees order by employee_id asc
    ) Tb
)
where rNum between 1 and 10; 
--where rNum between 11 and 20; 
--where rNum between 21 and 30; 
/*
between의 구간을 위와같이 변경해주면 해당 페이지의 레코드만
보여지게된다. 위의 구간은 차후 JSP에서 여러 변수들을 통해
계산하여 구현하게 된다. 
*/
















