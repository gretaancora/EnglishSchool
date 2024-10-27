package it.uniroma2.dicii.bd.model.domain;

import java.time.LocalDate;
import java.time.LocalTime;

public class Lesson {
    private String insegnante;
    private LocalDate dataLezione;
    private LocalTime oraInizio;
    private LocalTime oraFine;
    private Level livelloCorso;
    private int corso;

    public Lesson(String insegnante, LocalDate dataLezione, LocalTime oraInizio, LocalTime oraFine, Level livelloCorso, int corso) {
        this.insegnante = insegnante;
        this.dataLezione = dataLezione;
        this.oraInizio = oraInizio;
        this.oraFine = oraFine;
        this.livelloCorso = livelloCorso;
        this.corso = corso;
    }

    public String getInsegnante() {
        return this.insegnante;
    }

    public LocalDate getDataLezione() {
        return this.dataLezione;
    }

    public LocalTime getOraInizio() {
        return this.oraInizio;
    }

    public LocalTime getOraFine() {
        return this.oraFine;
    }

    public Level getLivelloCorso() {
        return this.livelloCorso;
    }

    public int getCorso() {
        return this.corso;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(this.insegnante).append(" ").append(this.dataLezione).append(" ").append(this.oraInizio).append(" ").append(this.oraFine).append(" ").append(this.livelloCorso.name()).append(" ").append(this.corso).append('\n');
        return sb.toString();
    }
}
