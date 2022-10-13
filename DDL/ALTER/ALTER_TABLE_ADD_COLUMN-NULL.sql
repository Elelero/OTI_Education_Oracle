-- 기존의 데이터가 있는 테이블에서 컬럼을 새로 추가할 때에는
-- null을 허용하도록 해야함
-- 데이터를 채우고 난 후에, not null로 권한 설정 해주면 됨!
create table emp_ddl(
    empno number(4) not null,
    ename varchar2(10) not null
);

--테이블에 데이터 추가
insert into emp_ddl (empno, ename) values(1, 'winter');
insert into emp_ddl (empno, ename) values(2, 'summer');

--컬럼 추가 (무조건 처음에는 null로 지정해줘야함!)
alter table emp_ddl
    add(
        city varchar(10) null,
        age number(3) null
    );
