/*13.2*/
-- 인덱스 생성
create index ix_member_mname
on members(mname);

-- where 조건문에 많이 언급되는 컬럼은 인덱스를 생성하면 좋음
select * from members
where mtel like '%1234%' and mcity='서울';

-- 컬럼을 묶어서 인덱스 생성
create index ix_member_mtel_mcity
on members(mtel, mcity);


/*13.3*/
-- 뷰1 생성
create view v_emp
    as (select employee_id, email, salary from employees);

select * from v_emp;

-- 뷰2 생성
create view v_emp2
as (
    select employee_id, first_name, department_name
    from employees e, department d
    where e.department_id = d.department_d
);

-- 뷰3 생성
-- or replace : 같은 이름의 뷰 존재 -> 대체 생성
create or replace view v_emp3
as (
    select employee_id, email, salary
    from employees
    where department_id = 30
);
select * from v_emp3;
-- 뷰3 삭제
drop view v_emp3;

-- View를 통해서 DML(insert, update, delete 실행)
-- products 테이블 생성
create table products (
    pno number primary key,
    pname varchar(50) not null,
    pprice number default 0 not null,
    pdate date default sysdate not null,
    pcompany varchar(50) null
);    
-- products 테이블에서 3개의 열을 추출한 뷰 생성
create or replace view v_prod
as (select pno, pname, pprice from products);
-- insert
-- 데이터는 뷰가 아닌 테이블에 저장됨
-- 대신 not null이 아닌 컬럼은 다 있어야함
insert into v_prod values (1, 'TV', 1000);
select * from products;
----
create or replace view v_emp3
as (
    select employee_id, email, salary, department_id
    from employees
    where department_id = 30
);
update v_emp3 set department_id = 50
where employee_id = 114;


/* =============프로젝트에서 사용해야할 내용들============= */
-------------------------------------------------------
--------------------- ROWNUM --------------------------
-------------------------------------------------------
-- 테이블에서 가져온 순서부터 rownum을 지정함
select rownum, employee_id, first_name
from employees;
-- rownum 무작위
select rownum, employee_id, first_name
from employees
order by employee_id;
-- rownum 무작위
select rownum, employee_id, first_name
from employees
order by salary;
-- rownum을 가져오기 전에 미리 정렬을 시켜야함

-- 정렬화 (인라인뷰)
select rownum, first_name, salary
from (
    select first_name, salary
    from employees
    order by salary
);  
-- where 조건문을 이용해서 rownum에 범위 지정가능
select rownum, first_name, salary
from (
    select first_name, salary
    from employees
    order by salary
)    
where rownum <=5;
-- > 연산자 사용 불가능
-- 가져오지도 않은 행(테이블 데이터)에 대해서 rownum 부여 불가능
select rownum, first_name, salary
from (
    select first_name, salary
    from employees
    order by salary
)    
where rownum > 5;

-------------------------------------------------------
---------------- Paging(페이징) 처리 -------------------
-------------------------------------------------------
select rnum, employee_id, first_name
from (
    select rownum as rnum, employee_id, first_name
    from (
        select employee_id, first_name
        from employees
        order by employee_id
    )
    where rownum <30 --(pageNo + rowsPerPage)
)
where rnum >=21; -- (pageNo -1) * rowsPerPage + 1;


/* Pager 설명

[처음] 1, 2, 3, 4, 5 [다음][맨끝]
[처음][이전] 6, 7, 8, 9, 10 [다음][맨끝]
[처음][이전] 11, 12, 13, 14, 15 [다음][맨끝]
...
[처음][이전] 96, 97 [맨끝]

페이지당 행수(rowsPerPage): 10행 (고정값)
그룹 당 페이지 수(pagesPerGroup) 5 페이지 (고정값)

전체 행수(totalRows): 963행 (select count(*) from table)

전체 페이지수: Math.ceil((double)totalRows/rowsPerPage)
각 페이지의 시작 행번호: (page-1) * rowsPerPage + 1
각 페이지의 끝 행번호: page * rowsPerPage 
각 그룹의 시작 페이지 번호: (group-1) * pagesPerGroup + 1
각 그룹의 끝 페이지 번호: group * pagesPerGroup

*/


/*ch13.4 시퀀스*/
drop table boards;
create table boards (
    bno number primary key,
    btitle varchar(100) not null,
    bcontent clob not null
);
-- Sequence 생성
create sequence seq_boards_bno;

select seq_boards_bno.nextval from dual;
select seq_boards_bno.currval from dual;

insert into boards values (seq_boards_bno.nextval, '제목', '내용');
select * from boards;







