package it.uniroma2.dicii.bd.model.domain;

import java.time.LocalDate;

public class InfoCourse {
    private LocalDate dataInizio;
    private LocalDate dataFine;
    private String libro;
    private boolean esame;
    private short numIscr;
    private String nomeIns;
    private String cognomeIns;
    private String idIns;

    public InfoCourse(LocalDate dataInizio, LocalDate dataFine, String libro, boolean esame, short numIscr, String nomeIns, String cognomeIns, String idIns){
        this.dataInizio = dataInizio;
        this.dataFine = dataFine;
        this.libro = libro;
        this.esame = esame;
        this.numIscr = numIscr;
        this.nomeIns = nomeIns;
        this.cognomeIns = cognomeIns;
        this.idIns = idIns;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(this.dataInizio).append(" ").append(this.dataFine).append(" ").append(this.libro).append(" ").append(this.esame ? "esame richiesto" : "esame non richiesto").append(" ").append("numero iscritti:"+this.numIscr).append(" ").append(this.nomeIns).append(" ").append(this.cognomeIns).append(" ").append(this.idIns).append('\n');
        return sb.toString();
    }
}
