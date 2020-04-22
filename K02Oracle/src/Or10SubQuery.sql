/******************
���ϸ� : Or10SubQuery.sql
��������
���� : �������ȿ� �� �ٸ� �������� ���� ������ select��
*******************/

/*
������ ��������
    ����]
        select * from ���̺�� where �÷�=(
            select �÷� from ���̺�� where ����
        );
    �� ��ȣ���� ���������� �ݵ�� �ϳ��� ����� �����ؾ� �Ѵ�. 
*/

/*
�ó�����] ������̺��� ��ü����� ��ձ޿����� ���� �޿��� �޴� ������� 
�����Ͽ� ����Ͻÿ�.
    ����׸� : �����ȣ, �̸�, �̸���, ����ó, �޿�
*/
select first_name, email, salary
from employees
where salary < round(avg(salary)) ;/*
    ORA-00934: �׷� �Լ��� �㰡���� �ʽ��ϴ�
    �ش� �������� ���ƻ� �´µ��ϳ� ���Ͱ��� ������ �߻��ȴ�. 
    �׷��Լ��� �����࿡ ������ �߸��� �������̴�. 
*/
--1�ܰ� : ��ü������ ��� �޿��� ���Ѵ�. 
select round(avg(salary)) from employees;
--2�ܰ� : 6462���� ���� �޿��� �޴� ������ �����´�. 
select * from employees where salary<6462;
--3�ܰ� : �� 2���� ������ �ϳ��� �������������� ��ħ.
/*
    -���������� �ݵ�� () �Ұ�ȣ �ȿ� ����ؾ� �Ѵ�.
    -���������� ���������� ����Ǿ�� �Ѵ�. 
*/
select first_name, last_name, email, salary 
    from employees where salary<(
        select round(avg(salary)) from employees
    );

/*
�ó�����] ��ü ����� �޿��� �������� ����� �̸��� �޿��� ����ϴ� 
������������ �ۼ��Ͻÿ�.
����׸� : �̸�1, �̸�2, �̸���, �޿�
*/
select first_name, last_name, email, salary from employees 
where salary=min(salary); -- �����߻�

--1�ܰ� : �ּұ޿��� ã�´�. -> 2100
select min(salary) from employees;
--2�ܰ� : 2100�޷��� �޿��� �޴� ������ �����Ѵ�.
select * from employees where salary=2100;
--3�ܰ� :  ������ ��ģ��.
select first_name, last_name, email, salary from employees where salary=(
    select min(salary) from employees
);

/*
�ó�����] ��ձ޿����� ���� �޿��� �޴� ������� ����� ��ȸ�Ҽ� �ִ� 
������������ �ۼ��Ͻÿ�.
��³��� : �̸�1, �̸�2, ��������, �޿�
�� ���������� jobs ���̺� �����Ƿ� join�ؾ� �Ѵ�. 
*/
--1.��ձ޿�
select round(avg(salary)) from employees;
--2.6462�̻��� �޿��� �޴� ����� ����
select
    first_name, last_name, J.job_id, job_title, salary
from employees E inner join jobs J
    on E.job_id=J.job_id
where
    salary>=6462;
--3.��������
select
    first_name, last_name, J.job_id, job_title, salary
from employees E inner join jobs J
    on E.job_id=J.job_id
where
    salary>=(select round(avg(salary)) from employees);




/*
������ ��������
    ����]
        select * from ���̺�� where �÷� in (
            select �÷� from ���̺�� where ����
        );
    �� ��ȣ���� ���������� 2�� �̻��� ����� �����ؾ� �Ѵ�.
*/

--�����࿬���� : in

/*
�ó�����] ���������� ���� ���� �޿��� �޴� ����� ����� ��ȸ�Ͻÿ�.
    ��¸�� : ������̵�, �̸�, ���������̵�, �޿� 
*/
-- 1. ������̺��� �ܼ� ������ ���� ������ ��׿����� Ȯ��
select job_id, salary from employees
order by job_id, salary desc;
-- 2. 1������ Ȯ���� ���ڵ带  group by���� �׷�ȭ�Ͽ� �� ������
--     �ִ�޿��� Ȯ��
select job_id, max(salary)
from employees
group by job_id
order by job_id asc;
-- 3. 2�ܰ��� ����� ������� �ܼ� ������ �ۼ�
/*
    2�ܰ迡�� 19���� �������� �������Ƿ� �̸� �ܼ� ������ �ۼ��ϸ�
    19���� ������ or�����ڷ� �����ؾ� �Ѵ�. ������ ���� �������Ƿ�
    ��ȿ�����̴�. 
*/
select 
    employee_id, first_name, job_id, salary
from employees
where
    (job_id='AC_ACCOUNT' and salary=8300) or
    (job_id='AC_MGR' and salary=12008) or
    (job_id='AD_ASST' and salary=4400);    
--4. 3�� �������� ���������� ����. ���������� ����� �������̹Ƿ� in�� ����Ѵ�. 
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
�����࿬���� : any
    ���������� �������� ���������� �˻������ �ϳ��̻�
    ��ġ�ϸ� ���� �Ǵ� ������. �� ���� �ϳ��� �����ϸ�
    �ش� ���ڵ带 �����´�. 
*/

/*
�ó�����] ��ü����߿��� �μ���ȣ�� 20�� ������� �޿����� ���� �޿��� �޴� �������� 
�����ϴ� ������������ �ۼ��Ͻÿ�. 
-> 6000 Ȥ�� 13000���� ���� �޿��� �޴� ���ڵ带 ����
��, 6000�޷� �̻��� �����鸸 �����ϸ� ������ ���ǿ� ������.
*/
--20�� �μ��� �޿� Ȯ��
select salary from employees where department_id=20;
--��������
select employee_id, department_id, first_name, salary
from employees
where salary >= any (
    select salary from employees where department_id=20
); -- 6000 or 13000 �̻��� ���ڵ常 ����ȴ�. 


/*
������ ������ : all
    ���������� �������� ���������� �˻������ ��� ��ġ�ؾ�
    ���̵ȴ�. 
*/
--���� ���������� all �� �����Ѵ�. 
select employee_id, department_id, first_name, salary
from employees
where salary >= all (
    select salary from employees where department_id=20
); -- 13000 �̻��� ����� �����.



/*
Top���� : ��ȸ�� ������� ������ ���� ���ڵ带 �����ö� ����Ѵ�. 
    �ַ� �Խ����� ����¡�� ���ȴ�. 
    
    rownum : ���̺��� ���ڵ带 ��ȸ�� ������� ������ �ο��Ǵ�
        ������ �÷��� ���Ѵ�. �ش� �÷��� ��� ���̺� �����Ѵ�. 
*/
select * from employees;
select employee_id, first_name, rownum from employees;
select employee_id, first_name, rownum from (
    select * from employees order by first_name 
);
--�����ȣ�� �������� ��ȸ�� ���ڵ��� ������ 5�� ��������
select
    rownum No, employee_id, first_name, salary
from
    ( select * from employees order by employee_id desc )
where rownum<=5;


/*
��ȸ�� ������� ������ ���� ���ڵ� ��������(�Խ����� paging���
������ ���� ������)
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
between�� ������ ���Ͱ��� �������ָ� �ش� �������� ���ڵ常
�������Եȴ�. ���� ������ ���� JSP���� ���� �������� ����
����Ͽ� �����ϰ� �ȴ�. 
*/
















