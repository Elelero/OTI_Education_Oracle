-- employees 테이블 삭제
drop table employees;

-- employees 테이블 생성
create table employees(
    eno number(4) not null,
    ename varchar2(15) not null
);

-- 테이블에 데이터 삽입
insert into employees (eno, ename) values(1, '홍길동');
insert into employees (eno, ename) values(2, '감자바');

-- 커밋(영구저장)
commit;

-- employees 테이블 전체 컬럼 조회
select * from employees;
