<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Notify - Login</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 420px; margin: 40px auto; }
        input, button { width: 100%; padding: 10px; margin-top: 8px; box-sizing: border-box; }
        .link-box { margin-top: 12px; }
        .message { margin-top: 12px; color: #c0392b; }
    </style>
</head>
<body>
<h2>Notify 로그인</h2>
<form id="loginForm">
    <input type="email" id="email" placeholder="이메일" required>
    <input type="password" id="password" placeholder="비밀번호" required>
    <button type="submit">로그인</button>
</form>
<div class="link-box">
    <a href="/signup">회원가입</a>
</div>
<div class="message" id="message"></div>

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
        document.getElementById('message').textContent = result.message;
    });
</script>
</body>
</html>
