/*###########################
제약조건: Not Null
###########################*/

--테이블 제거
drop table members;


-- 테이블 생성
create table members (
    mid     varchar(20) not null,
    mname   varchar(20) not null,
    mtel    varchar(20) null
);


-- 데이터 추가
-- 순서 바꿔서 저장해도됨!
insert into members (mid, mname, mtel) values ('winter', '한겨울', '010-123-1234');
--컬럼 리스트가 생략되면, DB에 추가된 컬럼 순서대로 모든 컬럼의 값을 제공
insert into members values ('winter', '한겨울', '010-123-1234');

-- 명시적으로 null로 저장
insert into members (mid, mname, mtel) values ('winter', '한겨울', null);
insert into members values ('winter', '한겨울', null);
-- 컬럼 리스트에 없는 컬럼은 null로 저장
insert into members (mid, mname) values ('winter', '한겨울');


-- Not null은 null로 수정할 수 없음
update members set mid=null where mid='winter';


drop table members;

-- 제약 조건 이름 직접 지정
create table members (
    mid     varchar(20) constraint members_mid_nn not null,
    mname   varchar(20) not null,
    mtel    varchar(20) null
);
