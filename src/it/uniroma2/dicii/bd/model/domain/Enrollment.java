package it.uniroma2.dicii.bd.model.domain;

import java.time.LocalDate;

public class Enrollment {
    private String studente;
    private Level livelloCorso;
    private int corso;
    private LocalDate dataIscrizione;

    public Enrollment(String studente, Level livelloCorso, int corso, LocalDate dataIscrizione){
        this.studente = studente;
        this.livelloCorso = livelloCorso;
        this.corso = corso;
        this.dataIscrizione = dataIscrizione;
    }

    public String getStudente() { return this.studente; }
    public Level getLivelloCorso() { return this.livelloCorso; }
    public int getCorso() { return this.corso; }
    public LocalDate getDataIscrizione() { return this.dataIscrizione; }
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(this.livelloCorso.name()).append(" ").append(this.corso).append(" ").append(this.dataIscrizione).append('\n');
        return sb.toString();
    }

}
