package it.uniroma2.dicii.bd.model.domain;

import java.util.ArrayList;
import java.util.List;

public class AbsenceList {
    List<Absence> absences = new ArrayList<>();

    public void addAbsence(Absence abs) {
        this.absences.add(abs);
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        int i = 1;
        for(Absence absence : absences) {
            sb.append(i + ") " + absence);
            i++;
        }
        return sb.toString();
    }
}
