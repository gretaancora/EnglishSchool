package it.uniroma2.dicii.bd.view;

import it.uniroma2.dicii.bd.model.domain.*;

import java.io.IOException;
import java.time.DateTimeException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.NoSuchElementException;
import java.util.Scanner;

public class SegreteriaView {
    public static int showMenu() throws IOException {
        System.out.println("*********************************");
        System.out.println("*    ENGLISH SCHOOL DASHBOARD    *");
        System.out.println("*********************************\n");
        System.out.println("*** What should I do for you? ***\n");
        System.out.println("1) Add course");
        System.out.println("2) Add lesson");
        System.out.println("3) Add teacher");
        System.out.println("4) Add student");
        System.out.println("5) List student courses");
        System.out.println("6) Enroll student");
        System.out.println("7) Records absence");
        System.out.println("8) List active courses");
        System.out.println("9) Update end of the course");
        System.out.println("10) Teacher lessons Report");
        System.out.println("11) Lessons Report");
        System.out.println("12) Quit");


        Scanner input = new Scanner(System.in);
        int choice = 0;
        while (true) {
            System.out.print("Please enter your choice: ");
            choice = input.nextInt();
            if (choice >= 1 && choice <= 12) {
                break;
            }
            System.out.println("Invalid option");
        }

        return choice;
    }

    public static int getLevel(Scanner input) {
        int livello = 0;

        System.out.println("Choose course level: ");
        System.out.println("1) C-KET");
        System.out.println("2) C-PET");
        System.out.println("3) C-FCE");
        System.out.println("4) C-CAE");
        System.out.println("5) C-CPE");

        while (true) {
            System.out.print("Please enter your choice: ");
            livello = input.nextInt();
            if (livello >= 1 && livello <= 5) {
                break;
            }
            System.out.println("Invalid option");
        }
        return livello;
    }

    public static Course getCourseInfo() {
        int livello = 0;
        int day;
        int month;
        int year;
        LocalDate dataInizio;
        LocalDate dataFine;

        Scanner input  = new Scanner(System.in);

        System.out.println("Choose course level: ");
        System.out.println("1) C-KET");
        System.out.println("2) C-PET");
        System.out.println("3) C-FCE");
        System.out.println("4) C-CAE");
        System.out.println("5) C-CPE");

        while (true) {
            System.out.print("Please enter your choice: ");
            livello = input.nextInt();
            if (livello >= 1 && livello <= 5) {
                break;
            }
            System.out.println("Invalid option");
        }

        System.out.println("Insert start date");
        while (true){
            try {
                System.out.println("Insert day: ");
                day = input.nextInt();
                System.out.println("Insert month: ");
                month = input.nextInt();
                System.out.println("Insert year: ");
                year = input.nextInt();
                dataInizio = LocalDate.of(year, month, day);
            } catch (DateTimeException e) {
                System.out.println("Invalid date");
                continue;
            }
            break;
        }

        System.out.println("Insert end date");
        while (true){
            try {
                System.out.println("Insert day: ");
                day = input.nextInt();
                System.out.println("Insert month: ");
                month = input.nextInt();
                System.out.println("Insert year: ");
                year = input.nextInt();
                dataFine = LocalDate.of(year, month, day);
            } catch (DateTimeException e) {
                System.out.println("Invalid date");
                continue;
            }
            break;
        }

        return new Course(livello, dataInizio, dataFine);

    }

    public static Lesson getLessonInfo(){
        String insegnante;
        LocalDate dataLezione;
        LocalTime oraInizio;
        LocalTime oraFine;
        int livelloCorso;
        int corso;
        int day;
        int month;
        int year;
        int hour;
        int minute;

        Scanner input  = new Scanner(System.in);

        System.out.println("Choose course level: ");
        System.out.println("1) C-KET");
        System.out.println("2) C-PET");
        System.out.println("3) C-FCE");
        System.out.println("4) C-CAE");
        System.out.println("5) C-CPE");

        while (true) {
            System.out.print("Please enter your choice: ");
            livelloCorso = input.nextInt();
            if (livelloCorso >= 1 && livelloCorso <= 5) {
                break;
            }
            System.out.println("Invalid option");
        }

        System.out.println("Insert course id: ");
        while (true) {
            try {
                corso = input.nextInt();
            } catch (NoSuchElementException e) {
                System.out.println("Invalid id");
                continue;
            }
            break;
        }

        System.out.println("Insert lesson date");
        while (true){
            try {
                System.out.println("Insert day: ");
                day = input.nextInt();
                System.out.println("Insert month: ");
                month = input.nextInt();
                System.out.println("Insert year: ");
                year = input.nextInt();
                dataLezione = LocalDate.of(year, month, day);
            } catch (DateTimeException e) {
                System.out.println("Invalid date");
                continue;
            }
            break;
        }

        System.out.println("Insert start time");
        while (true){
            try {
                System.out.println("Insert hour: ");
                hour = input.nextInt();
                System.out.println("Insert minute: ");
                minute = input.nextInt();
                oraInizio = LocalTime.of(hour, minute);
            } catch (DateTimeException e) {
                System.out.println("Invalid start time");
                continue;
            }
            break;
        }

        System.out.println("Insert end time");
        while (true){
            try {
                System.out.println("Insert hour: ");
                hour = input.nextInt();
                System.out.println("Insert minute: ");
                minute = input.nextInt();
                oraFine = LocalTime.of(hour, minute);
            } catch (DateTimeException e) {
                System.out.println("Invalid start time");
                continue;
            }
            break;
        }

        System.out.println("Insert teacher id: ");
        while (true) {
            try {
                insegnante = input.nextLine();
            } catch (NoSuchElementException e) {
                System.out.println("Invalid id");
                continue;
            }
            break;
        }

        return new Lesson(insegnante, dataLezione, oraInizio, oraFine, livelloCorso, corso);

    }

    public static Teacher getTeacherInfo(){
        String nome;
        String cognome;
        String indirizzo;
        String mail;
        String nazione;

        Scanner input  = new Scanner(System.in);

        System.out.println("Insert name: ");
        while (true) {
            try {
                nome = input.nextLine();
            } catch (NoSuchElementException e) {
                System.out.println("Invalid name");
                continue;
            }
            break;
        }

        System.out.println("Insert surname: ");
        while (true) {
            try {
                cognome = input.nextLine();
            } catch (NoSuchElementException e) {
                System.out.println("Invalid surname");
                continue;
            }
            break;
        }

        System.out.println("Insert address: ");
        while (true) {
            try {
                indirizzo = input.nextLine();
            } catch (NoSuchElementException e) {
                System.out.println("Invalid address");
                continue;
            }
            break;
        }

        System.out.println("Insert mail: ");
        while (true) {
            try {
                mail = input.nextLine();
            } catch (NoSuchElementException e) {
                System.out.println("Invalid mail");
                continue;
            }
            break;
        }

        System.out.println("Insert nation: ");
        while (true) {
            try {
                nazione = input.nextLine();
            } catch (NoSuchElementException e) {
                System.out.println("Invalid Address");
                continue;
            }
            break;
        }

        return new Teacher(nome, cognome, indirizzo, mail, nazione);
    }

    public static Student getStudentInfo(){
        String nome;
        String cognome;
        String indirizzo;
        String mail;
        String telefono;

        Scanner input  = new Scanner(System.in);

        System.out.println("Insert name: ");
        while (true) {
            try {
                nome = input.nextLine();
            } catch (NoSuchElementException e) {
                System.out.println("Invalid name");
                continue;
            }
            break;
        }

        System.out.println("Insert surname: ");
        while (true) {
            try {
                cognome = input.nextLine();
            } catch (NoSuchElementException e) {
                System.out.println("Invalid surname");
                continue;
            }
            break;
        }

        System.out.println("Insert address: ");
        while (true) {
            try {
                indirizzo = input.nextLine();
            } catch (NoSuchElementException e) {
                System.out.println("Invalid address");
                continue;
            }
            break;
        }

        System.out.println("Insert mail: ");
        while (true) {
            try {
                mail = input.nextLine();
            } catch (NoSuchElementException e) {
                System.out.println("Invalid mail");
                continue;
            }
            break;
        }

        System.out.println("Insert phone number: ");
        while (true) {
            try {
                telefono = input.nextLine();
            } catch (NoSuchElementException e) {
                System.out.println("Invalid phone number");
                continue;
            }
            break;
        }

        return new Student(nome, cognome, indirizzo, mail, telefono);
    }

    public static Enrollment getEnrollmentInfo(){
        String studente;
        int livelloCorso;
        int corso;
        LocalDate dataIscrizione;
        int day;
        int month;
        int year;

        Scanner input  = new Scanner(System.in);

        System.out.println("Insert student id: ");
        while (true) {
            try {
                studente = input.nextLine();
            } catch (NoSuchElementException e) {
                System.out.println("Invalid id");
                continue;
            }
            break;
        }

        System.out.println("Choose course level: ");
        System.out.println("1) C-KET");
        System.out.println("2) C-PET");
        System.out.println("3) C-FCE");
        System.out.println("4) C-CAE");
        System.out.println("5) C-CPE");

        while (true) {
            System.out.print("Please enter your choice: ");
            livelloCorso = input.nextInt();
            if (livelloCorso >= 1 && livelloCorso <= 5) {
                break;
            }
            System.out.println("Invalid option");
        }

        System.out.println("Insert course id: ");
        while (true) {
            try {
                corso = input.nextInt();
            } catch (NoSuchElementException e) {
                System.out.println("Invalid id");
                continue;
            }
            break;
        }

        System.out.println("Insert enrollment date");
        while (true){
            try {
                System.out.println("Insert day: ");
                day = input.nextInt();
                System.out.println("Insert month: ");
                month = input.nextInt();
                System.out.println("Insert year: ");
                year = input.nextInt();
                dataIscrizione = LocalDate.of(year, month, day);
            } catch (DateTimeException e) {
                System.out.println("Invalid date");
                continue;
            }
            break;
        }

        return new Enrollment(studente, livelloCorso, corso, dataIscrizione);
    }

}
