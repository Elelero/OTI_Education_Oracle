/* ch10.1 */
-- 기존에 만들어둔 테이블 삭제
drop table members;
drop table boards;
-- 조회
select * from members;
select * from boards;
-- members 테이블 생성
create table members (
    mid varchar2(20) primary key,
    mname varchar2(20) not null,
    memail varchar2(100) unique null,
    mage number check (mage>0 and mage<300),
    mtel varchar2(20),
    mcity varchar2(20) default '서울' not null
);
-- boards 테이블 생성
create table boards (
    bno number primary key,
    btitle varchar2(100) not null,
    bcontent clob not null,
    bwriter varchar(20) references members (mid) on delete cascade,
    bdate date default sysdate not null
);
--================================================================================================
-- <insert문> ( members 테이블 )
-- 테이블명 뒤에 열을 지정하지 않으면, 무조건 테이블 컬럼의 개수 만큼 있어야함!
insert into members values ('winter', '눈송이', 'snow@mycompany.com', 25, '010-123-1234', '부산');
insert into members values ('spring', '봄돌이', null, 25, null, default);
commit;
-- 테이블명 뒤에 열을 지정하면 , 지정한 열만 데이터 입력하면 됨
insert into members (mid, mname) values ('summer', '하여름');
--================================================================================================
-- <insert문> ( boards 테이블 )
insert into boards values (1, '제목1', '내용1', 'winter', sysdate);
insert into boards values (2, '제목2', '내용1', 'winter', '2022.12.31');
-- insert into boards values (3, '제목3', '내용3', 'fall', sysdate); --(x) members 테이블에 fall 이 있어야 함
insert into boards values (3, '제목3', '내용3', 'summer', default);
insert into boards (bno, btitle, bcontent, bwriter) values (4, '제목4', '내용4', 'summer');
--================================================================================================

-- 테이블에 날짜 데이터 추가
insert into boards values (5, '제목5', '내용5', 'winter', to_date('12.25.2022', 'mm.dd.yyyy'));


/* ch10.2 */
-- update문을 작성할 때 where문을 가급적이면 사용해야함!
update members set memail='ice@mycompany.com', mage=30, mtel='010-321-4321'
where mid='winter';
-- 연산식
update members 
set memail='ice@mycompany.com', mage= mage+1, mtel='010-321-4321'
where mid='winter';

-- 서브쿼리를 사용하여 데이터 수정
update boards set bwriter=(select mid from members where memail='ice@mycompany.com')
where bwriter='winter';



/* ch10.3 */
delete from boards
where bwriter = 'winter';
----
delete from members
where mid = 'winter';

-- 데이터 일부분 삭제
delete from members
where mid in ('summer', 'fall');
