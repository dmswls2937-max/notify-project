# Notify JSP Project

Spring Boot + JSP + REST API + MyBatis + MySQL + Scheduler 기본 프로젝트입니다.

## 포함 기능
- 회원가입
- 로그인 / 로그아웃
- JSP 화면 렌더링
- 일정 CRUD API
- 세션 기반 인증 체크
- 스케줄러 기반 알림 대상 조회
- 이메일 발송 서비스 기본 구조

## 권장 환경
- Java 17
- MySQL 8.x
- Maven 3.9+

## 실행 전 준비
1. MySQL에 `notify_db` 생성
2. `src/main/resources/application.yml`의 DB / 메일 계정 수정
3. 아래 SQL 실행

```sql
SOURCE sql/schema.sql;
```

## 실행
```bash
mvn spring-boot:run
```

## 기본 URL
- 메인: http://localhost:8080/
- 회원가입: http://localhost:8080/signup
- 로그인: http://localhost:8080/login
- 캘린더: http://localhost:8080/calendar

## 주의
- 현재는 졸업작품 시작용 기본 구조라서 보안, 예외처리, UI, 캘린더 라이브러리 연동은 최소화되어 있습니다.
- 비밀번호는 BCrypt로 저장합니다.
- 메일 발송은 `mail.enabled: true` 로 바꾸고 SMTP 계정을 넣어야 실제 발송됩니다.
