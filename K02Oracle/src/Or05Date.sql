/*****************
���ϸ� : Or05Date.sql
��¥�Լ�
���� : ��, ��, ��, ��, ��, ���� �������� ��¥������ �����ϰų� 
    ��¥�� ����Ҷ� Ȱ���ϴ� �Լ���
*******************/

/*
months_between()
    : ���糯¥�� ���س�¥ ������ �������� ��ȯ�Ѵ�. 
    ����] months_between(���糯¥, ���س�¥[���ų�¥]);
*/
--2017��5��1�Ϻ��� ���ݱ��� ���� �������� ���ΰ�?
select
    to_char(sysdate, 'yyyy-mm-dd') "���糯¥",
    to_char('2017-05-01') "���ذ��ų�¥",
    months_between(sysdate, to_date('2017-05-10')) "����������"
from dual;

/*
Ȱ��ó�����1] emplyees ���̺� �Էµ� �������� �ټӰ������� ����Ͽ�
����Ͻÿ�. �ټӰ������� �������� �������� �����Ͻÿ�
*/
select
    last_name, hire_date,
    months_between(sysdate, hire_date) "�ټӰ�����1",
    round(months_between(sysdate, hire_date)) "�ټӰ�����2",
    trunc(months_between(sysdate, hire_date), 2) "�ټӰ�����3"
from employees
order by "�ټӰ�����3" desc;

/*
Ȱ��ó�����2][����] �� ������ ���糯¥ ������ �ƴ� '2017-12-31'�� 
�������� �����Ͻÿ�.
*/
select
    months_between('2017-12-31', hire_date) as "�ټӰ�����1",
    months_between(to_date('2017-12-31'), hire_date) as "�ټӰ�����2",
    round(months_between(to_date('2017-12-31'), hire_date)) as "�ټӰ�����3"
from employees
order by hire_date asc;/*
                months_between() �Լ��� ���ڷ� ��¥�� �־����� ����Ŭ �⺻����
                ��-��-�� �� ��쿡�� to_date()�� ��ȯ���� �״�� ����ص� �ȴ�. 
                ��, ������ Ʋ����쿡�� ��¥�� ��ȯ�� �����ؾ� �ȴ�. 
        */


/*
add_months() : ��¥�� �������� ���� ����� ��ȯ�Ѵ�. 
    ����] add_months(���糯¥, ���� ������)
*/
--���縦 �������� 7���� ������ ��¥�� ���Ͻÿ�.
select
    to_char(sysdate, 'yyyy/mm/dd') "���糯¥",
    add_months(sysdate, 7) "7�������ĳ�¥"
from dual;

/*
Ȱ��ó�����] 61���� �������� ����غ���.
    ������ : 20/02/10
*/
select
    add_months('20/02/10', 6) as "�츮�Ǽ�����"
from dual;


/*
next_day() : ���糯¥�� �������� ���ڷ� �־��� ���Ͽ� �ش��ϴ�
    �̷��� ��¥�� ��ȯ�ϴ� �Լ�
    ����] next_day(���糯¥, '������')
        -> ������ �������� �����ΰ���?
*/
select
    to_char(sysdate, 'yyyy-mm-dd') "���ó�¥",
    to_char(next_day(sysdate, '������'), 'yyyy-mm-dd') "������������?",
    to_char(next_day(sysdate, 'ȭ����'), 'yyyy-mm-dd') "����ȭ������?",
    to_char(next_day(sysdate, '������'), 'yyyy-mm-dd') "������������?"
from dual; -- ������ ������ ��¥�� ��ȸ�� �� ����.

/*
last_day() : �ش���� ������ ��¥�� ��ȯ��
    ����] last_day(��¥)
*/
select last_day('20/02/01') from dual; -- 20�� 2���� 29�ϱ��� ����. (����)


--�÷��� date���ΰ�� ������ ��¥������ �����ϴ�.
select
    sysdate "���糯¥",
    sysdate + 1 "����",
    sysdate -1 "����",
    sysdate + 7 "��������"
from dual;






































