package it.uniroma2.dicii.bd.model.domain;

import java.time.LocalDate;

public class Enrollment {
    private String studente;
    private int livelloCorso;
    private int corso;
    private LocalDate dataIscrizione;

    public Enrollment(String studente, int livelloCorso, int corso, LocalDate dataIscrizione){
        this.studente = studente;
        this.livelloCorso = livelloCorso;
        this.corso = corso;
        this.dataIscrizione = dataIscrizione;
    }

    public String getStudente() { return this.studente; }
    public int getLivelloCorso() { return this.livelloCorso; }
    public int getCorso() { return this.corso; }
    public LocalDate getDataIscrizione() { return this.dataIscrizione; }

}
