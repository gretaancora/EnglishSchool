package it.uniroma2.dicii.bd.model.domain;

public enum Level {
    A1(1),
    A2(2),
    B1(3),
    B2(4),
    C1(5),
    C2(6);

    private final int lev;

    Level(int lev) { this.lev = lev; }

    public static Level fromInt(int lev) {
        for (Level livello : values()) {
            if (livello.getLev() == lev) {
                return livello;
            }
        }
        return null;
    }

    public int getLev() {
        return lev;
    }

}
