/************
���ϸ� : Or02Number.sql
����(����) ���� �Լ�
���� : ���ڵ����͸� ó���ϱ� ���� ���ڰ��� �Լ��� �˾ƺ���
    ���̺� ������ number Ÿ������ ����� �÷��� ����� �����͸�
    ������� �Ѵ�. 
*************/

/*
DUAL ���̺�
    : �� ������ ����� ����ϱ� ���� �����Ǵ� ���̺�� ����Ŭ���� 
    �ڵ����� �����Ǵ� �ӽ� ���̺��̴�. 
    varchar2(1)�� ���ǵ� dummy��� �� �ϳ��� �÷����� �����Ǿ�
    �ִ�. 
*/
desc dual; -- ���̺��� ���̾ƿ� Ȯ��
select * from dual;

--abs() : ���밪 ���ϱ�
select abs(-1000) AS "-1000�����밪" from dual ;
select abs(9000) AS "9000�����밪" from dual ;

/*
trunc() :  �Ҽ����� Ư���ڸ������� �߶󳾶� ����ϴ� �Լ�
    ���� : trunc(�÷��� Ȥ�� ��, �Ҽ��������ڸ���)
        �ι�° ���ڰ�
            ����϶� : �־��� ���ڸ�ŭ �Ҽ����� ǥ��
            ������ : �����θ� ǥ��. �� �Ҽ��� �Ʒ��κ��� ����
            �����϶� : �����θ� ���ڸ�ŭ �߶� �������� 0���� ä��
*/
select trunc(1234.123456, 2) "TRUNC�������" from dual;
select trunc(1234.123456) "TRUNC���ھ���" from dual;
select trunc(1234.123456, -2) "TRUNC��������" from dual;

--������̺��� ���ʽ����� �ִ� ����� �����ͼ� �Ҽ��� 1�ڸ��� ǥ���Ͻÿ�.
select 
    first_name, last_name, commission_pct, trunc(commission_pct, 1)
from employees
where commission_pct is not null;

/*
�Ҽ��� �����Լ�

ceil(��) : �Ҽ��� ���ϸ� ������ �ø�ó��

floor(��) : �Ҽ��� ���ϸ� ������ ����ó��.

round(��, �ڸ���) : �Ҽ��� ���ϸ� �ݿø� ó��
    �ι�° ���ڰ�
        ���°�� : �Ҽ��� ù��° �ڸ��� 5�̻��̸� �ø�, �̸��̸� ����
        �ִ°�� : ���ڸ�ŭ �Ҽ����� ǥ���ǹǷ� �� �������� 5�̻��̸�
            �ø�, �̸��̸� ����
*/
select ceil(32.8) from dual; --33
select ceil(32.3) from dual; --33

select floor(32.8) from dual; --32
select floor(32.3) from dual; --32

select round(0.123), round(0.543) from dual; -- 0, 1
--ù��° : �Ҽ����� 6�ڸ����� ǥ���ϹǷ� 7�� �ø�ó����
--�ι�° : �Ҽ����� 4�ڸ��� ǥ���ϹǷ� 1�� ����ó����
select round(0.1234567, 6), round(2.345612, 4) from dual;


/*
power() : �ŵ������� ����Ҷ� ����ϴ� �Լ�
    ���� : power(k, n) => k�� n�� ���Ѱ���� ��ȯ�Ѵ�. 
*/
select power(4, 3) "4��3��" from dual;
select power(2, 10) "2��10��" from dual;

/*
mod() : �������� ���ϴ� �Լ�
*/
select mod(99, 4) "99�� 4�� ���� ������" from dual;

/*
sqrt() : ������(��Ʈ)�� ���ϴ� �Լ�
    => ����� �����ϸ� 64�� �ǳ���? => 64�� ��������?
*/
select sqrt(64), sqrt(9) "9��������" from dual;

/*
��������] 3�� �������� �Ҽ��� ��°�ڸ����� ǥ���Ͻÿ�.
�� trunc()�Լ��� round()�Լ��� ����ؼ� ���� �����Ͻÿ�.
*/
select sqrt(3) "3��������" from dual;
select trunc(sqrt(3), 2) from dual;
select round(sqrt(3), 2) from dual;
-- trunc()�� 4�ڸ� �Ʒ��� ����ó���ϰ� round()�� �ݿø� ó����.
select trunc(sqrt(3), 4), round(sqrt(3), 4) from dual;













