<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Notify - Signup</title>
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
            background: linear-gradient(160deg, #0f172a 0%, #0f766e 55%, #2dd4bf 100%);
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
            font-size: 40px;
            line-height: 1.25;
        }

        .auth-hero p {
            margin: 0 0 30px;
            font-size: 16px;
            line-height: 1.7;
            color: rgba(255, 255, 255, 0.88);
        }

        .hero-box {
            padding: 18px 20px;
            border-radius: 18px;
            background: rgba(255, 255, 255, 0.12);
            line-height: 1.7;
            font-size: 14px;
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
            border-color: #0f766e;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(15, 118, 110, 0.12);
        }

        .btn-primary {
            width: 100%;
            height: 54px;
            border: none;
            border-radius: 14px;
            background: linear-gradient(135deg, #0f766e 0%, #0d9488 100%);
            color: #ffffff;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: transform 0.15s ease;
            box-shadow: 0 12px 24px rgba(13, 148, 136, 0.22);
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
            color: #0f766e;
            text-decoration: none;
            font-weight: 700;
        }

        .message {
            margin-top: 18px;
            min-height: 22px;
            font-size: 14px;
            font-weight: 600;
            color: #059669;
        }

        .message.error {
            color: #dc2626;
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
                font-size: 32px;
            }
        }
    </style>
</head>
<body>
<div class="auth-wrap">
    <section class="auth-hero">
        <div class="brand-badge">CREATE ACCOUNT</div>
        <h1>Notify 서비스를<br>시작해보세요</h1>
        <p>
            회원가입 후 일정 등록과 메일 알림 기능을 이용할 수 있습니다.
            개인 일정 관리를 위한 간단한 프로젝트형 서비스입니다.
        </p>

        <div class="hero-box">
            이메일 기반 로그인과 일정 알림 기능을 통해
            중요한 일정을 보다 체계적으로 관리할 수 있습니다.
        </div>
    </section>

    <section class="auth-card">
        <h2>회원가입</h2>
        <p class="sub-text">기본 정보를 입력하고 계정을 생성하세요.</p>

        <form id="signupForm">
            <div class="field">
                <label for="email">이메일</label>
                <input type="email" id="email" placeholder="example@email.com" required>
            </div>

            <div class="field">
                <label for="name">이름</label>
                <input type="text" id="name" placeholder="이름을 입력하세요" required>
            </div>

            <div class="field">
                <label for="password">비밀번호</label>
                <input type="password" id="password" placeholder="비밀번호를 입력하세요" required>
            </div>

            <button type="submit" class="btn-primary">회원가입</button>
        </form>

        <div class="auth-footer">
            이미 계정이 있나요?
            <a href="/login">로그인으로 이동</a>
        </div>

        <div class="message" id="message"></div>
    </section>
</div>

<script>
    document.getElementById('signupForm').addEventListener('submit', async function (e) {
        e.preventDefault();

        const body = {
            email: document.getElementById('email').value,
            name: document.getElementById('name').value,
            password: document.getElementById('password').value
        };

        const response = await fetch('/api/auth/signup', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(body)
        });

        const result = await response.json();
        const messageEl = document.getElementById('message');

        messageEl.textContent = result.message || (result.success ? '회원가입이 완료되었습니다.' : '회원가입에 실패했습니다.');
        messageEl.className = result.success ? 'message' : 'message error';

        if (result.success) {
            setTimeout(function () {
                location.href = '/login';
            }, 1000);
        }
    });
</script>
</body>
</html>