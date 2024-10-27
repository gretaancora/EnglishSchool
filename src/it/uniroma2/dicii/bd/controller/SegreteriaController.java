package it.uniroma2.dicii.bd.controller;

import it.uniroma2.dicii.bd.exception.DAOException;
import it.uniroma2.dicii.bd.model.dao.*;
import it.uniroma2.dicii.bd.model.domain.*;
import it.uniroma2.dicii.bd.view.SegreteriaView;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Objects;

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
                case 5 -> assignCourse();
                case 6 -> enrollStudent();
                case 7 -> recordsAbsence();
                case 8 -> getCourseInfo();
                case 9 -> getTeacherInfo();
                case 10 -> getStudentInfo();
                case 11 -> getStudentAbsences();
                case 12 -> listStudentCourses();
                case 13 -> getCourseLessons();
                case 14 -> getTeacherCourses();
                case 15 -> updateCourseEnd();
                case 16 -> teacherReport();
                case 17 -> lessonsReport();
                case 18 -> coursesList();
                case 19 -> teacherList();
                case 20 -> studentList();
                case 21 -> getCourseStudents();
                case 22 -> levelList();
                case 23 -> System.exit(0);
                default -> throw new RuntimeException("Invalid choice");
            }
        }
    }

    public void addCourse() {
        Course course = SegreteriaView.getCourseInfo();
        try {
            new AddCourseProcedureDAO().execute(course);
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
        }
    }

    public void addLesson(){
        Lesson lesson = SegreteriaView.getLessonInfo();
        try {
            new AddLessonProcedureDAO().execute(lesson);
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
        }
    }

    public void addTeacher() {
        Teacher teacher = SegreteriaView.getTeacherInfo();
        try {
            new AddTeacherProcedureDAO().execute(teacher);
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
        }
    }

    public void addStudent() {
        Student student = SegreteriaView.getStudentInfo();
        try {
            new AddStudentProcedureDAO().execute(student);
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
        }
    }

    public void listStudentCourses() {
        EnrollmentList enr;
        String student = SegreteriaView.getId("Insert student id: ");

        try {
            enr = (EnrollmentList) new GetStudentCoursesDAO().execute(student);
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
            return;
        }

        System.out.println(enr);
    }

    public void assignCourse() {
        String idInsegnante = SegreteriaView.getId("Insert teacher id: ");
        Course course = SegreteriaView.getCourseId();

        try {
            new AssignCourseDAO().execute(idInsegnante, course.getLevel(), course.getIdCorso());
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
        }
    }

    public void enrollStudent() {
        Enrollment enrollment = SegreteriaView.getEnrollmentInfo();
        try {
            new EnrollmentProcedureDAO().execute(enrollment);
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
        }
    }

    public void recordsAbsence() {
        Absence absence = SegreteriaView.getAbsenceInfo();
        try {
            new RecordAbsenceProcedureDAO().execute(absence);
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
        }
    }

    public void getCourseInfo() {
        InfoCourseList info;
        Course course = SegreteriaView.getCourseId();

        try {
            info = (InfoCourseList) new GetCourseInfoDAO().execute(course.getLevel(), course.getIdCorso());
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
            return;
        }

        System.out.println(info);
    }

    public void getTeacherInfo() {
        String idInsegnante = SegreteriaView.getId("Insert teacher id: ");
        Teacher teacher;

        try {
            teacher = (Teacher) new GetTeacherInfoDAO().execute(idInsegnante);
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
            return;
        }

        try {
            Objects.requireNonNull(teacher, "Teacher not found.");
            System.out.println(teacher);
        }catch (NullPointerException e) {
            System.err.println(e.getMessage());
        }
    }

    public void getStudentInfo() {
        String idStudente = SegreteriaView.getId("Insert student id: ");
        Student student;

        try {
            student = (Student) new GetStudentInfoDAO().execute(idStudente);
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
            return;
        }

        try {
            Objects.requireNonNull(student, "Student not found.");
            System.out.println(student);
        }catch (NullPointerException e) {
            System.err.println(e.getMessage());
        }

    }

    public void getStudentAbsences(){
        String id = SegreteriaView.getId("Insert student id: ");
        Course course = SegreteriaView.getCourseId();
        AbsenceList abs;

        try{
            abs = (AbsenceList) new GetStudentAbsencesDAO().execute(id, course.getLevel(), course.getIdCorso());
        }catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
            return;
        }

        System.out.print(abs);

    }

    public void getCourseLessons(){
        LessonsList lessons;
        Course course = SegreteriaView.getCourseId();

        try {
            lessons = (LessonsList) new GetCourseLessonsDAO().execute(course.getLevel(), course.getIdCorso());
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
            return;
        }

        System.out.print(lessons);
    }

    public void getTeacherCourses(){
        CoursesList courses;
        String id = SegreteriaView.getId("Insert teacher id: ");

        try {
            courses = (CoursesList) new GetTeacherCoursesDAO().execute(id);
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
            return;
        }

        System.out.println(courses);
    }

    public void updateCourseEnd(){
        Course course = SegreteriaView.getUpdateCourseInfo();
        try {
            new UpdateCourseProcedureDAO().execute(course);
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
        }
    }

    public void teacherReport(){
        String id = SegreteriaView.getId("Insert teacher id: ");
        LocalDate date = SegreteriaView.getLessonsDateInfo();
        LessonsList lessons;

        try {
            lessons = (LessonsList) new GetMonthReportTeacherDAO().execute(id, date);
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
            return;
        }

        System.out.println(lessons);
    }

    public void lessonsReport(){
        LocalDate date = SegreteriaView.getLessonsDateInfo();
        LessonsList lessons;

        try {
            lessons = (LessonsList) new GetMonthReportDAO().execute(date);
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
            return;
        }

        System.out.println(lessons);
    }

    public void coursesList() {
        CoursesList courses;

        try {
            courses = (CoursesList) new GetCoursesListDAO().execute();
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
            return;
        }

        System.out.println(courses);
    }

    public void teacherList() {
        TeacherList teachers;

        try {
            teachers = (TeacherList) new GetTeachersListDAO().execute();
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
            return;
        }

        System.out.println(teachers);
    }

    public void studentList() {
        StudentList students;

        try {
            students = (StudentList) new GetStudentsListDAO().execute();
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
            return;
        }

        System.out.println(students);
    }

    public void getCourseStudents() {
        Course course = SegreteriaView.getCourseId();
        StudentList students;

        try {
            students = (StudentList) new GetCourseStudentsDAO().execute(course.getLevel(), course.getIdCorso());
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
            return;
        }

        System.out.println(students);
    }

    public void levelList() {
        LivelloList livelli;

        try {
             livelli = (LivelloList) new GetLivelliListDAO().execute();
        } catch (DAOException e) {
            //throw new RuntimeException(e);
            System.out.println(e.getMessage());
            return;
        }

        System.out.println(livelli);
    }

}
