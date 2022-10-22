--=============================================--
--------------- 제약조건: Not Null --------------- 
--=============================================--

-- Null의 저장을 허용하지 않는 제약 조건


/* members 테이블 생성 */
create table members (
    mid    varchar(20) not null,
    mname  varchar(20) not null,
    mtel   varchar(20) null
);


/* 데이터 추가 */
insert into members (mid, mname, mtel) values ('winter', '한겨울', '010-1234-1234');
-- 컬럼 리스트가 생략되면, 생성된 컬럼 순서대로 기입한 값을 저장
insert into members values ('winter', '한겨울', '010-1234-1234') 
-- 명시적으로 null로 저장
insert into members (mid, mname, metel) values ('winter', '한겨울', null);
insert into members values ('winter', '한겨울', null);
-- 컬럼 리스트에 없는 컬럼은 Null로 저장
insert into members (mid, mname) values ('winter', '한겨울');


/* Not Null은 Null로 수정할 수 없음 */
update members set mid=null where mid='winter';


/* 제약 조건 이름 직접 지정 */
create table members (
    mid    varchar(20) constraint members_mid_nn not null,
    mname  varchar(20) not null,
    mtel   varchar(20) null
);
