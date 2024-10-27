package it.uniroma2.dicii.bd.model.dao;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.domain.*;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;


public class GetLivelliListDAO implements GenericProcedureDAO{
    @Override
    public Object execute(Object... params) throws DAOException {
        var livelli = new LivelloList();

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call lista_livelli()}");
            boolean status = cs.execute();

            if(status) {
                ResultSet rs = cs.getResultSet();
                while (rs.next()) {
                    Livello livello = new Livello(Level.valueOf(rs.getString(1)), rs.getString(2), rs.getBoolean(3));
                    livelli.addLivello(livello);
                }
            }

        } catch(SQLException e) {
            throw new DAOException("Get levels list error: " + e.getMessage());
        }

        return livelli;
    }
}
