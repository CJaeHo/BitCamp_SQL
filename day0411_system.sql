-- 연습용 계정 생성

-- 계정명이 angel 비번이 a1234인 계정을 생성하기
create user angel identified by a1234;

-- angel 계정에 connect, resource 권한 주기
grant connect,resource to angel;    -- grant 명령어를 사용해서 angel에 권한주기

-- angel 계정의 두가지 권한을 다시 뺏기
revoke connect,resource from angel;

-- angel 계정 제거(만약 데이타가 있다면 모두 삭제)
drop user angel;
-- Enter user-name: angel
-- Enter password:
-- ERROR:
-- ORA-01017: invalid username/password; logon denied
-- drop하고 cmd로 로그인해보면 이렇게 나오는데 이거는 계정이 없거나 
-- 계정명이나 비번을 잘못 입력했을 때 나오는 문구임

-- bitcamp/a1234 계정을 생성 후 기본 권한을 주세요

create user bitcamp identified by a1234;
grant connect,resource to bitcamp;

----------------------------------------------
--bitcamp 계정에 권한 추가하기
grant create view to bitcamp;