/*********************
���ϸ� : Or09Join.sql
���̺�����
���� : �ΰ� �̻��� ���̺��� ���ÿ� �����Ͽ� �����͸� �����;� �Ҷ� ����ϴ� SQL��
**********************/

/*
1] inner join(��������)
-���� ���� ���Ǵ� ���ι����� ���̺��� ���������� ��� �����ϴ�
���� �˻��Ҷ� ���ȴ�. 
-�Ϲ������� �⺻Ű(primary key)�� �ܷ�Ű(foreign key)�� ����Ͽ�
join�ϴ°�찡 ��κ��̴�.
-�ΰ��� ���̺� ������ �̸��� �÷��� �����ϸ� "���̺��.�÷���" 
���·� ����ؾ� �Ѵ�. 
-���̺��� ��Ī�� ����Ѵٸ� "��Ī��.�÷���" ���·� ������ �ִ�. 


����1(ANSI ǥ�ع��)
    select 
        �÷�1, �÷�2,.....
    from  ���̺�1 inner join ���̺�2 
        on ���̺�1.�⺻Ű�÷�=���̺�2.�ܷ�Ű�÷�
    where
        ����1 and ����2 ... ;
*/
/*
�ó�����] ������̺�� �μ����̺��� �����Ͽ� �� ������ ��μ�����
    �ٹ��ϴ��� ����Ͻÿ�. �� ǥ�ع������ �ۼ��Ͻÿ�.
    ��°�� : ������̵�, �̸�1, �̸�2, �̸���, �μ���ȣ, �μ���
*/

/*
�Ʒ� SQL���� ���� ���̺� �����ϴ� department_id�÷������� ������ �߻��Ѵ�. 
�̷���� � ���̺��� select������ ����ؾ� �Ѵ�. 
ORA-00918: ���� ���ǰ� �ָ��մϴ�
00918. 00000 -  "column ambiguously defined"
*/
select
    employee_id, first_name, last_name, 
    department_id, department_name
from employees inner join departments
    on employees.department_id=departments.department_id
where 1=1;--�����߻�

--as(��Ī) ���� �ۼ�
select
    employee_id, first_name, last_name, 
    employees.department_id, department_name
from employees inner join departments
    on employees.department_id=departments.department_id
where 1=1;

--as(��Ī)�� �߰��Ͽ� �ۼ�
select
    employee_id, first_name, last_name, 
    emp.department_id, department_name
from employees emp inner join departments dep
    on emp.department_id=dep.department_id
where 1=1;

/*
2�� �̻��� ���̺� ����

�ó�����] seattle(�ÿ�Ʋ)�� ��ġ�� �μ����� �ٹ��ϴ� ������ ������ ����ϴ�
�������� �ۼ��Ͻÿ�. �� ǥ�ع������ �ۼ��Ͻÿ�.
    ��°��] ����̸�, �̸���, �μ����̵�, �μ���, ���������̵�, ��������,
        �ٹ�����
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
���2] ����Ŭ���
    select
        �÷�1, �÷�2......�÷�n
    from
        ���̺��1, ���̺��2
    where
        ���̺��1.�⺻Ű�÷�=���̺��2.����Ű�÷� 
        and ����1 and ����2;
*/

/*
�ó�����] ������̺�� �μ����̺��� �����Ͽ� �� ������ ��μ�����
    �ٹ��ϴ��� ����Ͻÿ�. �� ����Ŭ������� �ۼ��Ͻÿ�.
    ��°�� : ������̵�, �̸�1, �̸�2, �̸���, �μ���ȣ, �μ���
*/
select
    employee_id, first_name, last_name, Dep.department_id, department_name
from employees Emp, departments Dep
where Emp.department_id=Dep.department_id;

/*
�ó�����] seattle(�ÿ�Ʋ)�� ��ġ�� �μ����� �ٹ��ϴ� ������ ������ ����ϴ�
�������� �ۼ��Ͻÿ�. �� ����Ŭ������� �ۼ��Ͻÿ�.
    ��°��] ����̸�, �̸���, �μ����̵�, �μ���, ���������̵�, ��������,
        �ٹ�����
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
2] outer join(�ܺ�����)

outer join�� inner join���� �޸� �� ���̺� ���������� ��Ȯ�� ��ġ����
�ʾƵ� ������ �Ǵ� ���̺��� ������� �������� join���̴�.
outer join�� ����Ҷ��� �ݵ�� outer ���� �����͸� � ���̺��� ��������
���������� ����ؾ� �Ѵ�. 
    -> left(�������̺�), right(���������̺�), full(�������̺�)

����1(ǥ�ع��)
    select �÷�1, �÷�2 ....
    from ���̺�1 
        left[right, full] outer join ���̺�2
            on ���̺�1.�⺻Ű=���̺�2.����Ű
    where ����1 and ����2 or ����3;
*/

/*
�ó�����] ��ü������ �����ȣ, �̸�, �μ����̵�, �μ���, ������ �ܺ�����(left)��
    ���� ����Ͻÿ�.
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
�ó�����] ��ü������ �����ȣ, �̸�, �μ����̵�, �μ���, ������ �ܺ�����(right)��
    ���� ����Ͻÿ�.
*/
--left Ȥ�� right �� ���� ������ �޶����� ����� ������ �޶�����. 
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
����2(����Ŭ���)
    select
        �÷�1, �÷�2, ..... �÷�N
    from
        ���̺�1, ���̺�2
    where
        ���̺�1.�⺻Ű=���̺�2.�ܷ�Ű (+)
        and ����1 and ����2 ... ;
        
�� ����Ŭ��Ŀ����� ���ʿ� �ִ� ���̺��� �����̵ȴ�.         
    �̿Ͱ��� ���� ���̺�1�� ������ �ȴ�. 
*/
/*
�ó�����] ��ü������ �����ȣ, �̸�, �μ����̵�, �μ���, ������ �ܺ�����(left)��
    ���� ����Ͻÿ�. �� ����Ŭ������� �ۼ��Ͻÿ�. 
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
3] self join(��������)
    ���������� �ϳ��� ���̺� �ִ� �÷����� �����ؾ� �ϴ� ��쿡 ����Ѵ�.
    �� �ڱ��ڽ��� ���̺�� ������ �δ°��̴�. 
    �������ο����� ��Ī�� ���̺��� �����ϴ� �������� ������ �ϹǷ� ������
    �߿��ϴ�.
    
    ����]
        select 
            ��Ī1.�÷�, ��Ī2.�÷� ....
        from    
            ���̺� ��Ī1, ���̺� ��Ī2
        where
            ��Ī1.�÷�=��Ī2.�÷� ;
*/

/*
�ó�����] ������̺��� �� ����� �޴������̵�� �޴����̸��� ����Ͻÿ�.
    1. �ϳ��� ���̺��� ���� ����������̺�� �޴����������̺�� ������.
    2. ����� �޴������̵�� �޴����� ������̵� ����(join)�Ѵ�.
    3. ������ ���̺� ��Ī�� �̿��ؼ� �ʿ��� ������ ����(select)�Ѵ�.
*/
select
    empClerk.employee_id "�����ȣ", empClerk.first_name "����̸�",
    empManager.employee_id "�޴����ǻ����ȣ", empManager.first_name "�޴����̸�"
from 
    employees empClerk , employees empManager
where
    empClerk.manager_id=empManager.employee_id ;

/*
�ó�����] self join�� ����Ͽ� "Kimberely / Grant" ������� �ʰ� �Ի���
    ����� �̸��� �Ի����� ����Ͻÿ�
��¸�� : first_name, last_name, hire_date
*/
--1. Kimberely�� ����Ȯ�� ->  07/05/24
select * from employees where first_name='Kimberely' and last_name='Grant';
--2. 07/05/24 ���� ū(����) ��¥�� �����´�. 
select first_name, last_name, hire_date from employees
    where  hire_date>'07/05/24';
--3. self join�� ���� �� 2���� ������ �ϳ��� ��ģ��.    
select
    Clerk.first_name, Clerk.last_name, Clerk.hire_date
from 
    employees Kim , employees Clerk
where
    Kim.first_name='Kimberely' and Kim.last_name='Grant'
    and Kim.hire_date < Clerk.hire_date
order by Clerk.hire_date ;


/*
using : join������ �ַ� ����ϴ� on���� ��ü�Ҽ� �ִ� ����
    ����] on ���̺�1.�÷�=���̺�2.�÷�
                =>  using(�÷�) 
*/

/*
�ó�����] seattle(�ÿ�Ʋ)�� ��ġ�� �μ����� �ٹ��ϴ� ������ ������ ����ϴ�
�������� �ۼ��Ͻÿ�. �� ǥ�ع�İ� using�� ����ؼ� �ۼ��Ͻÿ�.
    ��°��] ����̸�, �̸���, �μ����̵�, �μ���, ���������̵�, ��������,
        �ٹ�����
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
    using���� ���� �ĺ��� �÷��� ��� select ������ ���̺��� ��Ī��
    ���̸� ���������� �߻��Ѵ�. 
    using���� ���� �÷����� ��, ������ ���̺� ���ÿ� �����ϴ� �÷�
    �̶�°��� ������ �ۼ��ϱ� ������ ���� ��Ī�� ���� ������ ���°��̴�.
*/

 /*
 ����] 2005�⿡ �Ի��� ������� California(STATE_PROVINCE) / 
 South San Francisco(CITY)���� �ٹ��ϴ� ������� ������ ����Ͻÿ�.
 ��, ǥ�ع�İ� using�� ����ؼ� �ۼ��Ͻÿ�.
 
 ��°��] �����ȣ, �̸�, ��, �޿�, �μ���, �����ڵ�, ������(COUNTRY_NAME)
        �޿��� ���ڸ����� �ĸ��� ǥ���Ѵ�. 
 ����] '������'�� countries ���̺� �ԷµǾ��ִ�. 
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
8. �� �μ��� ���� �μ���ȣ, �μ��̸�, ������, �����, �μ����� 
��� ����� ��ձ޿��� ����Ͻÿ�. ��ձ޿��� ������ �ݿø��ϰ� 
���ڸ����� �ĸ��� ����Ͻÿ�.
decode�Լ��� ����Ͽ� �� �μ���ȣ�� �´� �μ����� ������ �Ͻÿ�.
(����, ���������� ����ؼ� �ۼ��Ͻÿ�.)
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






