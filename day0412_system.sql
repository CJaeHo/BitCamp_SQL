-- ������ ���� ����

-- �������� angel ����� a1234�� ������ �����ϱ�
create user angel identified by a1234;

-- angel ������ connect, resource ���� �ֱ�
grant connect,resource to angel;    -- grant ��ɾ ����ؼ� angel�� �����ֱ�

-- angel ������ �ΰ��� ������ �ٽ� ����
revoke connect,resource from angel;

-- angel ���� ����(���� ����Ÿ�� �ִٸ� ��� ����)
drop user angel;
-- Enter user-name: angel
-- Enter password:
-- ERROR:
-- ORA-01017: invalid username/password; logon denied
-- drop�ϰ� cmd�� �α����غ��� �̷��� �����µ� �̰Ŵ� ������ ���ų� 
-- �������̳� ����� �߸� �Է����� �� ������ ������

-- bitcamp/a1234 ������ ���� �� �⺻ ������ �ּ���

create user bitcamp identified by a1234;
grant connect,resource to bitcamp;

----------------------------------------------
--bitcamp ������ ���� �߰��ϱ�
grant create view to bitcamp;