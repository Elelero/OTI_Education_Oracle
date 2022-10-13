create table emp_ddl (
  empno number(4) not null,
  ename varchar2(10) not null,
  job varchar2(9) null,
  mgr number(4) null,
  hiredate date not null,
  sal number(7, 2) not null,
  comm number(7, 2) not null,
  deptno number(2) null
);
