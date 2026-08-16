# ☕ Java 21 + Eclipse + Oracle 21c XE + SQL Developer 환경설정 및 접속 정보 완전 기록

> **작성일자:** 2026-08-16  
> **기록 목적:** 이클립스-오라클 JDBC 연동, 오라클 리스너 수리 내역, 비밀번호, 수업 자료 경로 등 환경 설정 전체 보존

---

## 1. ☕ Java (JDK 21) 환경 정보
* **설치 버전:** Java 21.0.9 LTS (64-bit)
* **`JAVA_HOME`:** `C:\Program Files\Java\jdk-21`
* **`PATH` 등록:** `C:\Program Files\Java\jdk-21\bin`
* **이클립스 연동 규칙:**
  * 새 프로젝트 생성 시 `module-info.java`는 **반드시 삭제(Delete)** 할 것 *(삭제하지 않으면 JDBC java.sql 라이브러리 접근 차단됨)*

---

## 2. 🗄️ Oracle Database 21c Express Edition (XE) 설정
* **버전:** Oracle Database 21c Express Edition Release 21.0.0.0.0 (Production)
* **호스트 (Host):** `localhost` (127.0.0.1)
* **포트 (Port):** `1521`
* **기본 SID / 서비스 이름:** `xe`
* **PDB (플러그형 DB):** `XEPDB1`
* **관리자 / 실습 계정 및 비밀번호:**
  * **아이디:** `system` (또는 `sys`, `hr`, `c##scott`)
  * **비밀번호:** **`1234`** *(전체 계정 1234로 통일 및 언락 완료)*
* **리스너 통신 수리 내역:**
  * 설정 파일: `C:\oracle\homes\OraDB21Home1\network\admin\listener.ora`
  * 기존 유동 공인 IP 바인딩 오류 수정 ➔ `localhost` 및 `XE`, `XEPDB1` 정적 등록 완료
  * 윈도우 서비스명: `OracleOraDB21Home1TNSListener`, `OracleServiceXE`

---

## 3. 🔌 이클립스 Java JDBC 연동 규격
* **JDBC 드라이버 파일:** `C:\oracle\dbhomeXE\jdbc\lib\ojdbc11.jar` (JDK 21 호환)
* **드라이버 클래스:** `oracle.jdbc.OracleDriver`
* **접속 URL:** `jdbc:oracle:thin:@localhost:1521/xe`
* **이클립스 등록 방법:**
  * 프로젝트 우클릭 ➔ `Build Path` ➔ `Configure Build Path...` ➔ `Libraries` ➔ `Classpath` ➔ `Add External JARs...` ➔ `ojdbc11.jar` 추가

---

## 4. 🖥️ Oracle SQL Developer (공식 GUI 툴)
* **버전:** 24.3.1
* **실행 파일 위치:** `C:\Users\ildoc\AppData\Local\Microsoft\WinGet\Packages\Oracle.SQLDeveloper_Microsoft.Winget.Source_8wekyb3d8bbwe\sqldeveloper\sqldeveloper.exe`
* **바탕화면 바로가기:** `C:\Users\ildoc\Desktop\Oracle SQL Developer.lnk`
* **접속 설정:**
  * 접속 이름: `로컬-SYSTEM`
  * 사용자 이름: `system`
  * 비밀번호: `1234`
  * 호스트/포트/SID: `localhost` / `1521` / `xe`

---

## 5. 📂 수업 교재 및 실습 SQL 파일 실존 경로 (E: 드라이브)
* **수업 SQL 쿼리 실습 파일 모음:** `E:\KH_Fullstack_과정\ORACLE_TEST\`
  * `01장_설치기능명령어, 사용자계정, 테이브스페이스.sql`
  * `4장select.sql`
  * `5장insert_update_delete.sql`
  * `6장테이블.sql`, `7장select함수.sql`, `8장 그룹함수.sql`
  * `12장_조인.sql`, `14장서브쿼리.sql`, `15장TRANSACTION.sql`
  * `로컬_KH.sql`, `book_project.sql` 등
* **오라클 이론 교재 (PDF):** `E:\KH_Fullstack_과정\03.오라클\`
* **자바 이론 교재 (PDF):** `E:\KH_Fullstack_과정\02_자바\`
