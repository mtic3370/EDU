/*****************************
���ϸ� : Or06GroupBy.sql
�׷��Լ�(select�� 2��°)
���� : ��ü ���ڵ�(�ο�)���� ������� ����� ���ϱ� ���� �ϳ� �̻���
    ���ڵ带 �׷����� ��� ������ ����� ��ȯ�ϴ� �Լ� Ȥ�� ������
*******************************/
/*
distinct 
    - �ߺ��Ǵ� ���ڵ带 �������� �ϳ��� ���ڵ常 �����ͼ� �����ش�. 
    - ���� ������� �����͸� ����� �� ����. 
*/
select distinct job_id from employees;

select job_id from employees;

/*
group by
    - ������ ���� �ִ� ���ڵ带 �ϳ��� �׷����� ��� �����´�.
    - �������°� �ϳ��� ���ڵ�������, �������� ���ڵ尡 ������ ����̹Ƿ�
    ������� �����͸� ����� �� �ִ�. 
    -�ִ�, �ּ�, ���, �ջ� ���� �����ϴ�. 
*/
select job_id from employees group by job_id;

/*
�׷��Լ��� �⺻����
    : []���ȣ �κ��� ��������. 
    
    select
        �÷�1, �÷�2..... Ȥ�� *(��ü)
    from    
         ���̺��
    [where
        ����1 or ����2  and ����3.....]
    [group by
        ������ �׷�ȭ�� ���� �÷���]   
    [having
        �׷쿡�� ã�� ����]
    [order by
        ���ڵ� ������ ���� �÷��� ���Ĺ��(asc / desc)]
        
    �� ������ �������
    from -> where -> group by -> having -> select -> order by
*/


/*
sum() : �հ踦 ���Ҷ� ����ϴ� �Լ�
    ����] sum(�÷�)
    -numberŸ���� �÷������� ��밡��
    -�ʵ���� �ʿ��� ��� AS�� �̿��ؼ� ��Ī �ο� ����
*/
--��ü������ �޿��� �հ踦 ����Ͻÿ�.
select
    sum(salary),
    sum(salary) AS SumSalary,
    to_char(sum(salary), '999,000') AS TotalSalary1,
    to_char(sum(salary), 'L999,000') AS TotalSalary2
from employees
where 1=1;
-- 1=1 : ���� �������� where���� ���ԵǸ� ��� ���ڵ带 ������� �Ѵٴ� �ǹ�.


--10�� �μ��� �ٹ��ϴ� ������� �޿��հ�� ������ ����Ͻÿ�
select
    sum(salary) SalaySum1,
    to_char(sum(salary), '$999,999') SalaySum2,
    trim(to_char(sum(salary), '$999,999')) SalaySum3
from employees
where department_id=10;

--sum()�� ���� �׷��Լ��� NumberŸ���� �÷������� ��밡��. 
select sum(first_name) from employees;--�����߻�


/*
count() : ���ڵ��� ������ ī��Ʈ�Ҷ� ����ϴ� �Լ�
*/
select count(*) from employees;--���1
select count(employee_id) from employees;--���2
/*
    count()�Լ��� ����Ҷ��� �� 2���� ��� ��� �����ϳ�,
    *�� ����Ұ��� �����ϰ� �ִ�. �÷��� Ư���� Ÿ���ʾ�
    �˻��ӵ��� ������. 
*/

/*
count()�Լ��� 
    ����1 : count(all �÷���)
        => ����Ʈ. �÷���ü�� ���ڵ带 �������� ī��Ʈ�Ѵ�.
    ����2 : count(distinct �÷���)
        => �ߺ��� ������ ���¿��� ī��Ʈ�Ѵ�. 
*/
select
    count(all job_id) "��������ü����",
    count(distinct job_id) "��������������"
from employees;


/*
avg() : ��հ��� ���Ҷ� ����ϴ� �Լ�
*/
--��ü����� ��ձ޿��� �������� ����ϴ� �������� �ۼ��Ͻÿ�.
select
    count(*) "�����",
    sum(salary) "�޿����հ�",
    sum(salary) / count(*) "��ձ޿�1",
    round(sum(salary) / count(*)) "��ձ޿�2",
    avg(salary) "avg()�Լ����1",
    to_char(avg(salary), '$999,000') "avg()�Լ����2"
from employees;

--�������� ��ձ޿��� ���ΰ�?
select * from departments where department_name='Sales';
--��/�ҹ��� ���� �Լ��� �̿��ؼ� �Ʒ��Ͱ��� select ������.
select * from departments where lower(department_name)='sales';
select * from departments where upper(department_name)='SALES';

select
    to_char(avg(salary), '$999,000.00') as "��������ձ޿�"
from employees where department_id=80;


/*
max() / min() : �ִ밪, �ּҰ��� ã���� ����ϴ� �Լ�
*/
--����� �޿��� ���� ���� ����� �����ΰ�?
--step1 : ����� ���� ���� �޿��� ������ ã�´�.
select max(salary) from employees;
--step2 : ������ ���� 24000�޷��� �޴� ������ ã�´�.
select first_name, last_name, job_id from employees
where salary=24000;
--step3 : �� 2���� ������ �ϳ��� ���������� ��ģ��.
select first_name, last_name, job_id 
from employees
where salary=(
    select max(salary) from employees
);
/*
�� ������ ���������� ���ؼ��� 1���� �ذ��� �����ϴ�. 
�׷��� �ʴٸ� 2���� ������ ������ �����ؾ� �Ѵ�. 
���� ������ �ľ����� ���������� ����ؾ����� �����ؾ� �Ѵ�..
*/

--����� ���� ���� �޿��� ���ΰ���?
select min(salary) from employees;
--�ִ�/�ּ� �޿� �������� ���ĵ� ���ڵ� ����
select distinct salary from employees order by salary asc;


/*
group by�� : �������� ���ڵ带 �ϳ��� �׷����� �׷�ȭ�Ͽ� ������
    ����� ��ȯ�ϴ� ������
    �� distinct �� �ܼ��� �ߺ����� ������.
*/
--������̺��� ���ڵ带 �μ����� �׷�ȭ�Ͽ� Ȯ���ϱ�
select department_id from employees
group by department_id;
/*
���� ������ �����̱� �ϳ� �׷����� ������ �ʴ� first_name��
������ �ָ��ϹǷ� ������ �߻��Ѵ�. select���� group_by���� 
����� �÷��� �����ü� �ִ�. �׿� �÷��� �׷��Լ��� ����ؾ��Ѵ�.
*/
select department_id, first_name from employees
group by department_id; --�����߻�

--�� �μ��� �޿��� �հ�� ���ΰ�?
select
    department_id, sum(salary) "�μ����޿�����1",
    to_char(sum(salary), '$999,000') "�μ����޿�����2"
from employees
group by department_id
order by sum(salary) desc;

/*
�ó�����][����] �μ��� ������� ��ձ޿��� ���ΰ���? 
    ��°��] �μ���ȣ, �޿�����, �������, ��ձ޿�
        �μ���ȣ ������� �������� �����ϼ���.
*/
select
    department_id "�μ���ȣ",
    to_char(sum(salary), '999,000') "�޿�����",
    count(*) "�������",
    to_char(avg(salary), '999,000.00') "��ձ޿�"
from employees
group by department_id
order by department_id asc;

/*
�μ��� �޿��� �հ踦 distinct �� ����ؼ� SQL���� �ۼ��Ҽ� ����.
ORA-00937: ���� �׷��� �׷� �Լ��� �ƴմϴ�.
*/
select distinct department_id, sum(salary)
from employees;

/*
�ó�����] �μ����̵� 50�� ������� ��������, ��ձ޿�, �޿������� 
������ ǥ���ϴ� �������� �ۼ��Ͻÿ�.
*/
select
    count(*) "������",
    sum(salary) "�޿�����",
    avg(salary) "��ձ޿�"
from employees
where department_id=50
group by department_id;


/*
having�� : ���������� �����ϴ� �÷��� �ƴ� �׷��Լ��� ���� ��������
    ������ �÷��� ������ �߰��Ҷ� ����Ѵ�. 
    �ش� ������ where���� �߰��ϸ� ������ �߻��ȴ�. 
*/
/*
�ó�����] ������̺��� �� �μ����� �ٹ��ϰ� �ִ� ������ �������� �������
    ��ձ޿��� �������� ����ϴ� �������� �ۼ��Ͻÿ�.
    ��, ����� ������ 10���� �ʰ��ϴ� ���ڵ常 �����Ͻÿ�. 
*/
select
    department_id "�μ���ȣ", job_id "������ID", count(*) "�����", avg(salary) "��ձ޿�"
from employees
where 1=1
group by department_id, job_id
having  count(*)>10
order by department_id desc ;
/*
--�Ʒ� ������ ���� �߻���. count(*)>10�� �׷��Լ��̹Ƿ� where���� ����Ҽ� ����.
ORA-00934: �׷� �Լ��� �㰡���� �ʽ��ϴ�
*/
select
    department_id "�μ���ȣ", job_id "������ID", count(*) "�����", avg(salary) "��ձ޿�"
from employees
where 1=1 and count(*)>10
group by department_id, job_id
order by department_id desc ;--�����߻�


------------------------------------------------------
----------------�� �� �� �� -----------------------
------------------------------------------------------
/*
hr ������ employees ���̺� ���
*/

/*
1. ��ü ����� �޿��ְ��, ������, ��ձ޿��� ����Ͻÿ�. 
�÷��� ��Ī�� �Ʒ��� ���� �ϰ�, ��տ� ���ؼ��� 
�������·� �ݿø� �Ͻÿ�.
��Ī) �޿��ְ�� -> MaxPay
�޿������� -> MinPay
�޿���� -> AvgPay
*/  
select
    max(salary) "�޿��ְ��", min(salary) "�޿�������", round(avg(salary)) "�޿����"
from employees
where 1=1;


/*
2. �� ������ �������� �޿��ְ��, ������, �Ѿ� �� ��վ��� 
����Ͻÿ�. �÷��� ��Ī�� �Ʒ��� �����ϰ� ��� ���ڴ� 
to_char�� �̿��Ͽ� ���ڸ����� �ĸ��� ��� �������·� ����Ͻÿ�.
��Ī) �޿��ְ�� -> MaxPay
�޿������� -> MinPay
�޿���� -> AvgPay
�޿��Ѿ� -> SumPay
����) employees ���̺��� job_id�÷��� �������� �Ѵ�.
*/ 
select
    to_char(max(salary),'999,000') "MaxPay", to_char(min(salary),'999,000') "MinPay", 
    to_char(avg(salary),'999,000') AvgPay, to_char(sum(salary),'999,000') SumPay
from employees
group by job_id;

/*
3. count() �Լ��� �̿��Ͽ� �������� ������ ������� 
����Ͻÿ�.
����) employees ���̺��� job_id�÷��� �������� �Ѵ�.
*/
select
    job_id, count(*) CrewCount
from employees
group by job_id
order by CrewCount desc;

/*
4. �޿��� 10000�޷� �̻��� �������� �������� �հ��ο����� 
����Ͻÿ�.    
*/ 
select
    job_id, count(*) "�������ο��հ�"
from employees
where salary>=10000
group by job_id
order by count(*);
/*
    �޿��� 1000 �̻���...���� => where��
    �޿��� �հ谡 400�̻���..���� => having��
    �� ���������Ϳ� ���� �����̶�� where���� ����ϰ�
    �׷쿡 ���� ���Ӱ� ������ �����Ͷ�� having���� ����ؾ��Ѵ�. 
*/


/*
5. �޿� �ְ�װ� �������� ������ ����Ͻÿ�. 
*/ 
select
    (max(salary) - min(salary)) "�ְ������޿���"
from employees;

/*
6. ���޺� ����� �����޿��� ����Ͻÿ�. 
(�����ڸ� �˼����� ��� �� �����޿��� 3000�̸��� �׷���)
���ܽ�Ű�� ����� �޿��� ������������ �����Ͽ� ����Ͻÿ�.
*/ 
select
    job_id, min(salary)
from employees
where manager_id is not null 
group by job_id
having not min(salary)<3000
order by min(salary) desc;

/*
7. �� �μ��� ���� �μ���ȣ, �����, 
�μ� ���� ��� ����� ��ձ޿��� ����Ͻÿ�. 
��ձ޿��� �Ҽ��� ��°�ڸ��� �ݿø��Ͻÿ�.
*/ 
select
    department_id "�μ���ȣ", count(*) "�����", round(avg(salary),2) "��ձ޿�"
from employees
group by department_id;

/*
8. �� �μ��� ���� �μ���ȣ, �μ��̸�, ������, �����, �μ����� 
��� ����� ��ձ޿��� ����Ͻÿ�. ��ձ޿��� ������ �ݿø��ϰ� 
���ڸ����� �ĸ��� ����Ͻÿ�.
decode�Լ��� ����Ͽ� �� �μ���ȣ�� �´� �μ����� ������ �Ͻÿ�.
(����, ���������� ������� �ʴ´�)
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
        100,'Finance', '�׳ɺμ�') AS "�μ���", 
    decode(department_id, 
        10, 'Seattle',
        20, 'Toronto',
        30, 'Seattle',
        40, 'London',
        50, 'South San Francisco', '�׳�����') AS "������",    
    count(*), to_char(avg(salary),'$999,000')
from employees
group by department_id;






