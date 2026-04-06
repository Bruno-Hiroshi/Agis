package dao;

import model.Aluno;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AlunoDAO {

    public void inserir(Aluno a) throws Exception {

        String sql = "{CALL sp_inserir_aluno(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";

        try (Connection conn = ConnectionFactory.getConnection();
             CallableStatement cs = conn.prepareCall(sql)) {

            cs.setString(1, a.getCpf());
            cs.setString(2, a.getNome());
            cs.setString(3, null);
            cs.setDate(4, Date.valueOf(a.getDataNascimento()));
            cs.setString(5, a.getEmailPessoal());
            cs.setString(6, a.getEmailCorporativo());
            cs.setDate(7, Date.valueOf(a.getDataConclusao()));
            cs.setString(8, a.getInstituicao());
            cs.setDouble(9, a.getPontuacaoVestibular());
            cs.setInt(10, a.getPosicaoVestibular());
            cs.setInt(11, a.getAnoIngresso());
            cs.setInt(12, a.getSemestreIngresso());
            cs.setInt(13, a.getIdCurso());
            cs.setString(14, a.getTurno());
            cs.registerOutParameter(15, Types.BIGINT);

            cs.execute();
        }
    }

    public List<Aluno> listar() throws Exception {

        List<Aluno> lista = new ArrayList<>();
        String sql = "SELECT ra, nome, cpf FROM aluno ORDER BY nome";

        try (Connection conn = ConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Aluno a = new Aluno();
                a.setRa(rs.getInt("ra"));
                a.setNome(rs.getString("nome"));
                a.setCpf(rs.getString("cpf"));
                lista.add(a);
            }
        }

        return lista;
    }
}
