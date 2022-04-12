-- ���õ� join ������ ���̺� ����

-- �θ� ���̺� : ���ĸ��
create table food (
    idx number(5) Constraint food_pk_idx Primary key,   -- �⺻Ű
    foodname varchar2(20) not null,                     -- ���ĸ�
    price number(7) not null);                          -- ����

-- �ڽ� ���̺�
create table foodjumun(
    num number(5) constraint foodjumun_pk_num primary key,  -- �⺻Ű
    name varchar2(20),                                      -- �ֹ���
    idx number(5),                                          -- �ܺ�Ű�� ����
    foodtime date,                                          -- ����ð�
    constraint foodjumun_fk_idx FOREIGN key(idx)            
    REFERENCES food(idx) on delete cascade);                
    -- foreign key = �θ�� �ڽİ��� ������ġ��� �����ϸ� ��.
    -- on delete cascade = �θ����̺��� ����Ÿ�� ����� �ڽ����̺��� ����Ÿ�� �ڵ����� ������
    -- ex.) �Խñ� ����Ÿ ������ �� �� �Խñ��� ��۵� ���� ����� ����
    
-- ����� ������ ����
create SEQUENCE seq_food start with 1 INCREMENT by 1 nocache;

-- food�� foodname�� �˳��� 50����Ʈ�� ����
alter table food modify foodname varchar2(50);

-- food ���̺� ����Ÿ �ֱ�
insert into food values (10,'���񷹽��İ�Ƽ',17000);
-- varchar2�� ������ �����ؼ� ����Ÿ�� ���� ���ϱ� ������ �˳��ϰ� �������ְ� ������ ��.
insert into food values (20,'���캺����',11000);
insert into food values (30,'�����',8000);
insert into food values (40,'ũ�����İ�Ƽ',12000);
insert into food values (50,'¥���',8000);
insert into food values (60,'���κ��',9000);

select * from food;

-- ���� �ֹ� ���̺� ����Ÿ �ֱ�
insert into foodjumun values (seq_food.nextval,'���缮',20,'2022-04-15');
insert into foodjumun values (seq_food.nextval,'��ȣ��',10,'2022-05-10');
insert into foodjumun values (seq_food.nextval,'�̿���',50,sysdate);
insert into foodjumun values (seq_food.nextval,'����',60,'2022-04-10');
insert into foodjumun values (seq_food.nextval,'������',20,'2022-03-15');
commit;
select * from foodjumun;

-- join�ϱ� 
-- ��� 1 // ... where ...
select
    name �ֹ���,foodname ���ĸ�,price ����,to_char(foodtime,'yyyy-mm-dd') ������
from food f,foodjumun fj
where f.idx=fj.idx;

-- ��� 2 // inner join ... on ...
select
    name �ֹ���,foodname ���ĸ�,price ����,to_char(foodtime,'yyyy-mm-dd') ������
from food f inner join foodjumun fj
on f.idx=fj.idx;

-- outer join : ��ġ���� ���� ����Ÿ ��� = �ƹ��� �ֹ����� ���� ���� ã��
select foodname �α��������
from food f,foodjumun fj 
where f.idx=fj.idx(+) and num is null;      -- foodjumun �ʿ� (+)�� ���̸� ��.
-- and num is null�� ���������� ��ü ����Ÿ ����. null���� ã�°���
-- ���⼭ null���� ���� ����Ÿ�� food���� �ִµ� foodjumun���� ���� ����Ÿ�ΰ���


-- food���� idx�� 20�� ������ ���� �� foodjunmun�� Ȯ���ϱ�
delete from food where idx=20;
-- foreign key�� �����س��� on delete cascade�� ���� �����ǰԲ� �س��� ����ϰ� �Ǵ°���

rollback;
