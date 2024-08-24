package it.uniroma2.dicii.bd.controller;

import it.uniroma2.dicii.bd.model.dao.ConnectionFactory;
import it.uniroma2.dicii.bd.model.domain.Role;
import it.uniroma2.dicii.bd.view.InsegnanteView;
import java.io.IOException;
import java.sql.SQLException;

public class InsegnanteController implements Controller{
    @Override
    public void start() {
        try {
            ConnectionFactory.changeRole(Role.INSEGNANTE);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        while(true){
            int choice;
            try {
                choice = InsegnanteView.showMenu();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

            switch (choice) {
                case 1 -> currWeekReport();
                case 2 -> nextWeekReport();
                case 3 -> System.exit(0);
                default -> throw new RuntimeException("Invalid choice");
            }
        }
    }

    public void currWeekReport(){}

    public void nextWeekReport(){}
}
