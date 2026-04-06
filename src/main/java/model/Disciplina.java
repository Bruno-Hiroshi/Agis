package model;

public class Disciplina {

    private int idDisciplina;
    private String nome;
    private int horasSemanais;

    public Disciplina() {}

    public Disciplina(int idDisciplina, String nome, int horasSemanais) {
        this.idDisciplina = idDisciplina;
        this.nome = nome;
        this.horasSemanais = horasSemanais;
    }

    public int getIdDisciplina() { return idDisciplina; }
    public void setIdDisciplina(int idDisciplina) { this.idDisciplina = idDisciplina; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public int getHorasSemanais() { return horasSemanais; }
    public void setHorasSemanais(int horasSemanais) { this.horasSemanais = horasSemanais; }
}