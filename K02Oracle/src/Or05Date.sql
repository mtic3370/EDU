/*****************
파일명 : Or05Date.sql
날짜함수
설명 : 년, 월, 일, 시, 분, 초의 포맷으로 날짜형식을 지정하거나 
    날짜를 계산할때 활용하는 함수들
*******************/

/*
months_between()
    : 현재날짜와 기준날짜 사이의 개월수를 반환한다. 
    형식] months_between(현재날짜, 기준날짜[과거날짜]);
*/
--2017년5월1일부터 지금까지 지난 개월수는 얼마인가?
select
    to_char(sysdate, 'yyyy-mm-dd') "현재날짜",
    to_char('2017-05-01') "기준과거날짜",
    months_between(sysdate, to_date('2017-05-10')) "지난개월수"
from dual;

/*
활용시나리오1] emplyees 테이블에 입력된 직원들의 근속개월수를 계산하여
출력하시오. 근속개월수를 기준으로 오름차순 정렬하시오
*/
select
    last_name, hire_date,
    months_between(sysdate, hire_date) "근속개월수1",
    round(months_between(sysdate, hire_date)) "근속개월수2",
    trunc(months_between(sysdate, hire_date), 2) "근속개월수3"
from employees
order by "근속개월수3" desc;

/*
활용시나리오2][퀴즈] 위 문제를 현재날짜 기준이 아닌 '2017-12-31'을 
기준으로 변경하시오.
*/
select
    months_between('2017-12-31', hire_date) as "근속개월수1",
    months_between(to_date('2017-12-31'), hire_date) as "근속개월수2",
    round(months_between(to_date('2017-12-31'), hire_date)) as "근속개월수3"
from employees
order by hire_date asc;/*
                months_between() 함수의 인자로 날짜가 주어질때 오라클 기본포맷
                년-월-일 인 경우에는 to_date()로 변환없이 그대로 사용해도 된다. 
                단, 포맷이 틀린경우에는 날짜로 변환후 적용해야 된다. 
        */


/*
add_months() : 날짜에 개월수를 더한 결과를 반환한다. 
    형식] add_months(현재날짜, 더할 개월수)
*/
--현재를 기준으로 7개월 이후의 날짜를 구하시오.
select
    to_char(sysdate, 'yyyy/mm/dd') "현재날짜",
    add_months(sysdate, 7) "7개월이후날짜"
from dual;

/*
활용시나리오] 61기의 수료일을 계산해보자.
    개강일 : 20/02/10
*/
select
    add_months('20/02/10', 6) as "우리의수료일"
from dual;


/*
next_day() : 현재날짜를 기준으로 인자로 주어진 요일에 해당하는
    미래의 날짜를 반환하는 함수
    형식] next_day(현재날짜, '월요일')
        -> 다음주 월요일은 몇일인가요?
*/
select
    to_char(sysdate, 'yyyy-mm-dd') "오늘날짜",
    to_char(next_day(sysdate, '월요일'), 'yyyy-mm-dd') "다음월요일은?",
    to_char(next_day(sysdate, '화요일'), 'yyyy-mm-dd') "다음화요일은?",
    to_char(next_day(sysdate, '수요일'), 'yyyy-mm-dd') "다음수요일은?"
from dual; -- 일주일 이후의 날짜는 조회할 수 없음.

/*
last_day() : 해당월의 마지막 날짜를 반환함
    형식] last_day(날짜)
*/
select last_day('20/02/01') from dual; -- 20년 2월은 29일까지 있음. (윤년)


--컬럼이 date형인경우 간단한 날짜연산이 가능하다.
select
    sysdate "현재날짜",
    sysdate + 1 "내일",
    sysdate -1 "어제",
    sysdate + 7 "일주일후"
from dual;






































