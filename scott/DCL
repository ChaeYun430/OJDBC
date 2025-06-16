--===================<<<사용자 관리>>>======================
--사용자: 오라클 DB에서 데이터 베이스에 접속하여 데이터를 관리하는 계정
--1. 업무별 사용자 생성 후 각 사용자가 데이터 구조 만들어 관리
--2. 대표 사용자가 데이터 구조를 정의하고 권한은 각 사용자에게 지정
--사용자: 데이터를 사용 및 관리하기 위해 오라클DB에 접속하는 개체
--스키마: 오라클DB에 접속한 사용자와 연결된 객체
--데이터 간의 관계, 데이터 구조, 제약 조건 등 데이터를 저장 및 관리하기 위해 정의한 
--	DB 구조의 범위를 스키마를 통해 그룹 단위로 분류한다.

--=====================사용자 생성======================
--CREATE USER 사용자 이름 (필수)
--IDENTIFIED BY 패스워드 (필수)
--DEFAULT TABLESPACE 테이블 스페이스 이름(선택)
--TEMPORARY TABLESPACE 테이블 스페이스(그룹) 이름(선택)
--QUOTA 테이블 스페이스크기 ON 테이블 스페이스 이름(선택)
--PROFILE 프로파일 이름(선택)
--PASSWORD EXPIRE(선택)
--ACCOUNT [LOCK/UNLOCK] (선택)

--===================TABLESPACE======================
--하나 또는 여러개의 데이터 파일로 구성되어 있는 논리적인 데이터 저장구조 
--사용자에게 공간을 할당할 수 있으며, 안에 저장되어있을 데이터의 가용성 제어 가능
--▶ 시스템 테이블 스페이스
--오라클 DB를 생성할 때 자동으로 생기며 오라클DB의 기동을 위해 꼭 필요한 테이블스페이스
  입니다.
--모든 데이터 사전(Data Dictionary) 정보와, 저장 프로시저, 패키지, 데이터베이스 트리거등을 저장
--유저데이터가 포함될 수 있지만 관리 효율성 면에서 포함 시키면 안 된다.
 --▶ 비 시스템 테이블 스페이스
--롤백세그먼트, 임시세그먼트, 응용프로그램 데이터, 응용프로그램 인덱스를 저장 가능
--공간관리를 쉽게 하기 위해서 생성
--유저에게 할당되는 공간 

--데이터가 저장되는 물리경로 및 테이블스페이스 정보 
--SELECT * FROM dba_data_files

--설정된 테이블 스페이스 확인 
--SELECT * FROM DBA_TABLESPACE

--현재 유저의 default_tablespace 확인 
--SELECT * FROM USER_USERS; 
 
--유저의 default tablespace 변경 
--ALTER USER [유저명] DEFAULT TABLESPACE [테이블 스페이스명] 

--테이블의 tablespace 변경 ALTER TABLE [테이블명] move tablespace [테이블 스페이스명] ; -- 테이블 스페이스 수정이나 삭제 시 설정  ALTER tablespace [테이블 스페이스명] ONLINE; ALTER tablespace [테이블 스페이스명] OFFLINE; -- 테이블 스페이스 물리적인 파일의 이름 또는 위치변경  ALTER TABLESPACE RENAME A TO B  
 
 
-- 테이블스페이스 공간관리 ALTER DATABASE DATAFILE 'C:\경로\DB.dbf' resize 10M; -- 공간이 가득찬 경우 증설 ALTER TABLESPACE [테이블 스페이스명] ADD DATAFILE 'C:\경로\DB.dbf' SIZE 10M; -- 10M 씩 자동증가 ALTER TABLESPACE [테이블 스페이스명] ADD DATAFILE 'C:\경로\DB.dbf' SIZE 10M  autoextend ON NEXT 10M maxsize 10M; 
 
 
-- 테이블스페이스 내 객체(테이블, 인덱스 등)를 모두 삭제 DROP TABLESPACE [테이블 스페이스명] include contents; -- 테이블스페이스의 모든 세그먼트를 삭제 (데이터가 테이블스페이스는 삭제할 수 없다) DROP TABLESPACE [테이블 스페이스명] INCLUDING contents; -- 삭제된 테이블스페이스 내의 테이블의 기본키와 PK를 참조하는 다른 테이블스페이스의 테이블로부터 참조무결성 제약 조건을 삭제한다. DROP TABLESPACE [테이블 스페이스명] CASCADE constranints; -- 테이블 스페이스의 물리파일까지 삭제 DROP TABLESPACE [테이블 스페이스명] INCLUDING CONTENTS AND DATAFILES;  
 
-- 테이블스페이스 생성  CREATE TABLESPACE  DATAFILE 'C:\경로\DB.dbf' SIZE 10M  autoextend ON NEXT 10M maxsize 100M extent management LOCAL uniform SIZE 1m ;



--SCOTT 계정은 사용자 생성 권한이 없다. 
--CREATE USER ORCLSTUDY IDENTIFIED BY ORACLE;
 
