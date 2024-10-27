package it.uniroma2.dicii.bd.model.dao;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.domain.*;

import java.sql.*;
//aggiornato cambiamento id
public class GetStudentCoursesDAO implements GenericProcedureDAO{
    @Override
    public Object execute(Object... params) throws DAOException {
        String idStudente = (String) params[0];
        var enrollments = new EnrollmentList();

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call lista_iscrizioni_studente(?)}");
            cs.setString(1, idStudente);
            boolean status = cs.execute();

            if(status) {
                ResultSet rs = cs.getResultSet();
                while (rs.next()) {
                     Enrollment enr = new Enrollment(idStudente, Level.valueOf(rs.getString(1)), rs.getInt(2), rs.getDate(3).toLocalDate());
                    enrollments.addEnrollment(enr);
                }
            }

        } catch(SQLException e) {
            throw new DAOException("Get student courses error: " + e.getMessage());
        }

        return enrollments;
    }
}
