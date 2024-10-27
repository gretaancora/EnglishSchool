package it.uniroma2.dicii.bd.model.dao;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.domain.*;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;


public class GetTeachersListDAO implements GenericProcedureDAO{
    @Override
    public Object execute(Object... params) throws DAOException {
        var teachers = new TeacherList();

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call lista_insegnanti()}");
            boolean status = cs.execute();

            if(status) {
                ResultSet rs = cs.getResultSet();
                while (rs.next()) {
                    Teacher teacher = new Teacher(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6));
                    teachers.addTeacher(teacher);
                }
            }

        } catch(SQLException e) {
            throw new DAOException("Get teacher list error: " + e.getMessage());
        }

        return teachers;
    }
}
