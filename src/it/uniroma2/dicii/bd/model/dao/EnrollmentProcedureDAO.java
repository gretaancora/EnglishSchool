package it.uniroma2.dicii.bd.model.dao;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.domain.Enrollment;
import java.sql.*;

public class EnrollmentProcedureDAO implements GenericProcedureDAO {

    @Override
    public Object execute(Object... params) throws DAOException{
        Enrollment enrollment = (Enrollment) params[0];

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call registra_iscrizione(?,?,?,?,?)}");
            cs.setString(1, enrollment.getStudente());
            cs.setInt(2, enrollment.getLivelloCorso());
            cs.setInt(3, enrollment.getCorso());
            cs.setDate(4, Date.valueOf(enrollment.getDataIscrizione()));
            cs.executeQuery();
        } catch(SQLException e) {
            throw new DAOException("Enrollment error: " + e.getMessage());
        }
        //mi dovrebbe ritornare un oggetto dalla firma ma in questo caso non serve
        return 0;
    }
}
