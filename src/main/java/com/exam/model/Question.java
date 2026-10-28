package com.exam.model;

public class Question {
    private int questionId;
    private int examId;
    private String questionText;
    private String optionA;
    private String optionB;
    private String optionC;
    private String optionD;
    private String correctOption;
    private int marks;

    public Question() {}

    public Question(int questionId, int examId, String questionText, String optionA, String optionB, String optionC, String optionD, String correctOption, int marks) {
        this.questionId = questionId;
        this.examId = examId;
        this.questionText = questionText;
        this.optionA = optionA;
        this.optionB = optionB;
        this.optionC = optionC;
        this.optionD = optionD;
        this.correctOption = correctOption;
        this.marks = marks;
    }

    public int getQuestionId() { return questionId; }
    public int getExamId() { return examId; }
    public String getQuestionText() { return questionText; }
    public String getOptionA() { return optionA; }
    public String getOptionB() { return optionB; }
    public String getOptionC() { return optionC; }
    public String getOptionD() { return optionD; }
    public String getCorrectOption() { return correctOption; }
    public int getMarks() { return marks; }
}
