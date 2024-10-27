package it.uniroma2.dicii.bd.model.dao;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.domain.Student;
import it.uniroma2.dicii.bd.model.domain.Teacher;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GetStudentInfoDAO implements GenericProcedureDAO{
    @Override
    public Object execute(Object... params) throws DAOException{
        String id = (String) params[0];
        Student student = null;

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call ottieni_info_studente(?)}");
            cs.setString(1, id);
            boolean status = cs.execute();

            if(status) {
                ResultSet rs = cs.getResultSet();
                while (rs.next()) {
                    student = new Student(id, rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5));
                }
            }

        } catch(SQLException e) {
            throw new DAOException("Get student info error: " + e.getMessage());
        }

        return student;
    }
}
