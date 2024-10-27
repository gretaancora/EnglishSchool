package it.uniroma2.dicii.bd.model.domain;

import java.util.ArrayList;
import java.util.List;

public class StudentList {
    List<Student> students = new ArrayList<>();

    public void addStudent(Student student) {
        this.students.add(student);
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        int i = 1;
        for(Student student: students) {
            sb.append(i + ") " + student);
            i++;
        }
        return sb.toString();
    }
}
