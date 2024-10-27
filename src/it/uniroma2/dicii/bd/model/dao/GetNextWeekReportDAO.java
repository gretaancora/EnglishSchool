package it.uniroma2.dicii.bd.model.dao;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.domain.Lesson;
import it.uniroma2.dicii.bd.model.domain.LessonsList;
import it.uniroma2.dicii.bd.model.domain.Level;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GetNextWeekReportDAO implements GenericProcedureDAO{

    @Override
    public Object execute(Object... params) throws DAOException {
        String idInsegnante = (String) params[0];
        var lessons = new LessonsList();

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call report_settimana_prossima_lezioni(?)}");
            cs.setString(1, idInsegnante);
            boolean status = cs.execute();

            if(status) {
                ResultSet rs = cs.getResultSet();
                while (rs.next()) {
                    Lesson lesson = new Lesson(idInsegnante, rs.getDate(1).toLocalDate(), rs.getTime(2).toLocalTime(), rs.getTime(3).toLocalTime(), Level.valueOf(rs.getString(4)), rs.getInt(5));
                    lessons.addLesson(lesson);
                }
            }

        } catch(SQLException e) {
            throw new DAOException("Next week report error: " + e.getMessage());
        }

        return lessons;
    }
}
