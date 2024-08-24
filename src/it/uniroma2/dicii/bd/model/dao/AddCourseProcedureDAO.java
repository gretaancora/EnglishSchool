package it.uniroma2.dicii.bd.model.dao;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.domain.Course;

import java.sql.*;

public class AddCourseProcedureDAO implements GenericProcedureDAO{

    @Override
    public Object execute(Object... params) throws DAOException {
        Course course = (Course) params[0];

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call aggiungi_corso(?,?,?)}");
            cs.setInt(1, course.getLevel());
            cs.setDate(2, Date.valueOf(course.getDataInizio()));
            cs.setDate(3, Date.valueOf(course.getDataFine()));
            cs.executeQuery();
        } catch(SQLException e) {
            throw new DAOException("Login error: " + e.getMessage());
        }
        //mi dovrebbe ritornare un oggetto dalla firma ma in questo caso non serve
        return 0;
    }
}
