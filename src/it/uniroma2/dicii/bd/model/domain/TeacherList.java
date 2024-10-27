package it.uniroma2.dicii.bd.model.domain;

import java.util.ArrayList;
import java.util.List;

public class TeacherList {
    List<Teacher> teachers = new ArrayList<>();

    public void addTeacher(Teacher teacher) {
        this.teachers.add(teacher);
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        int i = 1;
        for(Teacher teacher : teachers) {
            sb.append(i + ") " + teacher);
            i++;
        }
        return sb.toString();
    }
}
