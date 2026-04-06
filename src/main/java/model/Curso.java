package model;

public class Curso {

    private int idCurso;
    private String nome;
    private int cargaHoraria;
    private String sigla;
    private Integer notaEnade;

    public Curso() {}

    public Curso(int idCurso, String nome, int cargaHoraria, String sigla, Integer notaEnade) {
        this.idCurso = idCurso;
        this.nome = nome;
        this.cargaHoraria = cargaHoraria;
        this.sigla = sigla;
        this.notaEnade = notaEnade;
    }

    public int getIdCurso() { return idCurso; }
    public void setIdCurso(int idCurso) { this.idCurso = idCurso; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public int getCargaHoraria() { return cargaHoraria; }
    public void setCargaHoraria(int cargaHoraria) { this.cargaHoraria = cargaHoraria; }

    public String getSigla() { return sigla; }
    public void setSigla(String sigla) { this.sigla = sigla; }

    public Integer getNotaEnade() { return notaEnade; }
    public void setNotaEnade(Integer notaEnade) { this.notaEnade = notaEnade; }
}