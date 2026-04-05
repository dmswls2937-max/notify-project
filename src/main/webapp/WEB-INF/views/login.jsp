<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Notify - Login</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: "Malgun Gothic", "Apple SD Gothic Neo", Arial, sans-serif;
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 45%, #334155 100%);
            color: #0f172a;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
        }

        .auth-wrap {
            width: 100%;
            max-width: 1100px;
            display: grid;
            grid-template-columns: 1.15fr 0.85fr;
            background: rgba(255, 255, 255, 0.96);
            border-radius: 28px;
            overflow: hidden;
            box-shadow: 0 30px 80px rgba(15, 23, 42, 0.28);
        }

        .auth-hero {
            padding: 56px 52px;
            background: linear-gradient(160deg, #0f172a 0%, #1d4ed8 55%, #38bdf8 100%);
            color: #ffffff;
            position: relative;
        }

        .auth-hero::after {
            content: "";
            position: absolute;
            right: -90px;
            bottom: -90px;
            width: 240px;
            height: 240px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.14);
        }

        .brand-badge {
            display: inline-flex;
            align-items: center;
            padding: 8px 14px;
            border-radius: 999px;
            background: rgba(255, 255, 255, 0.16);
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 0.04em;
            margin-bottom: 24px;
        }

        .auth-hero h1 {
            margin: 0 0 16px;
            font-size: 42px;
            line-height: 1.2;
        }

        .auth-hero p {
            margin: 0 0 30px;
            font-size: 16px;
            line-height: 1.7;
            color: rgba(255, 255, 255, 0.88);
        }

        .hero-points {
            margin: 0;
            padding: 0;
            list-style: none;
            display: grid;
            gap: 14px;
        }

        .hero-points li {
            padding: 14px 16px;
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(6px);
            font-size: 14px;
            line-height: 1.6;
        }

        .auth-card {
            padding: 56px 44px;
            background: #ffffff;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .auth-card h2 {
            margin: 0 0 10px;
            font-size: 32px;
            color: #0f172a;
        }

        .auth-card .sub-text {
            margin: 0 0 28px;
            color: #64748b;
            font-size: 15px;
        }

        .field {
            margin-bottom: 16px;
        }

        .field label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 700;
            color: #334155;
        }

        .field input {
            width: 100%;
            height: 52px;
            border: 1px solid #dbe2ea;
            border-radius: 14px;
            padding: 0 16px;
            font-size: 15px;
            outline: none;
            transition: all 0.2s ease;
            background: #f8fafc;
        }

        .field input:focus {
            border-color: #2563eb;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.12);
        }

        .btn-primary {
            width: 100%;
            height: 54px;
            border: none;
            border-radius: 14px;
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            color: #ffffff;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: transform 0.15s ease, box-shadow 0.15s ease;
            box-shadow: 0 12px 24px rgba(37, 99, 235, 0.24);
        }

        .btn-primary:hover {
            transform: translateY(-1px);
        }

        .auth-footer {
            margin-top: 22px;
            text-align: center;
            font-size: 14px;
            color: #64748b;
        }

        .auth-footer a {
            color: #2563eb;
            text-decoration: none;
            font-weight: 700;
        }

        .message {
            margin-top: 18px;
            min-height: 22px;
            font-size: 14px;
            color: #dc2626;
            font-weight: 600;
        }

        @media (max-width: 900px) {
            .auth-wrap {
                grid-template-columns: 1fr;
            }

            .auth-hero {
                padding: 40px 28px;
            }

            .auth-card {
                padding: 40px 28px;
            }

            .auth-hero h1 {
                font-size: 34px;
            }
        }
    </style>
</head>
<body>
<div class="auth-wrap">
    <section class="auth-hero">
        <div class="brand-badge">NOTIFY PROJECT</div>
        <h1>일정을 등록하고<br>메일 알림으로 관리하세요</h1>
        <p>
            Notify는 웹 기반 일정 관리와 메일 알림 기능을 제공하는 프로젝트입니다.
            중요한 일정을 놓치지 않도록 간단하고 직관적인 방식으로 관리할 수 있습니다.
        </p>

        <ul class="hero-points">
            <li>일정 등록, 수정, 삭제 기능 제공</li>
            <li>알림 시간을 설정하여 메일 자동 발송</li>
            <li>간단한 UI로 빠르게 일정 확인 가능</li>
        </ul>
    </section>

    <section class="auth-card">
        <h2>로그인</h2>
        <p class="sub-text">이메일과 비밀번호를 입력하여 서비스를 시작하세요.</p>

        <form id="loginForm">
            <div class="field">
                <label for="email">이메일</label>
                <input type="email" id="email" placeholder="example@email.com" required>
            </div>

            <div class="field">
                <label for="password">비밀번호</label>
                <input type="password" id="password" placeholder="비밀번호를 입력하세요" required>
            </div>

            <button type="submit" class="btn-primary">로그인</button>
        </form>

        <div class="auth-footer">
            아직 계정이 없나요?
            <a href="/signup">회원가입</a>
        </div>

        <div class="message" id="message"></div>
    </section>
</div>

<script>
    document.getElementById('loginForm').addEventListener('submit', async function (e) {
        e.preventDefault();

        const body = {
            email: document.getElementById('email').value,
            password: document.getElementById('password').value
        };

        const response = await fetch('/api/auth/login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(body)
        });

        const result = await response.json();
        if (result.success) {
            location.href = '/calendar';
            return;
        }

        document.getElementById('message').textContent = result.message || '로그인에 실패했습니다.';
    });
</script>
</body>
</html>