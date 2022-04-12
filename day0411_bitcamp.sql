-- ������ ������ ���̺� ����

-- primary key �⺻Ű = not null + unique
--                      �� �ְ� + �ߺ� �ȵǰ�
create table test (idx number(5) primary key,
    name varchar2(20) not null,
    age number(3),
    email varchar2(20) unique);
    
-- ���̺��� �⺻ ���� Ȯ��
desc test;

-- ����Ÿ �߰�
insert into test (idx,name,age,email) values (1,'lee',12,'aaa@naver.com');

-- ��ü �ķ� ����Ÿ �߰��� �÷����� ������ ������
insert into test values (2,'kim',23,'kim@nate.com');

-- idx ���� ���� �ʾ��� ��� ���� Ȯ��
insert into test (name,age) values ('park',30);
-- �̷��� ����. cannot insert NULL into ("BITCAMP"."TEST"."IDX")

-- idx�� �ߺ����� �־��� ��� ���� Ȯ��
insert into test (idx,name,age) values  (2,'park',30);
-- �̷��� ����. unique constraint (BITCAMP.SYS_C007002) violated
-- ���⼭ SYS_C007002 �긦 �˾ƺ��� ���� �̸��� �ٲ��� �� ����

-- email�� unique ����� ���� Ȯ��
insert into test (idx,name,email) values (3,'shin','kim@nate.com');
-- �̷��� ����. unique constraint (BITCAMP.SYS_C007003) violated

-- ����Ÿ Ȯ��
select * from test;


-- test ���̺� ����
drop table test;


-- ���� test ���̺��� �������Ǹ��� �ָ鼭 �ٽ� �����غ���
create table test (idx number(5) CONSTRAINT test_pk_idx primary key,
    name varchar2(20) CONSTRAINT test_nn_name not null,
    age number(3),
    email varchar2(20) CONSTRAINT test_uq_email unique);

-- ����Ÿ �߰��ϸ� ���� Ȯ���غ���
insert into test values (1,'aaa',11,'aaa@naver.com');
insert into test (idx,name) values (1,'bbb'); -- unique constraint (BITCAMP.TEST_PK_IDX) violated
insert into test (idx,name,email) values (2,'bbb','aaa@naver.com'); -- unique constraint (BITCAMP.TEST_PK_IDX) violated
insert into test (idx,age,email) values (2,12,'bbb@naver.com'); -- cannot insert NULL into ("BITCAMP"."TEST"."NAME")

-- email test_uq_email�� ���������� �����ϱ�
alter table test drop CONSTRAINT TEST_UQ_EMAIL;
-- ���� �̸����� �־ ���� ������ �ȳ�.
insert into test (idx,name,email) values (2,'bbb','aaa@naver.com');

-- ���ο� �÷� �߰��ϱ�
alter table test add blood varchar2(10);
-- ���ο� �÷� �߰��� �ʱⰪ �����ϱ�
alter table test add addr varchar2(50) default '���� ���ﵿ';

-- �÷� Ÿ�� ���� ex.) varchar2(50) -> varchar2(100)
alter table test MODIFY addr varchar2(100);
alter table test modify age varchar2(5); 
-- "column to be modified must be empty to change datatype" -> ����Ÿ�� �־ �ȵȴ�

-- �÷� ����
alter table test drop column blood;

-- �÷��� �����ϱ� addr -> address
alter table test rename COLUMN addr to address;
alter table test rename COLUMN age to nai;

--------------------------------------------------------------------------------
-- ����

-- score��� �÷� �߰��ϱ�. Ÿ���� number(5), �ʱⰪ�� 50����
alter table test add score number(5) default 50;
-- score�� �÷��� ���� score -> jumsoo��
alter table test rename COLUMN score to jumsoo;
-- idx�� �÷� ���̸� 5���� 10����
alter table test modify idx number(10);
--------------------------------------------------------------------------------

-- ����Ÿ Ȯ��
select * from test;
-- ���̺� ���� Ȯ��
desc test;

-- ���̺� ����
drop table test;
-- =============================================================================
-- =============================================================================
-- =============================================================================
-- =============================================================================

-- ������ ����
create SEQUENCE seq1;   -- �⺻������ 1���� 1�� �����Ǵ� �������� ������ ��
create SEQUENCE seq2 start with 1 INCREMENT by 1;   -- �׷��� ���� ����� �Ȱ���
create SEQUENCE seq3 start with 10 increment by 5;
create sequence seq4 nocache;   -- cache ����� 0
create sequence seq5 maxvalue 5 cycle nocache;  -- 5���� �����Ǹ� �ٽ� 1�� �ݺ��ϱ�
--                  (maxvalue 5 cycle)�� nocache �̷��� 2�� ������

-- ������ ����
drop sequence seq4;
-- ���Ŵ� ��𼭵��� drop

-- �������� ���
select seq2.nextval from dual;
select seq3.nextval from dual;
select seq5.nextval from dual;

-- ��ü ������ Ȯ��
select * from seq;

-- ���� ������ ��� �����ϱ�
drop sequence seq1;
drop sequence seq2;
drop sequence seq3;
drop sequence seq5;
-- =============================================================================

-- table �����
create table sawon(
    num number(5) CONSTRAINT sawon_pk_num PRIMARY key,
    name varchar(20),
    buseo varchar2(20) default '������',   -- �ʱⰪ ������
    age number(5),
    pay number(10),
    ipsaday date);

create SEQUENCE seq_sawon nocache;
-- ����Ÿ �߰�
insert into sawon values (seq_sawon.nextval,'��ȣ��','ȫ����',34,6700000,'2017-12-11');
insert into sawon (num,name,age,pay,ipsaday) values (seq_sawon.nextval,'������',28,3450000,sysdate);
insert into sawon values (seq_sawon.nextval,'���缮','�λ��',45,5600000,'2018-03-19');
insert into sawon values (seq_sawon.nextval,'������','������',25,2800000,'2021-10-12');
insert into sawon values (seq_sawon.nextval,'������','ȫ����',41,5500000,'2019-12-30');
insert into sawon values (seq_sawon.nextval,'����ȣ','�λ��',38,4780000,'2020-05-06');
commit; -- Developer(DML)�� �ڵ� Ŀ���� �ȵ�. commit�̶� ������� ����, rollback�̶� ������� ���

-- ��������
-- ��ȣ�� �μ��� �λ�η�, ���̸� 34���� 35�� ����
update sawon set buseo='�λ��', age=35 where num=1;
-- �������� �Ի����� 2020-12-29�Ϸ� ����
update sawon set ipsaday='2020-12-29' where name='������';
-- �����ϱ�
-- num�� 3���� ����Ÿ ����
delete from sawon where num=3;

ROLLBACK;

-- Ȯ��
select * from sawon order by num;

-- Group by ����
-- �μ��� �ο����� ��ճ��� ��տ��� ���ϱ�(������ �μ��� ��������)
select buseo �μ���, COUNT(*) �ο���, floor(avg(age)) ��ճ���, 
    to_char(avg(pay),'L9,999,999') ��տ��� from sawon
    group by buseo order by �μ���;

-- �������� ����
-- �ִ� �޿��� �޴� ����� �̸��� ���̿� �μ�, �޿��� ����Ͻÿ�
select name �̸�, age ����, buseo �μ���, pay �޿� from sawon where pay=(select max(pay) from sawon);
-- ��� �޿����� ���� �޴� ����� �̸��� ����, �μ�, �޿��� ����Ͻÿ�
select name �̸�, age ����, buseo �μ���, pay �޿� from sawon where pay>(select avg(pay) from sawon);


-- ������ ��Ÿ���� �Լ�
-- �μ��� ȫ���θ� '���', �����θ� '����', �λ�θ� '���ǵ�'
select name �����, buseo �μ���, 
decode(buseo,'ȫ����','���','������','����','�λ��','���ǵ�') �繫����ġ
from sawon;

-- case when
select name �����, buseo �μ�, pay ���޿�,
case when pay>=6000000 then '�ʰ���'
     when pay>=5000000 then '����'
     when pay>=4000000 then '��տ���'
     else '�ּҽñ�'
end �з�
from sawon;

select name,
case when name in ('��ȣ��','���缮','������') then '�׷� A'
     when name in ('������','����ȣ') then '�׷� B'
     else '�׷� C'
end �׷�
from sawon;


-- ���� ���̺��� �����ؼ� ���ο� ���̺��� ���� 
create table sawon_a as select * from sawon where buseo='ȫ����';
select * from sawon_a;

-- skdlrk 35�� �̻��� ����� �����ؼ� sawon_b ���̺�� ����
create table sawon_b as select * from sawon where age>=35;
select * from sawon_b;


-- =============================================================================

-- join ����
-- shop ���̺� ����
create table shop(
    idx number(5) constraint shop_pk_idx Primary key,
    sangpum varchar2(20),
    color varchar2(20),
    price number(10),
    ipgoday date);
    
-- jumun ���̺� ����(shop�� idx�� �ܺ�Ű�� ���)
create table jumun(
    num number(5) constraint jumun_pk_num primary key,
    name varchar2(20),
    idx number(5) constraint jumun_fk_idx references shop(idx),
    cnt number(5));


-- ��ǰ�� ������ ���� ����
create sequence seq_shop nocache;

-- shop�� ��ǰ ���
insert into shop values (seq_shop.nextval,'���콺','white',23000,sysdate);
insert into shop values (seq_shop.nextval,'û����','blue',47000,'2022-03-20');
insert into shop values (seq_shop.nextval,'���̳�Ƽ','pink',16000,sysdate);
insert into shop values (seq_shop.nextval,'üũ����','red',17000,'2021-12-25');
insert into shop values (seq_shop.nextval,'���콺','yellow',19500,'2021-03-29');

commit;

select * from shop;

-- jumun ���̺� ����Ÿ �߰��ϱ�
-- ���� shop��ǰ�� ��Ͻ� � ������ �������� Ȯ���غ���
insert into jumun values (seq_shop.nextval,'�̿���',3,1); -- �����߻� : parent key not found
insert into jumun values (seq_shop.nextval,'�̿���',16,1); -- 14 ~ 18��������
insert into jumun values (seq_shop.nextval,'���缮',17,3);
insert into jumun values (seq_shop.nextval,'�Ѱ���',18,2);
insert into jumun values (seq_shop.nextval,'������',15,1);
insert into jumun values (seq_shop.nextval,'������',16,3);
insert into jumun values (seq_shop.nextval,'������',14,1);
commit;
select * from jumun;

-- join�ؼ� ���(��ġ�ϴ� �� ���)
select
    j.num,j.name,s.sangpum,s.color,s.price,j.cnt,s.ipgoday
from shop s,jumun j
where s.idx=j.idx;

-- �÷��� �տ� ���̺���� ��� ���ʸ� �����ϴ� ��� ������ ������
-- idx�� ������ �� �־ ����������� num,name,sangpum,color,price,cnt,ipgoday�� s. j. ��������
select
    num,name,sangpum,color,price,cnt,ipgoday
from shop s,jumun j
where s.idx=j.idx;
---------------------------------------------------------
-- ��ǰ�� �ֹ��� ����� �ִ� ���¿��� ��ǰ�� �����غ���
delete from shop where idx=14; -- �����߻� : child record found

-- ������ ������ �� ��� view�� �������� ��ȸ�� �ʿ��� �� ����Ѵ�

-- create�� �� ��� : ���� ������ ����, ���� �̸��� ���� ��� ������ �߻���
-- create or replace�� �� ��� : ���� ������ �ϴµ� ���� �̸��� ���� ��� ���

create or replace view mycart
as
select
    j.num,j.name,s.sangpum,s.color,s.price,j.cnt,s.ipgoday
from shop s,jumun j
where s.idx=j.idx;  -- ������ �߻��� : ������ ���ٰ� ����. 
            -- �׷��� system�� ���� bitcamp�� create view�� ���� ������ �߰��ؾ��Ѵ�

-- view ��ȸ
select * from mycart;



