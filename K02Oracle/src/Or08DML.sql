/********************************
���ϸ� : Or08DML.sql
DML : Data Manipulation Language
���� : ���ڵ带 �����Ҷ� ����ϴ� ������. �տ��� �н��ߴ�
     select���� ����Ͽ� update(���ڵ����), delete(���ڵ����),
     insert(���ڵ��Է�)�� �ִ�.
*********************************/     

--study�������� �ǽ��մϴ�. 

/*
���ڵ� �Է��ϱ� : insert��
    ���ڵ� �Է��� ���� ������ �������� �ݵ�� '�� ���ξ��Ѵ�. 
    �������� '���� �׳� ����. ���� �������� '�� ���θ� �ڵ�����
    ����ȯ�Ǿ� �Էµȴ�. 
*/

--�ǽ��� ���� ���ο� ���̺� ����
create table tb_sample (
    deptNo number(10),            --�μ���ȣ
    deptName varchar2(20),      --�μ���
    deptLoc varchar2(15),          --����
    deptManager varchar2(30)  --�޴����̸�
);
desc tb_sample;

--���1�� ���� ���ڵ� �Է�
insert into tb_sample (deptno, deptname, deptloc, deptmanager)
    values (10, '��ȹ��', '����', '����');
insert into tb_sample (deptno, deptname, deptloc, deptmanager)
    values (20, '������', '����', '����');

select * from tb_sample;-- �Էµ� ���ڵ� Ȯ��    

--���2�� ���� ���ڵ� �Է�
insert into tb_sample values (30, '������', '�뱸', '���');
insert into tb_sample values (40, '�λ���', '�λ�', '��ȿ');

select * from tb_sample;
    
commit;
/*
    ���ݱ����� �۾�(Ʈ�����)�� �״�� �����ϰڴٴ� �������
    Ŀ���� �������� ������ �ܺο����� ����� ���ڵ带 Ȯ���� �� ����. 
    ���⼭ ���ϴ� �ܺζ� Java / JSP �� ���� Oracle �̿��� ���α׷���
    ���Ѵ�. 
*/

--����Ŭ���� insert �����Ƿ� �ӽ����̺� ����Ǿ� �ܺο����� Ȯ�ε��� �ʴ´�.
insert into tb_sample values (50, '������', '����', '���̸�');
select * from tb_sample;

--�ѹ��ϸ� ��� �Է��� 50�� ���ڵ�� ������� �ȴ�. 
rollback;
/*
��� ���ڵ带 ������ Ŀ�� ������ ���·� �ǵ��� �ش�. 
��, commit�� ������ ���·δ� rollback �Ҽ� ����. 
*/

select * from tb_sample;

/*
���ڵ� �����ϱ� : update��
    ����] 
        update ���̺�� 
        set  �÷�1=��1, �÷�2=��2, ....
        where ����;
    �������� ���°�� ��� ���ڵ尡 �Ѳ����� �����ȴ�. 
*/
--�μ���ȣ 40�� ���ڵ��� ������ �̱����� �����Ͻÿ�.
update tb_sample
    set  deptloc='�̱�'
    where deptno=40;
select * from tb_sample;

--������ ������ ���ڵ��� �޴������� '������'���� �����Ͻÿ�
update tb_sample set deptmanager='������' where deptloc='����';
select * from tb_sample;

--where�� ���� ��� ���ڵ带 ������� ������ '���������'�� �����Ͻÿ�.
update tb_sample set deptloc='���������';
select * from tb_sample;


/*
������ �����ϱ� : delete��
    ����]
        delete from ���̺�� where ����;
        �ط��ڵ带 �����ϹǷ� delete �ڿ� �÷��� ������� �ʴ´�. 
*/
--�μ���ȣ�� 10�� ���ڵ带 �����Ͻÿ�
delete from tb_sample where deptno=10;
select * from tb_sample;

--where�� ���� �����ϸ� ��� ���ڵ� ������(���ǿ��)
delete from tb_sample;
select * from tb_sample;

rollback;--������ commit ���·� �ǵ�����.
select * from tb_sample;

--where���� �Ʒ��� ���� �پ��ϰ� ���밡���ϴ�. 
--Ư�� numberŸ���� ��쿡�� ���굵 �����ϴ�. 
update tb_sample set deptname='�ڽ���' where deptno>=30;
select * from tb_sample;
update tb_sample set deptno=deptno+1 ;
select * from tb_sample;

commit;



--------------------------------------------------------
---------------�� �� �� �� ----------------------------
--------------------------------------------------------

/*
1. DDL�� �������� 2������ ���� ��pr_emp�� ���̺� ������ ���� ���ڵ带 �����Ͻÿ�. 
��, ��¥�� sysdate�� �̿��ؼ� ���� ��¥�� �Է��Ͻÿ�.
*/
insert into pr_emp (eno, ename, job, regist_date)
    values (1, '���¿�', '� �¹�', sysdate);
insert into pr_emp (eno, ename, job, regist_date)
    values (2, '������', '���л� �¹�', sysdate);
insert into pr_emp values (3, '�Ѱ���', '� ����', sysdate);    
insert into pr_emp values (4, '�����', '���л� ����', sysdate);    

/*
2. �� ���̺� ���� ���ǿ� �´� ���ڵ带 �����Ͻÿ�.
�̸� : ������
��å : ������
��ϳ�¥ : to_date�Լ��� �̿��ؼ� 7���� ��¥�� �Է��Ͻÿ�.
(���糯¥�� �������� 7������)
*/
insert into pr_emp values (5, '������', '������', to_date(sysdate - 7, 'yy/mm/dd'));
select * from pr_emp;


/*
3. eno�� ¦���� ���ڵ带 ã�Ƽ� job �÷��� ������ ������ ���� �����Ͻÿ�.
����¦�����ڵ塱 �� ���� ��ȣ�� ���ڿ��� �߰��Ѵ�.
*/
update pr_emp set job='��¦�����ڵ�' where mod(eno,2)=0;
select * from pr_emp;

/*
�� ���� ������ ������ 4~6�� ������ �����ϵ��� �Ѵ�.
��emp�� ���̺���  ��pr_employees�� ���̺�� �����ͱ��� �����Ѵ�.
���̺� �÷��� ũ�Ⱑ ������ �ȴٸ� alter����� �̿��Ͽ� ������ �����ϵ��� �Ѵ�.
*/
create table pr_employees
as 
select * from emp where 1=1;

/*
4. pr_employees ���̺��� 
�����ȣ 7900���� ������ �޴����� ���� ����� �μ���ȣ�� 
�̸��� SCOTT�� ����� �μ���ȣ�� ������Ʈ �Ͻÿ�.
*/
--�����ȣ 7900 ���ڵ� Ȯ��
select * from pr_employees where empno=7900;--�޴����� 7698���� Ȯ��. 

--�޴����� 7698�� ����� Ȯ��
select * from pr_employees where mgr=7698;--�μ���ȣ�� 30���� Ȯ��

--���� 2���� ������ �ϳ��� ���������� ��ģ��.
select empno, deptno from pr_employees where mgr=(
    select mgr from pr_employees where empno=7900
);

--SCOTT�� �μ���ȣ Ȯ��
select * from pr_employees where ename='SCOTT';--�μ���ȣ 20���� Ȯ��

--���� ������Ʈ : �����ȣ 7499, 7521, 7654, 7844, 7900�� �μ���ȣ�� 20���� ������Ʈ
update pr_employees
set 
    deptno=(select deptno from pr_employees where ename='SCOTT')
where empno in (
    select empno from pr_employees where mgr=(
        select mgr from pr_employees where empno=7900
    )
);

/*
5.  pr_employees ���̺��� �Ի����� 12���� ��� ������ �����Ͻÿ�.
*/
--�Ի����� 12���� ��� Ȯ���ϱ�
select * from pr_employees where to_char(hiredate, 'mm')=12;
select * from pr_employees where substr(hiredate,4,2)=12;
select * from pr_employees where substr(to_char(hiredate),4,2)=12;
--���ڵ� �����ϱ�
delete from pr_employees where to_char(hiredate, 'mm')=12;

/*
6. pr_employees ���̺��� �Ի����ڰ� ���� ���� ������ ã�Ƽ� ename �÷��� 
���������̸�(���Ի��)�� �� �ɼ� �ֵ��� ������Ʈ �Ͻÿ�. 
��) KING(���Ի��)
*/
--�Ի����� ���� ���� ����
select max(hiredate) from pr_employees; --��� : 87/05/23

--�� ����� ���� ��� ���� Ȯ��
select * from pr_employees where hiredate=(
    select max(hiredate) from pr_employees
);

--������Ʈ
update pr_employees
set ename=concat(ename, '(���Ի��)')
where hiredate=(
    select max(hiredate) from pr_employees
);

--�÷��� ũ�⸦ Ȯ��
alter table pr_employees modify ename varchar2(100);

--�� ������Ʈ���� �����
update pr_employees
set ename=concat(ename, '(���Ի��)')
where hiredate=(
    select max(hiredate) from pr_employees
);

select * from pr_employees;



/********************
DDL�� -> ���̺��� ���� �� �����ϴ� SQL�� 
    ���̺���� : create table ���̺��
    �÷��߰� : alter table ���̺�� add �÷���
    �÷����� : alter table ���̺�� modify �÷���
    �÷����� : alter table ���̺�� drop column �÷���
    ���̺���� : drop table ���̺��

DML�� -> ���ڵ带 �Է� �� �����ϴ� SQL��
    ���ڵ��Է� : insert into ���̺�� [(�÷���)] values (��)
    ���ڵ���� : update ���̺�� set �÷���='��' where ����
    ���ڵ���� : delete from ���̺�� where ����
    ���ڵ���ȸ : select �÷� from ���̺�� where ���� 
                            group by �׷� having �׷������� 
                            order by ��������(��������)
********************/
----------------------------------------------------------
----------------��������
----------------------------------------------------------
/*
1. �� �μ��� ���� �μ���ȣ, �μ��̸�, ������, �����, �μ����� 
��� ����� ��ձ޿��� ����Ͻÿ�. ��ձ޿��� ������ �ݿø��ϰ� 
���ڸ����� �ĸ��� ����Ͻÿ�.
-����׸� : �����ȣ, �����, ��ձ޿�, �μ���ȣ, �μ���, ������(����)
(����, ��������, �׷����� ����ؼ� �����ذ�)
*/ 
--����1)
select department_id"�μ���ȣ", count(*)"�����",
    to_char(round(avg(salary)),'999,000')"��ձ޿�",  department_name"�μ���", city"����"
from employees
    inner join departments using(department_id)
    inner join locations using(location_id)
group by department_id, department_name, city 
order by department_id asc;


--����2)
select D.department_id"�μ���ȣ", count(*)"�����", to_char(round(avg(salary)), '999,000')"��ձ޿�",  
(select department_name from departments D2 
 where D2.department_id=D.department_id)"�μ���",
(select city from locations L2
  inner join departments D2
  on L2.location_id=D2.location_id
  where D2.department_id=D.department_id)"���ø�"
 
from employees E
    inner join departments D 
     on E.department_id=D.department_id 
    inner join locations L 
     on D.location_id=L.location_id
where 1=1
group by D.department_id
order by D.department_id asc;