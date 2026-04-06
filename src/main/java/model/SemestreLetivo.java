package model;

import java.time.LocalDate;

public class SemestreLetivo {

    private int idSemestre;
    private int ano;
    private int semestre;
    private LocalDate dataInicio;
    private LocalDate dataFim;

    public SemestreLetivo() {}

    public int getIdSemestre() { return idSemestre; }
    public void setIdSemestre(int idSemestre) { this.idSemestre = idSemestre; }

    public int getAno() { return ano; }
    public void setAno(int ano) { this.ano = ano; }

    public int getSemestre() { return semestre; }
    public void setSemestre(int semestre) { this.semestre = semestre; }

    public LocalDate getDataInicio() { return dataInicio; }
    public void setDataInicio(LocalDate dataInicio) { this.dataInicio = dataInicio; }

    public LocalDate getDataFim() { return dataFim; }
    public void setDataFim(LocalDate dataFim) { this.dataFim = dataFim; }
}