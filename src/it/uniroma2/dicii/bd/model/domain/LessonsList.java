package it.uniroma2.dicii.bd.model.domain;

import java.util.ArrayList;
import java.util.List;

public class LessonsList {
    List<Lesson> lessons = new ArrayList<>();

    public void addLesson(Lesson lesson) {
        this.lessons.add(lesson);
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        int i = 1;
        for(Lesson lesson : lessons) {
            sb.append(i + ") " + lesson);
            i++;
        }
        return sb.toString();
    }

}
