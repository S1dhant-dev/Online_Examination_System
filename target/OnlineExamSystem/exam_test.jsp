<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Active Examination | Chandigarh University UIC Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f3f4f6; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .cu-header { background: linear-gradient(135deg, #b31217, #7f0000); color: white; padding: 14px 24px; box-shadow: 0 4px 10px rgba(0,0,0,0.15); }
        .timer-container { background: #fff; color: #b31217; padding: 6px 18px; border-radius: 8px; font-weight: 700; font-size: 1.25rem; border: 2px solid #ffd700; }
        .card-test { border-radius: 12px; border: none; box-shadow: 0 4px 12px rgba(0,0,0,0.06); }
        .palette-btn { width: 40px; height: 40px; font-weight: 700; margin: 4px; border-radius: 8px; }
        .opt-box { cursor: pointer; border: 1.5px solid #e2e8f0; border-radius: 8px; padding: 12px 16px; margin-bottom: 12px; transition: all 0.2s ease; background: #fff; }
        .opt-box:hover { border-color: #b31217; background-color: #fffaf0; }
    </style>
</head>
<body>

<!-- Header Banner -->
<header class="cu-header d-flex justify-content-between align-items-center">
    <div>
        <h4 class="m-0 fw-bold">CHANDIGARH UNIVERSITY | University Institute of Computing</h4>
        <small>Subject: Advanced Java Programming • Candidate: <strong>${sessionScope.userName}</strong> (UID: ${sessionScope.uidNo})</small>
    </div>
    <div class="d-flex align-items-center gap-3">
        <span class="d-none d-md-inline fw-semibold">Time Remaining:</span>
        <div id="timerDisplay" class="timer-container">15:00</div>
    </div>
</header>

<div class="container-fluid my-4 px-4">
    <form id="examForm" action="exam" method="post">
        <input type="hidden" name="examId" value="${examId}">

        <div class="row g-4">
            <!-- Question Screen -->
            <div class="col-lg-9">
                <div class="card card-test p-4">
                    <c:forEach var="q" items="${questions}" varStatus="status">
                        <div class="question-pane" id="pane_${status.index}" style="${status.index == 0 ? '' : 'display:none;'}">
                            <div class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-4">
                                <span class="badge bg-secondary fs-6">Question ${status.count} of ${questions.size()}</span>
                                <span class="text-danger fw-bold">+${q.marks} Marks</span>
                            </div>

                            <h5 class="fw-bold text-dark mb-4">${q.questionText}</h5>

                            <div class="opt-box" onclick="selectRadio('${q.questionId}', 'A', ${status.index})">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="q_${q.questionId}" id="optA_${q.questionId}" value="A" onchange="markAnswered(${status.index})">
                                    <label class="form-check-label w-100" for="optA_${q.questionId}"><strong>(A)</strong> ${q.optionA}</label>
                                </div>
                            </div>
                            <div class="opt-box" onclick="selectRadio('${q.questionId}', 'B', ${status.index})">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="q_${q.questionId}" id="optB_${q.questionId}" value="B" onchange="markAnswered(${status.index})">
                                    <label class="form-check-label w-100" for="optB_${q.questionId}"><strong>(B)</strong> ${q.optionB}</label>
                                </div>
                            </div>
                            <div class="opt-box" onclick="selectRadio('${q.questionId}', 'C', ${status.index})">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="q_${q.questionId}" id="optC_${q.questionId}" value="C" onchange="markAnswered(${status.index})">
                                    <label class="form-check-label w-100" for="optC_${q.questionId}"><strong>(C)</strong> ${q.optionC}</label>
                                </div>
                            </div>
                            <div class="opt-box" onclick="selectRadio('${q.questionId}', 'D', ${status.index})">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="q_${q.questionId}" id="optD_${q.questionId}" value="D" onchange="markAnswered(${status.index})">
                                    <label class="form-check-label w-100" for="optD_${q.questionId}"><strong>(D)</strong> ${q.optionD}</label>
                                </div>
                            </div>

                            <div class="d-flex justify-content-between align-items-center mt-4 pt-3 border-top">
                                <button type="button" class="btn btn-outline-secondary" onclick="prevQ(${status.index})" ${status.first ? 'disabled' : ''}>Previous</button>
                                <div>
                                    <button type="button" class="btn btn-warning me-2" onclick="markReview(${status.index})">Mark for Review</button>
                                    <button type="button" class="btn btn-primary" onclick="nextQ(${status.index})" ${status.last ? 'style="display:none;"' : ''}>Save & Next</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Question Palette Sidebar -->
            <div class="col-lg-3">
                <div class="card card-test p-3">
                    <h6 class="fw-bold border-bottom pb-2 mb-3">Question Palette</h6>
                    <div class="d-flex flex-wrap justify-content-start mb-3">
                        <c:forEach var="q" items="${questions}" varStatus="status">
                            <button type="button" class="btn btn-outline-secondary palette-btn" id="pal_${status.index}" onclick="jumpTo(${status.index})">
                                ${status.count}
                            </button>
                        </c:forEach>
                    </div>

                    <div class="small text-muted border-top pt-2">
                        <div class="mb-1"><span class="badge bg-success">&nbsp;&nbsp;</span> Answered</div>
                        <div class="mb-1"><span class="badge bg-primary">&nbsp;&nbsp;</span> Active / Current</div>
                        <div class="mb-1"><span class="badge bg-warning text-dark">&nbsp;&nbsp;</span> Marked for Review</div>
                        <div class="mb-1"><span class="badge bg-secondary">&nbsp;&nbsp;</span> Not Visited</div>
                    </div>

                    <hr>
                    <button type="submit" class="btn btn-danger w-100 py-2 fw-bold" onclick="return confirm('Are you sure you want to finalize and submit the exam?');">Submit & Finish Exam</button>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    let currentIdx = 0;
    const totalQ = ${questions.size()};

    function selectRadio(qid, val, idx) {
        document.getElementById('opt' + val + '_' + qid).checked = true;
        markAnswered(idx);
    }

    function jumpTo(targetIdx) {
        document.getElementById('pane_' + currentIdx).style.display = 'none';
        currentIdx = targetIdx;
        document.getElementById('pane_' + currentIdx).style.display = 'block';
    }

    function nextQ(idx) {
        if (idx < totalQ - 1) jumpTo(idx + 1);
    }
    function prevQ(idx) {
        if (idx > 0) jumpTo(idx - 1);
    }
    function markAnswered(idx) {
        const btn = document.getElementById('pal_' + idx);
        btn.className = 'btn palette-btn btn-success text-white';
    }
    function markReview(idx) {
        const btn = document.getElementById('pal_' + idx);
        btn.className = 'btn palette-btn btn-warning text-dark';
        if (idx < totalQ - 1) nextQ(idx);
    }

    // 15-Minute Countdown Timer with Automatic Lock & Auto-Submit
    let timeRemaining = ${durationMinutes} * 60;
    const timerElem = document.getElementById('timerDisplay');
    const examForm = document.getElementById('examForm');

    const timerInterval = setInterval(() => {
        let mins = Math.floor(timeRemaining / 60);
        let secs = timeRemaining % 60;
        mins = mins < 10 ? '0' + mins : mins;
        secs = secs < 10 ? '0' + secs : secs;
        timerElem.innerText = mins + ':' + secs;

        if (timeRemaining <= 120) {
            timerElem.style.borderColor = '#dc3545';
            timerElem.style.backgroundColor = '#ffeef0';
        }

        if (timeRemaining <= 0) {
            clearInterval(timerInterval);
            alert('Examination time expired! Auto-submitting responses.');
            examForm.submit();
        }
        timeRemaining--;
    }, 1000);
</script>
</body>
</html>
