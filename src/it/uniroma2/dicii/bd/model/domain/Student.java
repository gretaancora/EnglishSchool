package it.uniroma2.dicii.bd.model.domain;

public class Student {
    private String id;
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

    public Student(String id, String nome, String cognome, String indirizzo, String mail, String telefono){
        this.id = id;
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
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(this.id).append(" ").append(this.nome).append(" ").append(this.cognome).append(" ").append(this.indirizzo).append(" ").append(this.mail).append(" ").append(this.telefono).append('\n');
        return sb.toString();
    }

}
