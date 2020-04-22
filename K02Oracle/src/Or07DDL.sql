/***********************
���ϸ� : Or07DDL.sql
DDL : Data Definition Language
���� : ���̺�, ��� ���� ��ü�� ���� �� �����ϴ� �������� ���Ѵ�.
************************/

--system�������� �������� �Ʒ� ��ɾ �����Ѵ�. 
--���ο� ������ ���� ������ system���� �� �����ڰ����� �����ϴ�. 
create user study identified by 1234; --study������ �����Ѵ�.
grant connect, resource to study;--������ ������ ������ �ο��Ѵ�. 

--------------------------------------------
---study�������� �ǽ��մϴ�.

select * from dual; --��� ������ �ڵ����� �����Ǵ� �ӽ����̺�

/*
[���̺����]
����] 
    create table ���̺�� (
        �÷�1 �ڷ��� [not null ...] ,
        �÷�2 �ڷ��� [�������� ...],
        .....
        primary key (�÷���) �� �������� ...
    );
*/
--���̺� �����ϱ�
create table tb_member (
    member_idx number(10),
    userid varchar2(30),
    passwd varchar2(50),
    username varchar2(30),
    mileage number(7,2)
);

/*
desc : ������ ���̺��� �Ӽ�(���̾ƿ� Ȥ�� ��Ű��)�� Ȯ���ϱ�
    ���� ��ɾ�
*/
desc tb_member;

/*
���� ������ ���̺� ���ο� �÷� �߰��ϱ�
    -> tb_member ���̺� email �÷��� �߰��Ͻÿ�
    
    ����] alter table ���̺�� add �߰����÷� �ڷ���(ũ��) ��������;
*/
alter table tb_member add email varchar2(100);
desc tb_member;

/*
���� ������ ���̺��� �÷� �����ϱ�
    -> tb_member���̺��� email �÷��� ����� 200���� Ȯ���Ͻÿ�.
    ���� �̸��� ����Ǵ� username�÷��� 60���� Ȯ���Ͻÿ�.
    
    ����] alter table ���̺�� modify �������÷��� �ڷ���(ũ��);
*/
alter table tb_member modify email varchar2(200);
alter table tb_member modify username varchar2(60);
desc tb_member;


/*
���̺��� �÷� �����ϱ�
    -> tb_member ���̺��� mileage�÷��� �����Ͻÿ�.
    
    ����] alter table ���̺�� drop column �������÷���;
*/
alter table tb_member drop column mileage;
desc tb_member;

/*
[���̺� �����ϱ�]
    -> tb_member ���̺��� ���̻� ������� �����Ƿ� �����Ͻÿ�.
    
    ����] drop table ���������̺��;
*/
select * from tab; --���� ���ӵ� ������ ������ ���̺��� ����� Ȯ���ϴ� ���
drop table tb_member;
select * from tab;--������ ���̺��� �ִ°�� recyclebin �� Ȯ�εȴ�. 

--�����뿡 ������ ���̺� ��� Ȯ��
show recyclebin;

--������ ����
purge recyclebin;
show recyclebin;--�����뿡 ����� ������ ������ �����޼����� ��µȴ�. 
select * from tab;--���� ������ ������ ���̺��� �ϳ��� ����. 


------------
--�� create �������� ������Ͽ� ���̺��� �����Ѵ�. 

--���̺����
drop table tb_member;  
--������ Ȯ���ϱ�
show recyclebin;
--�����뿡�� ���̺� �����ϱ�
flashback table tb_member to before drop;

show recyclebin;--�����޼��� ��µ�
select * from tab; --���̺��� �����Ǿ����� Ȯ��


--���ڵ� �Է��ϱ�
insert into tb_member values (1, 'hong', '1234', 'ȫ�浿', 1000);
insert into tb_member values (2, 'gasan', '9876', '����', 2000);
--���ڵ� Ȯ���ϱ�
select * from tb_member;

--���̺��� ���ڵ���� �����ϱ�
create table tb_member_copy
as
select * from tb_member where 1=1;

desc tb_member_copy;
select * from tb_member_copy;


--���̺��� �Ӽ��� �����ϱ�(���ڵ�� ����)
create table tb_member_empty
as
select * from tb_member where 1=0;

desc tb_member_empty;
select * from tb_member_empty;


--------------------------------------------------------
---------------�� �� �� �� ----------------------------
--------------------------------------------------------

/*
1. ���� ���ǿ� �´� ��pr_dept�� ���̺��� �����Ͻÿ�.
*/
create table pr_dept (
    dno number(2),
    dname varchar2(20),
    loc varchar2(35)
);

/*
2. ���� ���ǿ� �´� ��pr_emp�� ���̺��� �����Ͻÿ�.
*/
create table pr_emp (
    eno number(4) ,
    ename varchar2(10) ,
    job varchar2(30) ,
    regist_date date
);

/*
3. pr_emp ���̺��� ename �÷��� varchar2(50) �� �����Ͻÿ�.
*/
desc pr_emp;
alter table pr_emp modify ename varchar2(50);
desc pr_emp;

/*
4. emp ���̺��� �����ؼ� pr_emp_clone ���̺��� �����ϵ� 
EMPNO, ENAME, SAL, DEPTNO�� �����ϰ� ���� ������ 
Į������ emp_id, name, salary, dept_id �� �����Ͻÿ�. ���ڵ���� �����Ͻÿ�.
*/
create table pr_emp_clone (
    emp_id, name, salary, dept_id
)
as
select 
    EMPNO, ENAME, SAL, DEPTNO
from emp where 1=1;
/*
    create table �������� �÷��� �ڷ��� ���������� ����Ǿ�� ������
    ���̺��� �����ϴ� ��쿡�� �������̺��� �����ϹǷ� �÷��� 
    ����ϸ� �ȴ�. 
*/
desc pr_emp_clone;
select * from pr_emp_clone;


/*
5. ������ ������ pr_emp_clone ���̺��� 
�̸��� pr_emp_clone_rename ���� �����Ͻÿ�.
*/
--���� :  rename �������̺�� to ���������̺��
rename pr_emp_clone to pr_emp_clone_rename;
desc pr_emp_clone;
desc pr_emp_clone_rename;

/*
6. 1������ ������ pr_dept ���̺��� dname Į���� �����Ͻÿ�.
*/
alter table pr_dept drop column dname;
desc pr_dept;

/*
7. ��pr_emp�� ���̺��� job �÷��� varchar2(50) ���� �����Ͻÿ�.
*/
alter table pr_emp modify job varchar2(50);

/*
8. 5���� pr_emp_clone_rename ���̺��� �����Ͻÿ�
*/
drop table pr_emp_clone_rename;

/*
9. 8������ ������ pr_emp_clone_rename ���̺��� �����뿡 �ִ��� Ȯ���ϰ�, 
������ �� ������ �����뿡�� ������ �����Ͻÿ�.
*/
show recyclebin;
purge table pr_emp_clone_rename;
show recyclebin;













