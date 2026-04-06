package model;

public class Conteudo {

    private int idConteudo;
    private Disciplina disciplina;
    private String descricao;
    private int ordem;

    public Conteudo() {}

    public Conteudo(int idConteudo, Disciplina disciplina, String descricao, int ordem) {
        this.idConteudo = idConteudo;
        this.disciplina = disciplina;
        this.descricao = descricao;
        this.ordem = ordem;
    }

    public int getIdConteudo() { return idConteudo; }
    public void setIdConteudo(int idConteudo) { this.idConteudo = idConteudo; }

    public Disciplina getDisciplina() { return disciplina; }
    public void setDisciplina(Disciplina disciplina) { this.disciplina = disciplina; }

    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }

    public int getOrdem() { return ordem; }
    public void setOrdem(int ordem) { this.ordem = ordem; }
}