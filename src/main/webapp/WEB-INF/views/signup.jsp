<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Notify - Signup</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 420px; margin: 40px auto; }
        input, button { width: 100%; padding: 10px; margin-top: 8px; box-sizing: border-box; }
        .link-box { margin-top: 12px; }
        .message { margin-top: 12px; color: #27ae60; }
        .error { color: #c0392b; }
    </style>
</head>
<body>
<h2>Notify 회원가입</h2>
<form id="signupForm">
    <input type="email" id="email" placeholder="이메일" required>
    <input type="text" id="name" placeholder="이름" required>
    <input type="password" id="password" placeholder="비밀번호" required>
    <button type="submit">회원가입</button>
</form>
<div class="link-box">
    <a href="/login">로그인으로 이동</a>
</div>
<div class="message" id="message"></div>

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
        messageEl.textContent = result.message;
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
