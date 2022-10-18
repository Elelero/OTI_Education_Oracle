/*===ch5.1===*/
-- order by는 where 뒤에 위치해야 함
select email, job_id, salary, hire_date
from employees
where department_id = 30
order by hire_date;


/*===ch5.2===*/
-- 조건식은 and 또는 or로 연결할 수 있음
-- <and>
select email, job_id, salary, hire_date
from employees
where department_id = 30 and salary>3000
order by hire_date;
-- <or>
select email, job_id, salary, department_id, hire_date
from employees
where department_id = 30 or salary>3000
order by department_id, hire_date;


/*===ch5.3===*/
select email, salary*12 as yearsal
from employees
where salary*12 >= 200000;

-- 문자도 비교연산자가 가능함
select first_name
from employees
where first_name >= 'A' and first_name <'C';

-- 등가 비교 연산자
select job_id
from employees
where job_id != 'IT_PROG' and job_id <> 'FI_ACCOUNT';

-- 논리 부정 연산자
select job_id
from employees
where not (job_id != 'IT_PROG' and job_id <> 'FI_ACCOUNT');

-- in 연산자
select email, job_id
from employees
where job_id in('IT_PROG', 'FI_ACCOUNT');
-- 참고 ( 제약조건에서의 in)
create table t1 (
    grade char(1) check (grade in ('A', 'B', 'C'))
);
-- in연산자에 논리부정 연산자 붙여보기 
select email, job_id
from employees
where not job_id in('IT_PROG', 'FI_ACCOUNT');
--------(두 코드 같은 코드임 / not의 위치만 다름)
select email, job_id
from employees
where job_id not in('IT_PROG', 'FI_ACCOUNT');

-- between 연산자
select email, salary
from employees
where salary >= 5000 and salary >= 7000;
--------(두 코드 같은 코드임)
select email, salary
from employees
where salary between 5000 and 7000;

-- LIKE 연산자 & 와일드카드
select first_name
from employees
where first_name like '%St%';
-- 추후 게시판에서 정보 불러오기 할 때 많이 사용하는 코드
select first_name, email
from employees
where first_name like '%ev%' or email like '%ev%';
-- 언더바 & 퍼센티지 혼용해서 사용
select email
from employees
where email like '_L%';

-- IS NULL 연산자
select employee_id, first_name
from employees
--where department_id = null; --(x)
where department_id is null;
-- IS NOT NULL (<-> IS NULL) 연산자
select employee_id, first_name
from employees
where department_id is not null;
/* 중요한 부분 */
-- null은 어떠한 연산을 하게되더라도 null이 나옴
select (salary*12)+(commission_pct*salary) as yearsal
from employees;

-- 집합 연산자
-- where + or 연산자
select email, phone_number
from employees
where department_id = 10 or department_id = 20;
-- where +  in 연사자
select email, phone_number
from employees
where department_id in (10, 20);
-- union 연산자
select email, phone_number, department_id
from employees
where department_id = 10
union
select email, phone_number, department_id
from employees
where department_id = 20;







