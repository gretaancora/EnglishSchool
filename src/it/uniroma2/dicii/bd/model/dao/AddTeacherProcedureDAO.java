package it.uniroma2.dicii.bd.model.dao;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.domain.Teacher;

import java.sql.*;

public class AddTeacherProcedureDAO implements GenericProcedureDAO{
    @Override
    public Object execute(Object... params) throws DAOException{
        Teacher teacher = (Teacher) params[0];

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call aggiungi_insegnante(?,?,?,?,?,?)}");
            cs.setString(1, teacher.getNome());
            cs.setString(2, teacher.getCognome());
            cs.setString(3, teacher.getIndirizzo());
            cs.setString(4, teacher.getMail());
            cs.setString(5, teacher.getNazione());
            cs.registerOutParameter(6, Types.VARCHAR);
            cs.executeQuery();
            String idInsegnante = cs.getString(6);
            System.out.println("Teacher id: " + idInsegnante);

        } catch(SQLException e) {
            throw new DAOException("Add teacher error: " + e.getMessage());
        }
        //mi dovrebbe ritornare un oggetto dalla firma ma in questo caso non serve
        return 0;
    }
}
