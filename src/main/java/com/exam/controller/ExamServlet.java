package com.exam.controller;

import com.exam.dao.ExamDAO;
import com.exam.model.ExamResult;
import com.exam.model.Question;
import com.exam.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/exam")
public class ExamServlet extends HttpServlet {
    private ExamDAO examDAO;

    @Override
    public void init() {
        examDAO = new ExamDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession();
        
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            userId = 1; // Default candidate
            User user = examDAO.getUserById(userId);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userName", user.getFullName());
            session.setAttribute("uidNo", user.getUidNo());
            session.setAttribute("classSection", user.getClassSection());
        }

        if ("history".equals(action)) {
            List<ExamResult> history = examDAO.getScoreHistory(userId);
            req.setAttribute("history", history);
            req.getRequestDispatcher("/score_history.jsp").forward(req, resp);
        } else if ("create".equals(action)) {
            req.getRequestDispatcher("/create_exam.jsp").forward(req, resp);
        } else {
            // Default: Launch Active Exam Test
            int examId = req.getParameter("examId") != null ? Integer.parseInt(req.getParameter("examId")) : 1;
            List<Question> questions = examDAO.getQuestionsForExam(examId);
            req.setAttribute("questions", questions);
            req.setAttribute("examId", examId);
            req.setAttribute("durationMinutes", 15);
            req.getRequestDispatcher("/exam_test.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession();
        int userId = (session.getAttribute("userId") != null) ? (Integer) session.getAttribute("userId") : 1;

        if ("createExam".equals(action)) {
            String title = req.getParameter("title");
            String subject = req.getParameter("subject");
            int duration = Integer.parseInt(req.getParameter("duration"));
            int totalMarks = Integer.parseInt(req.getParameter("totalMarks"));
            int passMarks = Integer.parseInt(req.getParameter("passMarks"));

            String questionText = req.getParameter("questionText");
            String optA = req.getParameter("optA");
            String optB = req.getParameter("optB");
            String optC = req.getParameter("optC");
            String optD = req.getParameter("optD");
            String correctOpt = req.getParameter("correctOpt");

            examDAO.createNewExamWithQuestion(title, subject, duration, totalMarks, passMarks, questionText, optA, optB, optC, optD, correctOpt);
            resp.sendRedirect("exam?msg=Exam+Created+Successfully");
            return;
        }

        // Submitting Exam
        int examId = Integer.parseInt(req.getParameter("examId"));
        List<Question> questions = examDAO.getQuestionsForExam(examId);

        int totalQuestions = questions.size();
        int attempted = 0;
        int correctCount = 0;
        int obtainedMarks = 0;
        int maxMarks = 0;

        for (Question q : questions) {
            maxMarks += q.getMarks();
            String submittedAns = req.getParameter("q_" + q.getQuestionId());
            if (submittedAns != null && !submittedAns.trim().isEmpty()) {
                attempted++;
                if (submittedAns.equalsIgnoreCase(q.getCorrectOption())) {
                    correctCount++;
                    obtainedMarks += q.getMarks();
                }
            }
        }

        double percentage = (maxMarks > 0) ? ((double) obtainedMarks / maxMarks) * 100.0 : 0.0;
        percentage = Math.round(percentage * 10.0) / 10.0;
        String status = (percentage >= 40.0) ? "PASSED" : "FAILED";

        examDAO.saveExamResult(userId, examId, totalQuestions, attempted, correctCount, obtainedMarks, percentage, status);

        req.setAttribute("totalQuestions", totalQuestions);
        req.setAttribute("attempted", attempted);
        req.setAttribute("correctCount", correctCount);
        req.setAttribute("obtainedMarks", obtainedMarks);
        req.setAttribute("maxMarks", maxMarks);
        req.setAttribute("percentage", percentage);
        req.setAttribute("status", status);

        req.getRequestDispatcher("/exam_result.jsp").forward(req, resp);
    }
}
