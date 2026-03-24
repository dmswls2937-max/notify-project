CREATE DATABASE IF NOT EXISTS notify_db
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_unicode_ci;

USE notify_db;

CREATE TABLE IF NOT EXISTS users (
    user_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '사용자 PK',
    email VARCHAR(100) NOT NULL COMMENT '로그인 이메일',
    password_hash VARCHAR(255) NOT NULL COMMENT '암호화 비밀번호',
    name VARCHAR(50) NOT NULL COMMENT '사용자 이름',
    email_verified_yn CHAR(1) NOT NULL DEFAULT 'N' COMMENT '이메일 인증 여부',
    use_yn CHAR(1) NOT NULL DEFAULT 'Y' COMMENT '사용 여부',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    PRIMARY KEY (user_id),
    UNIQUE KEY uk_users_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='사용자 정보';

CREATE TABLE IF NOT EXISTS schedules (
    schedule_id BIGINT NOT NULL AUTO_INCREMENT COMMENT '일정 PK',
    user_id BIGINT NOT NULL COMMENT '사용자 PK',
    title VARCHAR(200) NOT NULL COMMENT '일정 제목',
    content TEXT NULL COMMENT '일정 내용',
    start_datetime DATETIME NOT NULL COMMENT '일정 시작 일시',
    end_datetime DATETIME NULL COMMENT '일정 종료 일시',
    alarm_datetime DATETIME NULL COMMENT '알림 예정 일시',
    alarm_sent_yn CHAR(1) NOT NULL DEFAULT 'N' COMMENT '알림 발송 여부',
    alarm_sent_at DATETIME NULL COMMENT '실제 알림 발송 일시',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '생성일시',
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    PRIMARY KEY (schedule_id),
    KEY idx_schedules_user_id (user_id),
    KEY idx_schedules_start_datetime (start_datetime),
    KEY idx_schedules_alarm_datetime (alarm_datetime),
    CONSTRAINT fk_schedules_user_id FOREIGN KEY (user_id)
        REFERENCES users (user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='일정 정보';
