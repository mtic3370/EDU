/**********************************
파일명 : Or04TypeConvert.sql
형변환함수 / 기타함수
설명 : 데이터타입을 다른 타입으로 변환해야 할때 사용하는 함수와 기타함수
***********************************/

/*
sysdate : 현재날짜와 시간을 초단위로 반환해준다. 주로 게시판에서 
    새로운 포스팅이 있을때 입력한날짜를 표현하기 위해 사용된다. 
*/
select sysdate from dual; -- 20/03/17

/*
to_char() : 날짜나 숫자를 문자형으로 변환할때 사용하는 함수.
    형식] to_char(숫자 or 날짜를 저장한 컬럼, '시간포맷/통화포맷,날짜포맷 등)
*/

/* 날짜 포맷 */
--현재날짜를 0000/00/00 형태로 출력하시오   
select to_char(sysdate, 'yyyy/mm/DD') "오늘날짜" from dual;

--현재날짜를 00-00-00 형태로 출력하시오   
select to_char(sysdate, 'yy-mm-dd') "오늘날짜" from dual;

--현재날짜를 "오늘은 0000년 00월 00일 00요일입니다" 형태로 출력하시오
select
    to_char(sysdate, '오늘은 yyyy년 mm월 dd일 dy요일입니다') "과연될까?"
from dual; -- 에러발생 : 날짜형식이 부적합합니다.

select
    to_char(sysdate, '"오늘은 "yyyy"년 "mm"월 "dd"일 "dy"요일입니다"') "날짜를서식으로표현"
from dual;-- 정상출력됨 : 서식문자를 제외한 나머지 문자열을 "(더블)로 묶어준다.

select
    to_char(sysdate, 'day') "요일(화요일)",
    to_char(sysdate, 'dy') "요일(화)",
    to_char(sysdate, 'mon') "월(3월)",
    to_char(sysdate, 'mm') "월(03)",
    to_char(sysdate, 'month') "월(3월)",
    to_char(sysdate, 'yy') "2자리년도",
    to_char(sysdate, 'dd') "일을 숫자로 표현",
    to_char(sysdate, 'ddd') "1년중 몇번째 일"
from dual;

/* 시간 포맷 */
--현재시간을 00:00:00형태로 표시하기
select 
    to_char(sysdate, 'HH:MI:SS') "대문자서식",
    to_char(sysdate, 'hh:mi:ss') "소문자서식"
from dual;

--현재날짜와 시간을 한꺼번에 표시하기
select to_char(sysdate, 'yyyy-mm-dd hh:mi:ss') from dual;

--현재 시간을 오전/오후 혹은 24시간제로 표시하기
select 
    to_char(sysdate, 'hh am') AS "AM사용" ,
    to_char(sysdate, 'hh pm') "PM사용",
    to_char(sysdate, 'hh24') "24시간제"
from dual; -- 오전/오후를 표시하는 서식문자는 am 혹은 pm의 결과가 동일하다.

/* 숫자 포맷 */
/*
    0 : 숫자의 자리수를 나타내며 자리수가 맞지 않을경우 0으로 자리를 채운다.
    9 : 0과 동일하지만 자리수가 맞지 않으면 공백으로 채운다. 
*/
select 
    to_char(123, '0000') "서식문자0사용",
    to_char(123, '9999') "서식문자9사용",
    trim(to_char(123, '9999')) "trim()사용"
from dual;

select
    to_char(12345, '000,000') ,
    to_char(12345, '999,999') ,
    to_char(12345, '999,000') ,
    to_char(123456, '000,000,000') ,
    ltrim(to_char(123456, '999,999,000')) "좌측공백제거"
from dual;

--통화표시 : L -> 각 나라에 맞는 통화표시가 된다. 한국의 경우 \(원)
select to_char(12345, 'L999,999') from dual;


/*
to_number() : 문자형 데이터를 숫자형으로 변환한다. 
*/
select to_number('123') + to_number('456') from dual; -- 두 문자가 숫자로 변환되어 
                                                                                        -- 덧셈의 결과 인출됨.

/*
to_date() 
    : 문자열 데이터를 날짜형식으로 변환해서 출력해줌.(Oracle에 지정된 기본
    날짜포맷으로 반환됨)
*/
select
    to_date('2020-03-17') "날짜1",
    to_date('20200317') "날짜2",
    to_date('2020/03/17') "날짜3"
from dual;

/*
날짜포맷이 년-월-일 순이 아닌경우는 오라클이 인식하지 못하여 에러발생됨.
이런경우 날짜서식을 이용해서 오라클이 인식할수 있도록 처리해야함.
*/
select to_date('17-03-2020') "날짜서식맞지않음" from dual; --에러발생
select to_date('17-03-2020','dd-mm-yyyy') "날짜서식알려주기" from dual;

/*
날짜에 시간까지 포함되어 인식하지 못할경우
방법1 : 문자열을 날짜부분까지만 잘라서 인식하게한다.
방법2 : 날짜와 시간까지 서식문자를 통해 시스템이 인식하게 한다. 
*/
select to_date('2020-03-17 12:39:40') "날짜에시간포함" from dual; --에러발생
select to_date(substr('2020-03-17 12:39:40', 1, 10)) "날짜만잘라냄" from dual;
select to_date('2020-03-17 12:39:40', 'yyyy-mm-dd hh:mi:ss') "시간서식포함" from dual;

/*
활용 시나리오1] 문자열 '2012/04/03'는 어떤 요일인지 변환함수를 통해 출력하시오
*/
select
    to_date('2012/04/03') "1단계",
    to_char(to_date('2012/04/03'), 'day') "2단계",
    to_char(to_date('2012/04/03'), 'dy') "요일간단표시"
from dual;

/*
활용 시나리오2][퀴즈] 문자열 '2013년10월24일'은 어떤 요일인지 변환함수를 통해
    출력할수 있는 쿼리문을 작성하시오. 단 문자열은 임의로 변경할 수 없습니다.
*/
select
    to_char('2013년10월24일') "주어진문자열",
    to_date('2013년10월24일', 'yyyy"년"mm"월"dd"일"') "1단계:날짜변경",
    to_char(to_date('2013년10월24일', 'yyyy"년"mm"월"dd"일"'), 'day') "2단계:요일출력"
from dual;

/*
활용 시나리오3[퀴즈] : hr계정의 employees 테이블에서 사원번호 206인 사원이 어떤 요일에
    입사했는지 출력하는 쿼리문을 작성하시오.
*/
select
    hire_date, to_char(hire_date, 'day') "입사요일"
from employees
where employee_id=206;


/*
활용 시나리오4 : '2015-10-24 12:34:56' 형태로 주어진 데이터를 인자로하여 
    '0000년00월00일 0요일' 형식으로 변환함수를 이용하여 출력하시오.
*/ 
select
    to_date('2015-10-24 12:34:56', 'yyyy-mm-dd hh:mi:ss') as "1단계",
    to_char(to_date('2015-10-24 12:34:56', 'yyyy-mm-dd hh:mi:ss'), 
        'yyyy"년"mm"월"dd"일 "dy"요일"') as "2단계"
from dual;


/*
nvl() : null값을 다른 데이터로 변경하는 함수
    형식] nvl(컬럼명, 대체할값)
    
    ※레코드를 select해서 웹브라우저에 출력을 하는경우 해당 컬럼이 null이면
    NullPointerException이 발생하게 된다. 그러므로 아예 데이터를 가져올때 null값이 
    나올수 있는 컬럼에 대해 미리 처리하면 예외발생을 미리 차단할수 있으므로 편리하다.
*/
--사원테이블에서 보너스율이 null인 레코드를 0으로 대체해서 출력하는 쿼리를 작성하시오
select
    first_name, commission_pct, nvl(commission_pct, 0) AS "보너스율"
from employees;


/*
decode() :  java의  switch문과 비슷하게 특정값에 해당하는 출력문이 있는
    경우 사용한다. 
    형식] decode(컬럼명 , 
                            값1, 결과1,
                            값2, 결과2, 
                            .........
                            기본값)
        ※내부적인 코드값을 문자열로 변환하여 출력할때 많이 사용된다. 
*/
--사원테이블에서 각 부서에 해당하는 부서명을 출력하는 쿼리문을 작성하시오.
--10:최고관리자, 20:마케팅, 30:전산팀 .... 

select
    first_name, last_name, department_id,
    decode(department_id, 10, '최고관리자',
                                        20, '마케팅팀',
                                        30, '전산팀',
                                        90, '경영관리팀',
                                        '그외떨거지팀') AS TeamName
from employees;


/*
case() : java의 if~else문과 비슷한 역할을 하는 함수
    형식] case
                when 조건1 then 값1
                when 조건2 then 값2
                .....
                else 기본값
            end
*/
select
    case
        when department_id=20 then '마케팅'
        when department_id=60 then '전산팀'
        when department_id=90 then '경영관리'
        else '그외부서'
    end as TeamName
from employees
order by department_id desc;






select
    months_between(to_date('2017-12-31'), hire_date) AS "근속개월수1",
    round(months_between(to_date('2017-12-31'), hire_date)) AS "근속개월수2",
    months_between('2017-12-31', hire_date) AS "근속개월수3"
from employees
order by hire_date asc;



-----------------------------------------------------
--------------------연 습 문 제--------------------
-----------------------------------------------------

/*
1. substr() 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력하시오.
*/
select
    substr(hiredate, 1, 2) "입사년도",
    substr(hiredate, 4, 2) "입사월",
    to_char(hiredate, 'yy/mm') "입사년월"
from emp;

/*
2. substr()함수를 사용하여 4월에 입사한 사원을 출력하시오. 
즉, 연도에 상관없이 4월에 입사한 모든사원이 출력되면 된다.
*/
select *
from emp
where substr(hiredate, 4, 2)='04';

/*
3. mod() 함수를 사용하여 사원번호가 짝수인 사람만 출력하시오.
*/
select * from emp
where mod(empno, 2)=0
order by empno asc;

/*
4. 입사일을 연도는 2자리(YY), 월은 숫자(MON)로 표시하고 요일은 약어(DY)로 
지정하여 출력하시오.
*/
select
    hiredate,
    to_char(hiredate, 'yy') "입사년도2자리",
    to_char(hiredate, 'mon') "입사월",
    to_char(hiredate, 'dy') "입사요일",
    to_char(hiredate, 'day') "입사요일"
from emp;


/*
5. 올해 며칠이 지났는지 출력하시오. 현재 날짜에서 올해 1월1일을 뺀 결과를 
출력하고 TO_DATE()함수를 사용하여 데이터 형을 일치 시키시오. 
    sysdate - '20/01/01'
*/
select
    sysdate - to_date('20/01/01') "결과1",
    round(sysdate - to_date('20/01/01')) "결과2"
from dual;

/*
6. 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 NULL값 대신 
0으로 출력하시오.
*/
select
    empno, ename, nvl(mgr, 0)
from emp;


/*
7. decode 함수로 직급에 따라 급여를 인상하여 출력하시오. ‘CLERK’는 200, 
‘SALESMAN’은 180, ‘MANAGER’은 150, ‘PRESIDENT’는 100을 인상하여 출력하시오.
*/
select
    empno, ename, sal,
    decode(job, 
        'CLERK', sal+200,
        'SALESMAN', sal+180,
        'MANAGER', sal+150,
        'PRESIDENT', sal+100,
        sal) as "UpSalary"
from emp;












 

