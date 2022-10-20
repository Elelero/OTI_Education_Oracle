/* ch11.2 */
drop table accounts;

create table accounts (
    ano varchar2(15) primary key,
    owner varchar2(10) not null,
    balance number not null
);

-- 트랜잭션 시작
insert into accounts values('111-111', '홍길동', 10000);
insert into accounts values('111-112', '감자바', 0);
commit;
-- 트랜잭션 종료

-- 트랜잭션 시작
update accounts set balance=balance-1000 where ano='111-111';
update accounts set balance=balance+1000 where ano='111-112';
rollback;
-- 트랜잭션 종료

-- <트랜잭션 예시>
-- 트랜잭션 시작
insert into accounts values('111-113', '홍길서', 10000);
insert into accounts values('111-114', '홍길남', 0);
-- ...
savepoint inseredPoint;
update accounts set balance=balance-1000 where ano='111-111';
update accounts set balance=balance+1000 where ano='111-112';
-- ...
savepoint updatedPoint;
delete from accounts where ano='111-114';
-- ...
rollback to updatedPoint;
-- 트랜잭션 종료
select * from accounts;


/* ch11.3 */
update boards
set btitle = '수정제목3'
where bno=3;
commit;





























