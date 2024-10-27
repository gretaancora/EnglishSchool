package it.uniroma2.dicii.bd.model.domain;

import java.util.ArrayList;
import java.util.List;

public class EnrollmentList {
    List<Enrollment> enrollments = new ArrayList<>();

    public void addEnrollment(Enrollment enr) {
        this.enrollments.add(enr);
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        int i = 1;
        for(Enrollment enr : enrollments) {
            sb.append(i + ") " + enr);
            i++;
        }
        return sb.toString();
    }
}
