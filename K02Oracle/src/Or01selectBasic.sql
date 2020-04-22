/*****
���ϸ� : Or01SelectBasic.sql
ó������ �����غ��� ���Ǿ�(SQL�� Ȥ�� Query��)
���� : select, where�� ���� �⺻���� DQL�� ����غ���
******/

/*
SQL Developer���� �ּ� ����ϱ�
    �������ּ� : �ڹٿ� ������ / * ~ * /
    ���δ����ּ� : -- ���๮��. ������ 2���� �������� ����Ѵ�. 
*/

/*
select�� : ���̺� ����� ���ڵ带 ��ȸ�ϴ� SQL������ DQL���� �ش��Ѵ�. 

����] select �÷�1, �÷�2 ....[�Ǵ� *(��ü�÷�)]
    from ���̺��
    where ����1 and ����2 or ����3 .....
    order by �������÷� asc(��������), desc(��������) ;
*/

--������̺� ����� ��� ���ڵ� ��ȸ�ϱ�
select * from employees;  

--�÷����� �����ؼ� �����ڰ� ������� �÷��� �����Ҽ� �ִ�.
select employee_id, first_name, last_name, email, department_id 
from employees;

--�ش� ���̺��� �Ӽ��� �ڷ����� Ȯ���ϴ� ���
desc employees;

--�ش� �÷��� number(����) Ÿ���̸� ������� ������
select first_name, salary, salary+1000 from employees;
--numberŸ���� �÷������� ���굵 �����ϴ�. 
select first_name, salary, salary+commission_pct from employees;


/*
AS(�˸��ƽ�) : ���̺� Ȥ�� �÷��� ��Ī(����)�� �ο��Ҷ� ����Ѵ�. 
    ���� ���ϴ� �̸�(����, �ѱ� ��)���� ������ �Ŀ� ����Ҽ� �ִ�. 
    Ȱ���] ���� 2�� �̻��� ���̺��� join(����)�ؾ� �� ��� �÷�����
        �ߺ��ɶ� �����ϴ� �뵵�� ���ɼ� �ִ�.
*/
select first_name, salary, salary+100 as "�޿�100����" from employees;
select first_name, salary, salary+100 as salaryUp100 from employees;

--AS(�˸��ƽ�)�� ��������
select employee_id "������̵�", first_name Name, last_name "��"
from employees 
where first_name='William';

/*
where���� �̿��Ͽ� ���ǿ� �´� ���ڵ� ��������
    : last_name�� Smith�� ���ڵ带 �����´�. 
    ����] where���� ������ �Է��Ҷ� �÷��� �������̸� �ݵ��
    �̱������̼��� ����ؾ� �Ѵ�. �������� ��쿡�� ������ �����ϴ�. 
*/
select * from employees where last_name='Smith'; --2������

select * from employees where last_name='Smith' and salary=8000; --1������

select * from employees where last_name='Smith' or salary=8000; --4������

--�޿��� 5000�̸� Ȥ�� 5000�̻��� ����� ������ ��������
select * from employees where salary<5000; --5000�̸��� ���
select * from employees where salary>=5000; --5000�̻��� ���

/*
�Ի����� 04��01��01�� ������ ������� ��������
��¥�� ����ó�� >, <= ��� ���� �񱳿����ڸ� ���� ������ �����Ҽ� �ִ�.
*/
select * from employees
where hire_date>='04/01/01';

/*
and ������ : �� �̻��� ������ ���ÿ� �����Ҷ� ���ڵ带 ������.
�μ����̵� 50�̸鼭 �޴������̵� 100�� ��������� ��ȸ�Ͻÿ�
*/
select * from employees where department_id=50 and manager_id=100;

/*
in������ : or �����ڿ� ����� ������� �ϳ��� �÷��� ����������
    ������ �ɰ� ������ ����ϴ� ������. 
    �޿��� 4200, 6400, 8000�� ������ ������ ��ȸ�Ͻÿ�
*/
--���1 : in�� ����ϸ� �÷��� �ѹ��� ����ϹǷ� ����.
select * from employees where salary in (4200, 6400, 8000);
--���2 : or�� ���.
select * from employees where salary=4200 or salary=6400 or salary=8000;

/*
not  ������ : �ش� ������ �ƴ� ���ڵ带 �����´�. 
    �μ���ȣ�� 50�� �ƴ� ��������� ��ȸ�Ͻÿ�.
    => not Ȥ�� <> ���� ǥ���Ѵ�. 
*/
select * from employees where department_id<>50;
select * from employees where not (department_id=50);

/*
between and ������ : �÷��� ������ ���� �˻��Ҷ� ����Ѵ�. 
    �޿��� 4000~8000 ������ ��������� ��ȸ�Ͻÿ�
*/
select * from employees where salary>=4000 and salary<=8000;

select * from employees where salary between 4000 and 8000;


/*
distinct : �÷����� �ߺ��Ǵ� ���ڵ� �����ϱ�
    Ư�� �������� select������ �ϳ��� �÷����� �ߺ��Ǵ� ���� �ִ°��
    �ߺ����� �������� ����� ����Ҽ��ִ�.
*/
select job_id from employees; --������ ��ü�� �����ش�.
select distinct job_id from employees; --���������� �ߺ����� �������� �����ش�. 


/*
like ������ : Ư�� Ű���带 ���� ���ڿ� �˻��ϱ�
    ����) �÷��� like '%Ű����%'
    ���ϵ�ī�� ����
        % : ��� ���� Ȥ�� ���ڿ��� ��ü��
        Ex) D�� �����ϴ� �ܾ� : D% -> Da, Dae, Daewoo
              Z�� ������ �ܾ� : %Z -> aZ, abcZ
              C�� ���ԵǴ� �ܾ� : %C% -> aCb, abCde, Vitamin-C
            
        _ : '�����'�� �ϳ��� ���ڸ� ��ü��
        Ex) D�� �����ϴ� 3������ �ܾ� : D__ -> Dab , Ddd, Dxy
              A�� �߰��� ���� 3������ �ܾ� : _A_ -> aAa, xAy     
*/
--first_name�� 'D'�� �����ϴ� ������ �˻��Ͻÿ�
select * from employees where first_name like 'D%';

--first_name�� ����° ���ڰ� 'a'�� ��� ������ �˻��Ͻÿ�
select * from employees where first_name like '__a%';

--first_name�� 'd'�� ������ ��� ������ �˻��Ͻÿ�.
select * from employees where first_name like '%d';

--��ȭ��ȣ�� 1344�� ���ԵǴ� ��� ������ �˻��Ͻÿ�.
select * from employees where phone_number like '%1344%';

/*
���ڵ� �����ϱ�(Sorting)
    ������������ : order by �÷��� asc (Ȥ�� ��������[����Ʈ])
    ������������ : order by �÷��� desc
    
    2���̻��� �÷����� �����ؾ� �Ҷ��� ,(�޸�)�� �����ؼ� �����Ѵ�. 
    ��, �̶� ���� �Է��� �÷����� ���ĵ� ���¿��� �ι�° �÷��� ���ĵȴ�. 
*/
/*
������� ���̺��� �޿��� ������������ ���������� �������� �����Ͽ� ��ȸ�Ͻÿ�.
������÷� : first_name, salary, email, phone_number
*/
select first_name, salary, email, phone_number
from employees
order by salary asc;

/*
�μ���ȣ�� ������������ ������ �� �ش� �μ����� ���� �޿��� �޴� ������
���� ��µǵ��� �ϴ� SQL���� �ۼ��Ͻÿ�.
����׸� : �����ȣ, �̸�, ��, �޿�, �μ���ȣ
*/
select employee_id, first_name, last_name, salary, department_id
from employees
order by department_id desc, salary asc;

/*
is null Ȥ�� is not null
    : ���� null�̰ų� null�� �ƴ� ���ڵ� ��������. 
    �÷��� null���� ����ϴ� ��� ���� �Է����� ������ null���̵Ǵµ�
    �̸� �������  select�Ҷ� ����Ѵ�. 
*/ 
--���ʽ����� ���� ����� ��ȸ�Ͻÿ�
select * from employees where commission_pct is null;

--���ʽ����� ���� ����� �޿��� 5000�̻��� ����� ��ȸ�ϴ� �������� �ۼ��Ͻÿ�.
select * from employees where commission_pct is null and salary>=5000;

-- ���ʽ��� �޴� ����� ��ȸ�Ͻÿ�
select * from employees where commission_pct is not null;

--------------------------------------------
----��������
--------------------------------------------
/*
1. ���� �����ڸ� �̿��Ͽ� ��� ����� ���ؼ� $300�� �޿��λ��� 
������� �̸�, �޿�, �λ�� �޿��� ����Ͻÿ�.
*/
select * from emp; -- emp���̺� ��ü ���ڵ带 Ȯ���Ѵ�. 
select ename, sal, sal+300 as RiseSalary from emp;

/*
2. ����� �̸�, �޿�, ������ ������ �����ͺ��� ���������� ����Ͻÿ�. 
������ ���޿� 12�� ������ $100�� ���ؼ� ����Ͻÿ�.
*/
select ename "�̸�", sal "�޿�", sal*12+100 "����" from emp order by sal desc;
select ename "�̸�", sal "�޿�", sal*12+100 "����" from emp order by �޿� desc;
    -- ��Ī�� "�޿�" ��� ���·� �ߴٸ� order by������ �Ȱ��� ���ִ°� ����. 
    -- ����Ŭ ������ ���� ������ �߻��Ҽ��� �ִ�. 
select ename "�̸�", sal "�޿�", sal*12+100 "����" from emp order by "�޿�" desc;
select ename "�̸�", sal "�޿�", sal*12+100 "����" from emp order by sal*12+100 desc;

/*
3. �޿���  2000�� �Ѵ� ����� �̸��� �޿��� ������������ �����Ͽ� ����Ͻÿ�
*/
select ename, sal from emp where sal>=2000 order by sal desc;

/*
4. �����ȣ�� 7788�� ����� �̸��� �μ���ȣ�� ����Ͻÿ�.
*/
select ename, deptno
from emp 
where empno=7788;

/*
5. �޿��� 2000���� 3000���̿� ���Ե��� �ʴ� ����� �̸��� �޿��� ����Ͻÿ�.
*/
select ename, sal
from emp
where not (sal between 2000 and 3000);

select ename, sal
from emp
where not (sal>=2000 and sal<=3000);

/*
6. �Ի����� 81��2��20�� ���� 81��5��1�� ������ ����� �̸�, ������, 
�Ի����� ����Ͻÿ�.
*/
select ename, job, hiredate
from emp
where hiredate>='81/02/20' and hiredate<='81/05/01';

select ename, job, hiredate
from emp
where hiredate between '81/02/20' and '81/05/01';

/*
7. �μ���ȣ�� 20 �� 30�� ���� ����� �̸��� �μ���ȣ�� ����ϵ� �̸��� 
����(��������)���� ����Ͻÿ�
*/
select ename, deptno
from emp
where deptno=20 or deptno=30
order by ename desc;

select ename, deptno
from emp
where deptno in (20, 30)
order by ename desc;

/*
8. ����� �޿��� 2000���� 3000���̿� ���Եǰ� �μ���ȣ�� 
20 �Ǵ� 30�� ����� �̸�, �޿��� �μ���ȣ�� ����ϵ� 
�̸���(��������)���� ����Ͻÿ�
*/
select ename, sal, deptno
from emp
where (sal between 2000 and 3000) and (deptno in (20, 30))
order by ename ;

/*
9. 1981�⵵�� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�. 
(like �����ڿ� ���ϵ�ī�� ���)
*/
select * from emp;
select ename, hiredate
from emp 
where hiredate like '81%';

/*
10. �����ڰ� ���� ����� �̸��� �������� ����Ͻÿ�. 
*/
select * from emp;
select ename, job
from emp where mgr is null;

/*
11. Ŀ�̼��� ������ �ִ� �ڰ��� �Ǵ� ����� �̸�, �޿�, Ŀ�̼��� 
����ϵ� �޿� �� Ŀ�̼��� �������� ������������ �����Ͽ� ����Ͻÿ�.
*/
select ename, sal, comm
from emp
where comm is not null
order by sal desc, comm desc;

/*
12. �̸��� ����° ���ڰ� R�� ����� �̸��� ǥ���Ͻÿ�.
*/
select ename from emp where ename like '__R%';

/*
13. �̸��� A�� E�� ��� �����ϰ� �ִ� ����� �̸��� ǥ���Ͻÿ�.
*/
select ename
from emp
where ename like '%A%' and ename like '%E%';

/*
14. �������� �繫��(CLERK) �Ǵ� �������(SALESMAN)�̸鼭 
�޿��� $1600, $950, $1300 �� �ƴ� ����� �̸�, ������, �޿��� ����Ͻÿ�. 
*/
select ename, job, sal
from emp
where job in ('CLERK', 'SALESMAN') and sal not in (1600, 950, 1300);

select ename, job, sal
from emp
where (job in ('CLERK', 'SALESMAN')) and  not (sal in (1600, 950, 1300));

/*
15. Ŀ�̼��� $500 �̻��� ����� �̸��� �޿� �� Ŀ�̼��� ����Ͻÿ�. 
*/
select ename, sal, comm from emp where comm>=500;



