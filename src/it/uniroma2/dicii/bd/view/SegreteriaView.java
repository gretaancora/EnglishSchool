package it.uniroma2.dicii.bd.view;

import it.uniroma2.dicii.bd.model.domain.*;

import java.io.IOException;
import java.time.DateTimeException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.InputMismatchException;
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
        System.out.println("5) Assign course");
        System.out.println("6) Enroll student");
        System.out.println("7) Record absence");
        System.out.println("8) Get course info");
        System.out.println("9) Get teacher info");
        System.out.println("10) Get student info");
        System.out.println("11) Get student absences");
        System.out.println("12) Get student enrollments");
        System.out.println("13) Get course lessons");
        System.out.println("14) Get teacher courses");
        System.out.println("15) Update end of the course");
        System.out.println("16) Teacher lessons Report");
        System.out.println("17) Lessons Report");
        System.out.println("18) Courses list");
        System.out.println("19) Teacher list");
        System.out.println("20) Student list");
        System.out.println("21) Get course students");
        System.out.println("22) Level list");
        System.out.println("23) Quit");


        Scanner input = new Scanner(System.in);
        int choice;
        while (true) {
            try {
                System.out.print("Please enter your choice: ");
                choice = input.nextInt();
                input.nextLine();
                if (choice >= 1 && choice <= 23) {
                    break;
                }
                System.out.println("Invalid option");
            } catch (InputMismatchException e) {
                input.nextLine();
                System.out.println("Invalid choice");
            } catch (NoSuchElementException e) {
                System.out.println("Invalid choice");
            }
        }
        return choice;
    }

    public static Level getLevel(Scanner input) {
        int livello;

        System.out.println("Choose course level: ");
        System.out.println("1) A1");
        System.out.println("2) A2");
        System.out.println("3) B1");
        System.out.println("4) B2");
        System.out.println("5) C1");
        System.out.println("6) C2");

        while (true) {
            try {
                System.out.print("Please enter your choice: ");
                livello = input.nextInt();
                input.nextLine();
                if (livello >= 1 && livello <= 6) {
                    break;
                }
                System.out.println("Invalid option");
            } catch (InputMismatchException e) {
                System.out.println("Invalid option");
                input.nextLine();
            } catch (NoSuchElementException e) {
                System.out.println("Invalid choice");
            }
        }
        return Level.fromInt(livello);
    }

    public static LocalDate getDate(Scanner input, String msg) {
        int day;
        int month;
        int year;
        LocalDate data;

        System.out.println(msg);
        while (true){
            try {
                while (true) {
                    try {
                        System.out.println("Insert day (1 to 31): ");
                        day = input.nextInt();
                        input.nextLine();
                        break;
                    } catch (InputMismatchException e) {
                        System.out.println("Invalid day");
                        input.nextLine();
                    } catch (NoSuchElementException e) {
                        System.out.println("Invalid choice");
                    }
                }
                while (true) {
                    try {
                        System.out.println("Insert month (1 to 12): ");
                        month = input.nextInt();
                        input.nextLine();
                        break;
                    } catch (InputMismatchException e) {
                        System.out.println("Invalid month");
                        input.nextLine();
                    } catch (NoSuchElementException e) {
                        System.out.println("Invalid choice");
                    }
                }
                while (true) {
                    try {
                        System.out.println("Insert year (ex_ 2024): ");
                        year = input.nextInt();
                        input.nextLine();
                        break;
                    } catch (InputMismatchException e) {
                        System.out.println("Invalid year");
                        input.nextLine();
                    } catch (NoSuchElementException e) {
                        System.out.println("Invalid choice");
                    }
                }
                data = LocalDate.of(year, month, day);
            } catch (DateTimeException e) {
                System.out.println("Invalid date");
                continue;
            }
            break;
        }
        return data;
    }

    public static short getShort(Scanner input, String msg){
        short i;

        System.out.println(msg);
        while (true) {
            try {
                i = input.nextShort();
                input.nextLine();
                break;
            } catch (InputMismatchException e) {
                System.out.println("Invalid input");
                input.nextLine();
            } catch (NoSuchElementException e) {
                System.out.println("Invalid choice");
            }
        }
        return i;
    }

    public static LocalTime getTime(Scanner input, String msg){
        int hour;
        int minute;
        LocalTime ora;

        System.out.println(msg);
        while (true){
            try {
                while (true) {
                    try {
                        System.out.println("Insert hour (0 to 23): ");
                        hour = input.nextInt();
                        input.nextLine();
                        break;
                    } catch (InputMismatchException e) {
                        System.out.println("Invalid hour");
                        input.nextLine();
                    } catch (NoSuchElementException e) {
                        System.out.println("Invalid choice");
                    }
                }
                while (true) {
                    try {
                        System.out.println("Insert minute (0 to 59): ");
                        minute = input.nextInt();
                        input.nextLine();
                        break;
                    } catch (InputMismatchException e) {
                        System.out.println("Invalid minute");
                        input.nextLine();
                    } catch (NoSuchElementException e) {
                        System.out.println("Invalid choice");
                    }
                }
                ora = LocalTime.of(hour, minute);
            } catch (DateTimeException e) {
                System.out.println("Invalid time");
                continue;
            }
            break;
        }
        return ora;
    }

    public static String getString(Scanner input, String msg){
        System.out.println(msg);
        String str = input.nextLine();
        return str;
    }

    public static Course getCourseInfo() {
        Level livello;
        LocalDate dataInizio;
        LocalDate dataFine;

        Scanner input  = new Scanner(System.in);

        livello = getLevel(input);
        dataInizio = getDate(input, "Insert start date: ");
        dataFine = getDate(input, "Insert end date: ");

        return new Course(livello, dataInizio, dataFine);
    }

    public static Course getUpdateCourseInfo(){
        Level livello;
        short idCorso;
        LocalDate newDate;

        Scanner input = new Scanner(System.in);

        livello = getLevel(input);
        idCorso = getShort(input, "Insert course id: ");
        newDate = getDate(input, "Insert new end date: ");

        return new Course(livello, idCorso, newDate);
    }

    public static Lesson getLessonInfo(){
        String insegnante;
        LocalDate dataLezione;
        LocalTime oraInizio;
        LocalTime oraFine;
        Level livelloCorso;
        int corso;

        Scanner input  = new Scanner(System.in);

        livelloCorso = getLevel(input);
        corso = getShort(input, "Insert course id: ");
        dataLezione = getDate(input, "Insert lesson date: ");
        oraInizio = getTime(input, "Insert start time: ");
        oraFine = getTime(input, "Insert end time: ");
        insegnante = getString(input, "Insert teacher id: ");

        return new Lesson(insegnante, dataLezione, oraInizio, oraFine, livelloCorso, corso);
    }

    public static LocalDate getLessonsDateInfo(){
        Scanner input = new Scanner(System.in);

        LocalDate data;
        int month;
        int year;

        while (true){
            try {
                while (true) {
                    try {
                        System.out.println("Insert month (1 to 12): ");
                        month = input.nextInt();
                        input.nextLine();
                        break;
                    } catch (InputMismatchException e) {
                        System.out.println("Invalid month");
                        input.nextLine();
                    } catch (NoSuchElementException e) {
                        System.out.println("Invalid choice");
                    }
                }
                while (true) {
                    try {
                        System.out.println("Insert year (es_ 2024): ");
                        year = input.nextInt();
                        input.nextLine();
                        break;
                    } catch (InputMismatchException e) {
                        System.out.println("Invalid year");
                        input.nextLine();
                    } catch (NoSuchElementException e) {
                        System.out.println("Invalid choice");
                    }
                }
                data = LocalDate.of(year, month, 1);
            } catch (DateTimeException e) {
                System.out.println("Invalid date");
                continue;
            }
            break;
        }

        return data;
    }

    public static Teacher getTeacherInfo(){
        String nome;
        String cognome;
        String indirizzo;
        String mail;
        String nazione;

        Scanner input  = new Scanner(System.in);

        nome = getString(input, "Insert teacher name: ");
        cognome = getString(input, "Insert teacher surname: ");
        indirizzo = getString(input, "Insert teacher address: ");
        mail = getString(input, "Insert teacher mail: ");
        nazione = getString(input, "Insert teacher nation: ");

        return new Teacher(nome, cognome, indirizzo, mail, nazione);
    }

    public static String getId(String msg) {
        Scanner input  = new Scanner(System.in);

        return getString(input, msg);
    }


    public static Student getStudentInfo(){
        String nome;
        String cognome;
        String indirizzo;
        String mail;
        String telefono;

        Scanner input  = new Scanner(System.in);

        nome = getString(input, "Insert student name: ");
        cognome = getString(input, "Insert student surname: ");
        indirizzo = getString(input, "Insert student address: ");
        mail = getString(input, "Insert student mail: ");
        telefono = getString(input, "Insert student phone number: ");

        return new Student(nome, cognome, indirizzo, mail, telefono);
    }

    public static Enrollment getEnrollmentInfo() {
        String studente;
        Level livelloCorso;
        int corso;
        LocalDate dataIscrizione;

        Scanner input  = new Scanner(System.in);

        studente = getString(input, "Insert student id: ");
        livelloCorso = getLevel(input);
        corso = getShort(input, "Insert course id: ");
        dataIscrizione = getDate(input, "Insert enrollment date: ");

        return new Enrollment(studente, livelloCorso, corso, dataIscrizione);
    }

    public static Absence getAbsenceInfo() {
        String idStudente;
        String idInsegnante;
        LocalDate dataLezione;
        LocalTime oraInizioLezione;

        Scanner input = new Scanner(System.in);

        idStudente = getString(input, "Insert student id: ");
        idInsegnante = getString(input, "Insert teacher id: ");
        dataLezione = getDate(input, "Insert lesson date: ");
        oraInizioLezione = getTime(input, "Insert lesson start time: ");

        return new Absence(idStudente, idInsegnante, dataLezione, oraInizioLezione);
    }

    public static Course getCourseId(){
        Level livello;
        short corso;

        Scanner input = new Scanner(System.in);

        livello = getLevel(input);
        corso = getShort(input, "Insert course id: ");

        return new Course(livello, corso);
    }
}
