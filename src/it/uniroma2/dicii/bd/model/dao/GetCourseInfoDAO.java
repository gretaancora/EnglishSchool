package it.uniroma2.dicii.bd.model.dao;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.domain.*;

import java.sql.*;

public class GetCourseInfoDAO implements GenericProcedureDAO{
    @Override
    public Object execute(Object... params) throws DAOException {
        Level livelloCorso = (Level) params[0];
        short idCorso = (short) params[1];
        var courses = new InfoCourseList();
        int numIscr;

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call ottieni_info_corso(?,?)}");
            cs.setString(1, livelloCorso.name());
            cs.setInt(2, idCorso);
            boolean status = cs.execute();

            if(status) {
                ResultSet rs = cs.getResultSet();
                while (rs.next()) {
                    var course = new InfoCourse(rs.getDate(1).toLocalDate(), rs.getDate(2).toLocalDate(), rs.getString(3), rs.getBoolean(4), rs.getShort(5), rs.getString(6), rs.getString(7), rs.getString(8));
                    courses.addInfoCourse(course);
                }
            }

        } catch(SQLException e) {
            throw new DAOException("Get course info error: " + e.getMessage());
        }

        return courses;

    }
}
