package it.uniroma2.dicii.bd.model.dao;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.domain.Lesson;

import java.sql.*;

public class AddLessonProcedureDAO implements GenericProcedureDAO {

    @Override
    public Object execute(Object... params) throws DAOException {
        Lesson lesson = (Lesson) params[0];

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call aggiungi_lezione(?,?,?,?,?,?)}");
            cs.setString(1, lesson.getInsegnante());
            cs.setDate(2, Date.valueOf(lesson.getDataLezione()));
            cs.setTime(3, Time.valueOf(lesson.getOraInizio()));
            cs.setTime(4, Time.valueOf(lesson.getOraFine()));
            cs.setString(5, lesson.getLivelloCorso().name());
            cs.setInt(6, lesson.getCorso());
            cs.executeQuery();
        } catch(SQLException e) {
            throw new DAOException("Add lesson error: " + e.getMessage());
        }
        //mi dovrebbe ritornare un oggetto dalla firma ma in questo caso non serve
        return 0;
    }
}
