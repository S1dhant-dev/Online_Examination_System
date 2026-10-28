package com.exam.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.stream.Collectors;

public class DBConnection {
    private static final String URL = "jdbc:h2:mem:online_exam_db;MODE=MySQL;DB_CLOSE_DELAY=-1;DATABASE_TO_UPPER=false";
    private static final String USER = "sa";
    private static final String PASSWORD = "";
    private static volatile boolean initialized = false;

    public static Connection getConnection() {
        try {
            Class.forName("org.h2.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            initializeSchema(conn);
            return conn;
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Database Connection Error: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    private static synchronized void initializeSchema(Connection conn) throws SQLException {
        if (initialized) {
            return;
        }

        try (InputStream is = DBConnection.class.getClassLoader().getResourceAsStream("schema.sql");
             Statement stmt = conn.createStatement()) {
            if (is == null) {
                throw new SQLException("schema.sql not found on classpath");
            }
            String sql = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))
                    .lines()
                    .collect(Collectors.joining(System.lineSeparator()));
            stmt.execute(sql);
            initialized = true;
        } catch (IOException e) {
            throw new SQLException("Unable to load schema.sql", e);
        }
    }
}
