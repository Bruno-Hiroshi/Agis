package model;

public class Matricula {

    private int idMatricula;
    private Aluno aluno;
    private CursoDisciplina cursoDisciplina;
    private SemestreLetivo semestre;
    private String status;
    private Double notaFinal;

    public Matricula() {}

    public int getIdMatricula() { return idMatricula; }
    public void setIdMatricula(int idMatricula) { this.idMatricula = idMatricula; }

    public Aluno getAluno() { return aluno; }
    public void setAluno(Aluno aluno) { this.aluno = aluno; }

    public CursoDisciplina getCursoDisciplina() { return cursoDisciplina; }
    public void setCursoDisciplina(CursoDisciplina cursoDisciplina) { this.cursoDisciplina = cursoDisciplina; }

    public SemestreLetivo getSemestre() { return semestre; }
    public void setSemestre(SemestreLetivo semestre) { this.semestre = semestre; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Double getNotaFinal() { return notaFinal; }
    public void setNotaFinal(Double notaFinal) { this.notaFinal = notaFinal; }
}