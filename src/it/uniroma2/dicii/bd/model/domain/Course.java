package it.uniroma2.dicii.bd.model.domain;

import java.time.LocalDate;

public class Course {
    private int livello;
    private int idCorso;
    private LocalDate dataInizio;
    private LocalDate dataFine;
    private boolean stato;

    public Course(int livello, LocalDate dataInizio, LocalDate dataFine){
        this.idCorso = -1;
        this.livello = livello;
        this.dataInizio  = dataInizio;
        this.dataFine = dataFine;
        this.stato = true;
    }

    public int getLevel() { return this.livello; }

    public LocalDate getDataInizio() { return this.dataInizio; }

    public LocalDate getDataFine() { return this.dataFine; }


}
