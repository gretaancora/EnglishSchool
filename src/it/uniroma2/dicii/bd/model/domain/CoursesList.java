package it.uniroma2.dicii.bd.model.domain;

import java.util.ArrayList;
import java.util.List;

public class CoursesList {
    List<Course> courses = new ArrayList<>();

    public void addCourse(Course course) {
        this.courses.add(course);
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        int i = 1;
        for(Course course : courses) {
            sb.append(i + ") " + course);
            i++;
        }
        return sb.toString();
    }
}
