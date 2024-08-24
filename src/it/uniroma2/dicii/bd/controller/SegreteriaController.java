package it.uniroma2.dicii.bd.controller;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.dao.*;
import it.uniroma2.dicii.bd.model.domain.*;
import it.uniroma2.dicii.bd.view.SegreteriaView;

import java.io.IOException;
import java.sql.SQLException;

public class SegreteriaController implements Controller{
    @Override
    public void start() {
        try {
            ConnectionFactory.changeRole(Role.SEGRETERIA);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        while(true){
            int choice;
            try {
                choice = SegreteriaView.showMenu();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

            switch (choice) {
                case 1 -> addCourse();
                case 2 -> addLesson();
                case 3 -> addTeacher();
                case 4 -> addStudent();
                case 5 -> listStudentCourses();
                case 6 -> enrollStudent();
                case 7 -> recordsAbsence();
                case 8 -> listActiveCourses();
                case 9 -> updateCourseEnd();
                case 10 -> teacherReport();
                case 11 -> lessonsReport();
                case 12 -> System.exit(0);
                default -> throw new RuntimeException("Invalid choice");
            }
        }
    }

    public void addCourse() {
        Course course = SegreteriaView.getCourseInfo();
        //controlla come gestire l'eccezione
        try {
            new AddCourseProcedureDAO().execute(course);
        } catch (DAOException e) {
            throw new RuntimeException(e);
        }
    }

    public void addLesson(){
        Lesson lesson = SegreteriaView.getLessonInfo();
        try {
            new AddLessonProcedureDAO().execute(lesson);
        } catch (DAOException e) {
            throw new RuntimeException(e);
        }
    }

    public void addTeacher() {
        Teacher teacher = SegreteriaView.getTeacherInfo();
        try {
            new AddTeacherProcedureDAO().execute(teacher);
        } catch (DAOException e) {
            throw new RuntimeException(e);
        }
    }

    public void addStudent() {
        Student student = SegreteriaView.getStudentInfo();
        try {
            new AddStudentProcedureDAO().execute(student);
        } catch (DAOException e) {
            throw new RuntimeException(e);
        }
    }

    public void listStudentCourses() {}

    public void enrollStudent() {
        Enrollment enrollment = SegreteriaView.getEnrollmentInfo();
        try {
            new EnrollmentProcedureDAO().execute(enrollment);
        } catch (DAOException e) {
            throw new RuntimeException(e);
        }
    }

    public void recordsAbsence(){}

    public void listActiveCourses() {}

    public void updateCourseEnd(){}

    public void teacherReport(){}

    public void lessonsReport(){}

}
