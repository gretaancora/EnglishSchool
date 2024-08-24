package it.uniroma2.dicii.bd.model.domain;

public enum Level {
    CKET(1),
    CPET(2),
    CFCE(3),
    CCAE(4),
    CCPE(5);

    private final int lev;

    private Level(int lev) { this.lev = lev; }

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
