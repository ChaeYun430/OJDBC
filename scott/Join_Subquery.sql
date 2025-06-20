--====================<<<CH08. JOIN>>>======================
--FROM절에 테이블 또는 열과 행으로 구성된 데이터 집합 지정 가능(ex. 뷰, 서브쿼리)
--크로스 조인(교차 조인)
--데카르트 곱(카테시안 곱: Cartesian product): 각 집합을 이루는 모든 원소의 순서쌍
--(데카르트 곱 현상이 일어나지 않게 하는 데 필요한 조건식의 개수) = (조인 테이블 개수) - 1
SELECT * FROM EMP, DEPT ORDER BY EMPNO;
SELECT * FROM EMP, DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO ORDER BY EMPNO; --특정 테이블의 특정 열 이름 비교 조건
SELECT * FROM EMP E, DEPT D WHERE E.DEPTNO = D.DEPTNO ORDER BY EMPNO; --테이블 이름의 별칭 지정

--대상 데이터를 어떻게 연결하느냐에 따라

--============1. 등가 조인(equi join)/내부 조인, 단순 조인============
--여러 테이블에 있는 열은 반드시 속해 있는 테이블 명시해야 함
--실무에서는 대부분 열 이름의 테이블 명시 
--SELECT EMPNO, ENAME, DEPTNO, DNAME, LOC FROM EMP E, DEPT D WHERE E.DEPTNO = D.DEPTNO;
SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC FROM EMP E, DEPT D WHERE E.DEPTNO = D.DEPTNO ORDER BY D.DEPTNO, E.DEPTNO;
SELECT E.EMPNO, E.ENAME, E.SAL, D.DEPNO, D.DNAME, D.LOC FROM EMP.E, DEPT D WHERE E.DEPTNO = D.DEPTNO AND SAL = 3000;

--================2. 비등가 조인(non-equi join)==================
SELECT * FROM EMP E, SALGRADE S WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

--=================3. 자체 조인(self join)======================
--SELECT * FROM EMP E, COPY_EMP C WHERE E.MGR = C.EMPNO;
--데이터 저장 용량이 두 배가 됨-> 응용 프로그램 동작 효율 저하
--테이블의 데이터 수정 사항을 모든 테이블에 적용해야 하는 추가 작업 -> 반복 작업 횟수 증가
--하나의 테이블을 여러 개의 테이블처럼 활용하여 조인하는 방식//큰 범위에서의 등가 조인
--FROM절에 같은 테이블을 여러 번 명시하되 테이블의 별칭만 다르게 지정하는 방식
SELECT E1.EMPNO, E1.ENAME, E1.MGR, E2.EMPNO AS MGR_EMPNO,E2.ENAME AS MGR_ENAME FROM EMP E1, EMP E2 WHERE E1.MGR = E2.EMPNO;

--=================4. 외부 조인(outer join)=====================
--두 테이블 간 조인 수행에서 조인 기준 열의 어느 한쪽이 NULL이어도 강제로 출력하는 방식 //면접 빈도 높음
--좌우의 기준이 모니터이다.
--왼쪽 외부 조인(Left Outer Join): WHERE TABLE1.COL1 = TABLE2.COL1(+)
--오른쪽 외부 조인(Right Outer Join): WHERE TABLE1.COL1(+) = TABLE2.COL1
--양쪽에 +를 붙이는 방식으로는 전체 외부 조인 사용 불가
--집합연산자 UNION 사용해 같은 효과 구현 가능
SELECT E1.EMPNO, E1.ENAME, E1.MGR, E2.EMPNO AS MGR_EMPNO, E2.ENAME AS MGR_ENAME FROM EMP E1, EMP E2 WHERE E1.MGR = E2.EMPNO(+) ORDER BY E1.EMPNO;
SELECT E1.EMPNO, E1.ENAME, E1.MGR, E2.EMPNO AS MGR_EMPNO, E2.ENAME AS MGR_ENAME FROM EMP E1, EMP E2 WHERE E1.MGR(+) = E2.EMPNO ORDER BY E1.EMPNO;

--=====================SQL-99 표준 문법==========================
--간략하고 명시적으로 어떤 방식의 조인을 사용하고 있는지 알 수 있다
--조인 조건식과 출력 행을 선정하는 조건식을 구별할 수 있다. 

--NATURAL JOIN
--조인 대상이 되는 두 테이블에 이름과 자료형이 같은 열을 찾은 후 그 열을 기준으로 등가 조인
--기존 등가 조인과 다르게 조인 기준 열을 SELECT절에 명시할 때 테이블 이름을 붙이면 안 된다.
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, DEPTNO, D.DNAME, D.LOC FROM EMP E NATURAL JOIN DEPT D ORDER BY DEPTNO, E.EMPNO;
 
--JOIN ~ USING
--USING 키워드에 조인 기준으로 사용할 열을 명시하여 사용한다. 
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, DEPTNO, D.DNAME, D.LOC FROM EMP E JOIN DEPT D USING (DEPTNO) WHERE SAL >= 3000 ORDER BY DEPTNO, E.EMPNO;

--JOIN ~ ON
--범용성 높음
--조인 기준 조건식을 ON에 명시
SELECT E.EMPNO, E.ENAME, E.JOB, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO, D.DNAME, D.LOC FROM EMP E JOIN DEPT D ON (E.DEPTNO = D.DEPTNO) WHERE SAL <= 3000 ORDER BY E.DEPTNO, EMPNO;

--OUTER JOIN 
--Left Outer Join: FROM TABLE1 LEFT OUTER JOIN TABLE2 ON (조인 조건식)
--Right Outer Join: FROM TABLE1 RIGHT OUTER JOIN TABLE2 ON (조인 조건식)
--Full Outer Join: FROM TABLE1 FULL OUTER JOIN TABLE2 ON (조인 조건식)
SELECT E1.EMPNO, E1.ENAME, E1.MGR, E2.EMPNO AS MGR_EMPNO, E2.ENAME AS MGR_ENAME 
    FROM EMP E1 LEFT OUTER JOIN EMP E2 ON (E1.MGR = E2.EMPNO) ORDER BY E1.EMPNO;
SELECT E1.EMPNO, E1.ENAME, E1.MGR, E2.EMPNO AS MGR_EMPNO, E2.ENAME AS MGR_ENAME 
    FROM EMP E1 RIGHT OUTER JOIN EMP E2 ON (E1.MGR = E2.EMPNO) ORDER BY E1.EMPNO;
SELECT E1.EMPNO, E1.ENAME, E1.MGR, E2.EMPNO AS MGR_EMPNO, E2.ENAME AS MGR_ENAME 
    FROM EMP E1 FULL OUTER JOIN EMP E2 ON (E1.MGR = E2.EMPNO) ORDER BY E1.EMPNO;

--세 개 이상의 테이블을 조인할 때
--FROM TABLE1 JOIN TABLE2 ON (조건식) JOIN TABLE3 ON (조건식)

--239P
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL FROM DEPT D, EMP E WHERE D.DEPTNO = E.DEPTNO AND E.SAL > 2000 ORDER BY D.DEPTNO, E.EMPNO;
SELECT DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL FROM DEPT D JOIN EMP E USING(DEPTNO) WHERE SAL > 2000 ORDER BY DEPTNO, E.EMPNO;
SELECT DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL FROM DEPT D NATURAL JOIN EMP E WHERE SAL > 2000 ORDER BY DEPTNO, E.EMPNO;

--=========================<<<CH09. 서브쿼리>>>================================
--서브 쿼리: SQL문을 실행하는 데 필요한 데이터를 추가로 조회하기 위해 SQL문 내부에서 사용하는 SELECT문
--메인 쿼리: 서브쿼리의 결과 값을 사용하여 기능을 수행하는 영역
--발문의 적절한 분할이 중요
SELECT * FROM EMP WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'JONES');

--1. 서브쿼리는 연산자와 같은 비교 또는 조회 대상의 오른쪽에 놓이며 괄호로 묶어서 사용
--2. 특수한 몇몇 경우를 제외한 대부분의 서브쿼리에서는 ORDER BY절 사용 불가
--3 서브쿼리의 SELECT절에 명시한 열은 메인쿼리의 비교 대상과 같은 자료형과 같은 개수로 지정해야 함.
--4. 서브쿼리에 있는 SELECT문의 결과 행 수는 함께 사용하는 메인쿼리의 연산자 종류와 호환 가능해야 함.

--단일행 서브쿼리(single-row)
--단일행 연산자: 대소 비교 연산자, 동등 비교 연산자
SELECT * FROM EMP WHERE HIREDATE < (SELECT HIREDATE FROM EMP WHERE ENAME = 'SCOTT');--서브쿼리 결과값이 날짜형 데이터일 때도 사용 가능
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC FROM EMP E, DEPT D WHERE E.DEPTNO = D.DEPTNO AND E.DEPTNO = 20 AND E.SAL > (SELECT AVG(SAL) FROM EMP);--서브쿼리에서 특정 함수를 사용한 결과값이 하나일 때

--다중행 서브쿼리(multople-row)
--다중행 연산자: 
--IN: 메인쿼리의 데이터가 서브쿼리의 결과 중 하나라도 일치한 데이터가 있다면 참
SELECT * FROM EMP WHERE DEPTNO IN (20, 30)

SELECT MAX(SAL), DEPTNO FROM EMP GROUP BY DEPTNO
SELECT * FROM EMP WHERE SAL IN (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO)

--ANY, SOME: 메인쿼리의 조건식을 만족하는 서브쿼리의 결과가 하나 이상이면 참
SELECT * FROM EMP WHERE SAL = ANY (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO)
SELECT * FROM EMP WHERE SAL = SOME (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO)
--하나의 값에 의해 영향을 받음
SELECT SAL FROM EMP WHERE DEPTNO = 30
SELECT * FROM EMP WHERE SAL < ANY(SELECT SAL FROM EMP WHERE DEPTNO = 30) ORDER BY SAL, EMPNO
SELECT * FROM EMP WHERE SAL < (SELECT MAX(SAL) FROM EMP WHERE DEPTNO = 30) ORDER BY SAL, EMPNO
SELECT * FROM EMP WHERE SAL > ANY(SELECT SAL FROM EMP WHERE DEPTNO = 30) ORDER BY SAL, EMPNO

--ALL: 메인쿼리의 조건식을 서브쿼리의 결과의 모두가 만족하면 참
--전체 값의 영향을 받음
SELECT * FROM EMP WHERE SAL < ALL (SELECT SAL FROM EMP WHERE DEPTNO = 30)
SELECT * FROM EMP WHERE SAL > ALL (SELECT SAL FROM EMP WHERE DEPTNO = 30)

--EXISTS: 서브쿼리의 결과가 존재하면(즉, 행이 1개 이상이면) 조건식이 모두 참
--활용: 특정 서브커리 결과 값의 존재 유무를 통해 메인쿼리의 데이터 노출 여부를 결정해야 할 때 간혹 사용
SELECT * FROM EMP WHERE EXISTS (SELECT DNAME FROM DEPT WHERE DEPTNO = 10)
SELECT * FROM EMP WHERE EXISTS (SELECT DNAME FROM DEPT WHERE DEPTNO = 50)


--다중열 서브쿼리(multiple-column) //복수열 서브쿼리
--메인쿼리에 비교할 열을 괄호로 묶어 명시하고
--서브쿼리에서는 괄호로 묶은 데이터와 같은 자료형 데이터를 SELECT절에 명시
SELECT * FROM EMP WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO)

--인라인 뷰
--FROM절에 사용하는 서브쿼리
--특정 테이블 전체 데이터가 아닌 
--SELECT문을 통해 일부 데이터를 먼저 추출해 온 후 
--별칭을 주어 사용
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
	FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10,
		 (SELECT * FROM DEPT) D
		 WHERE E10.DEPTNO = D.DEPTNO
--활용1: 직접 테이블을 명시하여 사용하기에는 테이블 내 데이터 규모가 너무 클 때
--활용2: 현재 작업에 불필요한 열이 너무 많아 일부 행과 열만 사용하고자 할 때

--WITH 절
--메인쿼리가 될 SELECT문 안에서 사용할 서브쿼리와 별칭을 먼저 지정
WITH [별칭] AS [SELECT문], ... 
	SELECT [VALUE] FROM [별칭]
	
WITH 
E10 AS (SELECT * FROM EMP WHERE DEPTNO = 10),
D AS (SELECT * FROM DEPT)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC FROM E10, D
	WHERE E10.DEPTNO = D.DEPTNO
	
--상호연관 서브쿼리(correlated)
--메인쿼리에 사용한 데이터를 서브쿼리에서 사용하고 서브쿼리의 결과 값을 다시 메인쿼리로 돌려주는 방식
--성능을 떨어뜨리고 사용빈도가 높지 않다.
SELECT * FROM EMP E1 WHERE SAL > (SELECT MIN(SAL) FROM EMP E2 WHERE E2.DEPTNO = E1.DEPTNO)
	ORDER BY DEPTNO, SAL
	
--스칼라 서브쿼리(scalar)
--서브쿼리가 SELECT절의 하나의 열 영역으로서 결과 출력 가능
--SELECT절에 명시하는 서브쿼리는 반드시 하나의 결과만 반환하도록 작성해주어야 한다. 
--활용: 주 테이블의 값을 타 테이블의 값과 비교하는 조건식을 작성하고 싶을 때
SELECT EMPNO, ENAME, JOB, SAL, 
		(SELECT GRADE FROM SALGRADE WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE, 
		DEPTNO,
		(SELECT DNAME FROM DEPT WHERE E.DEPTNO = DEPT.DEPTNO) AS DNAME
		FROM EMP E



