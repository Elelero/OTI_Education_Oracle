-- employees 테이블 제거
drop table employees;

-- employees 테이블 생성
create table employees(
    eno number(4) not null,
    ename varchar2(15) not null
);

-- employees 테이블 데이터 추가
insert into employees (eno, ename) values(1, '홍길동');
insert into employees (eno, ename) values(2, '감자바');

-- 커밋(영구저장)
commit;

-- employees 테이블 조회
select * from employees;
