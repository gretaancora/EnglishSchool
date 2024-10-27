package it.uniroma2.dicii.bd.model.domain;

import java.util.ArrayList;
import java.util.List;

public class InfoCourseList {
    List<InfoCourse> courses = new ArrayList<>();

    public void addInfoCourse(InfoCourse info) {
        this.courses.add(info);
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        for(InfoCourse course : courses) {
            sb.append(course);
        }
        return sb.toString();
    }
}
