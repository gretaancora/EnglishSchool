package it.uniroma2.dicii.bd.model.dao;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.domain.Course;
import it.uniroma2.dicii.bd.model.domain.Level;

import java.sql.*;

public class UpdateCourseProcedureDAO implements GenericProcedureDAO{
    @Override
    public Object execute(Object... params) throws DAOException {
        Course course = (Course) params[0];

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call aggiorna_data_fine_corso(?,?,?)}");
            cs.setString(1, course.getLevel().name());
            cs.setInt(2, course.getIdCorso());
            cs.setDate(3, Date.valueOf(course.getDataFine()));
            cs.executeQuery();
        } catch(SQLException e) {
            throw new DAOException("Update end date course error: " + e.getMessage());
        }
        //mi dovrebbe ritornare un oggetto dalla firma ma in questo caso non serve
        return 0;
    }
}
