-- "" �ֵ���ǥ�� ������ �̸� �� ���ų� �̷� ���� ���� �ظ��Ѱ� �� ''����ǥ�θ�
-- emp���̺��� ��ü ����Ÿ Ȯ��

--------------------------------------------- select ����

select * from employees;    -- �ƹ� ���̳� �͵� ������� �� *

-- first_name�� last_name�� ��ȸ
select first_name,last_name from employees;

-- emp�� ���̺��� Ȯ��
desc employees;

-- ���� �������� �ѹ����� ���(�ߺ� ����)
select DISTINCT job_id from employees;

-- �̸��� �ٿ��� ����ϰ� ������ '�̸�'���� �����ϴ� ���
-- ������ as"~~~" ������ as, "" ��� �� ��, ������ ������ �ȵ�.
select first_name||' '||last_name as"�̸�" from employees;
select first_name||' '||last_name "�̸�" from employees;
select first_name||' '||last_name �̸� from employees;
-- ���� ������ ���� ��� as,""��������

--------------------------------------------------------------------------------
----------------------------------------- ���ǹ� ����

-- �������� �˻��� ��쿡 where���� ����ϱ�
select first_name,job_id from employees where first_name='Steven';

-- A�� �����ϴ� ��� �˻��� �� like ����ϱ�.. �ڿ� % �ٿ��ֱ�
select first_name,job_id from employees where first_name like 'A%';

-- A�� S�� �����ϴ� ��� �˻��ϱ�.. ���ļ� �������� ���� ������ ����
select first_name,job_id from employees where first_name like 'A%' or first_name like 'S%';

-- a�� s�� �����ϰ� �ִ� ��� �˻��ϱ�.. �յڷ� % �ٿ��ֱ�
select first_name,job_id from employees where first_name like '%a%' or first_name like '%s%';

-- ��,�ҹ��� ������� a�� s�� �����ϰ� �ִ� ��� �˻��ϱ�.. 
-- employees�� �ִ� ����� �̸��� ���� �ҹ��ڷ� �ٲ���� �ش�Ǵ� ��� �˻�
-- Ȥ�� �ݴ�� �빮�ڷ� �ٲ���� �ش�Ǵ� ��� �˻�
select first_name,job_id from employees where lower(first_name) like '%a%' or lower(first_name) like '%s%';
select first_name,job_id from employees where upper(first_name) like '%A%' or upper(first_name) like '%S%';

-- first_name�� a�� ������ ��� �˻��ϱ�.. �տ� % �ٿ��ֱ�
select first_name from employees where lower(first_name) like '%a';

-- first_name���� �ι�° ���ڰ� a�� ��� �˻��ϱ�.. 
-- _�� 1ĭ�� �ǹ��� 3��° ���ڸ� �տ� __ 2�� �ٵ� �ڿ� % �Ⱥ��̸� 
-- 2������ �̸����� 2��°�� a�� ����� �˻���
select first_name from employees where first_name like '_a%';

-- first_name���� ����° ���ڰ� a�� ��� �˻��ϱ�
select first_name from employees where first_name like '__a%';

-- salary�� 5000 �̻��� ��츸 ����ϱ�
select first_name,salary from employees where salary>=5000;

-- salary�� 5000~8000�� ��츸 ����ϱ�.. ��ȣ����, ��ɾ��
select first_name,salary from employees where salary>=5000 and salary<=8000;
select first_name,salary from employees where salary BETWEEN 5000 and 8000;

-- salary�� 3000�̸��̰ų� 10000 �ʰ��� ��츸 ����ϱ�.. ��ȣ����, ��ɾ��
select first_name,salary from employees where salary<3000 or salary>10000;
select first_name,salary from employees where salary NOT BETWEEN 3000 and 10000;

-- manager_id�� 100,103,120�� ��� ����ϱ�.. ��ȣ����, ��ɾ��
select first_name,manager_id from employees where manager_id=100 or manager_id=103 or manager_id=120;
select first_name,manager_id from employees where manager_id IN(100,103,120);

-- first_name,salary,commission_pct ����ϱ�
select first_name,salary,commission_pct from employees;

-- first_name,salary,commission_pct ����ϴµ� comm�� null�� ��츸 ����ϱ�
select first_name,salary,commission_pct from employees where commission_pct is null;

-- first_name,salary,commission_pct ����ϴµ� comm�� null�� �ƴ� ��츸 ����ϱ�
select first_name,salary,commission_pct from employees where commission_pct is not null;

-- salary�� commission_pct�� ���� ��� = commision�� null�̸� ����� null
select salary+commission_pct from employees;

-- comm�� ���� �ƴ� ��� �� salary�� 5000 �̻��� ��� ��ȸ(first_name, salary, comm�� ����ϱ�)
select first_name,salary,commission_pct from employees where commission_pct is not null and salary>=5000;
select first_name,salary,commission_pct from employees where commission_pct NOT LIKE '%null%' and salary>=5000;
select first_name,salary,commission_pct from employees where commission_pct NOT IN ('(null)') and salary>=5000;
-- �� �س��� �ȵǳ�....��...

-- ������ it_prog�̰ų� pu_man�� ����� ��ȸ(first_name,job_id)�� ���
select first_name,job_id from employees where job_id IN('IT_PROG','PU_MAN');
select first_name,job_id from employees where job_id='IT_PROG' or job_id='PU_MAN';
-- job_id�� �ִ� �������� ������ ����Ÿ���̱� ������ ��,�ҹ��� ���������

--------------------------------------------------------------------------------
--------------------------------------------------NVL �Լ� ����

-- NVL(�÷���, ��): null�� ��� �� �����ϱ�. -mysql������ ifnull
select salary ����, NVL(commission_pct,0) Ŀ�̼�, salary + NVL(commission_pct,0) �ѿ��� from employees;
-- salaryĭ ���� : ����, commissionĭ ���� : Ŀ�̼�, ���� ���Ѱ� ���� : �ѿ���

--------------------------------------------------------------------------------
----------------------------- �׷��Լ� ����:min,max,sum,avg,count

-- emp���̺��� �� ���� ���ϱ�
select count(*) count from employees;

-- salary�� ���հ� ��� ���ϱ�
select sum(salary),avg(salary) from employees;  -- �Ҽ������ϰ� �ʹ� ����
select sum(salary),round(avg(salary),0) from employees;   -- round = �ݿø�
select sum(salary),floor(avg(salary)) from employees;   -- floor = ����
select sum(salary),ceil(avg(salary)) from employees;   -- ceil = �ø�

-- salary�� �ְ����� �������� �˻��ϱ�
select min(salary) ��������,max(salary) �ְ��� from employees;

-- salary�� ���������� �޴� ����� �̸��� ������ ����Ͻÿ�(��������)
select first_name �̸�,salary ���� from employees where salary=(select min(salary) from employees);

-- ��� �������� ���� �޴� ����� �̸�(first+last) �� ������ ����Ͻÿ�(��������)
select first_name||' '||last_name �̸�,salary ���� from employees where salary>=(select avg(salary) from employees);

-- first_name�� Bruce�� ���� ������ ��������� ���(first_name,job_id)�Ͻÿ�
select first_name �̸�,job_id ���� from employees where job_id=(select job_id from employees where first_name='Bruce'); 

-- ������ �ο����� ��� ���� ���ϱ�
select job_id ����, count(*) �ο���, round(avg(salary),0) ��տ��� from employees group by job_id;
-- * �̰Ŵ� � ���̿͵� ��� ���� �� �����

-- ���� ������ ��տ����� ���� ������� ����ϱ� 
select job_id ����, count(*) �ο���, round(avg(salary),0) ��տ��� from employees group by job_id order by 3 desc;
-- ( order by 3 = 3��° ĭ�� �������� �ϰڴ�, desc = ������������ ���� )

-- ���� ������ �ο����� ���� �׷���� ����ϱ� ( order�� �ǳ��� )
select job_id ����, count(*) �ο���, round(avg(salary),0) ��տ��� from employees group by job_id order by 2 desc;

-- ���� ������ �ο��� 5�� �̻��� ���� ����ϱ�
select job_id ����, count(*) �ο���, round(avg(salary),0) ��տ��� from employees group by job_id having count(job_id)>=5;

--------------------------------------------------------------------------------
------------------------------------- join ����

-- join�� �̿��ؼ� first_name�� department_id�� �̿��ؼ� �μ����� ��ȸ�ϱ�
select e.first_name,d.department_name
from employees e, departments d
where e.department_id=d.department_id;

-- ���� sql������ ���� �ߺ����� ���� �÷����� �տ� ���̺�� ���� ����
select first_name,department_name
from employees e, departments d
where e.department_id=d.department_id;

--------------------------------------------------------------------------------
-------------------------------------- ��¥�� ���� �Լ��� ����(dual�� ����)

select sysdate ���� from dual; -- ����
select sysdate+1 ���� from dual; -- ���ñ��� ������
select sysdate+7 �����ϵ� from dual; -- ���ñ��� �����ϵ�

-- ���� ��¥���� �⵵ 4�ڸ��� �����ϱ�
select to_char(sysdate, 'YYYY') from dual;  -- 2022
select to_char(sysdate, 'yyyy') from dual;  -- 2022
select to_char(sysdate, 'YY') from dual;  -- 22
select to_char(sysdate, 'yy') from dual;  -- 22
select to_char(sysdate, 'YEAR') from dual;  -- ���ڿ���
select to_char(sysdate, 'year') from dual;  -- ���ڿ���
-- ���� �� ��ҹ��� �������.

-- ���� ��¥���� �� 2�ڸ��� �����ϱ�
select to_char(sysdate,'MM') from dual; -- 04
select to_char(sysdate,'mm') from dual; -- 04

-- ���� ��¥�� ��¥�� �ð����� ǥ��
select to_char(sysdate,'yyyy-mm-dd HH24:MI') from dual; -- 2022-04-28 15:41
select to_char(sysdate,'yyyy-mm-dd pm HH:MI') from dual; -- 2022-04-28 ���� 15:41
-- am�̵� pm�̵� ��� �θ� �� �ð��� ���� ����, ���İ� ��µ�

-- emp ���̺��� first_name�� hire_date�� ����ϴµ� hire_date�� yyyy-mm-dd �������� ����ϱ�
select first_name name,to_char(hire_date, 'yyyy-mm-dd') hire_date from employees;

-- hire_date���� �⵵�� �����ؼ� 2006�⿡ �Ի��� ����� ��ȸ�ϱ�(first_name,hire_date ���)
select first_name name,to_char(hire_date, 'yyyy-mm-dd') hire_date from employees 
where to_char(hire_date, 'yyyy')='2006';
-- hire_date=to_char(~~~) �̷��� �ؾ��ϴ� ��...

-- hire_date���� �⵵�� �����ؼ� 5���� �Ի��� ����� ��ȸ�ϱ�(first_name,hire_date ���)
select first_name name,to_char(hire_date, 'yyyy-mm-dd') hire_date from employees 
where to_char(hire_date, 'mm')='05';

-- ������ �÷��� ��������� ����ϱ�
select first_name name,to_char(hire_date, 'yyyy-mm-dd') hire_date, 
to_char(sysdate,'yyyy')-to_char(hire_date,'yyyy') �Ի���� from employees;

--------------------------------------------------------------------------------
-------------------------------------- �����Լ� ����

-- ����Ŭ�� �����Լ� ����
select abs(-5), abs(5) from dual;   -- ��� ��
select round(23.45,1) from dual;    -- 23.5 �ݿø�
select round(23.43,1) from dual;    -- 23.4 �ݿø�
select round(4567893,-1) from dual;    -- 1���ڸ����� �ݿø� 456789
select round(4567893,-2) from dual;    -- 10���ڸ����� �ݿø� 4567900
select round(4567893,-3) from dual;    -- 100���ڸ����� �ݿø� 4568000
select trunc(4567893,-3) from dual;    -- 100���ڸ����� ���� 4567000

select mod(10,3) from dual; -- 10�� 3���� ���� ������
select power(2,3) from dual; -- 2^3

--------------------------------------------------------------------------------
---------------------------------------------- ���� �Լ� ����

select concat('hello',' kitty') from dual;  -- ���ڿ� ���ؼ� ��µ�
select 'hello'||' kitty' from dual; -- ���� ����. ����Ŭ������ ����

select initcap('haPPy dAy') from dual;  -- �Ǿձ��ڸ� �빮�ڷ� �ٲ㼭 ��µ�
select lower('haPPy dAy') from dual;    -- �ҹ��ڷ� �ٲ㼭 ��µ�
select upper('haPPy dAy') from dual;    -- �빮�ڷ� �ٲ㼭 ��µ�

select LPAD('3500',10,'*') from dual;   -- 10ĭ Ȯ�� �� ���ʿ� * ��µ�
select RPAD('3500',10,'*') from dual;   -- 10ĭ Ȯ�� �� �����ʿ� * ��µ�

select substr('happy day',3,3) from dual;   -- 3��° �ڸ����� 3�� ��µ�
select substr('happy day',-3,3) from dual;   -- �ڿ��� 3��° �ڸ����� 3�� ��µ�

select length('happy day') from dual;   -- ���� ����(���� ����)

select replace('Have a Nice Day','a','*') from dual;    -- ���ڿ� �� a���ڸ� *�� �����ؼ� ���
select replace('Have a Nice Day','Nice','Good') from dual;   


--------------------------------------------------------------------------------
-- to_char, NVL, round, lower, upper ���� ��