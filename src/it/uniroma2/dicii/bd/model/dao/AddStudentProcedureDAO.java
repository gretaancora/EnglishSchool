package it.uniroma2.dicii.bd.model.dao;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.domain.Student;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

public class AddStudentProcedureDAO implements GenericProcedureDAO{
    @Override
    public Object execute(Object... params) throws DAOException{
        Student student = (Student) params[0];

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call aggiungi_studente(?,?,?,?,?, ?)}");
            cs.setString(1, student.getNome());
            cs.setString(2, student.getCognome());
            cs.setString(3, student.getIndirizzo());
            cs.setString(4, student.getMail());
            cs.setString(5, student.getTelefono());
            cs.registerOutParameter(6, Types.VARCHAR);
            cs.executeQuery();
            String idStudente = cs.getString(6);
            System.out.println("Student id: " + idStudente);

        } catch(SQLException e) {
            throw new DAOException("Add student error: " + e.getMessage());
        }

        return 0;
    }

}
