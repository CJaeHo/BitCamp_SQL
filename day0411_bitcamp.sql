-- 연습용 간단한 테이블 생성

-- primary key 기본키 = not null + unique
--                      값 주고 + 중복 안되고
create table test (idx number(5) primary key,
    name varchar2(20) not null,
    age number(3),
    email varchar2(20) unique);
    
-- 테이블의 기본 구조 확인
desc test;

-- 데이타 추가
insert into test (idx,name,age,email) values (1,'lee',12,'aaa@naver.com');

-- 전체 컴럼 데이타 추가시 컬럼명은 생략이 가능함
insert into test values (2,'kim',23,'kim@nate.com');

-- idx 값을 넣지 않았을 경우 오류 확인
insert into test (name,age) values ('park',30);
-- 이렇게 나옴. cannot insert NULL into ("BITCAMP"."TEST"."IDX")

-- idx에 중복값을 넣었을 경우 오류 확인
insert into test (idx,name,age) values  (2,'park',30);
-- 이렇게 나옴. unique constraint (BITCAMP.SYS_C007002) violated
-- 여기서 SYS_C007002 얘를 알아보기 쉽게 이름을 바꿔줄 수 있음

-- email에 unique 위배시 오류 확인
insert into test (idx,name,email) values (3,'shin','kim@nate.com');
-- 이렇게 나옴. unique constraint (BITCAMP.SYS_C007003) violated

-- 데이타 확인
select * from test;


-- test 테이블 제거
drop table test;


-- 위의 test 테이블을 제약조건명을 주면서 다시 생성해보기
create table test (idx number(5) CONSTRAINT test_pk_idx primary key,
    name varchar2(20) CONSTRAINT test_nn_name not null,
    age number(3),
    email varchar2(20) CONSTRAINT test_uq_email unique);

-- 데이타 추가하며 오류 확인해보기
insert into test values (1,'aaa',11,'aaa@naver.com');
insert into test (idx,name) values (1,'bbb'); -- unique constraint (BITCAMP.TEST_PK_IDX) violated
insert into test (idx,name,email) values (2,'bbb','aaa@naver.com'); -- unique constraint (BITCAMP.TEST_PK_IDX) violated
insert into test (idx,age,email) values (2,12,'bbb@naver.com'); -- cannot insert NULL into ("BITCAMP"."TEST"."NAME")

-- email test_uq_email의 제약조건을 삭제하기
alter table test drop CONSTRAINT TEST_UQ_EMAIL;
-- 같은 이메일을 넣어도 이젠 오류가 안남.
insert into test (idx,name,email) values (2,'bbb','aaa@naver.com');

-- 새로운 컬럼 추가하기
alter table test add blood varchar2(10);
-- 새로운 컬럼 추가시 초기값 지정하기
alter table test add addr varchar2(50) default '서울 역삼동';

-- 컬럼 타입 수정 ex.) varchar2(50) -> varchar2(100)
alter table test MODIFY addr varchar2(100);
alter table test modify age varchar2(5); 
-- "column to be modified must be empty to change datatype" -> 데이타가 있어서 안된대

-- 컬럼 제거
alter table test drop column blood;

-- 컬럼명 변경하기 addr -> address
alter table test rename COLUMN addr to address;
alter table test rename COLUMN age to nai;

--------------------------------------------------------------------------------
-- 문제

-- score라는 컬럼 추가하기. 타입은 number(5), 초기값은 50으로
alter table test add score number(5) default 50;
-- score의 컬럼명 변경 score -> jumsoo로
alter table test rename COLUMN score to jumsoo;
-- idx의 컬럼 길이를 5에서 10으로
alter table test modify idx number(10);
--------------------------------------------------------------------------------

-- 데이타 확인
select * from test;
-- 테이블 구조 확인
desc test;

-- 테이블 제거
drop table test;
-- =============================================================================
-- =============================================================================
-- =============================================================================
-- =============================================================================

-- 시퀀스 연습
create SEQUENCE seq1;   -- 기본적으로 1부터 1씩 증가되는 시퀀스가 생성이 됨
create SEQUENCE seq2 start with 1 INCREMENT by 1;   -- 그래서 굳이 안적어도 똑같음
create SEQUENCE seq3 start with 10 increment by 5;
create sequence seq4 nocache;   -- cache 사이즈가 0
create sequence seq5 maxvalue 5 cycle nocache;  -- 5까지 증가되면 다시 1로 반복하기
--                  (maxvalue 5 cycle)랑 nocache 이렇게 2개 조건임

-- 시퀀스 제거
drop sequence seq4;
-- 제거는 어디서든지 drop

-- 시퀀스값 출력
select seq2.nextval from dual;
select seq3.nextval from dual;
select seq5.nextval from dual;

-- 전체 시퀀스 확인
select * from seq;

-- 남은 시퀀스 모두 제거하기
drop sequence seq1;
drop sequence seq2;
drop sequence seq3;
drop sequence seq5;
-- =============================================================================

-- table 만들기
create table sawon(
    num number(5) CONSTRAINT sawon_pk_num PRIMARY key,
    name varchar(20),
    buseo varchar2(20) default '교육부',   -- 초기값 교육부
    age number(5),
    pay number(10),
    ipsaday date);

create SEQUENCE seq_sawon nocache;
-- 데이타 추가
insert into sawon values (seq_sawon.nextval,'강호동','홍보부',34,6700000,'2017-12-11');
insert into sawon (num,name,age,pay,ipsaday) values (seq_sawon.nextval,'이지영',28,3450000,sysdate);
insert into sawon values (seq_sawon.nextval,'유재석','인사부',45,5600000,'2018-03-19');
insert into sawon values (seq_sawon.nextval,'이지니','교육부',25,2800000,'2021-10-12');
insert into sawon values (seq_sawon.nextval,'박제니','홍보부',41,5500000,'2019-12-30');
insert into sawon values (seq_sawon.nextval,'강백호','인사부',38,4780000,'2020-05-06');
commit; -- Developer(DML)는 자동 커밋이 안됨. commit이란 변경사항 저장, rollback이란 변경사항 취소

-- 수정사항
-- 강호동 부서를 인사부로, 나이를 34에서 35로 수정
update sawon set buseo='인사부', age=35 where num=1;
-- 박제니의 입사일을 2020-12-29일로 수정
update sawon set ipsaday='2020-12-29' where name='박제니';
-- 삭제하기
-- num이 3번인 데이타 삭제
delete from sawon where num=3;

ROLLBACK;

-- 확인
select * from sawon order by num;

-- Group by 연습
-- 부서별 인원수와 평균나이 평균연봉 구하기(순서는 부서의 오름차순)
select buseo 부서명, COUNT(*) 인원수, floor(avg(age)) 평균나이, 
    to_char(avg(pay),'L9,999,999') 평균연봉 from sawon
    group by buseo order by 부서명;

-- 서브쿼리 연습
-- 최대 급여를 받는 사람의 이름과 나이와 부서, 급여를 출력하시오
select name 이름, age 나이, buseo 부서명, pay 급여 from sawon where pay=(select max(pay) from sawon);
-- 평균 급여보다 많이 받는 사람의 이름과 나이, 부서, 급여를 출력하시오
select name 이름, age 나이, buseo 부서명, pay 급여 from sawon where pay>(select avg(pay) from sawon);


-- 조건을 나타내는 함수
-- 부서가 홍보부면 '용산', 교육부면 '강남', 인사부면 '여의도'
select name 사원명, buseo 부서명, 
decode(buseo,'홍보부','용산','교육부','강남','인사부','여의도') 사무실위치
from sawon;

-- case when
select name 사원명, buseo 부서, pay 월급여,
case when pay>=6000000 then '초고연봉'
     when pay>=5000000 then '고연봉'
     when pay>=4000000 then '평균연봉'
     else '최소시급'
end 분류
from sawon;

select name,
case when name in ('강호동','유재석','박제니') then '그룹 A'
     when name in ('이지영','강백호') then '그룹 B'
     else '그룹 C'
end 그룹
from sawon;


-- 기존 테이블을 복사해서 새로운 테이블을 생성 
create table sawon_a as select * from sawon where buseo='홍보부';
select * from sawon_a;

-- skdlrk 35세 이상인 사원만 복사해서 sawon_b 테이블로 생성
create table sawon_b as select * from sawon where age>=35;
select * from sawon_b;


-- =============================================================================

-- join 연습
-- shop 테이블 생성
create table shop(
    idx number(5) constraint shop_pk_idx Primary key,
    sangpum varchar2(20),
    color varchar2(20),
    price number(10),
    ipgoday date);
    
-- jumun 테이블 생성(shop의 idx를 외부키로 사용)
create table jumun(
    num number(5) constraint jumun_pk_num primary key,
    name varchar2(20),
    idx number(5) constraint jumun_fk_idx references shop(idx),
    cnt number(5));


-- 상품용 시퀀스 새로 생성
create sequence seq_shop nocache;

-- shop에 상품 등록
insert into shop values (seq_shop.nextval,'블라우스','white',23000,sysdate);
insert into shop values (seq_shop.nextval,'청바지','blue',47000,'2022-03-20');
insert into shop values (seq_shop.nextval,'브이넥티','pink',16000,sysdate);
insert into shop values (seq_shop.nextval,'체크남방','red',17000,'2021-12-25');
insert into shop values (seq_shop.nextval,'블라우스','yellow',19500,'2021-03-29');

commit;

select * from shop;

-- jumun 테이블에 데이타 추가하기
-- 없는 shop제품을 등록시 어떤 오류가 나오는지 확인해보기
insert into jumun values (seq_shop.nextval,'이영자',3,1); -- 오류발생 : parent key not found
insert into jumun values (seq_shop.nextval,'이영자',16,1); -- 14 ~ 18까지있음
insert into jumun values (seq_shop.nextval,'유재석',17,3);
insert into jumun values (seq_shop.nextval,'한가인',18,2);
insert into jumun values (seq_shop.nextval,'김태희',15,1);
insert into jumun values (seq_shop.nextval,'김종국',16,3);
insert into jumun values (seq_shop.nextval,'이제니',14,1);
commit;
select * from jumun;

-- join해서 출력(일치하는 행 출력)
select
    j.num,j.name,s.sangpum,s.color,s.price,j.cnt,s.ipgoday
from shop s,jumun j
where s.idx=j.idx;

-- 컬럼명 앞에 테이블명은 어느 한쪽만 존재하는 경우 생략이 가능함
-- idx는 양쪽이 다 있어서 적어야하지만 num,name,sangpum,color,price,cnt,ipgoday는 s. j. 생략가능
select
    num,name,sangpum,color,price,cnt,ipgoday
from shop s,jumun j
where s.idx=j.idx;
---------------------------------------------------------
-- 상품을 주문한 사람이 있는 상태에서 상품을 삭제해보기
delete from shop where idx=14; -- 오류발생 : child record found

-- 복잡한 쿼리문 일 경우 view를 만들어놓고 조회가 필요할 때 사용한다

-- create만 쓴 경우 : 새로 생성만 가능, 같은 이름이 있을 경우 오류가 발생함
-- create or replace를 쓴 경우 : 새로 생성을 하는데 같은 이름이 있을 경우 덮어씀

create or replace view mycart
as
select
    j.num,j.name,s.sangpum,s.color,s.price,j.cnt,s.ipgoday
from shop s,jumun j
where s.idx=j.idx;  -- 오류가 발생함 : 권한이 없다고 나옴. 
            -- 그래서 system에 가서 bitcamp에 create view에 관한 권한을 추가해야한다

-- view 조회
select * from mycart;



