-- 오늘도 join 연습용 테이블 생성

-- 부모 테이블 : 음식목록
create table food (
    idx number(5) Constraint food_pk_idx Primary key,   -- 기본키
    foodname varchar2(20) not null,                     -- 음식명
    price number(7) not null);                          -- 가격

-- 자식 테이블
create table foodjumun(
    num number(5) constraint foodjumun_pk_num primary key,  -- 기본키
    name varchar2(20),                                      -- 주문자
    idx number(5),                                          -- 외부키로 설정
    foodtime date,                                          -- 예약시간
    constraint foodjumun_fk_idx FOREIGN key(idx)            
    REFERENCES food(idx) on delete cascade);                
    -- foreign key = 부모와 자식간의 연결장치라고 생각하면 됨.
    -- on delete cascade = 부모테이블의 데이타를 지우면 자식테이블의 데이타가 자동으로 지워짐
    -- ex.) 게시글 데이타 지워질 때 그 게시글의 댓글도 같이 지우는 느낌
    
-- 사용할 시퀀스 생성
create SEQUENCE seq_food start with 1 INCREMENT by 1 nocache;

-- food의 foodname을 넉넉히 50바이트로 변경
alter table food modify foodname varchar2(50);

-- food 테이블에 데이타 넣기
insert into food values (10,'봉골레스파게티',17000);
-- varchar2의 공간이 부족해서 데이타를 넣지 못하기 때문에 넉넉하게 변경해주고 넣으면 됨.
insert into food values (20,'새우볶음밥',11000);
insert into food values (30,'된장찌개',8000);
insert into food values (40,'크림스파게티',12000);
insert into food values (50,'짜장면',8000);
insert into food values (60,'순두부찌개',9000);

select * from food;

-- 음식 주문 테이블에 데이타 넣기
insert into foodjumun values (seq_food.nextval,'유재석',20,'2022-04-15');
insert into foodjumun values (seq_food.nextval,'강호동',10,'2022-05-10');
insert into foodjumun values (seq_food.nextval,'이영자',50,sysdate);
insert into foodjumun values (seq_food.nextval,'유진',60,'2022-04-10');
insert into foodjumun values (seq_food.nextval,'한지혜',20,'2022-03-15');
commit;
select * from foodjumun;

-- join하기 
-- 방법 1 // ... where ...
select
    name 주문자,foodname 음식명,price 가격,to_char(foodtime,'yyyy-mm-dd') 예약일
from food f,foodjumun fj
where f.idx=fj.idx;

-- 방법 2 // inner join ... on ...
select
    name 주문자,foodname 음식명,price 가격,to_char(foodtime,'yyyy-mm-dd') 예약일
from food f inner join foodjumun fj
on f.idx=fj.idx;

-- outer join : 일치하지 않은 데이타 출력 = 아무도 주문하지 않은 음식 찾기
select foodname 인기없는음식
from food f,foodjumun fj 
where f.idx=fj.idx(+) and num is null;      -- foodjumun 쪽에 (+)를 붙이면 됨.
-- and num is null을 넣지않으면 전체 데이타 나옴. null값을 찾는거임
-- 여기서 null값이 나온 데이타는 food에는 있는데 foodjumun에는 없는 데이타인거임


-- food에서 idx가 20인 음식을 삭제 시 foodjunmun도 확인하기
delete from food where idx=20;
-- foreign key로 연결해놓고 on delete cascade로 같이 삭제되게끔 해놔서 깔끔하게 되는거임

rollback;
