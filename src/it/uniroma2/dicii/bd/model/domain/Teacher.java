package it.uniroma2.dicii.bd.model.domain;

public class Teacher {
    //private String id;
    private String nome;
    private String cognome;
    private String indirizzo;
    private String mail;
    private String nazione;

    public Teacher(String nome, String cognome, String indirizzo, String mail, String nazione){
        this.nome = nome;
        this.cognome = cognome;
        this.indirizzo = indirizzo;
        this.mail = mail;
        this.nazione = nazione;
    }

    public String getNome() { return this.nome; }
    public String getCognome() { return this.cognome; }
    public String getIndirizzo() { return this.indirizzo; }
    public String getMail() { return this.mail; }
    public String getNazione() { return this.nazione; }

}
