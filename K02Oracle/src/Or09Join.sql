/*********************
파일명 : Or09Join.sql
테이블조인
설명 : 두개 이상의 테이블을 동시에 참조하여 데이터를 가져와야 할때 사용하는 SQL문
**********************/

/*
1] inner join(내부조인)
-가장 많이 사용되는 조인문으로 테이블간에 연결조건을 모두 만족하는
행을 검색할때 사용된다. 
-일반적으로 기본키(primary key)와 외래키(foreign key)를 사용하여
join하는경우가 대부분이다.
-두개의 테이블에 동일한 이름의 컬럼이 존재하면 "테이블명.컬럼명" 
형태로 기술해야 한다. 
-테이블의 별칭을 사용한다면 "별칭명.컬럼명" 형태로 쓸수도 있다. 


형식1(ANSI 표준방식)
    select 
        컬럼1, 컬럼2,.....
    from  테이블1 inner join 테이블2 
        on 테이블1.기본키컬럼=테이블2.외래키컬럼
    where
        조건1 and 조건2 ... ;
*/
/*
시나리오] 사원테이블과 부서테이블을 조인하여 각 직원이 어떤부서에서
    근무하는지 출력하시오. 단 표준방식으로 작성하시오.
    출력결과 : 사원아이디, 이름1, 이름2, 이메일, 부서번호, 부서명
*/

/*
아래 SQL문은 양쪽 테이블에 존재하는 department_id컬럼때문에 에러가 발생한다. 
이런경우 어떤 테이블에서 select할지를 명시해야 한다. 
ORA-00918: 열의 정의가 애매합니다
00918. 00000 -  "column ambiguously defined"
*/
select
    employee_id, first_name, last_name, 
    department_id, department_name
from employees inner join departments
    on employees.department_id=departments.department_id
where 1=1;--에러발생

--as(별칭) 없이 작성
select
    employee_id, first_name, last_name, 
    employees.department_id, department_name
from employees inner join departments
    on employees.department_id=departments.department_id
where 1=1;

--as(별칭)을 추가하여 작성
select
    employee_id, first_name, last_name, 
    emp.department_id, department_name
from employees emp inner join departments dep
    on emp.department_id=dep.department_id
where 1=1;

/*
2개 이상의 테이블 조인

시나리오] seattle(시에틀)에 위치한 부서에서 근무하는 직원의 정보를 출력하는
쿼리문을 작성하시오. 단 표준방식으로 작성하시오.
    출력결과] 사원이름, 이메일, 부서아이디, 부서명, 담당업무아이디, 담당업무명,
        근무지역
*/
select
    first_name, last_name, email, D.department_id, department_name,
    J.job_id, job_title, city
from locations L
    inner join departments D on L.location_id=D.location_id
    inner join employees E on D.department_id=E.department_id
    inner join jobs J on E.job_id=J.job_id
where lower(city)='seattle';


/*
방식2] 오라클방식
    select
        컬럼1, 컬럼2......컬럼n
    from
        테이블명1, 테이블명2
    where
        테이블명1.기본키컬럼=테이블명2.참조키컬럼 
        and 조건1 and 조건2;
*/

/*
시나리오] 사원테이블과 부서테이블을 조인하여 각 직원이 어떤부서에서
    근무하는지 출력하시오. 단 오라클방식으로 작성하시오.
    출력결과 : 사원아이디, 이름1, 이름2, 이메일, 부서번호, 부서명
*/
select
    employee_id, first_name, last_name, Dep.department_id, department_name
from employees Emp, departments Dep
where Emp.department_id=Dep.department_id;

/*
시나리오] seattle(시에틀)에 위치한 부서에서 근무하는 직원의 정보를 출력하는
쿼리문을 작성하시오. 단 오라클방식으로 작성하시오.
    출력결과] 사원이름, 이메일, 부서아이디, 부서명, 담당업무아이디, 담당업무명,
        근무지역
*/
select
    first_name, last_name, email, D.department_id, department_name,
    J.job_id, job_title
from locations L, departments D, employees E, jobs J
where city='Seattle' 
            and L.location_id=D.location_id 
            and D.department_id=E.department_id 
            and E.job_id=J.job_id;


/*
2] outer join(외부조인)

outer join은 inner join과는 달리 두 테이블에 조인조건이 정확히 일치하지
않아도 기준이 되는 테이블에서 결과값을 가져오는 join문이다.
outer join을 사용할때는 반드시 outer 전에 데이터를 어떤 테이블을 기준으로
가져올지를 기술해야 한다. 
    -> left(왼쪽테이블), right(오른쪽테이블), full(양쪽테이블)

형식1(표준방식)
    select 컬럼1, 컬럼2 ....
    from 테이블1 
        left[right, full] outer join 테이블2
            on 테이블1.기본키=테이블2.참조키
    where 조건1 and 조건2 or 조건3;
*/

/*
시나리오] 전체직원의 사원번호, 이름, 부서아이디, 부서명, 지역을 외부조인(left)을
    통해 출력하시오.
*/
select
    employee_id, first_name, last_name, D.department_id,
    department_name, L.location_id, city, state_province
from employees E
    left outer join departments D
        on E.department_id=D.department_id
    left outer join locations L
        on D.location_id=L.location_id
where
    1=1;

/*
시나리오] 전체직원의 사원번호, 이름, 부서아이디, 부서명, 지역을 외부조인(right)을
    통해 출력하시오.
*/
--left 혹은 right 와 같이 기준이 달라지면 결과도 완전히 달라진다. 
select
    employee_id, first_name, last_name, D.department_id,
    department_name, L.location_id, city, state_province
from employees E
    right outer join departments D
        on E.department_id=D.department_id
    right outer join locations L
        on D.location_id=L.location_id
where
    1=1;


/*
형식2(오라클방식)
    select
        컬럼1, 컬럼2, ..... 컬럼N
    from
        테이블1, 테이블2
    where
        테이블1.기본키=테이블2.외래키 (+)
        and 조건1 and 조건2 ... ;
        
※ 오라클방식에서는 왼쪽에 있는 테이블이 기준이된다.         
    이와같은 경우는 테이블1이 기준이 된다. 
*/
/*
시나리오] 전체직원의 사원번호, 이름, 부서아이디, 부서명, 지역을 외부조인(left)을
    통해 출력하시오. 단 오라클방식으로 작성하시오. 
*/
select
    employee_id, first_name, last_name, D.department_id, department_name, 
    D.location_id, city, state_province 
from 
    employees E, departments D, locations L
where 
    E.department_id=D.department_id(+)
    and D.location_id=L.location_id(+);


/*
3] self join(셀프조인)
    셀프조인은 하나의 테이블에 있는 컬럼끼리 연결해야 하는 경우에 사용한다.
    즉 자기자신의 테이블과 조인을 맺는것이다. 
    셀프조인에서는 별칭이 테이블을 구분하는 구분자의 역할을 하므로 굉장히
    중요하다.
    
    형식]
        select 
            별칭1.컬럼, 별칭2.컬럼 ....
        from    
            테이블 별칭1, 테이블 별칭2
        where
            별칭1.컬럼=별칭2.컬럼 ;
*/

/*
시나리오] 사원테이블에서 각 사원의 메니져아이디와 메니져이름을 출력하시오.
    1. 하나의 테이블을 각각 사원정보테이블과 메니져정보테이블로 나눈다.
    2. 사원의 메니져아이디와 메니져의 사원아이디를 조인(join)한다.
    3. 각각의 테이블 별칭을 이용해서 필요한 정보를 선택(select)한다.
*/
select
    empClerk.employee_id "사원번호", empClerk.first_name "사원이름",
    empManager.employee_id "메니져의사원번호", empManager.first_name "메니져이름"
from 
    employees empClerk , employees empManager
where
    empClerk.manager_id=empManager.employee_id ;

/*
시나리오] self join을 사용하여 "Kimberely / Grant" 사원보다 늦게 입사한
    사원의 이름과 입사일을 출력하시오
출력목록 : first_name, last_name, hire_date
*/
--1. Kimberely의 정보확인 ->  07/05/24
select * from employees where first_name='Kimberely' and last_name='Grant';
--2. 07/05/24 보다 큰(이후) 날짜를 가져온다. 
select first_name, last_name, hire_date from employees
    where  hire_date>'07/05/24';
--3. self join을 통해 위 2개의 쿼리를 하나로 합친다.    
select
    Clerk.first_name, Clerk.last_name, Clerk.hire_date
from 
    employees Kim , employees Clerk
where
    Kim.first_name='Kimberely' and Kim.last_name='Grant'
    and Kim.hire_date < Clerk.hire_date
order by Clerk.hire_date ;


/*
using : join문에서 주로 사용하는 on절을 대체할수 있는 문장
    형식] on 테이블1.컬럼=테이블2.컬럼
                =>  using(컬럼) 
*/

/*
시나리오] seattle(시에틀)에 위치한 부서에서 근무하는 직원의 정보를 출력하는
쿼리문을 작성하시오. 단 표준방식과 using을 사용해서 작성하시오.
    출력결과] 사원이름, 이메일, 부서아이디, 부서명, 담당업무아이디, 담당업무명,
        근무지역
*/
select
    first_name, last_name, email, department_id, department_name,
    job_id, job_title, city
from locations L
    inner join departments D 
        -- on L.location_id=D.location_id
        using(location_id)
    inner join employees E 
        -- on D.department_id=E.department_id
        using(department_id)
    inner join jobs J 
        -- on E.job_id=J.job_id
        using(job_id)
where lower(city)='seattle';/*
    using절에 사용된 식별자 컬럼의 경우 select 절에서 테이블의 별칭을
    붙이면 쿼리오류가 발생한다. 
    using절에 사용된 컬럼명은 좌, 우측의 테이블에 동시에 존재하는 컬럼
    이라는것을 전제로 작성하기 때문에 굳이 별칭을 붙일 이유가 없는것이다.
*/

 /*
 퀴즈] 2005년에 입사한 사원들중 California(STATE_PROVINCE) / 
 South San Francisco(CITY)에서 근무하는 사원들의 정보를 출력하시오.
 단, 표준방식과 using을 사용해서 작성하시오.
 
 출력결과] 사원번호, 이름, 성, 급여, 부서명, 국가코드, 국가명(COUNTRY_NAME)
        급여는 세자리마다 컴마를 표시한다. 
 참고] '국가명'은 countries 테이블에 입력되어있다. 
 */
select
    employee_id, first_name, last_name, trim(to_char(salary,'$99,000')), 
    department_name, country_id, country_name
from employees E
    inner join departments D using(department_id)
    inner join locations L using(location_id)
    inner join countries C using(country_id)
where
    to_char(hire_date, 'yyyy')='2005' 
    and city='South San Francisco' and state_province='California';

    






















/*
8. 각 부서에 대해 부서번호, 부서이름, 지역명, 사원수, 부서내의 
모든 사원의 평균급여를 출력하시오. 평균급여는 정수로 반올림하고 
세자리마다 컴마를 출력하시오.
decode함수를 사용하여 각 부서번호에 맞는 부서명이 나오게 하시오.
(조인, 서브쿼리를 사용해서 작성하시오.)
*/ 
select
    count(*), avg(salary)
from employees
group by department_id;

select e.department_id
from employees e inner join departments d 
    on e.department_id=d.department_id
where 1=1
group by e.department_id;






