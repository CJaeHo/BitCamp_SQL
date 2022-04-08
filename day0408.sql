-- "" 쌍따옴표는 제목의 이름 을 짓거나 이럴 때만 쓰고 왠만한건 다 ''따옴표로만
-- emp테이블의 전체 데이타 확인

--------------------------------------------- select 시작

select * from employees;    -- 아무 값이나 와도 상관없을 때 *

-- first_name과 last_name만 조회
select first_name,last_name from employees;

-- emp의 테이블구조 확인
desc employees;

-- 직업 종류별로 한번씩만 출력(중복 제거)
select DISTINCT job_id from employees;

-- 이름을 붙여서 출력하고 제목을 '이름'으로 설정하는 방법
-- 정석은 as"~~~" 하지만 as, "" 없어도 됨 단, 공백이 있으면 안됨.
select first_name||' '||last_name as"이름" from employees;
select first_name||' '||last_name "이름" from employees;
select first_name||' '||last_name 이름 from employees;
-- 제목에 공백이 없을 경우 as,""생략가능

--------------------------------------------------------------------------------
----------------------------------------- 조건문 연습

-- 조건으로 검색할 경우에 where절을 사용하기
select first_name,job_id from employees where first_name='Steven';

-- A로 시작하는 사람 검색할 때 like 사용하기.. 뒤에 % 붙여주기
select first_name,job_id from employees where first_name like 'A%';

-- A나 S로 시작하는 사람 검색하기.. 합쳐서 쓰지말고 따로 나눠서 쓰기
select first_name,job_id from employees where first_name like 'A%' or first_name like 'S%';

-- a나 s를 포함하고 있는 사람 검색하기.. 앞뒤로 % 붙여주기
select first_name,job_id from employees where first_name like '%a%' or first_name like '%s%';

-- 대,소문자 상관없이 a나 s를 포함하고 있는 사람 검색하기.. 
-- employees에 있는 사람들 이름을 먼저 소문자로 바꿔놓고 해당되는 사람 검색
-- 혹은 반대로 대문자로 바꿔놓고 해당되는 사람 검색
select first_name,job_id from employees where lower(first_name) like '%a%' or lower(first_name) like '%s%';
select first_name,job_id from employees where upper(first_name) like '%A%' or upper(first_name) like '%S%';

-- first_name이 a로 끝나는 사람 검색하기.. 앞에 % 붙여주기
select first_name from employees where lower(first_name) like '%a';

-- first_name에서 두번째 글자가 a인 사람 검색하기.. 
-- _는 1칸을 의미함 3번째 글자면 앞에 __ 2개 근데 뒤에 % 안붙이면 
-- 2글자인 이름에서 2번째가 a인 사람만 검색됨
select first_name from employees where first_name like '_a%';

-- first_name에서 세번째 글자가 a인 사람 검색하기
select first_name from employees where first_name like '__a%';

-- salary가 5000 이상인 경우만 출력하기
select first_name,salary from employees where salary>=5000;

-- salary가 5000~8000인 경우만 출력하기.. 기호쓰기, 명령어쓰기
select first_name,salary from employees where salary>=5000 and salary<=8000;
select first_name,salary from employees where salary BETWEEN 5000 and 8000;

-- salary가 3000미만이거나 10000 초과인 경우만 출력하기.. 기호쓰기, 명령어쓰기
select first_name,salary from employees where salary<3000 or salary>10000;
select first_name,salary from employees where salary NOT BETWEEN 3000 and 10000;

-- manager_id가 100,103,120인 경우 출력하기.. 기호쓰기, 명령어쓰기
select first_name,manager_id from employees where manager_id=100 or manager_id=103 or manager_id=120;
select first_name,manager_id from employees where manager_id IN(100,103,120);

-- first_name,salary,commission_pct 출력하기
select first_name,salary,commission_pct from employees;

-- first_name,salary,commission_pct 출력하는데 comm이 null인 경우만 출력하기
select first_name,salary,commission_pct from employees where commission_pct is null;

-- first_name,salary,commission_pct 출력하는데 comm이 null이 아닌 경우만 출력하기
select first_name,salary,commission_pct from employees where commission_pct is not null;

-- salary와 commission_pct를 더할 경우 = commision이 null이면 결과도 null
select salary+commission_pct from employees;

-- comm이 널이 아닌 사람 중 salary가 5000 이상인 사람 조회(first_name, salary, comm만 출력하기)
select first_name,salary,commission_pct from employees where commission_pct is not null and salary>=5000;
select first_name,salary,commission_pct from employees where commission_pct NOT LIKE '%null%' and salary>=5000;
select first_name,salary,commission_pct from employees where commission_pct NOT IN ('(null)') and salary>=5000;
-- 맨 밑놈은 안되네....음...

-- 직업이 it_prog이거나 pu_man인 사람을 조회(first_name,job_id)만 출력
select first_name,job_id from employees where job_id IN('IT_PROG','PU_MAN');
select first_name,job_id from employees where job_id='IT_PROG' or job_id='PU_MAN';
-- job_id에 있는 직업들은 각각의 데이타들이기 때문에 대,소문자 가려줘야해

--------------------------------------------------------------------------------
--------------------------------------------------NVL 함수 연습

-- NVL(컬럼명, 값): null일 경우 값 지정하기. -mysql에서는 ifnull
select salary 연봉, NVL(commission_pct,0) 커미션, salary + NVL(commission_pct,0) 총연봉 from employees;
-- salary칸 제목 : 연봉, commission칸 제목 : 커미션, 둘이 더한거 제목 : 총연봉

--------------------------------------------------------------------------------
----------------------------- 그룹함수 연습:min,max,sum,avg,count

-- emp테이블의 총 갯수 구하기
select count(*) count from employees;

-- salary의 총합과 평균 구하기
select sum(salary),avg(salary) from employees;  -- 소숫점이하가 너무 많아
select sum(salary),round(avg(salary),0) from employees;   -- round = 반올림
select sum(salary),floor(avg(salary)) from employees;   -- floor = 내림
select sum(salary),ceil(avg(salary)) from employees;   -- ceil = 올림

-- salary의 최고연봉과 최저연봉 검색하기
select min(salary) 최저연봉,max(salary) 최고연봉 from employees;

-- salary의 최저연봉을 받는 사람의 이름과 연봉을 출력하시오(서브쿼리)
select first_name 이름,salary 연봉 from employees where salary=(select min(salary) from employees);

-- 평균 연봉보다 많이 받는 사람의 이름(first+last) 과 연봉을 출력하시오(서브쿼리)
select first_name||' '||last_name 이름,salary 연봉 from employees where salary>=(select avg(salary) from employees);

-- first_name이 Bruce와 같은 직업을 가진사람을 출력(first_name,job_id)하시오
select first_name 이름,job_id 직업 from employees where job_id=(select job_id from employees where first_name='Bruce'); 

-- 직업별 인원수와 평균 연봉 구하기
select job_id 직업, count(*) 인원수, round(avg(salary),0) 평균연봉 from employees group by job_id;
-- * 이거는 어떤 값이와도 상관 없을 때 사용함

-- 위와 같은데 평균연봉이 높은 순서대로 출력하기 
select job_id 직업, count(*) 인원수, round(avg(salary),0) 평균연봉 from employees group by job_id order by 3 desc;
-- ( order by 3 = 3번째 칸을 기준으로 하겠다, desc = 내림차순으로 정렬 )

-- 위와 같은데 인원수가 많은 그룹부터 출력하기 ( order는 맨끝에 )
select job_id 직업, count(*) 인원수, round(avg(salary),0) 평균연봉 from employees group by job_id order by 2 desc;

-- 위와 같은데 인원수 5인 이상인 곳만 출력하기
select job_id 직업, count(*) 인원수, round(avg(salary),0) 평균연봉 from employees group by job_id having count(job_id)>=5;

--------------------------------------------------------------------------------
------------------------------------- join 연습

-- join을 이용해서 first_name과 department_id를 이용해서 부서명을 조회하기
select e.first_name,d.department_name
from employees e, departments d
where e.department_id=d.department_id;

-- 위의 sql문에서 서로 중복되지 않은 컬럼명은 앞에 테이블명 생략 가능
select first_name,department_name
from employees e, departments d
where e.department_id=d.department_id;

--------------------------------------------------------------------------------
-------------------------------------- 날짜에 관한 함수들 연습(dual로 연습)

select sysdate 오늘 from dual; -- 오늘
select sysdate+1 내일 from dual; -- 오늘기준 다음날
select sysdate+7 일주일뒤 from dual; -- 오늘기준 일주일뒤

-- 현재 날짜에서 년도 4자리만 추출하기
select to_char(sysdate, 'YYYY') from dual;  -- 2022
select to_char(sysdate, 'yyyy') from dual;  -- 2022
select to_char(sysdate, 'YY') from dual;  -- 22
select to_char(sysdate, 'yy') from dual;  -- 22
select to_char(sysdate, 'YEAR') from dual;  -- 문자열로
select to_char(sysdate, 'year') from dual;  -- 문자열로
-- 전부 다 대소문자 상관없음.

-- 현재 날짜에서 월 2자리만 추출하기
select to_char(sysdate,'MM') from dual; -- 04
select to_char(sysdate,'mm') from dual; -- 04

-- 현재 날짜를 날짜와 시간으로 표시
select to_char(sysdate,'yyyy-mm-dd HH24:MI') from dual; -- 2022-04-28 15:41
select to_char(sysdate,'yyyy-mm-dd pm HH:MI') from dual; -- 2022-04-28 오후 15:41
-- am이든 pm이든 적어만 두면 그 시간에 따라서 오전, 오후가 출력됨

-- emp 테이블에서 first_name과 hire_date를 출력하는데 hire_date는 yyyy-mm-dd 형식으로 출력하기
select first_name name,to_char(hire_date, 'yyyy-mm-dd') hire_date from employees;

-- hire_date에서 년도를 추출해서 2006년에 입사한 사람을 조회하기(first_name,hire_date 출력)
select first_name name,to_char(hire_date, 'yyyy-mm-dd') hire_date from employees 
where to_char(hire_date, 'yyyy')='2006';
-- hire_date=to_char(~~~) 이렇게 해야하는 줄...

-- hire_date에서 년도를 추출해서 5월에 입사한 사람을 조회하기(first_name,hire_date 출력)
select first_name name,to_char(hire_date, 'yyyy-mm-dd') hire_date from employees 
where to_char(hire_date, 'mm')='05';

-- 마지막 컬럼에 몇년차인지 출력하기
select first_name name,to_char(hire_date, 'yyyy-mm-dd') hire_date, 
to_char(sysdate,'yyyy')-to_char(hire_date,'yyyy') 입사년차 from employees;

--------------------------------------------------------------------------------
-------------------------------------- 숫자함수 연습

-- 오라클의 숫자함수 연습
select abs(-5), abs(5) from dual;   -- 양수 값
select round(23.45,1) from dual;    -- 23.5 반올림
select round(23.43,1) from dual;    -- 23.4 반올림
select round(4567893,-1) from dual;    -- 1원자리에서 반올림 456789
select round(4567893,-2) from dual;    -- 10원자리에서 반올림 4567900
select round(4567893,-3) from dual;    -- 100원자리에서 반올림 4568000
select trunc(4567893,-3) from dual;    -- 100원자리에서 내림 4567000

select mod(10,3) from dual; -- 10을 3으로 나눈 나머지
select power(2,3) from dual; -- 2^3

--------------------------------------------------------------------------------
---------------------------------------------- 문자 함수 연습

select concat('hello',' kitty') from dual;  -- 문자열 더해서 출력됨
select 'hello'||' kitty' from dual; -- 위와 같음. 오라클에서만 가능

select initcap('haPPy dAy') from dual;  -- 맨앞글자만 대문자로 바꿔서 출력됨
select lower('haPPy dAy') from dual;    -- 소문자로 바꿔서 출력됨
select upper('haPPy dAy') from dual;    -- 대문자로 바꿔서 출력됨

select LPAD('3500',10,'*') from dual;   -- 10칸 확보 후 왼쪽에 * 출력됨
select RPAD('3500',10,'*') from dual;   -- 10칸 확보 후 오른쪽에 * 출력됨

select substr('happy day',3,3) from dual;   -- 3번째 자리부터 3개 출력됨
select substr('happy day',-3,3) from dual;   -- 뒤에서 3번째 자리부터 3개 출력됨

select length('happy day') from dual;   -- 문자 길이(공백 포함)

select replace('Have a Nice Day','a','*') from dual;    -- 문자열 중 a글자를 *로 변경해서 출력
select replace('Have a Nice Day','Nice','Good') from dual;   


--------------------------------------------------------------------------------
-- to_char, NVL, round, lower, upper 많이 씀