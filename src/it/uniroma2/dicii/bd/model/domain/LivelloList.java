package it.uniroma2.dicii.bd.model.domain;

import java.util.ArrayList;
import java.util.List;

public class LivelloList {
    List<Livello> levelli = new ArrayList<>();

    public void addLivello(Livello livello) {
        this.levelli.add(livello);
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        for(Livello livello : levelli) {
            sb.append(livello);
        }
        return sb.toString();
    }
}
