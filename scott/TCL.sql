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
-DB 접속을 시작으로 여러 DB관련 작업을 수행한 후 접속을 종료하기 까지 전체 기간
-세션이 트랜잭션을 포함하는 관계에 있다.
-읽기 일관성: 데이터를 변경 중인 세션을 제외한 나머지 세션에서는 현재 진행 중인 변경과 무관한 본래의 데이터를 보여주는 특성
-어떤 데이터 조작이 포함된 트랜잭션이 완료(커밋, 롤백)되기 전까지 데이터를 직접 조작하는 세션 외 다른 세션에서는 데이터 조작 전 상태의 내요잉 일관적으로 조회, 출력, 검색되는 특성
-DB입장에서는 명령어 수행이 취될 경우레 대비해 변경 전 데이터를 UNDO SEGMENT에 따로 저장해 둔다.


===LOCK===
-조작 중인 데이터를 다른 조작할 수 없도록 접근을 보류시키는 것
행(HANG): 특정 세션에서 데이터 조작이 완료될 때까지 다른 세션에서 해당 데이터 조작을 기다리는 현상
-row level lock
sql문으로 조작하는 대상 데이터가 테이블의 특정 행 데이터일 경우에 해당 행만 LOCK이 발생한다.
테이블 전체 행이 LOCK 상태여도 INSERT문의 수행은 가능하다.
-table level lock
DML을 사용하여 데이터가 변경 중인 테이블은 테이블 단위로 잠금되고 DDL을 통한 테이블의 구조를 변경할 수 없다.
