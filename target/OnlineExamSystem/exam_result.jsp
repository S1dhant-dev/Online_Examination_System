<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Assessment Result Card | Chandigarh University</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8fafc; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .score-card { max-width: 680px; margin: 40px auto; border-radius: 16px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.08); overflow: hidden; background: #fff; }
        .header-pass { background: linear-gradient(135deg, #10b981, #059669); color: white; padding: 30px 20px; text-align: center; }
        .header-fail { background: linear-gradient(135deg, #ef4444, #dc2626); color: white; padding: 30px 20px; text-align: center; }
    </style>
</head>
<body>

<div class="container py-4">
    <div class="score-card">
        <div class="${status == 'PASSED' ? 'header-pass' : 'header-fail'}">
            <h2 class="fw-bold m-0">CHANDIGARH UNIVERSITY</h2>
            <p class="fs-6 mt-1 mb-0">Examination Evaluation & Grade Card</p>
            <div class="badge bg-white ${status == 'PASSED' ? 'text-success' : 'text-danger'} fs-6 mt-3 px-4 py-2 fw-bold">
                RESULT: ${status}
            </div>
        </div>

        <div class="p-4 text-center">
            <h1 class="display-3 fw-bold text-dark mb-0">${obtainedMarks} <span class="fs-4 text-muted">/ ${maxMarks}</span></h1>
            <p class="fs-5 text-muted">Score Percentage: <strong><fmt:formatNumber value="${percentage}" maxFractionDigits="1"/>%</strong></p>

            <div class="row g-3 my-3 text-start">
                <div class="col-6">
                    <div class="p-3 bg-light rounded border">
                        <small class="text-muted d-block">Candidate Name</small>
                        <strong>${sessionScope.userName}</strong>
                    </div>
                </div>
                <div class="col-6">
                    <div class="p-3 bg-light rounded border">
                        <small class="text-muted d-block">Student UID</small>
                        <strong>${sessionScope.uidNo}</strong>
                    </div>
                </div>
                <div class="col-6">
                    <div class="p-3 bg-light rounded border">
                        <small class="text-muted d-block">Total Questions</small>
                        <strong>${totalQuestions}</strong>
                    </div>
                </div>
                <div class="col-6">
                    <div class="p-3 bg-light rounded border">
                        <small class="text-muted d-block">Questions Attempted</small>
                        <strong>${attempted}</strong>
                    </div>
                </div>
                <div class="col-6">
                    <div class="p-3 bg-light rounded border">
                        <small class="text-muted d-block">Correct Answers</small>
                        <strong class="text-success">${correctCount}</strong>
                    </div>
                </div>
                <div class="col-6">
                    <div class="p-3 bg-light rounded border">
                        <small class="text-muted d-block">Incorrect / Skipped</small>
                        <strong class="text-danger">${totalQuestions - correctCount}</strong>
                    </div>
                </div>
            </div>

            <div class="d-flex justify-content-center gap-3 mt-4">
                <a href="exam?action=history" class="btn btn-outline-dark px-4 py-2">View Score History</a>
                <a href="exam" class="btn btn-danger px-4 py-2">Attempt New Test</a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
