/***************
���ϸ� : Or03String.sql
���ڿ� ó���Լ�
���� : ���ڿ��� ���� ��ҹ��ڸ� ��ȯ�ϰų� ���ڿ��� ���̸� ��ȯ�ϴ� �� ���ڿ���
    �����ϴ� �Լ�
***************/


/*
concat(���ڿ�1, ���ڿ�2)
    : ���ڿ�1�� 2�� ���� �����ؼ� ����ϴ� �Լ�
    ����1 : concat('���ڿ�1', '���ڿ�2');
    ����2 : '���ڿ�1' || '���ڿ�2'
*/
select concat('Good ', 'morning') AS "��ħ�λ�" from dual;

select 'Oracle'||' 11g'||' Good' from dual;
-- => �� ������ concat()���� �����ϸ�...
    select   
        concat(concat('Oracle' , ' 11g'), ' Good')
    from dual; --concat()�� �ΰ��� ���ڷ� ������ �Լ��̹Ƿ� 3���� ���ڿ���
                      -- �����ϱ� ���ؼ��� ���Ͱ��� 2���� concat()�Լ��� ����ؾ��Ѵ�.
    
/*
��������) employees ���̺��� �����ȣ�� 100�� ���ڵ带 ��ȸ�ؼ� "XXX���� 
    �̸����� YYY�Դϴ�" ���·� ��µǵ��� concat() �Լ��� �̿��ؼ� ��ȸ�Ͻÿ�.
*/
--���1 : concat()���
--���2 : || ���
select 
    concat(concat(concat(first_name, '���� �̸����� ') , email) , '�Դϴ�') AS "����1",
    first_name || '���� �̸�����' || email || '�Դϴ�' AS "����2"
from employees where employee_id=100;

/*
initcap(���ڿ�)
    : ���ڿ��� ù���ڸ� �빮�ڷ� ��ȯ�ϴ� �Լ�.
    ��, ù���ڸ� �ν��ϴ� ������ ������ ����.
    -���鹮�� ������ ������ ù���ڸ� �빮�ڷ� ��ȯ�Ѵ�.
    -���ĺ��� ���ڸ� ������ ������ ���� ������ ������
    ù��°���ڸ� �빮�ڷ� ��ȯ�Ѵ�. 
*/
select initcap('hi hello �ȳ�') from dual; -- Hi Hello �ȳ�

select initcap('good/bad morning') from dual; -- Good/Bad Morning

select initcap('never6say*good��bye') from dual; -- Never6say*Good��Bye

--������̺��� john�� ã�Ƽ� �����Ͻÿ�
select first_name, last_name from employees where first_name=initcap('john');

/*
��ҹ��ں���
lower() : �ҹ��ڷ� ������
upper() : �빮�ڷ� ������
*/
select lower('GOOD') AS "�ҹ��ڷ�", upper('bad') "�빮�ڷ�" from dual;
select lower(email) AS "�̸������ҹ��ڷ�" from employees;

/*
lpad(), rpad() 
    : ���ڿ��� ����, �����ʿ� Ư���� ��ȣ�� ä�ﶧ ����ϴ� �Լ�
    ����] lpad('���ڿ�', '��ü�ڸ���', 'ä�﹮�ڿ�')
        -> ��ü�ڸ������� ���ڿ��� ���̸�ŭ�� ������ ������ 
        �����κ��� �־��� ���ڿ��� ä���ִ� �Լ�. 
        rpad()�� �������� ä����
*/
select
    'good' STR,
    lpad('good', 6) "LPAD1",
    lpad('good', 7, '#') "LPAD2",
    rpad('KOSMO', 7) "RPAD1",
    rpad('KOSMO', 8, '@') "RPAD2"
from dual;

/*
trim() : ������ �����Ҷ� ����ϴ� �Լ�
    ����] trim([leading | trailing | both] �����ҹ��� from �÷�
    -leading : ���ʿ��� ������
    -trailing : �����ʿ��� ������
    -both : ���ʿ��� ������. �������� ������ both�� ����Ʈ
    [����1] ���ʳ��� ���ڸ� ���ŵǰ� �߰��� �ִ� ���ڴ� ���ŵ��� �ʴ´�.
    [����2] '����'�� ������ �� �ְ�, '���ڿ�'�� ������ �� ����. �����߻���
*/
select
    trim(' ���������׽�Ʈ ') as trim1,
    trim('��' from '�ٸ� �����ұ��?') as trim2,
    trim('��' from '�ٶ��㰡 ������ ž�ϴ�') as trim3,
    trim(both '��' from '�ٶ��㰡 ������ ž�ϴ�') as trim4,
    trim(leading '��' from '�ٶ��㰡 ������ ž�ϴ�') as trim5,
    trim(trailing '��' from '�ٶ��㰡 ������ ž�ϴ�') as trim6,
    trim(both '��' from '�ٶ��㰡 �ٸ����� ������ ž�ϴ�') as trim7
from dual;
    -- trim7�� ��� �߰��� '��'�� �������� �ʴ´�. 
    -- �ɼ��� ���°�� both�� ����Ʈ�̹Ƿ� trim3, trim4�� ������ ����� ���´�.

/*
�Ʒ� ������ �������� �߻���. trim()�� ���ڸ� �����Ҽ� ����
���� ���ڿ��� �����ϰ� �ʹٸ� replace()�� ����ؾ� �Ѵ�. 
*/
select
    trim('�ѱ�' from '�ѱ�����Ʈ�������簳�߿�') as trimError
from dual;


/*
ltrim(), rtrim() -> L[eft]TRIM, R[ight]TRIM
    : ����, ���� '����' Ȥ�� '���ڿ�'�� �����Ҷ� ����Ѵ�.
    �� TRIM�� ���ڿ��� ������ �� ������, LTRIM�� RTRIM�� ���ڿ����� 
    ������ �� �ִ�.
*/
select
    ltrim(' ������������ ') ltrim1,
    ltrim('�������ڿ�����', '����') ltrim2,
    ltrim('�䷸�Դ� ���ڿ����� �ӵ���', '����') as ltrim3,
    
    rtrim('�������ڿ�����', '����') as rtrim3
from dual;
    --���ڿ� �߰��� ������ �� ����. 


/*
substr() : ���ڿ����� �����ε������� ���̸�ŭ �߶� ���ڿ��� ����Ѵ�. 
    ����] substr(�÷�, �����ε���, ����)
    
    ����1) ����Ŭ�� �ε����� 1���� �����Ѵ�.(0���� �ƴ�)
    ����2) '����'�� �ش��ϴ� ���ڰ� ������ ���ڿ��� ���� �ǹ��Ѵ�.
    ����3) �����ε����� �������̸� ���������� �·� �ε����� �����Ѵ�. 
*/
select substr('good morning john', 8, 4) from dual; --rnin
select substr('good morning john', 8) from dual;--rning john

--�ε���2���� �߶�
select substr('�ȳ��ϼ���', 2) from dual; -- ���ϼ���

/*
substrb() : ����Ʈ(byte)������ �߶�.
    ��������� �ѱ۰� ���� �����ڵ�� �ѱ��ڿ� 3byte�� ǥ���ǳ� 
    ���ݾ� ��߳��� ��찡 ����Ƿ� �׽�Ʈ �ʿ���.
*/
select substrb('�ȳ��ϼ���', 1) from dual;--�ȳ��ϼ���
select substrb('�ȳ��ϼ���', 2) from dual;--__���ϼ���
select substrb('�ȳ��ϼ���', 3) from dual;--_���ϼ���
select substrb('�ȳ��ϼ���', 4) from dual;--���ϼ���
select substrb('�ȳ��ϼ���', 5) from dual;--
select substrb('�ȳ��ϼ���', 6) from dual;--
select substrb('�ȳ��ϼ���', 7) from dual;--
select substrb('�ȳ��ϼ���', 8) from dual;--

/*
replace() : ���ڿ��� �ٸ� ���ڿ��� ��ü�Ҷ� ����Ѵ�. 
    ����] replace(�÷��� or ���ڿ�, '�����Ҵ���ǹ���', '�����ҹ���')
    
    ��trim(), ltrim(), rtrim()�޼ҵ��� ����� replace()�޼ҵ� �ϳ��� ��ü�Ҽ� 
    �����Ƿ� trim()�� ���� replace()�� �ξ� �� ���󵵰� ����.
*/
select 
    replace('good morning tom', 'morning', 'evening') as "���ڿ���ü" 
from dual;
select 
    replace('good morning tom', ' morning', '') as "���ڿ�����" 
from dual;

select 
    trim(' blank1 blank2 ') as "��������1"
from dual;-- ��, ������ ������ ���ŵ����� ���ڿ� �߰��� ������ ���ŵ��� ����.
select 
    replace(' blank1 blank2 ', ' ', '') as "��������2" 
from dual;-- ��, ������ �߰��� ���鵵 �Ѳ����� ���ŵȴ�. 


/*
instr() : �ش� ���ڿ����� Ư�����ڰ� ��ġ�� �ε������� ��ȯ�Ѵ�. 
    ����1] instr(�÷���, 'ã������')
        => ���ڿ��� ó������ ���ڸ� ã�´�.
    ����2] instr(�÷���, 'ã������', Ž���� ������ �ε���, ���°����) 
        => Ž���� �ε������� ���ڸ� ã�´�. ��, ã�� ������ ���°�� �ִ�
        �������� ������ �� �ִ�. 
*/
select instr('good morning john', 'n') from dual; 
    -- n�� �߰ߵ� ù��° �ε��� ��ȯ : 9
select instr('good morning john', 'n', 1, 2) from dual; 
    -- n�� �߰ߵ� �ι�° �ε��� ��ȯ : 11
select instr('good morning john', 'n', 10, 2) from dual; 
    -- 10��° �ε������� Ž���� �����Ͽ� n�� �߰ߵ� 2��° �ε��� ��ȯ : 17







