package model;

import java.time.LocalDate;

public class Aluno {

    private int ra;
    private String cpf;
    private String nome;
    private String emailPessoal;
    private String emailCorporativo;

    private LocalDate dataNascimento;
    private LocalDate dataConclusao;

    private String instituicao;
    private double pontuacaoVestibular;
    private int posicaoVestibular;

    private int anoIngresso;
    private int semestreIngresso;
    private int semestreLimite;
    private int anoLimite;

    private int idCurso;
    private String turno;


    public int getRa() { return ra; }
    public void setRa(int ra) { this.ra = ra; }

    public String getCpf() { return cpf; }
    public void setCpf(String cpf) { this.cpf = cpf; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getEmailPessoal() { return emailPessoal; }
    public void setEmailPessoal(String emailPessoal) { this.emailPessoal = emailPessoal; }

    public String getEmailCorporativo() { return emailCorporativo; }
    public void setEmailCorporativo(String emailCorporativo) { this.emailCorporativo = emailCorporativo; }

    public LocalDate getDataNascimento() { return dataNascimento; }
    public void setDataNascimento(LocalDate dataNascimento) { this.dataNascimento = dataNascimento; }

    public LocalDate getDataConclusao() { return dataConclusao; }
    public void setDataConclusao(LocalDate dataConclusao) { this.dataConclusao = dataConclusao; }

    public String getInstituicao() { return instituicao; }
    public void setInstituicao(String instituicao) { this.instituicao = instituicao; }

    public double getPontuacaoVestibular() { return pontuacaoVestibular; }
    public void setPontuacaoVestibular(double pontuacaoVestibular) { this.pontuacaoVestibular = pontuacaoVestibular; }

    public int getPosicaoVestibular() { return posicaoVestibular; }
    public void setPosicaoVestibular(int posicaoVestibular) { this.posicaoVestibular = posicaoVestibular; }

    public int getAnoIngresso() { return anoIngresso; }
    public void setAnoIngresso(int anoIngresso) { this.anoIngresso = anoIngresso; }

    public int getSemestreIngresso() { return semestreIngresso; }
    public void setSemestreIngresso(int semestreIngresso) { this.semestreIngresso = semestreIngresso; }

    public int getSemestreLimite() { return semestreLimite; }
    public void setSemestreLimite(int semestreLimite) { this.semestreLimite = semestreLimite; }

    public int getAnoLimite() { return anoLimite; }
    public void setAnoLimite(int anoLimite) { this.anoLimite = anoLimite; }

    public int getIdCurso() { return idCurso; }
    public void setIdCurso(int idCurso) { this.idCurso = idCurso; }

    public String getTurno() { return turno; }
    public void setTurno(String turno) { this.turno = turno; }
}