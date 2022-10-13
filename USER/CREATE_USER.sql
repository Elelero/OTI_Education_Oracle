-- 사용자 생성
create user user1 identified by oracle;
/* user1 : 아이디
   oracle : 패스워드 */


-- 권한 설정
grant create session to user1; 
/* 접속 권한 부여 */
grant create resource to user1;
/* 테이블 및 데이터 생성 권한 부여 */
grant unlimited tablespace to user1;
/* 테이블 스페이스 권한 부여 */


-- <정리> 계정 생성을 하기 위한 최소 코드
create user user1 identified by oracle;
grant create session to user1; 
grant create resource to user1;
grant unlimited tablespace to user1;
