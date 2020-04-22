/**********************************
���ϸ� : Or04TypeConvert.sql
����ȯ�Լ� / ��Ÿ�Լ�
���� : ������Ÿ���� �ٸ� Ÿ������ ��ȯ�ؾ� �Ҷ� ����ϴ� �Լ��� ��Ÿ�Լ�
***********************************/

/*
sysdate : ���糯¥�� �ð��� �ʴ����� ��ȯ���ش�. �ַ� �Խ��ǿ��� 
    ���ο� �������� ������ �Է��ѳ�¥�� ǥ���ϱ� ���� ���ȴ�. 
*/
select sysdate from dual; -- 20/03/17

/*
to_char() : ��¥�� ���ڸ� ���������� ��ȯ�Ҷ� ����ϴ� �Լ�.
    ����] to_char(���� or ��¥�� ������ �÷�, '�ð�����/��ȭ����,��¥���� ��)
*/

/* ��¥ ���� */
--���糯¥�� 0000/00/00 ���·� ����Ͻÿ�   
select to_char(sysdate, 'yyyy/mm/DD') "���ó�¥" from dual;

--���糯¥�� 00-00-00 ���·� ����Ͻÿ�   
select to_char(sysdate, 'yy-mm-dd') "���ó�¥" from dual;

--���糯¥�� "������ 0000�� 00�� 00�� 00�����Դϴ�" ���·� ����Ͻÿ�
select
    to_char(sysdate, '������ yyyy�� mm�� dd�� dy�����Դϴ�') "�����ɱ�?"
from dual; -- �����߻� : ��¥������ �������մϴ�.

select
    to_char(sysdate, '"������ "yyyy"�� "mm"�� "dd"�� "dy"�����Դϴ�"') "��¥����������ǥ��"
from dual;-- ������µ� : ���Ĺ��ڸ� ������ ������ ���ڿ��� "(����)�� �����ش�.

select
    to_char(sysdate, 'day') "����(ȭ����)",
    to_char(sysdate, 'dy') "����(ȭ)",
    to_char(sysdate, 'mon') "��(3��)",
    to_char(sysdate, 'mm') "��(03)",
    to_char(sysdate, 'month') "��(3��)",
    to_char(sysdate, 'yy') "2�ڸ��⵵",
    to_char(sysdate, 'dd') "���� ���ڷ� ǥ��",
    to_char(sysdate, 'ddd') "1���� ���° ��"
from dual;

/* �ð� ���� */
--����ð��� 00:00:00���·� ǥ���ϱ�
select 
    to_char(sysdate, 'HH:MI:SS') "�빮�ڼ���",
    to_char(sysdate, 'hh:mi:ss') "�ҹ��ڼ���"
from dual;

--���糯¥�� �ð��� �Ѳ����� ǥ���ϱ�
select to_char(sysdate, 'yyyy-mm-dd hh:mi:ss') from dual;

--���� �ð��� ����/���� Ȥ�� 24�ð����� ǥ���ϱ�
select 
    to_char(sysdate, 'hh am') AS "AM���" ,
    to_char(sysdate, 'hh pm') "PM���",
    to_char(sysdate, 'hh24') "24�ð���"
from dual; -- ����/���ĸ� ǥ���ϴ� ���Ĺ��ڴ� am Ȥ�� pm�� ����� �����ϴ�.

/* ���� ���� */
/*
    0 : ������ �ڸ����� ��Ÿ���� �ڸ����� ���� ������� 0���� �ڸ��� ä���.
    9 : 0�� ���������� �ڸ����� ���� ������ �������� ä���. 
*/
select 
    to_char(123, '0000') "���Ĺ���0���",
    to_char(123, '9999') "���Ĺ���9���",
    trim(to_char(123, '9999')) "trim()���"
from dual;

select
    to_char(12345, '000,000') ,
    to_char(12345, '999,999') ,
    to_char(12345, '999,000') ,
    to_char(123456, '000,000,000') ,
    ltrim(to_char(123456, '999,999,000')) "������������"
from dual;

--��ȭǥ�� : L -> �� ���� �´� ��ȭǥ�ð� �ȴ�. �ѱ��� ��� \(��)
select to_char(12345, 'L999,999') from dual;


/*
to_number() : ������ �����͸� ���������� ��ȯ�Ѵ�. 
*/
select to_number('123') + to_number('456') from dual; -- �� ���ڰ� ���ڷ� ��ȯ�Ǿ� 
                                                                                        -- ������ ��� �����.

/*
to_date() 
    : ���ڿ� �����͸� ��¥�������� ��ȯ�ؼ� �������.(Oracle�� ������ �⺻
    ��¥�������� ��ȯ��)
*/
select
    to_date('2020-03-17') "��¥1",
    to_date('20200317') "��¥2",
    to_date('2020/03/17') "��¥3"
from dual;

/*
��¥������ ��-��-�� ���� �ƴѰ��� ����Ŭ�� �ν����� ���Ͽ� �����߻���.
�̷���� ��¥������ �̿��ؼ� ����Ŭ�� �ν��Ҽ� �ֵ��� ó���ؾ���.
*/
select to_date('17-03-2020') "��¥���ĸ�������" from dual; --�����߻�
select to_date('17-03-2020','dd-mm-yyyy') "��¥���ľ˷��ֱ�" from dual;

/*
��¥�� �ð����� ���ԵǾ� �ν����� ���Ұ��
���1 : ���ڿ��� ��¥�κб����� �߶� �ν��ϰ��Ѵ�.
���2 : ��¥�� �ð����� ���Ĺ��ڸ� ���� �ý����� �ν��ϰ� �Ѵ�. 
*/
select to_date('2020-03-17 12:39:40') "��¥���ð�����" from dual; --�����߻�
select to_date(substr('2020-03-17 12:39:40', 1, 10)) "��¥���߶�" from dual;
select to_date('2020-03-17 12:39:40', 'yyyy-mm-dd hh:mi:ss') "�ð���������" from dual;

/*
Ȱ�� �ó�����1] ���ڿ� '2012/04/03'�� � �������� ��ȯ�Լ��� ���� ����Ͻÿ�
*/
select
    to_date('2012/04/03') "1�ܰ�",
    to_char(to_date('2012/04/03'), 'day') "2�ܰ�",
    to_char(to_date('2012/04/03'), 'dy') "���ϰ���ǥ��"
from dual;

/*
Ȱ�� �ó�����2][����] ���ڿ� '2013��10��24��'�� � �������� ��ȯ�Լ��� ����
    ����Ҽ� �ִ� �������� �ۼ��Ͻÿ�. �� ���ڿ��� ���Ƿ� ������ �� �����ϴ�.
*/
select
    to_char('2013��10��24��') "�־������ڿ�",
    to_date('2013��10��24��', 'yyyy"��"mm"��"dd"��"') "1�ܰ�:��¥����",
    to_char(to_date('2013��10��24��', 'yyyy"��"mm"��"dd"��"'), 'day') "2�ܰ�:�������"
from dual;

/*
Ȱ�� �ó�����3[����] : hr������ employees ���̺��� �����ȣ 206�� ����� � ���Ͽ�
    �Ի��ߴ��� ����ϴ� �������� �ۼ��Ͻÿ�.
*/
select
    hire_date, to_char(hire_date, 'day') "�Ի����"
from employees
where employee_id=206;


/*
Ȱ�� �ó�����4 : '2015-10-24 12:34:56' ���·� �־��� �����͸� ���ڷ��Ͽ� 
    '0000��00��00�� 0����' �������� ��ȯ�Լ��� �̿��Ͽ� ����Ͻÿ�.
*/ 
select
    to_date('2015-10-24 12:34:56', 'yyyy-mm-dd hh:mi:ss') as "1�ܰ�",
    to_char(to_date('2015-10-24 12:34:56', 'yyyy-mm-dd hh:mi:ss'), 
        'yyyy"��"mm"��"dd"�� "dy"����"') as "2�ܰ�"
from dual;


/*
nvl() : null���� �ٸ� �����ͷ� �����ϴ� �Լ�
    ����] nvl(�÷���, ��ü�Ұ�)
    
    �ط��ڵ带 select�ؼ� ���������� ����� �ϴ°�� �ش� �÷��� null�̸�
    NullPointerException�� �߻��ϰ� �ȴ�. �׷��Ƿ� �ƿ� �����͸� �����ö� null���� 
    ���ü� �ִ� �÷��� ���� �̸� ó���ϸ� ���ܹ߻��� �̸� �����Ҽ� �����Ƿ� ���ϴ�.
*/
--������̺��� ���ʽ����� null�� ���ڵ带 0���� ��ü�ؼ� ����ϴ� ������ �ۼ��Ͻÿ�
select
    first_name, commission_pct, nvl(commission_pct, 0) AS "���ʽ���"
from employees;


/*
decode() :  java��  switch���� ����ϰ� Ư������ �ش��ϴ� ��¹��� �ִ�
    ��� ����Ѵ�. 
    ����] decode(�÷��� , 
                            ��1, ���1,
                            ��2, ���2, 
                            .........
                            �⺻��)
        �س������� �ڵ尪�� ���ڿ��� ��ȯ�Ͽ� ����Ҷ� ���� ���ȴ�. 
*/
--������̺��� �� �μ��� �ش��ϴ� �μ����� ����ϴ� �������� �ۼ��Ͻÿ�.
--10:�ְ������, 20:������, 30:������ .... 

select
    first_name, last_name, department_id,
    decode(department_id, 10, '�ְ������',
                                        20, '��������',
                                        30, '������',
                                        90, '�濵������',
                                        '�׿ܶ�������') AS TeamName
from employees;


/*
case() : java�� if~else���� ����� ������ �ϴ� �Լ�
    ����] case
                when ����1 then ��1
                when ����2 then ��2
                .....
                else �⺻��
            end
*/
select
    case
        when department_id=20 then '������'
        when department_id=60 then '������'
        when department_id=90 then '�濵����'
        else '�׿ܺμ�'
    end as TeamName
from employees
order by department_id desc;






select
    months_between(to_date('2017-12-31'), hire_date) AS "�ټӰ�����1",
    round(months_between(to_date('2017-12-31'), hire_date)) AS "�ټӰ�����2",
    months_between('2017-12-31', hire_date) AS "�ټӰ�����3"
from employees
order by hire_date asc;



-----------------------------------------------------
--------------------�� �� �� ��--------------------
-----------------------------------------------------

/*
1. substr() �Լ��� ����Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ����Ͻÿ�.
*/
select
    substr(hiredate, 1, 2) "�Ի�⵵",
    substr(hiredate, 4, 2) "�Ի��",
    to_char(hiredate, 'yy/mm') "�Ի���"
from emp;

/*
2. substr()�Լ��� ����Ͽ� 4���� �Ի��� ����� ����Ͻÿ�. 
��, ������ ������� 4���� �Ի��� ������� ��µǸ� �ȴ�.
*/
select *
from emp
where substr(hiredate, 4, 2)='04';

/*
3. mod() �Լ��� ����Ͽ� �����ȣ�� ¦���� ����� ����Ͻÿ�.
*/
select * from emp
where mod(empno, 2)=0
order by empno asc;

/*
4. �Ի����� ������ 2�ڸ�(YY), ���� ����(MON)�� ǥ���ϰ� ������ ���(DY)�� 
�����Ͽ� ����Ͻÿ�.
*/
select
    hiredate,
    to_char(hiredate, 'yy') "�Ի�⵵2�ڸ�",
    to_char(hiredate, 'mon') "�Ի��",
    to_char(hiredate, 'dy') "�Ի����",
    to_char(hiredate, 'day') "�Ի����"
from emp;


/*
5. ���� ��ĥ�� �������� ����Ͻÿ�. ���� ��¥���� ���� 1��1���� �� ����� 
����ϰ� TO_DATE()�Լ��� ����Ͽ� ������ ���� ��ġ ��Ű�ÿ�. 
    sysdate - '20/01/01'
*/
select
    sysdate - to_date('20/01/01') "���1",
    round(sysdate - to_date('20/01/01')) "���2"
from dual;

/*
6. ������� ��� ����� ����ϵ� ����� ���� ����� ���ؼ��� NULL�� ��� 
0���� ����Ͻÿ�.
*/
select
    empno, ename, nvl(mgr, 0)
from emp;


/*
7. decode �Լ��� ���޿� ���� �޿��� �λ��Ͽ� ����Ͻÿ�. ��CLERK���� 200, 
��SALESMAN���� 180, ��MANAGER���� 150, ��PRESIDENT���� 100�� �λ��Ͽ� ����Ͻÿ�.
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












 

