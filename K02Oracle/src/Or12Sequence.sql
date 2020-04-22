/****
���ϸ� : Or12Sequence.sql
������
���� : ���̺��� �⺻Ű �ʵ忡 �������� �Ϸù�ȣ�� �ο��ϴ� �������� �˻��ӵ��� ����ų�� �ִ� �ε���
****/

/*
������ 
:���̺��� �÷��� �ߺ����� �ʴ� �������� �Ϸù�ȣ�� �ο��ϴ� ������ �Ѵ�.
�׻� ������ �ǰ� ���Ҵ� ���� �ʴ� Ư¡������ �ִ�. 
*/
--��ǰ���̺����
Create table tb_goods(
g_idx number(10) primary key,
g_name varchar2(30)
);
--��ǰ���̺� ���ڵ� �Է�
insert into tb_goods values(1, '���ڷ�');
insert into tb_goods values(1, '�����');--�Է½���(�ߺ��� PK��)
--max()�׷��Լ��� �̿� �Ϸù�ȣ �ִ밪 Ȯ��
select max(g_idx)+1 from tb_goods;
--���ڵ� ������ �׻� max�Լ��� ���� Ȯ���ϴ°��� ���ŷ��� ������ �Ʒ��� ���� �������� �����Ͽ� �Է½� ���.

--������ ����
create sequence seq_serial_num
increment by 1 /* ����ġ */
start with 100 /* ���۰� */
maxvalue 110  /* �������� �ִ밪 */
minvalue 99  /* �ּҰ� */
cycle   /* ����Ŭ ��� ���� */
nocache; /*cache ��� ���� */

--������ �������� ������ ������ Ȯ��
select*from user_sequences;
--�������� �̿� ���ڵ� ����
insert into tb_goods VALUES(seq_serial_num.nextval,'���ڷ�1');

--nextval:���������� ��ȯ
select seq_serial_num.nextval from dual;
--currtval:��������� ��ȯ
select seq_serial_num.currval from dual;
/*
�������� ����Ŭ�ɼǿ� ���� �ִ밪�� �����ϸ� �����ϸ� �ٽ� ó������ �Ϸù�ȣ�� ���������� ���Ἲ �������ǿ� ����ȴ�.
��, �⺻Ű(PK)�� ����� �������� ����Ŭ�ɼ��� ���� ����ϸ� �ȵȴ�.
*/
insert into tb_goods values (seq_serial_num.nextval,'�������ڷ�');
SELECT_from tb_goods; 

--������ �����ϱ�
alter sequence seq_serial_num
increment by 10
nomaxvalue /* �������� ǥ���Ҽ� �ִ� �ִ�ġ�� ����ϰڴٴ� �ǹ�.*/
minvalue 1
nocycle
nocache;
SELECT*FROM user_sequences;
/*
������ ������ start with N���� �����Ҽ�����.
*/

--������ ������ ����
insert into tb_goods values (seq_serial_num.nextval,'�������ڷ�');

select seq_serial_num.currval from dual;

--����������
drop sequence seq_serial_num;

--�Ϲ����� ������ ����->start�� min�� 1����, ����ġ�� 1, �ִ밪�� ������.
create sequence seq_serial_num
increment by 1
start with 1
nomaxvalue 
minvalue 1
nocycle
nocache;
/*
������ ������ ���� ����ÿ��� currval�� ������ �߻�.
nextval�� ���� �����Ͽ� ���� �������� ������ cullval���������� ���� �۵�.
*/
select seq_serial_num.currval from dual;
select seq_serial_num.nextval from dual;
select seq_serial_num.currval from dual;

/*
������ ������ ���ǻ���
 -Start with�� Minvalue���� �������� �����Ҽ� ����. �� Start with���� Minvalue�� ���ų� Minvalue���� Ŀ���Ѵ�.
 -NoCycle�� �����ϰ� �������� ��� ���ö� MaxValue�� �������� �ʰ��ϸ� ������ �߻��ȴ�.
 -Primary key�� Cycle�ɼ��� ����� �����ϸ� �ȵȴ�.

nextval�� currval�� ����Ҽ� �ִ� ����
SubQuery�� �ƴ� select��
-Insert���� values��
-Update���� set��
*/
--tb_goods���̺� �÷��߰�
alter table tb_goods add re_idx number;
desc tb_goods;
/*
�������ȿ��� nextval�� ������ ����ص� �׻� ���� ���� ��ȯ.
���� �亯�� �Խ��ǿ� ����� ����
*/
insert into tb_goods values(seq_serial_num.nextval,'��Ʈ��', seq_serial_num.nextval);
SELECT*FROM tb_goods;

/*
�ε��� : ���� �˻��ӵ��� ����ų�������� �����ϴ� ��ü
primary key, unique�� ������ �÷����� �ڵ����� index�� ������.
*/
--�ε��� ����
create index tb_goods_name_idx on tb_goods(g_name);

--������ �������� Ȯ���ϱ�
SELECT*FROM user_ind_columns;

--�ε��� ����
drop index tb_goods_name_idx;

