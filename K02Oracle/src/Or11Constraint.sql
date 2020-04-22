/*
���ϸ� : Or11Constraint.sql
��������
���� : ���̺� ������ �ʿ��� �������� �������ǿ� ���� �н��Ѵ�.
*/

-- study �������� �ǽ��մϴ�. 

/*
Primary key : �⺻Ű
-�������Ἲ�� �����ϱ� ���� ���������̴�.
-�ϳ��� ���̺� �ϳ��� �⺻Ű�� �����Ҽ� �ִ�.
-�⺻Ű�� �����Ǹ� �� �÷��� �ߺ��Ȱ��̳� NULL���� �Է��Ҽ� ����.
*/

/*
����1] �ζ��ι��
    create table ���̺�� (
        �÷��� �ڷ��� [constraint �����] primary key
    );
*/
create table tb_primary1 (
    idx number(10) primary key,
    user_id varchar2(30),
    user_name varchar2(50)
);
desc tb_primary1;

/*
����2] �ƿ����� ���
    create table ���̺�� (
        �÷��� �ڷ���, 
        [constraint �����] primary key (�÷���)
    );    
*/
create table tb_primary2 (
    idx number,
    user_id varchar2(30),
    user_name varchar2(50),
    primary key (user_id)
);
desc tb_primary2;

/*
����3] ���̺� ������ alter������ �������� �߰�
    alter table ���̺�� add [constraint �����] primary key (�÷���);
*/
create table tb_primary3 (
    idx number,
    user_id varchar2(30),
    user_name varchar2(50)
);
alter table tb_primary3 add constraint tb_primary3_pk
    primary key (user_name);
desc tb_primary3;

/*
�������� Ȯ���ϱ�
    user_cons_columns : ���̺� ������ �������Ǹ�� �÷�����
        ������ ������ Ȯ���� �� �ִ�.    
    user_constraints : ���̺� ������ ���������� ���� ������
        Ȯ���� �� �ִ�. 

�� �̿Ͱ��� ���������̳� ��, ���ν������� ������ �����ϰ� �ִ�
�ý��� ���̺��� "�����ͻ���"�̶�� �Ѵ�. 
*/
select * from user_cons_columns;
select * from user_constraints;

--���ڵ� �����ϱ�
insert into tb_primary1 (idx, user_id, user_name) 
    values(1, 'kosmo', '�ڽ���');
insert into tb_primary1 (idx, user_id, user_name) 
    values(1, 'gasmo', '������');    /*
            ORA-00001: ���Ἲ ���� ����(STUDY.SYS_C0011872)�� ����˴ϴ�
            PK�� ������ idx�÷��� �ߺ��� ���� �Է��Ͽ� ���� �߻���.
    */
insert into tb_primary1 values (2, 'black', '��');
insert into tb_primary1 values ('', 'white', 'ȭ��Ʈ');/*
            ORA-01400: NULL�� ("STUDY"."TB_PRIMARY1"."IDX") �ȿ� ������ �� �����ϴ�
            PK�� ������ �÷����� ��(NULL)�� ������ �� ����. 
    */
select * from tb_primary1;
update tb_primary1 set idx=2 where user_name='�ڽ���';/*
            update���� ���������� idx���� �̹� �����ϴ� 2�� ���������Ƿ�
            �������� ����� �����߻���.
    */


/*
Unique : ����ũ
-���� �ߺ��� ������� �ʴ� ��������
-����, ���ڿ��� �ߺ��� ������� ������, NULL���� ���ؼ��� 
�ߺ��� ����Ѵ�. 
-unique�� �� ���̺� 2���̻� ������ �� �ִ�.
*/
create table tb_unique1(
    idx number unique not null,
    name varchar2(30),
    telephone varchar2(20),
    nickname varchar2(30),
    unique(telephone, nickname)
);
select * from user_cons_columns;
select * from user_constraints;

insert into tb_unique1 (idx, name, telephone, nickname)
    values (1, '���̸�', '010-1111-2222', '���座��');
insert into tb_unique1 (idx, name, telephone, nickname)
    values (2, '����', '010-1111-3333', '');
insert into tb_unique1 (idx, name, telephone, nickname)
    values (3, '����', '', '');    
select * from tb_unique1;    
    
insert into tb_unique1 (idx, name, telephone, nickname)
    values (1, '����', '', '');   -- �����߻�. �ߺ��� �� ����.

insert into tb_unique1 values (4, '���켺', '010-3333-3333', '��Ʈ');--�Է¼���
insert into tb_unique1 values (5, '������', '010-4444-4444', '��Ʈ');--�Է¼���
insert into tb_unique1 values (6, '�����', '010-3333-3333', '��Ʈ');--����
/*
    telephone�� nickname�÷��� ������ ��������� �����Ǿ����Ƿ� 
    �ΰ��� �÷��� ���ÿ� ������ ������ �ԷµǴ� ��찡 �ƴ϶��
    �ߺ��� ���� ���ȴ�. 
    ��, 4���� 5���� ���� �ٸ� �����ͷ� �ν��ϰ�
    4���� 6���� ������ �����ͷ� �ν��Ѵ�. 
*/


/*
Foreign key : �ܷ�Ű, ����Ű
-�ܷ�Ű�� �������Ἲ�� �����ϱ� ���� ���������̴�.
-���� ���̺��� �ܷ�Ű�� �����Ǿ� �ִٸ� �ڽ����̺� ��������
�����Ұ�� �θ����̺��� ���ڵ�� �������� �ʴ´�. 
*/

/*
����1] �ζ��ι��
    create table ���̺�� (
        �÷��� �ڷ��� [constraint �����] 
            references �θ����̺�� (�θ����̺��� PK�÷���)                    
    );
*/

-- ���̺� ������ tb_primary2 ���̺��� user_id�÷��� �����ϴ� �ܷ�Ű ������.
create table tb_foreign1 (
    f_idx number(10) primary key,
    f_name varchar2(50),
    f_id varchar2(30) constraint tb_foreign1_fk
        references tb_primary2 (user_id)
);
--�θ����̺��� tb_primary2���� ���ڵ尡 ���� ������.
select * from tb_primary2;
--�θ����̺� ������ ���ڵ尡 �����Ƿ� �ڽ����̺� �Է� �Ұ���.
insert into tb_foreign1 values (1, '���ʿ�', 'WannerOne');--�Է½���
--�θ����̺� ���ڵ� ����
insert into tb_primary2 values (1, 'WannerOne', '���ʿ�');
--�θ����̺��� ������ ���ڵ带 ������� �ڽ����̺� ���ڵ� �Էµ�.
insert into tb_foreign1 values (1, '���ʿ�', 'WannerOne');
insert into tb_foreign1 values (2, 'Ʈ���̽�', 'Twice');--�θ�Ű �����Ƿ� �Է½���

select * from tb_primary2;
select * from tb_foreign1;

/*
�ڽ����̺��� �����ϴ� ���ڵ尡 �����Ƿ�, �θ����̺��� ���ڵ带 
������ �� ����. �̰�쿡�� �ݵ�� �ڽ����̺��� ���ڵ带 ���� ��������
�θ����̺��� ���ڵ带 �����ؾ� �Ѵ�. 
*/
delete from tb_primary2 where idx=1;--�����߻�

delete from tb_foreign1 where f_idx=1;--�ڽ����̺��� ���ڵ� ���� ���� ��
delete from tb_primary2 where idx=1;--�θ����̺��� ���ڵ� ���� -> ��������.

/*
����2] �ƿ����ι��
    create table ���̺�� (
        �÷��� �ڷ��� , 
        
        [constraint �����] foreign key (�÷���)
            references �θ����̺� (�θ����̺��� �������÷�)
    )
*/
create table tb_foreign2 (
    f_id number(10) primary key,
    f_name varchar2(30),
    f_date date,
    
    constraint tb_foreign2_fk foreign key (f_name)
        references tb_primary3 (user_name)
);
select * from user_constraints;
/*
������ �������� �������� Ȯ�ν� �÷��� 
P : Primary key
R : Reference integrity �� Foreign key�� ����
C : Check Ȥ�� Not Null
U : Unique
*/

/*
�ܷ�Ű ������ �ɼ�
[on delete cascade]
	-> �θ��ڵ� ������ �ڽķ��ڵ���� ���� ������
	����] 
		�÷��� �ڷ��� references �θ����̺�(PK�÷�)
			on delete cascade;
[on delete set null]
	-> �θ��ڵ� ������ �ڽķ��ڵ尪�� null�� �����
	����]
		�÷��� �ڷ��� references �θ����̺�(PK�÷�)
			on delete set null

�� �ǹ����� ���԰Խù��� ���� ȸ���� �� �Խñ��� �ϰ������� �����ؾ� �Ҷ�
��밡���� �ɼ��̴�. ��, �ڽ��� ��� ���ڵ尡 �����ǹǷ� ��뿡 
�����ؾ� �Ѵ�. 
*/

--on delete cascade �ɼ� �׽�Ʈ
--���̺���� �� cascade�ɼ� �ο�
create table tb_primary4 (
    user_id varchar2(20) primary key,
    user_name varchar2(100)
);
create table tb_foreign4 (
    f_id number(10) primary key, 
    f_name varchar2(20),
    user_id varchar2(20) constraint tb_foreign4_fk
        references tb_primary4 (user_id) on delete cascade
);
desc tb_primary4;
desc tb_foreign4;
--�θ����̺�� �ڽ����̺� ���ڵ� �Է�
insert into tb_primary4 values ('kosmo', '�ڽ���');
insert into tb_foreign4 values (1, '1���Դϴ�', 'kosmo');
insert into tb_foreign4 values (2, '2���Դϴ�', 'kosmo');
insert into tb_foreign4 values (3, '3���Դϴ�', 'kosmo');
insert into tb_foreign4 values (4, '4���Դϴ�', 'kosmo');
insert into tb_foreign4 values (5, '5���Դϴ�', 'kosmo');
insert into tb_foreign4 values (6, '6���Դϴ�', 'gosma');--�Է½���(�θ�Ű ����)
--�Էµ� ���ڵ� Ȯ��
select * from tb_primary4;
select * from tb_foreign4;
--�θ����̺��� ���ڵ� ����
--on delete cascade �ɼǶ����� �θ��ʻӸ� �ƴ϶� �ڽ����̺���� ���ڵ� ��� ������.
delete from tb_primary4;
--������ ���ڵ� Ȯ��
select * from tb_primary4;
select * from tb_foreign4;





--on delete set null �ɼ� �׽�Ʈ
--���̺���� �� set null �ɼ� �ο�
create table tb_primary5 (
    user_id varchar2(20) primary key,
    user_name varchar2(100)
);
create table tb_foreign5 (
    f_id number(10) primary key, 
    f_name varchar2(20),
    user_id varchar2(20) constraint tb_foreign5_fk
        references tb_primary5 (user_id) on delete set null
);
desc tb_primary5;
desc tb_foreign5;
--�θ����̺�� �ڽ����̺� ���ڵ� �Է�
insert into tb_primary5 values ('kosmo', '�ڽ���');
insert into tb_foreign5 values (1, '1���Դϴ�', 'kosmo');
insert into tb_foreign5 values (2, '2���Դϴ�', 'kosmo');
insert into tb_foreign5 values (3, '3���Դϴ�', 'kosmo');
insert into tb_foreign5 values (4, '4���Դϴ�', 'kosmo');
insert into tb_foreign5 values (5, '5���Դϴ�', 'kosmo');
insert into tb_foreign5 values (6, '6���Դϴ�', 'gosma');--�Է½���(�θ�Ű ����)
--�Էµ� ���ڵ� Ȯ��
select * from tb_primary5;
select * from tb_foreign5;
--�θ����̺��� ���ڵ� ����
--on delete set null �ɼ����� �ڽ����̺��� ���ڵ�� �������� �ʰ� ����Ű�κи� null
--������ ����ȴ�. 
delete from tb_primary5;
--������ ���ڵ� Ȯ��
select * from tb_primary5;
select * from tb_foreign5;


/*
not null :  null���� ������� �ʴ� ��������.
    ����] 
         create table  ���̺�� (
            �÷��� �ڷ��� not null,
            �÷��� �ڷ��� null, <- ������� ����
         );
*/
/*
    m_idx : primary key�� ���������Ƿ� not null
    m_id : not null�� ����
    m_pw : null���(��, null�� ����ϴ� �÷��� ��� ����� null�� �����ʴ°��� ����)
    m_name : null���
*/
create table tb_not_null (
    m_idx number(10) primary key, 
    m_id varchar2(30) not null,  
    m_pw varchar2(40) null,  
    m_name varchar2(50) 
);
desc tb_not_null;

insert into tb_not_null values (10, 'hong1', '1111', 'ȫ�浿');
insert into tb_not_null values (20, 'hong2', '2222', '��浿');
insert into tb_not_null values (30, 'hong3', '', '');
insert into tb_not_null values (40, '', '4444', '���浿');--�Է½���(m_id�÷��� null�� �Է�)
insert into tb_not_null (m_idx, m_pw, m_name) 
    values (50, '4444', '���浿');--�Է½���(m_id�÷��� null�� �Է�)
insert into tb_not_null values (60, ' ', '4444', '���浿');--�Է¼���.(space�� ������)

select * from tb_not_null;--�Է¿� ������ 4���� ���ڵ常 Ȯ�εȴ�. 


/*
Default : insert�� �ƹ��� ���� �Է����� ������ �ڵ����� ���ԵǴ�
    �����͸� ���Ѵ�. 
*/
create table tb_default (
    id varchar2(30) not null,
    pw varchar2(30) default 'qwer'
);  
desc tb_default;
select * from tb_default;

insert into tb_default values ('aaaa', '1234');
insert into tb_default values ('bbbb', ''); -- null���� �Էµ�. (�����ǿ��)
insert into tb_default (id) values ('cccc'); --default�� �Է�
insert into tb_default (id,pw) values ('dddd',default); --default�� �Է�
insert into tb_default values ('eeee',default); --default�� �Է�
/*
    ������ ������ default���� �Է��Ϸ��� insert�� �÷���ü�� �����ϰų� 
    defaultŰ���带 ����ؾ� �Ѵ�. 
*/
select * from tb_default;



/*
Check : Domain(�ڷ���) ���Ἲ�� �����ϱ� ���� ������������ 
    �ش� �÷��� �߸��� �����Ͱ� �Էµ��� �ʵ��� �����ϴ� ���������̴�.
*/
create table tb_check1 (
    gender varchar2(20) not null
        constraint check_gender
            check (gender in ('M', 'F'))
);
insert into tb_check1 values ('M'); 
insert into tb_check1 values ('F'); 
insert into tb_check1 values ('Male'); -- �Է½���
insert into tb_check1 values ('����'); -- �Է½���


create table tb_check2 (
    ticketCnt number(10) not null
        check (ticketCnt <= 5)
);
insert into tb_check2 values (4);
insert into tb_check2 values (5);
insert into tb_check2 values (6);--�Է½���(�������� ����)


----------------------------------------------------------
-----------------�� �� �� ��------------------------
----------------------------------------------------------
/*
1. emp ���̺��� ������ �����Ͽ� pr_emp_const ���̺��� ����ÿ�. 
����� ���̺��� �����ȣ Į���� pr_emp_pk ��� �̸����� primary key 
���������� �����Ͻÿ�.
*/
--���̺���
create table pr_emp_const
as
select * from emp where 1=0;

--�⺻Ű(PK) �����ϱ�
alter table pr_emp_const add constraint pr_emp_pk
    primary key (empno);

--�����ͻ������� Ȯ���ϱ�
select * from user_cons_columns;
select * from user_cons_columns where constraint_name=upper('pr_emp_pk');


/*
2. dept ���̺��� ������ �����ؼ� pr_dept_const ���̺��� ����ÿ�. 
�μ���ȣ�� pr_dept_pk ��� �������Ǹ����� primary_key�� �����Ͻÿ�.
*/
--���̺� ���̾ƿ��� ����
create table pr_dept_const
as
select * from dept where 1=0;

--�⺻Ű �������� �߰�
alter table pr_dept_const add constraint pr_dept_pk 
    primary key (deptno);


/*
3. pr_dept_const ���̺� �������� �ʴ� �μ��� ����� �������� �ʵ��� 
�ܷ�Ű ���������� �����ϵ� �������� �̸��� pr_emp_dept_fk �� �����Ͻÿ�.
*/
alter table pr_emp_const
    add constraint pr_emp_dept_fk
    foreign key (deptno)   /* �ڽ����̺��� �ܷ�Ű �÷� */
        references pr_dept_const (deptno); /* �θ����̺��� �⺻Ű �÷� */


/*
4. pr_emp_const ���̺��� comm Į���� 0���� ū ������ �Է��Ҽ� �ֵ��� 
���������� �����Ͻÿ�. �������Ǹ��� �������� �ʾƵ� �ȴ�
*/
alter table pr_emp_const add check( comm > 0 );

insert into pr_emp_const values 
    (100, '�ڽ���', '����1', null, sysdate, 1000, 0, 10);--check�������� ����(0�� �Էµ�)
insert into pr_emp_const values 
    (100, '�ڽ���', '����2', null, sysdate, 1000, 0.5, 10);--�θ�Ű ����. �ܷ�Ű �������� ����

--�θ����̺� ���ڵ� ���� �Է�
insert into pr_dept_const values (10, '���ǹ�', '����');
insert into pr_dept_const values (20, '�����ǹ�', '������');
--�ڽ����̺� ���ڵ� �Է�
insert into pr_emp_const values 
    (100, '�ڽ���', '����', null, sysdate, 1000, 0.5, 10);


/*
5. �� 3�������� �� ���̺��� �ܷ�Ű�� �����Ǿ 
pr_dept_const ���̺��� ���ڵ带 ������ �� ������. 
�� ��� �θ� ���ڵ带 ������ ��� �ڽı��� ���� �����ɼ� �ֵ��� 
�ܷ�Ű�� �����Ͻÿ�.
*/
select * from pr_dept_const;
select * from pr_emp_const;

--�θ����̺��� ���ڵ� ����
delete from pr_dept_const where deptno=10;--�����Ұ�(�ڽķ��ڵ� �߰ߵ�)

--������ ������ �ܷ�Ű �����ϱ�
alter table pr_emp_const drop constraint pr_emp_dept_fk;

--�ܷ�Ű �缳�� : �θ��ڵ� ������ �ڽķ��ڵ���� ���ÿ� �����ǵ���
--                         cascade �ɼ� �߰�
alter table pr_emp_const
    add constraint pr_emp_dept_fk
    foreign key (deptno)
    references pr_dept_const (deptno)
    on delete cascade ; 
delete from pr_dept_const where deptno=10;
select * from pr_dept_const;
select * from pr_emp_const;





