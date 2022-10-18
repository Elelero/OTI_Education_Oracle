/*ch6.2*/
-- UPPER / LOWER 함수
select last_name, upper(last_name), lower(last_name)
from employees;
-- 조건식(where)에서 쓰인 함수
select first_name
from employees
where lower(first_name) like '%s%';
--첫문자는 대문자, 나머지는 소문자 (INICAT 함수)
select initcap(email) from employees;

-- LENGTH 함수
-- 테이블 생성 및 데이터 삽입
create table members (
    mid varchar(50) not null,
    mname varchar(50) not null
);
insert into members values ('fall', '한가을');
commit;
-- length 함수와 lengthb함수 
select mname, length(mname), lengthb(mname) from members;

-- SUBSTR 함수
select first_name, substr(first_name, 5) as col1, substr(first_name, 3, 2) as col2
from employees;
-- '-' 부호 사용하기
select first_name, substr(first_name, -3, 2)
from employees;

-- REPLACE 함수
select phone_number, replace(phone_number, '.', '-')
from employees;

-- LPAD 함수 / RPAD 함수
select first_name, RPAD(LPAD(first_name, 3), 6, '*'), RPAD(substr(first_name, 1, 3), 6, '*')
from employees;

-- CONCAT 함수
select concat(first_name, concat(', ', last_name)) as name
from employees;
-- concat 함수와 유사한 효과를 내주는 '||' 연산자
select (first_name || ', ' || last_name) as name
from employees;


/*ch6.3*/
-- round 함수
select salary, round(salary/31),round(salary/31, 2)
from employees;

-- ceil 함수 / floor 함수(몫) / mod 함수(나머지) / trunc 함수
select salary, 
       trunc(salary/31), -- 버림
       trunc(salary/31, 2),
       ceil(salary/31),  -- 올림
       floor(salary/31), -- 몫
       mod(salary, 31)   -- 나머지
from employees;


/*ch6.4*/
-- 테이블 생성
create table boards (
    bno number primary key,
    btitle varchar(50) not null,
    bdate date not null
);
-- sysdate 함수를 이용해 데이터 삽입
insert into boards values(1, '제목', sysdate);
-- boards 테이블 조회
select * from boards;
-- dual 가상테이블 이용한 현재날짜 조회
select sysdate, sysdate+14 from dual;

-- 날짜 연산 (일수 기준)
/*select '2022-12-31' - sysdate from dual*/ -- (x)
select to_date('2022-12-31', 'YYYY-MM-dd') - sysdate from dual; --(o)

-- 날짜 함수 (ADD_MONTHS) 
select sysdate, add_months(sysdate, 1) from dual; -- 한달 뒤 날짜 출력

-- 날짜 함수 (months_between) (월수 기준)
select months_between(to_date('2022-12-31', 'YYYY-MM-dd'), sysdate) from dual;

-- 날짜 함수 (NEXT_DAY)
select sysdate, next_day(sysdate, '금') from dual;
select sysdate, next_day(sysdate, '금요일') from dual;
/*select sysdate, next_day(sysdate, 'Friday') from dual;*/ -- 환경변수가서 언어 변경해주면 됨!

-- 날짜 함수 (LAST_DAY)
select sysdate, last_day(sysdate) from dual;


/*ch6.5*/
select hire_date from employees;
-- to_char 함수 (날짜)
select to_char(sysdate, 'YYYY.MM.dd hh24:mi:ss') from dual;
-- 시간형식 변경
select to_char(sysdate, 'YYYY.MM.dd hh24:mi:ss am') from dual;

-- to_char 함수 (숫자)
select to_char(salary, '99,999.00') from employees;
select to_char(salary, 'L99,999.00') from employees; -- L : 달러 표시

-- to_date 함수 ( 문자 -> 날짜)
-- 이미 만들어둔 boards 테이블에 데이터 삽입
select * from boards;
insert into boards values(3, '제목', '2022.10.17'); --(o) 굳이 to_date 함수 이용안해도 됨!
select * from boards where bdate='2022.10.17'; --(ㅇ)
select * from boards where bdate>='2022.10.16'; --(ㅇ)
-- 번외
select '2022.12.31' - sysdate from daul; --(x)
select to_date('2022.12.31', 'yyyy.mm.dd') - sysdate from dual; --(o)


/*ch6.6*/
-- null 값 출력
select 10 + null from dual;
select salary*12 + commission_pct*salary from employees;
-- 연산을 해도 null이 출력되지 않도록, nvl 적용!
select 10 + nvl(null, 0) from dual;
select salary*12 + nvl(commission_pct, 0)*salary from employees;
-- nvl2로 변환
select salary*12 + nvl2(commission_pct, commission_pct*salary, 0) from employees;
