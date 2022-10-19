/*8.1 조인*/
select employee_id, phone_number, department_name
from employees, departments
where employees.department_id = departments.department_id; -- 연결 조건

select employee_id, phone_number, department_name
from employees e, departments d -- 테이블 이름 지정(엘리야스?)
where e.department_id = d.department_id;

-- 두 테이블 다 department_id 컬럼을 갖고 있기 때문에 에러 발생
select email, phone_number, department_id,department_name
from employees e, departments d 
where e.department_id = d.department_id;

-- 어느 테이블에서 갖고올지 테이블 이름을 지정해줌
select email, phone_number, e.department_id,department_name
from employees e, departments d 
where e.department_id = d.department_id;

select email, phone_number, e.department_id, d.department_id,department_name
from employees e, departments d 
where e.department_id = d.department_id;


/*8.2 조인 종류*/
-- 등가 조인
select email, phone_number, e.department_id, d.department_id,department_name, salary
from employees e, departments d 
where e.department_id = d.department_id
      and d.department_id = 20
      and salary > 100;
      
-- 번외(교재에 없는 실습)-----------------------------------
select employee_id, phone_number, city
from employees e, departments d, locations l
where e.department_id = d.department_id
      and d.location_id = l.location_id;
      -- 만약 부서 이름까지 조회하고 싶다면..?
select employee_id, phone_number, city, e.department_id
from employees e, departments d, locations l
where e.department_id = d.department_id
      and d.location_id = l.location_id;
----------------------------------------------------------      
-- 번외2(교재에 없는 실습)-----------------------------------
select employee_id, phone_number, region_name
from employees e, departments d, locations l, countries c, regions r
where e.department_id = d.department_id
      and d.location_id = l.location_id
      and l.country_id = c.country_id
      and c.region_id = r.region_id;
-----------------------------------------------------------
-- 번외3(교재에 없는 실습)------------------------------------
select  e1.employee_id as 사번, e1.first_name as 이름, e2.first_name as "관리자 이름" -- 뛰어쓰기는 ""
from employees e1, employees e2
where e1.employee_id = e2.manager_id;
------------------------------------------------------------

-- 비등가 조인
--(테이블 생성)------------------------------
create table grade(
    grade_id char(1) primary key,
    low_salary number(8, 2) not null,
    hi_salary number(8, 2) not null
);
insert into grade values('A', 3001, 99999);
insert into grade values('B', 2001, 3000);
insert into grade values('C', 1401, 2000);
insert into grade values('D', 1201, 1400);
insert into grade values('E', 700, 1200);
commit;
select * from grade;
--------------------------------------------
-- 비등가 조인은 연결하는 것이 아닌 조건문에 범위를 설정하여 속해있는지 여부를 따짐
select employee_id, salary, grade_id
from employees e, grade g
where e.salary between g.low_salary and g.hi_salary;

-- 자체 조인
--아까 번외3으로 했었기 때문에 패스--

-- 외부 조인
select employee_id, e.department_id, d.department_id, department_name
from employees e, departments d
where e.department_id(+) = d.department_id;
-- 사원이 없는 부서의 번호와 이름 조회
select d.department_id, department_name
from employees e, departments d
where e.department_id(+) = d.department_id
    and employee_id is null;
-- 관리자가 있는 사원 조회
select emp.employee_id, emp.manager_id, mgr.first_name
from employees emp, employees mgr
where emp.manager_id = mgr.employee_id;
-- 관리자가 없는 사원 전체 조회
select emp.employee_id, emp.manager_id, mgr.first_name
from employees emp, employees mgr
where emp.manager_id = mgr.employee_id(+);
-- 관리자가 없는 사원만 조회
select emp.employee_id, emp.manager_id, mgr.first_name
from employees emp, employees mgr
where emp.manager_id = mgr.employee_id(+) and
      emp.manager_id is null;


/*8.3 조인 응용*/
----------------------------------------
--- 등가 조인 (내부 조인 = Inner Join) ---
----------------------------------------
-- 기존 내부조인
select email, department_name
from employees e, departments d
where e.department_id = d.department_id;
-- (기사시험)내부조인
select email, department_name
from employees e 
inner join departments d on e.department_id = d.department_id;

-- Natural JOIN
-- SQL-92
select email, department_name
from employees e inner join departments d on e.department_id = d.department_id;
-- SQL-99
select email, department_name
from employees e natural join departments d;

-- JOIN ~ USING
select email, department_name
from employees e join departments d using (department_id);

-- JOIN ~ ON
select email, department_name
from employees e join departments d 
                 on e.department_id = d.department_id;
             
----------------------------------------
--- 등가 조인 (외부 조인 = Outer Join) ---
----------------------------------------                 
-- NULL도 다 나올 수 있게 해줌
select email, department_name
from employees e, departments d 
where e.department_id(+) = d.department_id;
-- SQL-99
select email, department_name
from employees e right outer join departments d 
                 on e.department_id = d.department_id;

-- 복습 겸 다시한번 Nature join과 inner join을 해보자
drop table boards;
drop table members;
--------------------------
create table members(
    mid varchar2(10) primary key,
    mname varchar2(20) not null
);
create table boards(
    bno number primary key,
    btitle varchar(100) not null,
    mid varchar2(10) references members(mid) on delete cascade,
    mname varchar2(20) not null
);
insert into members values ('spring', '김하늘');
insert into members values ('summer', '하여름');
insert into members values ('fall', '김단풍');
insert into members values ('winter', '동장군');
commit;
insert into boards values (1, '제목1', 'spring', '김하늘');
insert into boards values (2, '제목2', 'fall', '김단풍');
insert into boards values (3, '제목3', 'spring', '이바다');
commit;
-------------------------------
-- inner join
select m.mid, m.mname, b.mid, bno, btitle, b.mid, b.mname 
from members m, boards b
where m.mid = b.mid;
-- natural join
select mid, mname, bno, btitle 
from members m natural join boards b;