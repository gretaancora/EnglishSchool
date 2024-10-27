package it.uniroma2.dicii.bd.model.domain;

import java.time.LocalDate;

public class Course {
    private Level livello;
    private short idCorso;
    private LocalDate dataInizio;
    private LocalDate dataFine;
    private short numIscr;

    public Course (Level livello, short idCorso, LocalDate dataInizio, LocalDate dataFine, short numIscr){
        this.idCorso = idCorso;
        this.livello = livello;
        this.dataInizio  = dataInizio;
        this.dataFine = dataFine;
        this.numIscr = numIscr;
    }

    public Course (Level livello, short idCorso, LocalDate dataInizio, LocalDate dataFine){
        this.idCorso = idCorso;
        this.livello = livello;
        this.dataInizio  = dataInizio;
        this.dataFine = dataFine;
    }

    public Course(Level livello, LocalDate dataInizio, LocalDate dataFine){
        this.idCorso = -1;
        this.livello = livello;
        this.dataInizio  = dataInizio;
        this.dataFine = dataFine;
    }

    public Course(Level livello, short idCorso, LocalDate dataFine) {
        this.livello = livello;
        this.idCorso = idCorso;
        this.dataFine = dataFine;
    }

    public Course(Level livello, short idCorso) {
        this.livello = livello;
        this.idCorso = idCorso;
    }

    public Level getLevel() { return this.livello; }

    public short getIdCorso() { return this.idCorso; }

    public LocalDate getDataInizio() { return this.dataInizio; }

    public LocalDate getDataFine() { return this.dataFine; }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(this.livello.name()).append(" ").append(this.idCorso).append(" ").append(this.dataInizio).append(" ").append(this.dataFine).append(" ").append("numero iscritti:"+this.numIscr).append('\n');
        return sb.toString();
    }


}
