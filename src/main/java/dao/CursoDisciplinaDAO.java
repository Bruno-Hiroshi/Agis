package dao;

import model.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CursoDisciplinaDAO {

    public List<CursoDisciplina> listar() {

        List<CursoDisciplina> lista = new ArrayList<>();

        String sql = """
            SELECT cd.*, 
                   c.nome AS curso_nome,
                   d.nome AS disciplina_nome,
                   h.hora_inicio, h.hora_fim, h.descricao
            FROM curso_disciplina cd
            JOIN curso c ON c.id_curso = cd.id_curso
            JOIN disciplina d ON d.id_disciplina = cd.id_disciplina
            JOIN horario h ON h.id_horario = cd.id_horario
        """;

        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {

                Curso curso = new Curso();
                curso.setNome(rs.getString("curso_nome"));

                Disciplina disciplina = new Disciplina();
                disciplina.setNome(rs.getString("disciplina_nome"));

                Horario horario = new Horario();
                horario.setHoraInicio(rs.getTime("hora_inicio").toLocalTime());
                horario.setHoraFim(rs.getTime("hora_fim").toLocalTime());
                horario.setDescricao(rs.getString("descricao"));

                CursoDisciplina cd = new CursoDisciplina();
                cd.setIdCursoDisciplina(rs.getInt("id_curso_disciplina"));
                cd.setCurso(curso);
                cd.setDisciplina(disciplina);
                cd.setDiaSemana(rs.getString("dia_semana"));
                cd.setHorario(horario);

                lista.add(cd);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar curso_disciplina: " + e.getMessage());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return lista;
    }
}