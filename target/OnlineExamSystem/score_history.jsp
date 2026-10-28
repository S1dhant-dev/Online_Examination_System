<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Score History | UIC Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8fafc; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .cu-header { background: #b31217; color: white; padding: 18px 24px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
    </style>
</head>
<body>

<header class="cu-header d-flex justify-content-between align-items-center">
    <div>
        <h4 class="m-0 fw-bold">CHANDIGARH UNIVERSITY | Examination Portal</h4>
        <small>Candidate: <strong>${sessionScope.userName}</strong> (UID: ${sessionScope.uidNo}) | Section: ${sessionScope.classSection}</small>
    </div>
    <div>
        <a href="exam" class="btn btn-light fw-bold text-danger me-2">+ Take Exam</a>
        <a href="exam?action=create" class="btn btn-outline-light">Admin: Create Test</a>
    </div>
</header>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="fw-bold text-dark m-0">Student Examination Score History & Analytics</h4>
        <span class="badge bg-danger fs-6">Persistent MySQL Records</span>
    </div>

    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>Attempt #</th>
                            <th>Assessment Title</th>
                            <th>Attempt Timestamp</th>
                            <th>Total Questions</th>
                            <th>Attempted</th>
                            <th>Correct</th>
                            <th>Score</th>
                            <th>Percentage</th>
                            <th>Evaluation</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${history}">
                            <tr>
                                <td class="fw-bold">#${item.resultId}</td>
                                <td class="fw-semibold">${item.examTitle}</td>
                                <td><fmt:formatDate value="${item.attemptedAt}" pattern="dd MMM yyyy, hh:mm a"/></td>
                                <td>${item.totalQuestions}</td>
                                <td>${item.attempted}</td>
                                <td class="text-success fw-bold">${item.correctAnswers}</td>
                                <td class="fw-bold">${item.obtainedMarks} / ${item.totalMarks}</td>
                                <td><fmt:formatNumber value="${item.percentage}" maxFractionDigits="1"/>%</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.status == 'PASSED'}">
                                            <span class="badge bg-success">PASSED</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-danger">FAILED</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
</html>
