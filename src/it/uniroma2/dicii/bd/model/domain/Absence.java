package it.uniroma2.dicii.bd.model.domain;

import java.time.LocalDate;
import java.time.LocalTime;

public class Absence {
    private String idStudente;
    private String idInsegnante;
    private LocalDate dataLezione;
    private LocalTime oraInizioLezione;
    private Level livello;
    private short corso;

    public Absence(String idStudente, String idInsegnante, LocalDate dataLezione, LocalTime oraInizioLezione) {
        this.idStudente = idStudente;
        this.idInsegnante = idInsegnante;
        this.dataLezione = dataLezione;
        this.oraInizioLezione = oraInizioLezione;
    }

    public Absence(LocalDate dataLezione, LocalTime oraInizioLezione, Level livello, short corso) {
        this.dataLezione = dataLezione;
        this.oraInizioLezione = oraInizioLezione;
        this.livello = livello;
        this.corso = corso;
    }

    public String getIdStudente() { return this.idStudente; }

    public String getIdInsegnante() { return this.idInsegnante; }

    public LocalDate getDataLezione() { return this.dataLezione; }

    public LocalTime getOraInizioLezione() { return this.oraInizioLezione; }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(this.dataLezione).append(" ").append(this.oraInizioLezione).append(" ").append(this.livello).append(" ").append(this.corso).append('\n');
        return sb.toString();
    }
}
