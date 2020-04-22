/*******************************
���ϸ� : Or13DCL.sql
����ڱ���
���� : ���ο� ����ڰ����� �����ϰ� �ý��۱����� �ο��ϴ� ����� �н�
*******************************/

/*
[����ڰ��� ���� �� ���Ѽ���]
�ش� ������ DBA������ �ִ� �ְ������(sys, system)�� ������ �����ؾ��Ѵ�.
(����� ���� ������ ���� �׽�Ʈ�� CMD(���������Ʈ)���� �����Ѵ�.)
*/


/*
1] ����ڰ��� ���� �� ��ȣ����
����]
    create user ���̵� identified by �н�����;
*/
create user test_user1 identified by 1234;
--cmd���� sqlplus������� ���ӽ� login denied ���� �߻���.

/*
2] ������ ����� ������ ���� Ȥ�� ���� �ο�
����]
    grant �ý��۱���1[,�ý��۱���2 .... ] | [����1[,����2....]
        to �����1[,�����2....] | [����1 [,����2....]
        [with grant option] <- �ο����� �ý��۱����� �ٸ� ����ڿ���
                                ��ο��Ҽ� �ִ� ����.

*/
--���ӱ��� �ο�
grant create session to test_user1;

--���̺� ���� ���� �ο�
grant create table to test_user1;

/*
* sqlplus ���� ED��ɾ�
-������ �ۼ��� �޸������� �ۼ��� ���� ��Ű�� ���

1. ED �ۼ��������̸�
SQL> ED MYBOARD[����]
-> �̿Ͱ��� ������ ����ڰ��� ���丮�� MYBOARD.sql������ ������.

2. �޸��忡�� BORAD���̺��� �����Ѵ�.
   ������ ���忡 / �� �� �ٿ��ش�.
   �ۼ��� ���� �׸��� ���� �ݱ�.

3. ����
SQL> @MYBOARD

4.���� ���� �����ÿ��� SQL>ED MYBOARD [����]ġ�� �޸����� ����.
*/

--�ý��� ���� ��� Ȯ���ϱ� : ��ü 208���� �ý��� ���� ����. 
select * from system_privilege_map;
select * from system_privilege_map where name like upper('%select%');

/*
3] ��ȣ����
����]
    alter user ����ھ��̵� identified by ���ο��ȣ;
*/
alter user test_user1 identified by 4321;


/*
[4] ROLE(��)�� ���� �������� ���� ���ÿ� �ο��ϱ�
    : ���� ����ڰ� �پ��� ������ ȿ�������� �����Ҽ� �ֵ��� ���õ�
    ���ѳ��� ���������
������ ����ڰ����� �����ϸ� �⺻������ Connect, Resource ���� �ο��Ѵ�.  
*/
--���ο� ���� ����
create user test_user2 identified by 1234;
--Role�� ���� ���Ѻο�
grant connect, resource to test_user2;


/*
4-1) �ѻ��� : ����ڰ� ���ϴ� ������ ���� ���ο� ���� ������ �� �ִ�.
����]
    create role ���̸�;
*/
create role kosmo_role;

/*
4-2) �ѿ� ���� �ο�
����]
    grant ����1, ����2......to ���̸�;
*/
grant create session, create table, create view to kosmo_role;
--���ο� ���� ����
create user test_user3 identified by 1234;
--�츮�� ������ ���� ���� ���Ѻο�
grant kosmo_role to test_user3;
--�����ͻ������� Ȯ���ϱ�
select * from role_sys_privs where role like upper('%kosmo_role%');
--�� �����ϱ�
drop role kosmo_role;
/*
    test_user3 ������ ����ڰ� ������ ���� ���� ������ �ο��޾����Ƿ�
    �ش� ���� �����ϸ� �ο��޾Ҵ� ������ ȸ��[����]�ȴ�. �� �� ������
    ������ �� ����. 
*/


/*
[5]��������
    ����]
        revoke ���� �� ���� from ����ھ��̵�;
*/
revoke create session from test_user1;

/*
[6]����ڰ��� ����
    ����] 
        drop user ����ھ��̵� [cascade];
        
��cascade�� ����ϸ� ����ڰ����� ���õ� ��� �����ͺ��̽� ��Ű���� 
�����ͻ������� ���� �����ǰ� ��� ��Ű�� ��ü�� ���������� �����ȴ�. 
*/
drop user test_user1 cascade;

--������ �������� ����� ��� Ȯ���ϱ�
select * from dba_users;








