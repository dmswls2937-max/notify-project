<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Notify - Calendar</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 960px; margin: 20px auto; }
        input, textarea, button { padding: 8px; margin-top: 6px; box-sizing: border-box; }
        input, textarea { width: 100%; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; }
        .top-bar { display: flex; justify-content: space-between; align-items: center; }
        .grid { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
    </style>
</head>
<body>
<div class="top-bar">
    <div>
        <h2>Notify 일정 관리</h2>
        <p>${loginUser.name} (${loginUser.email})</p>
    </div>
    <button type="button" onclick="logout()">로그아웃</button>
</div>

<div class="grid">
    <div>
        <h3>일정 등록</h3>
        <form id="scheduleForm">
            <input type="hidden" id="scheduleId">
            <input type="text" id="title" placeholder="제목" required>
            <textarea id="content" placeholder="내용"></textarea>
            <label>시작 일시</label>
            <input type="datetime-local" id="startDatetime" required>
            <label>종료 일시</label>
            <input type="datetime-local" id="endDatetime">
            <label>알림 일시</label>
            <input type="datetime-local" id="alarmDatetime">
            <button type="submit">저장</button>
            <button type="button" onclick="resetForm()">초기화</button>
        </form>
        <p id="message"></p>
    </div>
    <div>
        <h3>설명</h3>
        <p>현재 버전은 JSP 기반 기본 골격입니다.</p>
        <p>다음 단계에서 FullCalendar 같은 달력 라이브러리를 붙이면 됩니다.</p>
    </div>
</div>

<h3>일정 목록</h3>
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>제목</th>
        <th>시작</th>
        <th>종료</th>
        <th>알림</th>
        <th>발송</th>
        <th>관리</th>
    </tr>
    </thead>
    <tbody id="scheduleBody"></tbody>
</table>

<script>
    function toInputDateTime(value) {
        if (!value) return '';
        return value.substring(0, 16);
    }

    function getPayload() {
        const endValue = document.getElementById('endDatetime').value;
        const alarmValue = document.getElementById('alarmDatetime').value;

        return {
            title: document.getElementById('title').value,
            content: document.getElementById('content').value,
            startDatetime: document.getElementById('startDatetime').value ? document.getElementById('startDatetime').value + ':00' : null,
            endDatetime: endValue ? endValue + ':00' : null,
            alarmDatetime: alarmValue ? alarmValue + ':00' : null
        };
    }

    async function loadSchedules() {
        const response = await fetch('/api/schedules');
        const result = await response.json();
        const body = document.getElementById('scheduleBody');
        body.innerHTML = '';

        if (!result.success) {
            body.innerHTML = '<tr><td colspan="7">조회 실패</td></tr>';
            return;
        }

        result.data.forEach(function (item) {
            const tr = document.createElement('tr');
            tr.innerHTML = '' +
                '<td>' + item.scheduleId + '</td>' +
                '<td>' + item.title + '</td>' +
                '<td>' + (item.startDatetime || '') + '</td>' +
                '<td>' + (item.endDatetime || '') + '</td>' +
                '<td>' + (item.alarmDatetime || '') + '</td>' +
                '<td>' + item.alarmSentYn + '</td>' +
                '<td>' +
                '<button type="button" onclick="editSchedule(' + item.scheduleId + ')">수정</button> ' +
                '<button type="button" onclick="deleteSchedule(' + item.scheduleId + ')">삭제</button>' +
                '</td>';
            body.appendChild(tr);
        });
    }

    async function editSchedule(scheduleId) {
        const response = await fetch('/api/schedules/' + scheduleId);
        const result = await response.json();
        if (!result.success) {
            alert(result.message);
            return;
        }

        const item = result.data;
        document.getElementById('scheduleId').value = item.scheduleId;
        document.getElementById('title').value = item.title;
        document.getElementById('content').value = item.content || '';
        document.getElementById('startDatetime').value = toInputDateTime(item.startDatetime);
        document.getElementById('endDatetime').value = toInputDateTime(item.endDatetime);
        document.getElementById('alarmDatetime').value = toInputDateTime(item.alarmDatetime);
    }

    async function deleteSchedule(scheduleId) {
        if (!confirm('삭제하시겠습니까?')) {
            return;
        }

        const response = await fetch('/api/schedules/' + scheduleId, {
            method: 'DELETE'
        });
        const result = await response.json();
        alert(result.message);
        if (result.success) {
            loadSchedules();
            resetForm();
        }
    }

    function resetForm() {
        document.getElementById('scheduleId').value = '';
        document.getElementById('scheduleForm').reset();
    }

    async function logout() {
        await fetch('/api/auth/logout', { method: 'POST' });
        location.href = '/login';
    }

    document.getElementById('scheduleForm').addEventListener('submit', async function (e) {
        e.preventDefault();

        const scheduleId = document.getElementById('scheduleId').value;
        const method = scheduleId ? 'PUT' : 'POST';
        const url = scheduleId ? '/api/schedules/' + scheduleId : '/api/schedules';

        const response = await fetch(url, {
            method: method,
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(getPayload())
        });

        const result = await response.json();
        document.getElementById('message').textContent = result.message;
        if (result.success) {
            resetForm();
            loadSchedules();
        }
    });

    loadSchedules();
</script>
</body>
</html>
