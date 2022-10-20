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
-- in 연산자
select employee_id, salary, department_id
from employees
where department_id in (
    (select department_id
    from departments
    where department_id < 30)
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
select email, phone_number
from employees e, departments d, locations l
where city = 'Seattle' and
    e.department_id = d.department_id and
    d.location_id = l.location_id;

-- 방법2 : SubQuery 이용
select email, phone_number
from employees
where department_id in (
    select department_id
    from departments
    where location_id = (
        select location_id
        from locations
        where city = 'Seattle'
    )
);    


/* ch9.4 비교할 열이 여러 개인 다중열 서브쿼리 */
select employee_id, salary, department_id
from employees
where (department_id, salary) in (
    select department_id, max(salary)
    from employees
    group by department_id
);    


/* ch9.5 FROM절에 사용하는 서브쿼리와 WITH절 */
select email, department_name, city
from (
        select email, department_id
        from employees
        where department_id in (10, 20)
    ) e, 
    (
        select department_id, department_name, location_id
        from departments
    ) d,
    (
        select location_id, city
        from locations
    ) l    
where e.department_id = d.department_id and
      d.location_id = l.location_id;  

-- with절 사용
with
e as (select email, department_id from employees where department_id in (10, 20)),
d as (select department_id, department_name, location_id from departments),
l as (select location_id, city from locations)
select email, department_name, city
from e, d, l
where e.department_id = d.department_id and
      d.location_id = l.location_id;

-- 상호 연관 서브쿼리
select employee_id, department_id, salary
from employees e1
where salary > (
        select min(salary) from employees e2
        where e2.department_id = e1.department_id
)        
order by department_id, salary;


/* ch9.6 SELECT절에 사용하는 서브쿼리 */
select employee_id, first_name, job_id,
       salary, grade_id, department_id
from employees e, grade g
where salary between low_salary and hi_salary
      and department_id = 30;
----
select employee_id, first_name, job_id, salary, department_id, grade_id
from 
     (
        select employee_id, first_name, job_id, salary, department_id
        from employees
        where department_id = 30
    ) e,
    grade g
where salary between low_salary and hi_salary;
---- 스칼라 서브쿼리
select employee_id, first_name, job_id, salary, department_id, 
       (
            select grade_id 
            from grade 
            where e.salary between low_salary and hi_salary
            ) as grade_id
from  employees e
where department_id = 30;


--=====================================================
-- 번외 --
select employee_id, first_name, job_id
from employees
where job_id = 'ST_CLERK';
-- 위의 쿼리에 department_name도 출력할 수 있도록 해보기!

-- 방법1 : Join
select employee_id, first_name, job_id, department_name
from employees e, departments d
where job_id = 'ST_CLERK' and
    e.department_id = d.department_id;

-- 방법2 : from절에서 서브쿼리
select employee_id, first_name, job_id, department_name
from ( select employee_id, first_name, job_id, department_id
       from employees
      ) e,
      ( select department_id, department_name
        from departments
      ) d
where job_id = 'ST_CLERK' and
    e.department_id = d.department_id;
-- 교수님 풀이
select employee_id, first_name, job_id, d.department_id, department_name
from
    ( select employee_id, first_name, job_id, department_id
      from employees
      where job_id = 'ST_CLERK') e,
    departments d
where e.department_id = d.department_id;    

-- 방법3 : select절에서 서브쿼리
select employee_id, first_name, job_id,
       ( select department_name
         from departments d
         where e.department_id = d.department_id
        ) as department_name       
from employees e
where job_id = 'ST_CLERK';


