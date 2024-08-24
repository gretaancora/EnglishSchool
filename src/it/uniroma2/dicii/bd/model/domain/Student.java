package it.uniroma2.dicii.bd.model.domain;

public class Student {
    //private String id;
    private String nome;
    private String cognome;
    private String indirizzo;
    private String mail;
    private String telefono;

    public Student(String nome, String cognome, String indirizzo, String mail, String telefono){
        this.nome = nome;
        this.cognome = cognome;
        this.indirizzo = indirizzo;
        this.mail = mail;
        this.telefono = telefono;
    }

     public String getNome() { return this.nome; }
    public String getCognome() { return this.cognome; }
    public String getIndirizzo() { return this.indirizzo; }
    public String getMail() { return this.mail; }
    public String getTelefono() { return this.telefono; }

}
