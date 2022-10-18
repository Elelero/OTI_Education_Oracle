/*==== Ch4.3 ====*/ 
-- 전체 사원의 정보 가져오기
select * from employees;

-- 전체 사원의 특정 컬럼 정보 가져오기
select employee_id, first_name, last_name, department_id
from employees;


/*==== Ch4.4 ====*/ 
-- 사원들이 소속되어 있는 부서 번호 가져오기 (중복제거)
select distinct department_id from employees;

-- 직무번호와 부서번호를 결합해서 중복을 제거(distinct)
select distinct job_id, department_id from employees;

-- 직무번호와 부서번호를 결합해서 중복을 제거(all)
select distinct job_id, department_id from employees;


/*==== Ch4.5 ====*/ 
/* 매우 중요한 파트!! */
-- 별칭을 짓기 전
select first_name, salary, salary*12
from employees;

-- 연산된 컬럼 내용에 별칭 짓기 (AS)
select first_name, salary, salary*12 as yearsal
from employees;


/*==== Ch4.6 ====*/ 
-- 봉급액 기준으로 오름차순 정렬하여 사원번호와 봉급 가져오기 (asc)
select employee_id, salary
from employees
order by salary asc;

-- 봉급액 기준으로 내림차순 정렬하여 사원번호와 봉급 가져오기 (desc)
select employee_id, salary
from employees
order by salary desc;

-- 부서별로 오름차순으로 정렬 / 같은 부서 내에서 봉급을 내림차순으로 정렬
select department_id, salary
from employees
order by department_id, salary desc;
