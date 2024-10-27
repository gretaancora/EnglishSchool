package it.uniroma2.dicii.bd.model.dao;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.domain.Level;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;


public class AssignCourseDAO implements GenericProcedureDAO{

    @Override
    public Object execute(Object... params) throws DAOException {
        String id = (String) params[0];
        Level lev = (Level) params[1];
        short cor = (short) params[2];

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call assegna_corso(?,?,?)}");
            cs.setString(1, id);
            cs.setString(2, lev.name());
            cs.setInt(3, cor);
            cs.executeQuery();

        } catch(SQLException e) {
            throw new DAOException("Assign course error: " + e.getMessage());
        }
        //mi dovrebbe ritornare un oggetto dalla firma ma in questo caso non serve
        return 0;
    }
}
