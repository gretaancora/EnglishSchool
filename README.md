# Foreign Language Course Management System

This repository contains the final project for the **Database** course of the University of Rome Tor Vergata, Computer Engineering programme. It implements a Java desktop client for managing the information used by a foreign-language school, backed by a MySQL relational database.

---

## 📌 Executive Summary

The project combines a **JavaFX desktop application** with a MySQL database named `gestione_corsi_inglese`. The database models the main entities of a language school: students, teachers, course levels, courses, teacher assignments, lesson schedules, enrolments and student absences.

The supported course levels range from **A1 to C2**. The SQL dump also defines stored procedures and triggers for common operations and integrity checks, including login, course and person management, enrolments, attendance/absence records, timetable queries and lesson reports.

The repository is an academic project. The current configuration and authentication design should be reviewed before any use beyond a local development environment.

---

## 🎯 Technical Scope & Key Findings

### 1. Application Stack

| Component | Technology / Version | Purpose |
| :--- | :--- | :--- |
| Language | Java 21 | Application implementation |
| User interface | JavaFX Controls and FXML | Desktop user interface |
| Build system | Apache Maven | Dependency management and execution |
| Database | MySQL 8.0 (dump generated with 8.0.34) | Persistent storage, constraints and stored procedures |
| Test framework dependency | JUnit Jupiter 5.9.2 | Unit testing support |

The Maven configuration sets the Java compiler source and target to version 21. The provided `pom.xml` declares JavaFX dependencies, but does **not** currently declare MySQL Connector/J; ensure that a compatible JDBC driver is available at runtime or add it to the Maven configuration.

### 2. Core Data Model

The SQL dump defines a relational model centred on the following entities:

- **Students (`studenti`)** — student details and contact information.
- **Teachers (`insegnanti`)** — teacher details and contact information.
- **Users (`utenti`)** — login identifiers and role information for `segreteria` (administrative staff) and `insegnante` (teacher).
- **Course levels (`livelli`)** — levels A1, A2, B1, B2, C1 and C2, with associated book and exam information.
- **Courses (`corsi`)** — course level, start/end dates and enrolment count.
- **Enrolments (`iscrizioni`)** — links students to courses.
- **Teaching assignments (`docenza`)** — links teachers to courses.
- **Lessons (`lezioni`)** — date, start/end time, teacher and course.
- **Absences (`assenze`)** — records a student's absence from a scheduled lesson.

Primary keys, foreign keys, indexes and generated UUID representations are used to maintain relationships between records. The dump stores UUID values in binary form and uses MySQL UUID conversion functions to expose readable identifiers.

### 3. Business Rules and Database Logic

The database contains stored procedures for operations such as authentication, creating students/teachers/courses/lessons, assigning teachers to courses, registering enrolments and absences, retrieving lists and details, and producing lesson reports.

Triggers enforce several integrity rules, including:

- A course's start date must precede its end date.
- A lesson must fall within the date range of its course.
- A lesson's start time must precede its end time.
- A teacher cannot be scheduled for overlapping lessons on the same date.
- Lessons belonging to the same course cannot overlap on the same date.

These rules are implemented in MySQL; they are not merely user-interface validations.

### 4. User Roles and Authentication

The database defines two user roles:

| Role | Identifier in database | Intended context |
| :--- | :--- | :--- |
| Secretariat / administrative staff | `segreteria` | School administration |
| Teacher | `insegnante` | Teacher-facing operations |

The stored procedure `login` compares a supplied password against an MD5 digest stored in the database. **MD5 is not suitable for password storage in a production application.** Use a modern password-hashing algorithm (such as Argon2id, bcrypt or scrypt) before adapting this project for real accounts.

---

## 🧰 Repository Layout

| Path | Description |
| :--- | :--- |
| `src/` | Java application source code |
| `resources/` | Application resources, including UI resources where applicable |
| `pom.xml` | Maven project configuration and Java/JavaFX dependencies |
| `mvnw`, `mvnw.cmd`, `.mvn/wrapper/` | Maven Wrapper for Unix-like systems and Windows |
| `gestione_corsi_dump.sql` | MySQL schema, sample records, triggers and stored procedures |
| `template-progetto.pdf` | Project template/documentation supplied with the repository |
| `credentials.txt` | File containing credential-like identifiers; see the security note below |

---

## ⚙️ Setup & Execution

### 1. Prerequisites

Install or prepare the following components:

- JDK 21.
- MySQL 8.0.34 or a compatible MySQL 8.0 release. The dump uses MySQL-specific features such as `UUID_TO_BIN`, `BIN_TO_UUID` and the `utf8mb4_0900_ai_ci` collation.
- A compatible MySQL JDBC driver on the application's runtime classpath.

### 2. Create the Database

Create a dedicated local development database:

```sql
CREATE DATABASE gestione_corsi_inglese
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;
```

Import the SQL dump from the repository root:

```bash
mysql -u <db_user> -p gestione_corsi_inglese < gestione_corsi_dump.sql
```

Replace `<db_user>` with a MySQL account that has the required privileges. The dump includes `DROP TABLE IF EXISTS` statements and creates routines/triggers, so import it only into a disposable development database or after making a backup.

Some stored objects declare `DEFINER='root'@'localhost'`. If your MySQL account differs, the import may require a privileged account or edits to the `DEFINER` clauses. Prefer assigning the objects to a dedicated database account instead of using `root` for routine application use.

### 3. Configure the Database Connection

Update the application's JDBC connection configuration to match the local MySQL server, database name, username and password. Do not commit local credentials or embed production secrets in source code. Use a dedicated database account with only the privileges needed by the application.

If the application cannot find the MySQL JDBC driver, add a compatible MySQL Connector/J dependency to `pom.xml` and ensure it is available at runtime.

### 4. Build and Launch

From the repository root, run the JavaFX Maven goal with the Maven Wrapper.

**Linux / macOS**

```bash
./mvnw clean javafx:run
```

**Windows (Command Prompt)**

```bat
mvnw.cmd clean javafx:run
```

The project can also be opened in a Java IDE as a Maven project. Confirm that the Java 21 SDK, JavaFX dependencies, JDBC driver and database connection settings are configured correctly before launching.

---

## 🗃️ Database Operations Overview

The database-side logic includes operations broadly grouped as follows:

| Area | Examples of database support |
| :--- | :--- |
| Reference data | Listing course levels and courses |
| People | Adding and retrieving student and teacher records |
| Course administration | Creating courses, assigning teachers and retrieving course information |
| Scheduling | Adding lessons and listing lessons for a course or teacher |
| Enrolments | Registering and listing students enrolled in a course |
| Attendance | Registering and listing student absences |
| Reporting | Monthly lesson reports and weekly teacher schedules |
| Integrity | Foreign keys and triggers for date and scheduling constraints |

The table describes functionality found in the SQL dump; the exact screens and workflows available in the desktop UI depend on the Java client implementation.

---

## 🧪 Testing and Verification

The Maven project declares JUnit Jupiter API and engine dependencies. No automated test commands or coverage results are documented in the repository README at present.

For a local verification pass:

1. Import the dump into a clean MySQL development database.
2. Check that the schema, stored procedures and triggers are created successfully.
3. Verify JDBC connectivity and launch the JavaFX application.
4. Test representative operations with non-production data, including invalid course date ranges and overlapping lesson times, to confirm that database constraints reject inconsistent records.
