package it.uniroma2.dicii.bd.model.dao;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.domain.InfoCourse;
import it.uniroma2.dicii.bd.model.domain.Teacher;

import java.sql.*;

public class GetTeacherInfoDAO implements GenericProcedureDAO{


    @Override
    public Object execute(Object... params) throws DAOException {
        String id = (String) params[0];
        Teacher teacher = null;

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call ottieni_info_insegnante(?)}");
            cs.setString(1, id);
            boolean status = cs.execute();

            if(status) {
                ResultSet rs = cs.getResultSet();
                while (rs.next()) {
                    teacher = new Teacher(id, rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5));
                }
            }

        } catch(SQLException e) {
            throw new DAOException("Get teacher info error: " + e.getMessage());
        }

        return teacher;
    }
}
