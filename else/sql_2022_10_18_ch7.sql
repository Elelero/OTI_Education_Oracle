/*ch7.1*/
select salary from employees;
-- count 함수
select count(employee_id) from employees;
select count(department_id) from employees;
-- 참고. null 값까지 카운팅하기 위해서는 아스타(*)를 사용해야함
select count(*) from employees;


/*ch7.2*/
-- GROUP BY절 (기본 형식)
select department_id, job_id, sum(salary)
from employees
where department_id in (10, 20, 30)
group by department_id, job_id
order by department_id;

/*ch7.2*/
-- GROUP BY ~ HAVING
select department_id, avg(salary)
from employees
where department_id in (10, 20, 30)
group by department_id, job_id
having avg(salary) > 10000
order by department_id;
-- 다른 having 절
select department_id, avg(salary)
from employees
where department_id in (10, 20, 30)
group by department_id, job_id
having department_id = 10
order by department_id;

