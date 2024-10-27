package it.uniroma2.dicii.bd.controller;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.dao.ConnectionFactory;
import it.uniroma2.dicii.bd.model.dao.GetCurrWeekReportDAO;
import it.uniroma2.dicii.bd.model.dao.GetNextWeekReportDAO;
import it.uniroma2.dicii.bd.model.domain.Credentials;
import it.uniroma2.dicii.bd.model.domain.LessonsList;
import it.uniroma2.dicii.bd.model.domain.Role;
import it.uniroma2.dicii.bd.view.InsegnanteView;
import java.io.IOException;
import java.sql.SQLException;

public class InsegnanteController implements Controller{
    private final Credentials cred;

    public InsegnanteController(Credentials cred) {
        this.cred = cred;
    }

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
                case 1 -> currWeekReport(cred.getUsername());
                case 2 -> nextWeekReport(cred.getUsername());
                case 3 -> System.exit(0);
                default -> throw new RuntimeException("Invalid choice");
            }
        }
    }

    public void currWeekReport(String id){
        LessonsList lessons;

        try {
            lessons = (LessonsList) new GetCurrWeekReportDAO().execute(id);
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
            return;
        }

        System.out.println(lessons);
    }

    public void nextWeekReport(String id){
        LessonsList lessons;

        try {
            lessons = (LessonsList) new GetNextWeekReportDAO().execute(id);
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
            return;
        }

        System.out.println(lessons);
    }

}
