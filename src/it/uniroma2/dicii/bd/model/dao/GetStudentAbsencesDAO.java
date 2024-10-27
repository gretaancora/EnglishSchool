package it.uniroma2.dicii.bd.model.dao;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.domain.Absence;
import it.uniroma2.dicii.bd.model.domain.AbsenceList;
import it.uniroma2.dicii.bd.model.domain.Level;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GetStudentAbsencesDAO implements GenericProcedureDAO{
    @Override
    public Object execute(Object... params) throws DAOException {
        String id = (String) params[0];
        Level livello = (Level) params[1];
        short corso = (short) params[2];
        var abs = new AbsenceList();

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call lista_assenze_studente(?,?,?)}");
            cs.setString(1, id);
            cs.setString(2, livello.name());
            cs.setShort(3, corso);
            boolean status = cs.execute();

            if(status) {
                ResultSet rs = cs.getResultSet();
                while (rs.next()) {
                    var absence = new Absence(rs.getDate(1).toLocalDate(), rs.getTime(2).toLocalTime(), livello, corso);
                    abs.addAbsence(absence);
                }
            }

        } catch(SQLException e) {
            throw new DAOException("Get student absences error: " + e.getMessage());
        }

        return abs;

    }
}
