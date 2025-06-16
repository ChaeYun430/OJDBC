데이터 보관 및 관리를 위한 여러 기능과 저장 공간을 객체를 통해 제공한다.

// DATA DICTIONARY 
-데이터베이스 테이블 = 사용자 테이블 + 데이터 사전
-사용자 테이블(user table, normal table)
DB를 통해 관리할 데이터를 저장하는 테이블
-데이터 사전(data dictionary, base table)
DB를 구성하고 운영하는 데 필요한 모든 정보를 저장하는 특수한 테이블
DB생성 지점에 자동으로 생성
DB의 메모리, 성능, 사용자, 권한, 객체 등의 데이터 보관
데이터 사전 뷰를 제공해 정보 열람 가능 
뷰(view): 어떤 목적을 위해 테이블 일부 또는 전체 데이터 열람을 주목적으로 사용하는 객체
접두어 뒤에 복수형 단어로 이름 구성

- USER_ 
현재 DB에 접속한 사용자가 소유한 객체 정보

- ALL_
현재 DB에 접속한 사용자가 소유한 객체 또는 다른 사용자가 소유한 객체 중 사용 허가를 받은 객체 (사용 가능한 모든 객체)
USER_[테이블]에 OWNER 열 추가

내장된 열
OWNER VARCHAR2(30) NOT NULL
TABLE_NAME VARCHAR2(20) NOT NULL
TABLESPACE_NAME VARHAR2(20) 
NUM_ROW NUMBER

- DBA_ 
DB 관리를 위한 정보(SYSTEM, SYS 사용자만 열람 가능)
사용 권한이 없는 사용자는 해당 개체의 존재 여부조차 확인할 수 없음

- V$_ 
DB 성능 관련 정보(X$_ 테이블의 뷰) 

SELECT * FROM DICT;
SELECT * FROM DICTIONARY;

-SCOTT 계정이 소유하고 있는 객체 정보
SELECT TABLE_NAME FROM USER_TABLES;
SELECT * FROM USER_TABLES;
-SCOTT 계정이 사용할 수 있는 객체 정보
SELECT OWNER, TABLE_NAME FROM ALL_TABLES;
-SCOTT 계정으로 DBA_접두어 사용하기
SELECT * FROM DBA_TABLES
-SYSTEM 계정으로 DBA_접두어 사용하기
SELECT * FROM DBA_TABLES
-DBA_USERS를 사용하여 사용자 정보 알아보기
SELECT * FROM DBA_USERS WHERE USERNAME = 'SCOTT'


// INDEX

// VIEW

// SEQUENCE

// SYNONYM
