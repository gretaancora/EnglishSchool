package it.uniroma2.dicii.bd.model.dao;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.domain.Course;
import it.uniroma2.dicii.bd.model.domain.CoursesList;
import it.uniroma2.dicii.bd.model.domain.Level;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;


public class GetCoursesListDAO implements GenericProcedureDAO{
    @Override
    public Object execute(Object... params) throws DAOException{
        var courses = new CoursesList();

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call lista_corsi()}");
            boolean status = cs.execute();

            if(status) {
                ResultSet rs = cs.getResultSet();
                while (rs.next()) {
                    Course course = new Course(Level.valueOf(rs.getString(1)), rs.getShort(2), rs.getDate(3).toLocalDate(), rs.getDate(4).toLocalDate(), rs.getShort(5));
                    courses.addCourse(course);
                }
            }

        } catch(SQLException e) {
            throw new DAOException("Get courses list error: " + e.getMessage());
        }

        return courses;
    }
}
