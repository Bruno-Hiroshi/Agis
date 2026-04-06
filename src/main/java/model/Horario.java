package model;

import java.time.LocalTime;

public class Horario {

    private int idHorario;
    private LocalTime horaInicio;
    private LocalTime horaFim;
    private int qtdAulas;
    private String descricao;

    public Horario() {}

    public Horario(int idHorario, LocalTime horaInicio, LocalTime horaFim, int qtdAulas, String descricao) {
        this.idHorario = idHorario;
        this.horaInicio = horaInicio;
        this.horaFim = horaFim;
        this.qtdAulas = qtdAulas;
        this.descricao = descricao;
    }

    public int getIdHorario() { return idHorario; }
    public void setIdHorario(int idHorario) { this.idHorario = idHorario; }

    public LocalTime getHoraInicio() { return horaInicio; }
    public void setHoraInicio(LocalTime horaInicio) { this.horaInicio = horaInicio; }

    public LocalTime getHoraFim() { return horaFim; }
    public void setHoraFim(LocalTime horaFim) { this.horaFim = horaFim; }

    public int getQtdAulas() { return qtdAulas; }
    public void setQtdAulas(int qtdAulas) { this.qtdAulas = qtdAulas; }

    public String getDescricao() { return descricao; }
    public void setDescricao(String descricao) { this.descricao = descricao; }
}