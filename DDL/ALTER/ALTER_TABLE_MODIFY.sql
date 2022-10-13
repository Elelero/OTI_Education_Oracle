-- 컬럼의 데이터 타입 변경
alter table employees
    modify(
        ename varchar2(15),
        ecity varchar2(20)
    );
