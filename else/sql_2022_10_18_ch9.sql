/*ch9.1*/
-- 서브 쿼리
select salary from employees where first_name = 'John';
select salary from employees where employee_id = 110;
-- 서브 쿼리는 항상 괄호로 묶여있어야함
select employee_id, salary
from employees
where salary > (select salary from employees where employee_id = 110);

select employee_id, salary
from employees
where salary > (
    select salary
    from employees
    where first_name = 'John'
--    order by salary --(x)
);
-- in 연산자의 경우 여러개 와도 상관없음
select employee_id, salary, department_id
from employees
where department_id in (
    select department_id
    from departments
    where department_id < 30
);


/* ch9.2 */
-- 단일행 서브쿼리 (날짜형 데이터)
-- 110번보다 입사날짜가 빠른 사원을 조회
select *
from employees
where hire_date < (
        select hire_date
        from employees
        where employee_id = 110
);                
-- 전체 평균 봉급보다 많은 봉급을 가져가는 사원
select *
from employees
where salary > avg(salary); --(x) 집계함수는 다중행을 사용하기 때문에 group by를 이용 -> 비교연산!
-- 서브쿼리를 이용해서 조회
select *
from employees
where salary > (
    select avg(salary)
    from employees
);


/*9.3 다중행 서브쿼리*/
select salary from employees;
select max(salary) from employees;
----
select employee_id, first_name
from employees
where salary = (select max(salary) from employees);
----
select employee_id, first_name
from employees
where department_id in (
    select department_id from departments where location_id=1700
);

-- in 연산자
select employee_id, first_name, job_id, department_id
from employees
where salary in ( select max(salary)
from employees
group by department_id);

-- ANY 연산자
select employee_id, department_id
from employees
where department_id = any (10, 11);
-----
select employee_id, salary, department_id
from employees
where department_id = 100 and
      salary >= any (8000, 9000, 10000);
-- 번외 --
-- 여러 부서의 평균값을 받아서 그 평균값 중에 하나라도 이상인 값 출력 (부서는 100번 부서)
select employee_id, salary, department_id
from employees
where department_id = 100 and
      salary >= any(
            select avg(salary)
            from employees
            group by department_id
);   

-- ALL 연산자
select employee_id, salary, department_id
from employees
where department_id = 100 and
      salary >= all (8000, 9000, 10000);
-- 번외 --
-- 여러 부서의 평균값을 받아서 그 평균값 이상인 값 전체 출력 (부서는 100번 부서)
select employee_id, salary, department_id
from employees
where department_id = 100 and
      salary >= all (
            select avg(salary)
            from employees
            group by department_id
);   

-- EXISTS 연산자
select employee_id, department_id
from employees
where exists ( select 10 from dual);
----
select employee_id, department_id
from employees
where exists ( 
    select department_name
    from departments
    where department_id = 1000
); 
-- 번외 --
select employee_id, department_id
from employees e
where exists ( 
    select department_name
    from departments
    where department_id = (e.department_id + 200)
); 


/* 과제 */
-- 게시물을 전혀 작성하지 않은 멤버의 아이디와 이름을 가져오세요
-- JOIN 방식과 SUBQUERY 방식으로 해보세요.
select * from members;
select * from boards;

-- 방법1 : JOIN 방식 ( 힌트: 외부 조인 사용)
select m.mid, m.mname
from members m left join boards b on m.mname = b.mname
where b.mid is null; 
-- 교수님 풀이
select m.mid, m.mname
from members m, boards b
where m.mid = b.mid(+) and
    b.bno is null;

-- 방법 2 : SubQuery 방식 (내가 못품)
select mid, mname
from members
where not exists ( select mname from boards); --(x)
-- 교수님 풀이
select mid, mname
from members m
where not exists(
    select bno
    from boards b
    where b.mid = m.mid
);    

/* 과제2 */
-- 근무도시가 시애틀인 사원의 이메일과 전화번호를 가져오시오
-- 방법1 : Join 이용
-- 방법2 : SubQuery 이용