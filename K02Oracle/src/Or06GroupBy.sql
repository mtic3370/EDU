/*****************************
파일명 : Or06GroupBy.sql
그룹함수(select문 2번째)
설명 : 전체 레코드(로우)에서 통계적인 결과를 구하기 위해 하나 이상의
    레코드를 그룹으로 묶어서 연산후 결과를 반환하는 함수 혹은 쿼리문
*******************************/
/*
distinct 
    - 중복되는 레코드를 제거한후 하나의 레코드만 가져와서 보여준다. 
    - 따라서 통계적인 데이터를 계산할 수 없다. 
*/
select distinct job_id from employees;

select job_id from employees;

/*
group by
    - 동일한 값이 있는 레코드를 하나의 그룹으로 묶어서 가져온다.
    - 보여지는건 하나의 레코드이지만, 여러개의 레코드가 묶여진 결과이므로
    통계적인 데이터를 계산할 수 있다. 
    -최대, 최소, 평균, 합산 등이 가능하다. 
*/
select job_id from employees group by job_id;

/*
그룹함수의 기본형식
    : []대괄호 부분은 생략가능. 
    
    select
        컬럼1, 컬럼2..... 혹은 *(전체)
    from    
         테이블명
    [where
        조건1 or 조건2  and 조건3.....]
    [group by
        데이터 그룹화를 위한 컬럼명]   
    [having
        그룹에서 찾을 조건]
    [order by
        레코드 정렬을 위한 컬럼과 정렬방식(asc / desc)]
        
    ※ 쿼리의 실행순서
    from -> where -> group by -> having -> select -> order by
*/


/*
sum() : 합계를 구할때 사용하는 함수
    형식] sum(컬럼)
    -number타입의 컬럼에서만 사용가능
    -필드명이 필요한 경우 AS를 이용해서 별칭 부여 가능
*/
--전체직원의 급여의 합계를 출력하시오.
select
    sum(salary),
    sum(salary) AS SumSalary,
    to_char(sum(salary), '999,000') AS TotalSalary1,
    to_char(sum(salary), 'L999,000') AS TotalSalary2
from employees
where 1=1;
-- 1=1 : 참인 조건으로 where절에 쓰게되면 모든 레코드를 대상으로 한다는 의미.


--10번 부서에 근무하는 사원들의 급여합계는 얼마인지 출력하시오
select
    sum(salary) SalaySum1,
    to_char(sum(salary), '$999,999') SalaySum2,
    trim(to_char(sum(salary), '$999,999')) SalaySum3
from employees
where department_id=10;

--sum()과 같은 그룹함수는 Number타입의 컬럼에서만 사용가능. 
select sum(first_name) from employees;--에러발생


/*
count() : 레코드의 갯수를 카운트할때 사용하는 함수
*/
select count(*) from employees;--방법1
select count(employee_id) from employees;--방법2
/*
    count()함수를 사용할때는 위 2가지 방법 모두 가능하나,
    *를 사용할것을 권장하고 있다. 컬럼의 특성을 타지않아
    검색속도가 빠르다. 
*/

/*
count()함수의 
    사용법1 : count(all 컬럼명)
        => 디폴트. 컬럼전체의 레코드를 기준으로 카운트한다.
    사용법2 : count(distinct 컬럼명)
        => 중복을 제거한 상태에서 카운트한다. 
*/
select
    count(all job_id) "담당업무전체갯수",
    count(distinct job_id) "순수담당업무갯수"
from employees;


/*
avg() : 평균값을 구할때 사용하는 함수
*/
--전체사원의 평균급여는 얼마인지를 출력하는 쿼리문을 작성하시오.
select
    count(*) "사원수",
    sum(salary) "급여의합계",
    sum(salary) / count(*) "평균급여1",
    round(sum(salary) / count(*)) "평균급여2",
    avg(salary) "avg()함수사용1",
    to_char(avg(salary), '$999,000') "avg()함수사용2"
from employees;

--영업팀의 평균급여는 얼마인가?
select * from departments where department_name='Sales';
--대/소문자 변경 함수를 이용해서 아래와같이 select 가능함.
select * from departments where lower(department_name)='sales';
select * from departments where upper(department_name)='SALES';

select
    to_char(avg(salary), '$999,000.00') as "영업팀평균급여"
from employees where department_id=80;


/*
max() / min() : 최대값, 최소값을 찾을때 사용하는 함수
*/
--사원중 급여가 가장 높은 사람은 누구인가?
--step1 : 사원중 가장 높은 급여가 얼마인지 찾는다.
select max(salary) from employees;
--step2 : 위에서 구한 24000달러를 받는 직원을 찾는다.
select first_name, last_name, job_id from employees
where salary=24000;
--step3 : 위 2개의 쿼리를 하나의 서브쿼리로 합친다.
select first_name, last_name, job_id 
from employees
where salary=(
    select max(salary) from employees
);
/*
위 문제는 서브쿼리를 통해서만 1번에 해결이 가능하다. 
그렇지 않다면 2번의 쿼리를 별도로 실행해야 한다. 
따라서 문제를 파악한후 서브쿼리를 사용해야할지 결정해야 한다..
*/

--사원의 가장 낮은 급여는 얼마인가요?
select min(salary) from employees;
--최대/최소 급여 검증위한 정렬된 레코드 인출
select distinct salary from employees order by salary asc;


/*
group by절 : 여러개의 레코드를 하나의 그룹으로 그룹화하여 묶여진
    결과를 반환하는 쿼리문
    ※ distinct 는 단순히 중복값을 제거함.
*/
--사원테이블에서 레코드를 부서별로 그룹화하여 확인하기
select department_id from employees
group by department_id;
/*
위와 동일한 문장이긴 하나 그룹으로 사용되지 않는 first_name은
인출이 애매하므로 에러가 발생한다. select절은 group_by절에 
사용한 컬럼만 가져올수 있다. 그외 컬럼은 그룹함수를 사용해야한다.
*/
select department_id, first_name from employees
group by department_id; --에러발생

--각 부서별 급여의 합계는 얼마인가?
select
    department_id, sum(salary) "부서별급여총합1",
    to_char(sum(salary), '$999,000') "부서별급여총합2"
from employees
group by department_id
order by sum(salary) desc;

/*
시나리오][퀴즈] 부서별 사원수와 평균급여는 얼마인가요? 
    출력결과] 부서번호, 급여총합, 사원총합, 평균급여
        부서번호 순서대로 오름차순 정렬하세요.
*/
select
    department_id "부서번호",
    to_char(sum(salary), '999,000') "급여총합",
    count(*) "사원총합",
    to_char(avg(salary), '999,000.00') "평균급여"
from employees
group by department_id
order by department_id asc;

/*
부서별 급여의 합계를 distinct 를 사용해서 SQL문을 작성할수 없다.
ORA-00937: 단일 그룹의 그룹 함수가 아닙니다.
*/
select distinct department_id, sum(salary)
from employees;

/*
시나리오] 부서아이디가 50인 사원들의 직원총합, 평균급여, 급여총합이 
얼마인지 표현하는 쿼리문을 작성하시오.
*/
select
    count(*) "직원수",
    sum(salary) "급여총합",
    avg(salary) "평균급여"
from employees
where department_id=50
group by department_id;


/*
having절 : 물리적으로 존재하는 컬럼이 아닌 그룹함수를 통해 논리적으로
    생성된 컬럼의 조건을 추가할때 사용한다. 
    해당 조건을 where절에 추가하면 에러가 발생된다. 
*/
/*
시나리오] 사원테이블에서 각 부서별로 근무하고 있는 직원의 담당업무별 사원수와
    평균급여가 얼마인지를 출력하는 쿼리문을 작성하시오.
    단, 사원의 총합이 10명을 초과하는 레코드만 추출하시오. 
*/
select
    department_id "부서번호", job_id "담당업무ID", count(*) "사원수", avg(salary) "평균급여"
from employees
where 1=1
group by department_id, job_id
having  count(*)>10
order by department_id desc ;
/*
--아래 문장은 에러 발생됨. count(*)>10은 그룹함수이므로 where절에 사용할수 없음.
ORA-00934: 그룹 함수는 허가되지 않습니다
*/
select
    department_id "부서번호", job_id "담당업무ID", count(*) "사원수", avg(salary) "평균급여"
from employees
where 1=1 and count(*)>10
group by department_id, job_id
order by department_id desc ;--에러발생


------------------------------------------------------
----------------연 습 문 제 -----------------------
------------------------------------------------------
/*
hr 계정의 employees 테이블 사용
*/

/*
1. 전체 사원의 급여최고액, 최저액, 평균급여를 출력하시오. 
컬럼의 별칭은 아래와 같이 하고, 평균에 대해서는 
정수형태로 반올림 하시오.
별칭) 급여최고액 -> MaxPay
급여최저액 -> MinPay
급여평균 -> AvgPay
*/  
select
    max(salary) "급여최고액", min(salary) "급여최저액", round(avg(salary)) "급여평균"
from employees
where 1=1;


/*
2. 각 담당업무 유형별로 급여최고액, 최저액, 총액 및 평균액을 
출력하시오. 컬럼의 별칭은 아래와 같이하고 모든 숫자는 
to_char를 이용하여 세자리마다 컴마를 찍고 정수형태로 출력하시오.
별칭) 급여최고액 -> MaxPay
급여최저액 -> MinPay
급여평균 -> AvgPay
급여총액 -> SumPay
참고) employees 테이블의 job_id컬럼을 기준으로 한다.
*/ 
select
    to_char(max(salary),'999,000') "MaxPay", to_char(min(salary),'999,000') "MinPay", 
    to_char(avg(salary),'999,000') AvgPay, to_char(sum(salary),'999,000') SumPay
from employees
group by job_id;

/*
3. count() 함수를 이용하여 담당업무가 동일한 사원수를 
출력하시오.
참고) employees 테이블의 job_id컬럼을 기준으로 한다.
*/
select
    job_id, count(*) CrewCount
from employees
group by job_id
order by CrewCount desc;

/*
4. 급여가 10000달러 이상인 직원들의 담당업무별 합계인원수를 
출력하시오.    
*/ 
select
    job_id, count(*) "업무별인원합계"
from employees
where salary>=10000
group by job_id
order by count(*);
/*
    급여가 1000 이상인...조건 => where절
    급여의 합계가 400이상인..조건 => having절
    즉 순수데이터에 대한 조건이라면 where절을 사용하고
    그룹에 의해 새롭게 생성된 데이터라면 having절을 사용해야한다. 
*/


/*
5. 급여 최고액과 최저액의 차액을 출력하시오. 
*/ 
select
    (max(salary) - min(salary)) "최고최저급여차"
from employees;

/*
6. 직급별 사원의 최저급여를 출력하시오. 
(관리자를 알수없는 사원 및 최저급여가 3000미만인 그룹은)
제외시키고 결과를 급여의 내림차순으로 정렬하여 출력하시오.
*/ 
select
    job_id, min(salary)
from employees
where manager_id is not null 
group by job_id
having not min(salary)<3000
order by min(salary) desc;

/*
7. 각 부서에 대해 부서번호, 사원수, 
부서 내의 모든 사원의 평균급여를 출력하시오. 
평균급여는 소수점 둘째자리로 반올림하시오.
*/ 
select
    department_id "부서번호", count(*) "사원수", round(avg(salary),2) "평균급여"
from employees
group by department_id;

/*
8. 각 부서에 대해 부서번호, 부서이름, 지역명, 사원수, 부서내의 
모든 사원의 평균급여를 출력하시오. 평균급여는 정수로 반올림하고 
세자리마다 컴마를 출력하시오.
decode함수를 사용하여 각 부서번호에 맞는 부서명이 나오게 하시오.
(조인, 서브쿼리를 사용하지 않는다)
*/ 
select
    department_id,
    decode(department_id, 
        10,	'Administration',
        20,	'Marketing',
        30,	'Purchasing',
        40,	'Human Resources',
        50,	'Shipping',
        60,	'IT',
        70,	'Public Relations',
        80,	'Sales',
        90,	'Executive',
        100,'Finance', '그냥부서') AS "부서명", 
    decode(department_id, 
        10, 'Seattle',
        20, 'Toronto',
        30, 'Seattle',
        40, 'London',
        50, 'South San Francisco', '그냥지역') AS "지역명",    
    count(*), to_char(avg(salary),'$999,000')
from employees
group by department_id;






