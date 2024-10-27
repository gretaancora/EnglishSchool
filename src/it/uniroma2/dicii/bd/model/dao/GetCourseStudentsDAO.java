package it.uniroma2.dicii.bd.model.dao;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.domain.Level;
import it.uniroma2.dicii.bd.model.domain.Student;
import it.uniroma2.dicii.bd.model.domain.StudentList;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;


public class GetCourseStudentsDAO implements GenericProcedureDAO{
    @Override
    public Object execute(Object... params) throws DAOException {
        Level level = (Level) params[0];
        short course = (short) params[1];
        var students = new StudentList();

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call lista_studenti_corso(?,?)}");
            cs.setString(1, level.name());
            cs.setShort(2, course);
            boolean status = cs.execute();

            if(status) {
                ResultSet rs = cs.getResultSet();
                while (rs.next()) {
                    Student student = new Student(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6));
                    students.addStudent(student);
                }
            }

        } catch(SQLException e) {
            throw new DAOException("Get course students error: " + e.getMessage());
        }

        return students;
    }
}
