package it.uniroma2.dicii.bd.model.domain;

public class Livello {
    private Level name;
    private String libro;
    private boolean esame;

    public Livello(Level name, String libro, boolean esame) {
        this.name = name;
        this.libro = libro;
        this.esame = esame;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(this.name).append(" ").append(this.libro).append(" ").append(this.esame ? "esame richiesto" : "esame non richiesto").append('\n');
        return sb.toString();
    }

}
