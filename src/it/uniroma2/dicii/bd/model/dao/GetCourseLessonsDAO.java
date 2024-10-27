package it.uniroma2.dicii.bd.model.dao;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.domain.Lesson;
import it.uniroma2.dicii.bd.model.domain.LessonsList;
import it.uniroma2.dicii.bd.model.domain.Level;

import java.sql.*;


public class GetCourseLessonsDAO implements GenericProcedureDAO{
    @Override
    public Object execute(Object... params) throws DAOException {
        Level livello = (Level) params[0];
        short corso = (short) params[1];

        var lessons = new LessonsList();

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call lista_lezioni_corso(?,?)}");
            cs.setString(1, livello.name());
            cs.setInt(2, corso);
            boolean status = cs.execute();

            if(status) {
                ResultSet rs = cs.getResultSet();
                while (rs.next()) {
                    Lesson lesson = new Lesson(rs.getString(1), rs.getDate(2).toLocalDate(), rs.getTime(3).toLocalTime(), rs.getTime(4).toLocalTime(), livello, corso);
                    lessons.addLesson(lesson);
                }
            }

        } catch(SQLException e) {
            throw new DAOException("Get course lessons error: " + e.getMessage());
        }

        return lessons;
    }
}
