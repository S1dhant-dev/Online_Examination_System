package com.exam.dao;

import com.exam.model.ExamResult;
import com.exam.model.Question;
import com.exam.model.User;
import com.exam.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ExamDAO {

    public User getUserById(int userId) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("full_name"),
                        rs.getString("uid_no"),
                        rs.getString("class_section"),
                        rs.getString("role")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new User(1, "student", "Sidhant", "21MCI10087", "MCA (AI & ML) - Sec 4", "STUDENT");
    }

    public List<Question> getQuestionsForExam(int examId) {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM questions WHERE exam_id = ? ORDER BY question_id ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, examId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    questions.add(new Question(
                        rs.getInt("question_id"),
                        rs.getInt("exam_id"),
                        rs.getString("question_text"),
                        rs.getString("option_a"),
                        rs.getString("option_b"),
                        rs.getString("option_c"),
                        rs.getString("option_d"),
                        rs.getString("correct_option"),
                        rs.getInt("marks")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return questions;
    }

    public boolean createNewExamWithQuestion(String title, String subject, int duration, int totalMarks, int passMarks,
                                            String questionText, String optA, String optB, String optC, String optD, String correctOpt) {
        String examSql = "INSERT INTO exams (title, subject, duration_minutes, total_marks, passing_marks) VALUES (?, ?, ?, ?, ?)";
        String qSql = "INSERT INTO questions (exam_id, question_text, option_a, option_b, option_c, option_d, correct_option, marks) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            int generatedExamId = 0;
            try (PreparedStatement psExam = conn.prepareStatement(examSql, Statement.RETURN_GENERATED_KEYS)) {
                psExam.setString(1, title);
                psExam.setString(2, subject);
                psExam.setInt(3, duration);
                psExam.setInt(4, totalMarks);
                psExam.setInt(5, passMarks);
                psExam.executeUpdate();
                ResultSet rs = psExam.getGeneratedKeys();
                if (rs.next()) {
                    generatedExamId = rs.getInt(1);
                }
            }

            if (generatedExamId > 0 && questionText != null && !questionText.trim().isEmpty()) {
                try (PreparedStatement psQ = conn.prepareStatement(qSql)) {
                    psQ.setInt(1, generatedExamId);
                    psQ.setString(2, questionText);
                    psQ.setString(3, optA);
                    psQ.setString(4, optB);
                    psQ.setString(5, optC);
                    psQ.setString(6, optD);
                    psQ.setString(7, correctOpt);
                    psQ.setInt(8, 2);
                    psQ.executeUpdate();
                }
            }
            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean saveExamResult(int userId, int examId, int totalQuestions, int attempted, int correctCount, int obtainedMarks, double percentage, String status) {
        String sql = "INSERT INTO exam_results (user_id, exam_id, total_questions, attempted, correct_answers, obtained_marks, percentage, status, attempted_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, examId);
            ps.setInt(3, totalQuestions);
            ps.setInt(4, attempted);
            ps.setInt(5, correctCount);
            ps.setInt(6, obtainedMarks);
            ps.setDouble(7, percentage);
            ps.setString(8, status);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<ExamResult> getScoreHistory(int userId) {
        List<ExamResult> history = new ArrayList<>();
        String sql = "SELECT r.*, e.title AS exam_title, e.total_marks AS exam_total_marks FROM exam_results r " +
                     "JOIN exams e ON r.exam_id = e.exam_id " +
                     "WHERE r.user_id = ? ORDER BY r.attempted_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    history.add(new ExamResult(
                        rs.getInt("result_id"),
                        rs.getInt("user_id"),
                        rs.getString("exam_title"),
                        rs.getInt("total_questions"),
                        rs.getInt("attempted"),
                        rs.getInt("correct_answers"),
                        rs.getInt("obtained_marks"),
                        rs.getInt("exam_total_marks"),
                        rs.getDouble("percentage"),
                        rs.getString("status"),
                        rs.getTimestamp("attempted_at")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return history;
    }
}
