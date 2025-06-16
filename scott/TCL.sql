===TRANSACTION===
-더 이상 분할 할 수 없는 최소 수행 단위
-한 개 이상의 DML로 이루어짐
-ALL OR NOTHING
-DB계정에 접속하는 동시에 시작되고 TCL을 실행할 때 끝난다.
-TCL: 데이터 조작을 DB에 영구히 반영하거나 작업 전체를 취소한다.

CREATE TABLE DEPT_TCL AS SELECT * FROM DEPT
SELECT * FROM DEPT_TCL

INSERT INTO DEPT_TCL VALUES(50, 'DATABASE', 'SEOUL')
UPDATE DEPT_TCL SET LOC = 'BUSAN' WHERE DEPTNO = 40
DELETE FROM DEPT_TCL WHERE DNAME = 'RESEARCH'
SELECT * FROM DEPT_TCL

//ROLLBACK: 현재 트랜잭션에 포함된 데이터 조작 관련 명령어의 수행을 모두 취소한다.
-토드: Rollback executed 문구를 제외하면 데이터 관련 내용은 따로 출력되지 않는다.
-명령어 프롬프트: sql*plus를 통해 접속한 상태에서 rollback 명령어를 실행하면 '롤백이 완료되었습니다.'라는 문구만 출력됨
//SAVEPOINT: ROLLBACK 명령어을 통해 작업을 취소할 지점을 지정할 때 
//COMMIT: 수행한 트랜잭션 명령어를 데이터베이스에 영구히 반영할 때


===SESSION===
-
