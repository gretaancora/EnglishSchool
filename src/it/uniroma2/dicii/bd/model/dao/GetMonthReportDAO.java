package it.uniroma2.dicii.bd.model.dao;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.domain.Lesson;
import it.uniroma2.dicii.bd.model.domain.LessonsList;
import it.uniroma2.dicii.bd.model.domain.Level;

import java.sql.*;
import java.time.LocalDate;

public class GetMonthReportDAO implements GenericProcedureDAO{
    @Override
    public Object execute(Object... params) throws DAOException {
        LocalDate date = (LocalDate) params[0];
        var lessons = new LessonsList();

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call report_mensile_lezioni(?)}");
            cs.setDate(1, Date.valueOf(date));
            boolean status = cs.execute();

            if(status) {
                ResultSet rs = cs.getResultSet();
                while (rs.next()) {
                    Lesson lesson = new Lesson(rs.getString(1), rs.getDate(2).toLocalDate(), rs.getTime(3).toLocalTime(), rs.getTime(4).toLocalTime(), Level.valueOf(rs.getString(5)), rs.getInt(6));
                    lessons.addLesson(lesson);
                }
            }

        } catch(SQLException e) {
            throw new DAOException("Month report error: " + e.getMessage());
        }

        return lessons;
    }
}
