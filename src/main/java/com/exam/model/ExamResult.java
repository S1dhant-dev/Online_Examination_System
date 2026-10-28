package com.exam.model;

import java.sql.Timestamp;

public class ExamResult {
    private int resultId;
    private int userId;
    private String examTitle;
    private int totalQuestions;
    private int attempted;
    private int correctAnswers;
    private int obtainedMarks;
    private int totalMarks;
    private double percentage;
    private String status;
    private Timestamp attemptedAt;

    public ExamResult() {}

    public ExamResult(int resultId, int userId, String examTitle, int totalQuestions, int attempted, int correctAnswers, int obtainedMarks, int totalMarks, double percentage, String status, Timestamp attemptedAt) {
        this.resultId = resultId;
        this.userId = userId;
        this.examTitle = examTitle;
        this.totalQuestions = totalQuestions;
        this.attempted = attempted;
        this.correctAnswers = correctAnswers;
        this.obtainedMarks = obtainedMarks;
        this.totalMarks = totalMarks;
        this.percentage = percentage;
        this.status = status;
        this.attemptedAt = attemptedAt;
    }

    public int getResultId() { return resultId; }
    public int getUserId() { return userId; }
    public String getExamTitle() { return examTitle; }
    public int getTotalQuestions() { return totalQuestions; }
    public int getAttempted() { return attempted; }
    public int getCorrectAnswers() { return correctAnswers; }
    public int getObtainedMarks() { return obtainedMarks; }
    public int getTotalMarks() { return totalMarks; }
    public double getPercentage() { return percentage; }
    public String getStatus() { return status; }
    public Timestamp getAttemptedAt() { return attemptedAt; }
}
