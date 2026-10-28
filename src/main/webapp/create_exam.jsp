<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create MCQ Test | Faculty Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8fafc; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .cu-header { background: #b31217; color: white; padding: 18px 24px; }
        .card-custom { border-radius: 12px; border: none; box-shadow: 0 4px 15px rgba(0,0,0,0.06); }
    </style>
</head>
<body>

<header class="cu-header d-flex justify-content-between align-items-center">
    <div>
        <h4 class="m-0 fw-bold">CHANDIGARH UNIVERSITY | Examination Management</h4>
        <small>Faculty Portal • MCQ Test Creator</small>
    </div>
    <div>
        <a href="exam" class="btn btn-outline-light">Back to Exam</a>
    </div>
</header>

<div class="container my-5" style="max-width: 800px;">
    <div class="card card-custom p-4">
        <h4 class="fw-bold mb-4 text-dark border-bottom pb-2">Create New MCQ Examination</h4>
        <form action="exam" method="post">
            <input type="hidden" name="action" value="createExam">

            <div class="mb-3">
                <label class="form-label fw-bold">Test Title:</label>
                <input type="text" name="title" class="form-control" placeholder="e.g. Mid-Term Computer Science Exam" required>
            </div>

            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <label class="form-label fw-bold">Subject / Course:</label>
                    <input type="text" name="subject" class="form-control" placeholder="e.g. Advanced Java Programming" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-bold">Duration (Minutes):</label>
                    <input type="number" name="duration" class="form-control" value="15" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-bold">Total Marks:</label>
                    <input type="number" name="totalMarks" class="form-control" value="20" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-bold">Passing Marks:</label>
                    <input type="number" name="passMarks" class="form-control" value="8" required>
                </div>
            </div>

            <h5 class="fw-bold mt-4 mb-3 text-secondary">First Question Specification</h5>
            <div class="mb-3">
                <label class="form-label fw-bold">Question Statement:</label>
                <textarea name="questionText" class="form-control" rows="2" placeholder="Enter question..." required></textarea>
            </div>

            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <label class="form-label">Option A:</label>
                    <input type="text" name="optA" class="form-control" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Option B:</label>
                    <input type="text" name="optB" class="form-control" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Option C:</label>
                    <input type="text" name="optC" class="form-control" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Option D:</label>
                    <input type="text" name="optD" class="form-control" required>
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label fw-bold">Correct Option:</label>
                <select name="correctOpt" class="form-select" required>
                    <option value="A">Option A</option>
                    <option value="B">Option B</option>
                    <option value="C">Option C</option>
                    <option value="D">Option D</option>
                </select>
            </div>

            <div class="text-end">
                <button type="submit" class="btn btn-danger px-4 py-2 fw-bold">Publish Examination</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>
