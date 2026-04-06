package dao;

import model.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MatriculaDAO {

    public void matricular(long ra, int idCursoDisciplina, int idSemestre) throws Exception {

        String sql = "{CALL inserir_matricula(?, ?, ?)}";

        try (Connection conn = ConnectionFactory.getConnection();
             CallableStatement stmt = conn.prepareCall(sql)) {

            stmt.setLong(1, ra);
            stmt.setInt(2, idCursoDisciplina);
            stmt.setInt(3, idSemestre);

            stmt.execute();
        }
    }

    public List<Matricula> listarPorAluno(long ra) throws Exception {

        List<Matricula> lista = new ArrayList<>();

        String sql = """
            SELECT m.id_matricula, m.status, m.nota_final,
                   d.nome AS disciplina_nome,
                   s.ano, s.semestre, s.id_semestre
            FROM matricula m
            JOIN curso_disciplina cd ON cd.id_curso_disciplina = m.id_curso_disciplina
            JOIN disciplina d ON d.id_disciplina = cd.id_disciplina
            JOIN semestre_letivo s ON s.id_semestre = m.id_semestre
            WHERE m.ra = ?
            ORDER BY s.ano DESC, s.semestre DESC
        """;

        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, ra);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {

                    Disciplina disciplina = new Disciplina();
                    disciplina.setNome(rs.getString("disciplina_nome"));

                    SemestreLetivo semestre = new SemestreLetivo();
                    semestre.setIdSemestre(rs.getInt("id_semestre"));
                    semestre.setAno(rs.getInt("ano"));
                    semestre.setSemestre(rs.getInt("semestre"));

                    CursoDisciplina cd = new CursoDisciplina();
                    cd.setDisciplina(disciplina);

                    Matricula m = new Matricula();
                    m.setIdMatricula(rs.getInt("id_matricula"));
                    m.setCursoDisciplina(cd);
                    m.setSemestre(semestre);
                    m.setStatus(rs.getString("status"));
                    m.setNotaFinal((Double) rs.getObject("nota_final"));

                    lista.add(m);
                }
            }
        }

        return lista;
    }

    public List<CursoDisciplina> listarDisponiveisPorAluno(long ra) throws Exception {

        List<CursoDisciplina> lista = new ArrayList<>();

        String sql = """
            SELECT cd.id_curso_disciplina, d.nome AS disciplina_nome,
                   d.horas_semanais, cd.dia_semana,
                   h.descricao AS horario_descricao,
                   h.hora_inicio, h.hora_fim
            FROM curso_disciplina cd
            JOIN disciplina d ON d.id_disciplina = cd.id_disciplina
            JOIN horario h ON h.id_horario = cd.id_horario
            WHERE cd.id_curso = (SELECT id_curso FROM aluno WHERE ra = ?)
            AND cd.id_curso_disciplina NOT IN (
                SELECT id_curso_disciplina FROM matricula
                WHERE ra = ? AND status = 'Aprovado'
            )
            ORDER BY d.nome
        """;

        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, ra);
            stmt.setLong(2, ra);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {

                    Disciplina disciplina = new Disciplina();
                    disciplina.setNome(rs.getString("disciplina_nome"));
                    disciplina.setHorasSemanais(rs.getInt("horas_semanais"));

                    Horario horario = new Horario();
                    horario.setDescricao(rs.getString("horario_descricao"));
                    horario.setHoraInicio(rs.getTime("hora_inicio").toLocalTime());
                    horario.setHoraFim(rs.getTime("hora_fim").toLocalTime());

                    CursoDisciplina cd = new CursoDisciplina();
                    cd.setIdCursoDisciplina(rs.getInt("id_curso_disciplina"));
                    cd.setDisciplina(disciplina);
                    cd.setDiaSemana(rs.getString("dia_semana"));
                    cd.setHorario(horario);

                    lista.add(cd);
                }
            }
        }

        return lista;
    }

    public List<SemestreLetivo> listarSemestres() throws Exception {

        List<SemestreLetivo> lista = new ArrayList<>();
        String sql = "SELECT id_semestre, ano, semestre FROM semestre_letivo ORDER BY ano DESC, semestre DESC";

        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                SemestreLetivo s = new SemestreLetivo();
                s.setIdSemestre(rs.getInt("id_semestre"));
                s.setAno(rs.getInt("ano"));
                s.setSemestre(rs.getInt("semestre"));
                lista.add(s);
            }
        }

        return lista;
    }
}