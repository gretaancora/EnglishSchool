package it.uniroma2.dicii.bd.model.dao;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.domain.Absence;

import java.sql.*;

public class RecordAbsenceProcedureDAO implements GenericProcedureDAO{
    @Override
    public Object execute(Object... params) throws DAOException {
        Absence absence = (Absence) params[0];

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call registra_assenza(?,?,?,?)}");
            cs.setString(1, absence.getIdStudente());
            cs.setString(2, absence.getIdInsegnante());
            cs.setDate(3, Date.valueOf(absence.getDataLezione()));
            cs.setTime(4, Time.valueOf(absence.getOraInizioLezione()));
            cs.executeQuery();
        } catch(SQLException e) {
            throw new DAOException("Record absence error: " + e.getMessage());
        }
        //mi dovrebbe ritornare un oggetto dalla firma ma in questo caso non serve
        return 0;
    }
}
