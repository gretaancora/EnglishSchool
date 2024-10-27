package it.uniroma2.dicii.bd.view;

import java.io.IOException;
import java.util.InputMismatchException;
import java.util.NoSuchElementException;
import java.util.Scanner;

public class InsegnanteView {
    public static int showMenu() throws IOException {
        System.out.println("*********************************");
        System.out.println("*    ENGLISH SCHOOL DASHBOARD    *");
        System.out.println("*********************************\n");
        System.out.println("*** What should I do for you? ***\n");
        System.out.println("1) Current week lessons report");
        System.out.println("2) Next week lessons report");
        System.out.println("3) Quit");


        Scanner input = new Scanner(System.in);
        int choice;
        while (true) {
            try {
                System.out.print("Please enter your choice: ");
                choice = input.nextInt();
                input.nextLine();
                if (choice >= 1 && choice <= 3) {
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
}
