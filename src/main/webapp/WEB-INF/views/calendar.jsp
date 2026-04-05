<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Notify - Calendar</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: "Malgun Gothic", "Apple SD Gothic Neo", Arial, sans-serif;
            background: #f1f5f9;
            color: #0f172a;
        }

        .layout {
            min-height: 100vh;
        }

        .header {
            background: linear-gradient(135deg, #0f172a 0%, #1d4ed8 100%);
            color: #ffffff;
            padding: 22px 0;
            box-shadow: 0 12px 30px rgba(15, 23, 42, 0.18);
        }

        .container {
            width: min(1280px, calc(100% - 40px));
            margin: 0 auto;
        }

        .header-inner {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
        }

        .brand-title {
            margin: 0;
            font-size: 28px;
            font-weight: 800;
        }

        .brand-sub {
            margin-top: 8px;
            color: rgba(255, 255, 255, 0.82);
            font-size: 14px;
        }

        .header-user {
            text-align: right;
        }

        .header-user .name {
            font-size: 14px;
            color: rgba(255, 255, 255, 0.82);
            margin-bottom: 8px;
        }

        .btn-logout {
            height: 42px;
            border: 1px solid rgba(255, 255, 255, 0.25);
            background: rgba(255, 255, 255, 0.12);
            color: #ffffff;
            border-radius: 12px;
            padding: 0 16px;
            cursor: pointer;
            font-weight: 700;
        }

        .main {
            padding: 28px 0 40px;
        }

        .summary-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px;
            margin-bottom: 22px;
        }

        .summary-card {
            background: #ffffff;
            border-radius: 20px;
            padding: 22px 24px;
            box-shadow: 0 14px 30px rgba(15, 23, 42, 0.06);
            border: 1px solid #e5edf5;
        }

        .summary-label {
            color: #64748b;
            font-size: 13px;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .summary-value {
            font-size: 30px;
            font-weight: 800;
            color: #0f172a;
        }

        .top-grid {
            display: grid;
            grid-template-columns: 400px 1fr;
            gap: 22px;
            align-items: start;
            margin-bottom: 22px;
        }

        .card {
            background: #ffffff;
            border-radius: 24px;
            box-shadow: 0 16px 40px rgba(15, 23, 42, 0.07);
            border: 1px solid #e5edf5;
        }

        .card-head {
            padding: 24px 24px 0;
        }

        .card-head h3 {
            margin: 0;
            font-size: 22px;
        }

        .card-head p {
            margin: 8px 0 0;
            font-size: 14px;
            color: #64748b;
            line-height: 1.6;
        }

        .card-body {
            padding: 24px;
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

        .field input,
        .field textarea {
            width: 100%;
            border: 1px solid #dbe2ea;
            border-radius: 14px;
            background: #f8fafc;
            outline: none;
            transition: all 0.2s ease;
            font-size: 14px;
            color: #0f172a;
        }

        .field input {
            height: 48px;
            padding: 0 14px;
        }

        .field textarea {
            min-height: 110px;
            resize: vertical;
            padding: 14px;
        }

        .field input:focus,
        .field textarea:focus {
            border-color: #2563eb;
            background: #ffffff;
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.12);
        }

        .btn-row {
            display: flex;
            gap: 10px;
            margin-top: 22px;
        }

        .btn {
            height: 48px;
            border: none;
            border-radius: 14px;
            padding: 0 18px;
            cursor: pointer;
            font-weight: 700;
            font-size: 14px;
            transition: transform 0.15s ease, opacity 0.15s ease;
        }

        .btn:hover {
            transform: translateY(-1px);
        }

        .btn-primary {
            flex: 1;
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            color: #ffffff;
            box-shadow: 0 12px 24px rgba(37, 99, 235, 0.18);
        }

        .btn-secondary {
            flex: 1;
            background: #e2e8f0;
            color: #0f172a;
        }

        .message {
            margin-top: 16px;
            min-height: 22px;
            font-size: 14px;
            font-weight: 700;
            color: #2563eb;
        }

        .calendar-card {
            overflow: hidden;
        }

        .calendar-toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin-bottom: 18px;
        }

        .calendar-title {
            font-size: 24px;
            font-weight: 800;
            color: #0f172a;
        }

        .calendar-actions {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .btn-icon,
        .btn-today {
            border: none;
            cursor: pointer;
            font-weight: 700;
            border-radius: 12px;
            height: 40px;
        }

        .btn-icon {
            width: 40px;
            background: #e2e8f0;
            color: #0f172a;
        }

        .btn-today {
            padding: 0 14px;
            background: #dbeafe;
            color: #1d4ed8;
        }

        .weekday-row,
        .calendar-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 10px;
        }

        .weekday {
            text-align: center;
            font-size: 13px;
            font-weight: 800;
            color: #64748b;
            padding: 10px 0;
        }

        .calendar-day {
            min-height: 118px;
            background: #f8fafc;
            border: 1px solid #e5edf5;
            border-radius: 16px;
            padding: 10px;
            cursor: pointer;
            display: flex;
            flex-direction: column;
            gap: 8px;
            transition: all 0.2s ease;
        }

        .calendar-day:hover {
            background: #eff6ff;
            border-color: #bfdbfe;
        }

        .calendar-day.other-month {
            opacity: 0.42;
        }

        .calendar-day.today {
            border: 2px solid #2563eb;
            background: #eff6ff;
        }

        .calendar-day.selected {
            border: 2px solid #0f766e;
            background: #ecfeff;
        }

        .day-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .day-number {
            font-size: 14px;
            font-weight: 800;
            color: #0f172a;
        }

        .event-count {
            min-width: 24px;
            height: 24px;
            border-radius: 999px;
            background: #1d4ed8;
            color: #ffffff;
            font-size: 12px;
            font-weight: 800;
            display: inline-flex;
            justify-content: center;
            align-items: center;
            padding: 0 6px;
        }

        .day-events {
            display: flex;
            flex-direction: column;
            gap: 6px;
            overflow: hidden;
        }

        .event-chip {
            font-size: 12px;
            font-weight: 700;
            line-height: 1.35;
            padding: 6px 8px;
            border-radius: 10px;
            background: #dbeafe;
            color: #1d4ed8;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .more-text {
            font-size: 11px;
            font-weight: 700;
            color: #64748b;
        }

        .list-card .list-header {
            display: flex;
            justify-content: space-between;
            align-items: end;
            gap: 16px;
            margin-bottom: 18px;
        }

        .list-card .list-header h3 {
            margin: 0;
            font-size: 22px;
        }

        .list-card .list-header p {
            margin: 8px 0 0;
            color: #64748b;
            font-size: 14px;
        }

        .filter-text {
            font-size: 13px;
            color: #0f766e;
            font-weight: 800;
        }

        .table-wrap {
            overflow-x: auto;
            border-radius: 18px;
            border: 1px solid #e5edf5;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 880px;
        }

        thead th {
            background: #f8fafc;
            color: #475569;
            font-size: 13px;
            font-weight: 800;
            text-align: left;
            padding: 14px 16px;
            border-bottom: 1px solid #e5edf5;
        }

        tbody td {
            padding: 16px;
            border-bottom: 1px solid #eef2f7;
            font-size: 14px;
            vertical-align: top;
        }

        tbody tr:hover {
            background: #f8fbff;
        }

        .title-cell {
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 4px;
        }

        .content-cell {
            color: #64748b;
            font-size: 13px;
            line-height: 1.5;
            white-space: pre-wrap;
        }

        .badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 82px;
            height: 32px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 800;
            padding: 0 12px;
        }

        .badge.waiting {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .badge.sent {
            background: #dcfce7;
            color: #15803d;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .btn-sm {
            height: 36px;
            padding: 0 14px;
            border-radius: 10px;
            border: none;
            cursor: pointer;
            font-size: 13px;
            font-weight: 700;
        }

        .btn-edit {
            background: #e0e7ff;
            color: #3730a3;
        }

        .btn-delete {
            background: #fee2e2;
            color: #b91c1c;
        }

        .empty-row td {
            text-align: center;
            color: #64748b;
            padding: 40px 16px;
        }

        @media (max-width: 1100px) {
            .top-grid {
                grid-template-columns: 1fr;
            }

            .summary-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 760px) {
            .summary-grid {
                grid-template-columns: 1fr;
            }

            .header-inner {
                flex-direction: column;
                align-items: flex-start;
            }

            .header-user {
                text-align: left;
            }

            .btn-row {
                flex-direction: column;
            }

            .calendar-toolbar {
                flex-direction: column;
                align-items: flex-start;
            }

            .calendar-grid {
                gap: 8px;
            }

            .calendar-day {
                min-height: 96px;
                padding: 8px;
            }
        }
        .field-group {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }

        @media (max-width: 760px) {
            .field-group {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="layout">
    <header class="header">
        <div class="container header-inner">
            <div>
                <h1 class="brand-title">Notify</h1>
                <div class="brand-sub">메일 알림 기반 일정 관리 시스템</div>
            </div>

            <div class="header-user">
                <div class="name">${loginUser.name} (${loginUser.email})</div>
                <button type="button" class="btn-logout" onclick="logout()">로그아웃</button>
            </div>
        </div>
    </header>

    <main class="main">
        <div class="container">
            <section class="summary-grid">
                <div class="summary-card">
                    <div class="summary-label">TOTAL SCHEDULES</div>
                    <div class="summary-value" id="totalCount">0</div>
                </div>
                <div class="summary-card">
                    <div class="summary-label">WAITING ALARMS</div>
                    <div class="summary-value" id="waitingCount">0</div>
                </div>
                <div class="summary-card">
                    <div class="summary-label">SENT ALARMS</div>
                    <div class="summary-value" id="sentCount">0</div>
                </div>
                <div class="summary-card">
                    <div class="summary-label">SELECTED DATE</div>
                    <div class="summary-value" id="selectedDateCount">ALL</div>
                </div>
            </section>

            <section class="top-grid">
                <div class="card">
                    <div class="card-head">
                        <h3>일정 등록</h3>
                        <p>일정의 제목, 시간, 알림 시간을 입력하여 손쉽게 관리할 수 있습니다.</p>
                    </div>
                    <div class="card-body">
                        <form id="scheduleForm">
                            <input type="hidden" id="scheduleId">

                            <div class="field">
                                <label for="title">제목</label>
                                <input type="text" id="title" placeholder="일정 제목을 입력하세요" required>
                            </div>

                            <div class="field">
                                <label for="content">내용</label>
                                <textarea id="content" placeholder="일정에 대한 설명을 입력하세요"></textarea>
                            </div>

                            <div class="field-group">
                                <div class="field">
                                    <label for="startDate">시작 날짜</label>
                                    <input type="date" id="startDate" required>
                                </div>
                                <div class="field">
                                    <label for="startTime">시작 시간</label>
                                    <input type="time" id="startTime" required>
                                </div>
                            </div>

                            <div class="field-group">
                                <div class="field">
                                    <label for="endDate">종료 날짜</label>
                                    <input type="date" id="endDate">
                                </div>
                                <div class="field">
                                    <label for="endTime">종료 시간</label>
                                    <input type="time" id="endTime">
                                </div>
                            </div>

                            <div class="field-group">
                                <div class="field">
                                    <label for="alarmDate">알림 날짜</label>
                                    <input type="date" id="alarmDate">
                                </div>
                                <div class="field">
                                    <label for="alarmTime">알림 시간</label>
                                    <input type="time" id="alarmTime">
                                </div>
                            </div>

                            <div class="btn-row">
                                <button type="submit" class="btn btn-primary">저장</button>
                                <button type="button" class="btn btn-secondary" onclick="resetForm()">초기화</button>
                            </div>
                        </form>

                        <div class="message" id="message"></div>
                    </div>
                </div>

                <div class="card calendar-card">
                    <div class="card-body">
                        <div class="calendar-toolbar">
                            <div class="calendar-title" id="calendarTitle"></div>
                            <div class="calendar-actions">
                                <button type="button" class="btn-icon" onclick="moveMonth(-1)">‹</button>
                                <button type="button" class="btn-today" onclick="goToday()">오늘</button>
                                <button type="button" class="btn-icon" onclick="moveMonth(1)">›</button>
                            </div>
                        </div>

                        <div class="weekday-row">
                            <div class="weekday">일</div>
                            <div class="weekday">월</div>
                            <div class="weekday">화</div>
                            <div class="weekday">수</div>
                            <div class="weekday">목</div>
                            <div class="weekday">금</div>
                            <div class="weekday">토</div>
                        </div>

                        <div class="calendar-grid" id="calendarGrid"></div>
                    </div>
                </div>
            </section>

            <section class="card list-card">
                <div class="card-body">
                    <div class="list-header">
                        <div>
                            <h3>일정 목록</h3>
                            <p>등록된 일정과 알림 발송 상태를 한눈에 확인할 수 있습니다.</p>
                        </div>
                        <div class="filter-text" id="filterText">전체 일정 표시 중</div>
                    </div>

                    <div class="table-wrap">
                        <table>
                            <thead>
                            <tr>
                                <th style="width: 70px;">ID</th>
                                <th style="width: 260px;">일정 정보</th>
                                <th style="width: 160px;">시작 일시</th>
                                <th style="width: 160px;">종료 일시</th>
                                <th style="width: 160px;">알림 일시</th>
                                <th style="width: 110px;">발송 상태</th>
                                <th style="width: 140px;">관리</th>
                            </tr>
                            </thead>
                            <tbody id="scheduleBody"></tbody>
                        </table>
                    </div>
                </div>
            </section>
        </div>
    </main>
</div>

<script>
    let allSchedules = [];
    let filteredSchedules = [];
    let currentMonthDate = new Date();
    let selectedDateKey = '';

    function pad(value) {
        return String(value).padStart(2, '0');
    }

    function formatDateKey(date) {
        return date.getFullYear() + '-' + pad(date.getMonth() + 1) + '-' + pad(date.getDate());
    }

    function formatDateKeyFromString(value) {
        if (!value || value.length < 10) return '';
        return value.substring(0, 10);
    }

    function formatDisplayDateTime(value) {
        if (!value) return '-';
        return value.replace('T', ' ').substring(0, 16);
    }

    function formatCalendarTitle(date) {
        return date.getFullYear() + '년 ' + (date.getMonth() + 1) + '월';
    }

    function toInputDateTime(value) {
        if (!value) return '';
        return value.substring(0, 16);
    }

    function getPayload() {
        return {
            title: document.getElementById('title').value,
            content: document.getElementById('content').value,
            startDatetime: combineDateTime(
                document.getElementById('startDate').value,
                document.getElementById('startTime').value
            ),
            endDatetime: combineDateTime(
                document.getElementById('endDate').value,
                document.getElementById('endTime').value
            ),
            alarmDatetime: combineDateTime(
                document.getElementById('alarmDate').value,
                document.getElementById('alarmTime').value
            )
        };
    }

    function updateSummary(data) {
        const total = data.length;
        const sent = data.filter(function (item) {
            return item.alarmSentYn === 'Y';
        }).length;
        const waiting = total - sent;

        document.getElementById('totalCount').textContent = total;
        document.getElementById('waitingCount').textContent = waiting;
        document.getElementById('sentCount').textContent = sent;
        document.getElementById('selectedDateCount').textContent = selectedDateKey || 'ALL';
    }

    function getSchedulesByDateKey(dateKey) {
        return allSchedules.filter(function (item) {
            return formatDateKeyFromString(item.startDatetime) === dateKey;
        });
    }

    function applyFilter() {
        if (!selectedDateKey) {
            filteredSchedules = allSchedules.slice();
            document.getElementById('filterText').textContent = '전체 일정 표시 중';
        } else {
            filteredSchedules = getSchedulesByDateKey(selectedDateKey);
            document.getElementById('filterText').textContent = selectedDateKey + ' 일정 표시 중';
        }

        renderTable();
        updateSummary(allSchedules);
        renderCalendar();
    }

    function renderTable() {
        const body = document.getElementById('scheduleBody');
        body.innerHTML = '';

        if (!filteredSchedules || filteredSchedules.length === 0) {
            body.innerHTML = '<tr class="empty-row"><td colspan="7">표시할 일정이 없습니다.</td></tr>';
            return;
        }

        filteredSchedules
            .slice()
            .sort(function (a, b) {
                const aTime = new Date(a.startDatetime).getTime();
                const bTime = new Date(b.startDatetime).getTime();
                return aTime - bTime;
            })
            .forEach(function (item) {
                const tr = document.createElement('tr');
                const badgeClass = item.alarmSentYn === 'Y' ? 'sent' : 'waiting';
                const badgeText = item.alarmSentYn === 'Y' ? 'Sent' : 'Waiting';

                tr.innerHTML = ''
                    + '<td>' + item.scheduleId + '</td>'
                    + '<td>'
                    + '  <div class="title-cell">' + (item.title || '') + '</div>'
                    + '  <div class="content-cell">' + (item.content || '-') + '</div>'
                    + '</td>'
                    + '<td>' + formatDisplayDateTime(item.startDatetime) + '</td>'
                    + '<td>' + formatDisplayDateTime(item.endDatetime) + '</td>'
                    + '<td>' + formatDisplayDateTime(item.alarmDatetime) + '</td>'
                    + '<td><span class="badge ' + badgeClass + '">' + badgeText + '</span></td>'
                    + '<td>'
                    + '  <div class="action-buttons">'
                    // + '      <button type="button" class="btn-sm btn-edit" onclick="editSchedule(' + item.scheduleId + ')">수정</button>'
                    + '      <button type="button" class="btn-sm btn-delete" onclick="deleteSchedule(' + item.scheduleId + ')">삭제</button>'
                    + '  </div>'
                    + '</td>';

                body.appendChild(tr);
            });
    }

    function renderCalendar() {
        const calendarGrid = document.getElementById('calendarGrid');
        const calendarTitle = document.getElementById('calendarTitle');
        calendarGrid.innerHTML = '';
        calendarTitle.textContent = formatCalendarTitle(currentMonthDate);

        const todayKey = formatDateKey(new Date());
        const year = currentMonthDate.getFullYear();
        const month = currentMonthDate.getMonth();

        const firstDay = new Date(year, month, 1);
        const firstDayWeek = firstDay.getDay();
        const startDate = new Date(year, month, 1 - firstDayWeek);

        for (let i = 0; i < 42; i += 1) {
            const currentDate = new Date(startDate);
            currentDate.setDate(startDate.getDate() + i);

            const dateKey = formatDateKey(currentDate);
            const schedules = getSchedulesByDateKey(dateKey);
            const isOtherMonth = currentDate.getMonth() !== month;

            const dayEl = document.createElement('div');
            dayEl.className = 'calendar-day';
            if (isOtherMonth) {
                dayEl.classList.add('other-month');
            }
            if (dateKey === todayKey) {
                dayEl.classList.add('today');
            }
            if (dateKey === selectedDateKey) {
                dayEl.classList.add('selected');
            }

            let eventHtml = '';
            const maxVisible = 2;
            schedules.slice(0, maxVisible).forEach(function (item) {
                eventHtml += '<div class="event-chip">' + escapeHtml(item.title || '(제목 없음)') + '</div>';
            });

            if (schedules.length > maxVisible) {
                eventHtml += '<div class="more-text">+' + (schedules.length - maxVisible) + ' more</div>';
            }

            dayEl.innerHTML = ''
                + '<div class="day-top">'
                + '  <div class="day-number">' + currentDate.getDate() + '</div>'
                + (schedules.length > 0 ? '<div class="event-count">' + schedules.length + '</div>' : '')
                + '</div>'
                + '<div class="day-events">' + eventHtml + '</div>';

            dayEl.addEventListener('click', function () {
                if (selectedDateKey === dateKey) {
                    selectedDateKey = '';
                } else {
                    selectedDateKey = dateKey;
                }
                applyFilter();
            });

            calendarGrid.appendChild(dayEl);
        }
    }

    function moveMonth(diff) {
        currentMonthDate = new Date(currentMonthDate.getFullYear(), currentMonthDate.getMonth() + diff, 1);
        renderCalendar();
    }

    function goToday() {
        currentMonthDate = new Date();
        selectedDateKey = formatDateKey(new Date());
        applyFilter();
    }

    function escapeHtml(value) {
        return String(value)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;');
    }

    async function loadSchedules() {
        const response = await fetch('/api/schedules');
        const result = await response.json();

        if (!result.success) {
            allSchedules = [];
            filteredSchedules = [];
            renderTable();
            renderCalendar();
            updateSummary([]);
            return;
        }

        allSchedules = result.data || [];
        applyFilter();
    }

    async function editSchedule(scheduleId) {
        const response = await fetch('/api/schedules/' + scheduleId);
        const result = await response.json();

        if (!result.success) {
            alert(result.message || '조회에 실패했습니다.');
            return;
        }

        const item = result.data;
        document.getElementById('scheduleId').value = item.scheduleId;
        document.getElementById('title').value = item.title || '';
        document.getElementById('content').value = item.content || '';
        const start = splitDateTime(item.startDatetime);
        const end = splitDateTime(item.endDatetime);
        const alarm = splitDateTime(item.alarmDatetime);

        document.getElementById('startDate').value = start.date;
        document.getElementById('startTime').value = start.time;
        document.getElementById('endDate').value = end.date;
        document.getElementById('endTime').value = end.time;
        document.getElementById('alarmDate').value = alarm.date;
        document.getElementById('alarmTime').value = alarm.time;

        if (item.startDatetime) {
            const editDate = new Date(item.startDatetime);
            currentMonthDate = new Date(editDate.getFullYear(), editDate.getMonth(), 1);
            selectedDateKey = formatDateKey(editDate);
            applyFilter();
        }

        window.scrollTo({ top: 0, behavior: 'smooth' });
    }

    async function deleteSchedule(scheduleId) {
        if (!confirm('해당 일정을 삭제하시겠습니까?')) {
            return;
        }

        const response = await fetch('/api/schedules/' + scheduleId, {
            method: 'DELETE'
        });

        const result = await response.json();
        alert(result.message || '처리가 완료되었습니다.');

        if (result.success) {
            resetForm();
            loadSchedules();
        }
    }

    function resetForm() {
        document.getElementById('scheduleId').value = '';
        document.getElementById('scheduleForm').reset();
        document.getElementById('message').textContent = '';
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
        document.getElementById('message').textContent = result.message || '처리가 완료되었습니다.';

        if (result.success) {
            resetForm();
            await loadSchedules();
        }
    });

    document.addEventListener('DOMContentLoaded', async function () {
        try {
            renderCalendar();
            await loadSchedules();
        } catch (e) {
            console.error('초기 로딩 실패', e);
            document.getElementById('scheduleBody').innerHTML = '<tr class="empty-row"><td colspan="7">초기 로딩에 실패했습니다.</td></tr>';
        }
    });
    function combineDateTime(dateValue, timeValue) {
        if (!dateValue || !timeValue) return null;
        return dateValue + 'T' + timeValue + ':00';
    }

    function splitDateTime(value) {
        if (!value || value.length < 16) {
            return { date: '', time: '' };
        }

        return {
            date: value.substring(0, 10),
            time: value.substring(11, 16)
        };
    }
</script>
</body>
</html>