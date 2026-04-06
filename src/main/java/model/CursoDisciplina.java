package model;

public class CursoDisciplina {

    private int idCursoDisciplina;
    private Curso curso;
    private Disciplina disciplina;
    private String diaSemana;
    private Horario horario;

    public CursoDisciplina() {}

    public CursoDisciplina(int idCursoDisciplina, Curso curso, Disciplina disciplina,
                           String diaSemana, Horario horario) {
        this.idCursoDisciplina = idCursoDisciplina;
        this.curso = curso;
        this.disciplina = disciplina;
        this.diaSemana = diaSemana;
        this.horario = horario;
    }

    public int getIdCursoDisciplina() { return idCursoDisciplina; }
    public void setIdCursoDisciplina(int idCursoDisciplina) { this.idCursoDisciplina = idCursoDisciplina; }

    public Curso getCurso() { return curso; }
    public void setCurso(Curso curso) { this.curso = curso; }

    public Disciplina getDisciplina() { return disciplina; }
    public void setDisciplina(Disciplina disciplina) { this.disciplina = disciplina; }

    public String getDiaSemana() { return diaSemana; }
    public void setDiaSemana(String diaSemana) { this.diaSemana = diaSemana; }

    public Horario getHorario() { return horario; }
    public void setHorario(Horario horario) { this.horario = horario; }
}