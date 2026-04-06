package controller;

import model.Aluno;
import dao.AlunoDAO;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/aluno")
public class AlunoServlet extends HttpServlet {

    private AlunoDAO dao = new AlunoDAO();

    //Faz a lista de aluno
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            List<Aluno> alunos = dao.listar();
            req.setAttribute("alunos", alunos);
            req.getRequestDispatcher("listar.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("listar.jsp?msg=erro");
        }
    }

    //Manda pro SQL
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            req.setCharacterEncoding("UTF-8");

            Aluno a = new Aluno();

            a.setNome(req.getParameter("nome"));
            a.setCpf(req.getParameter("cpf").replaceAll("\\D", ""));
            a.setEmailPessoal(req.getParameter("email_pessoal"));
            a.setEmailCorporativo(req.getParameter("email_corporativo"));
            a.setDataNascimento(LocalDate.parse(req.getParameter("data_nascimento")));
            a.setDataConclusao(LocalDate.parse(req.getParameter("data_conclusao")));
            a.setInstituicao(req.getParameter("instituicao"));
            a.setPontuacaoVestibular(Double.parseDouble(req.getParameter("pontuacao")));
            a.setPosicaoVestibular(Integer.parseInt(req.getParameter("posicao")));
            a.setAnoIngresso(Integer.parseInt(req.getParameter("ano_ingresso")));
            a.setSemestreIngresso(Integer.parseInt(req.getParameter("semestre_ingresso")));
            a.setIdCurso(Integer.parseInt(req.getParameter("curso")));
            a.setTurno(req.getParameter("turno"));

            dao.inserir(a);

            resp.sendRedirect("aluno.jsp?msg=ok");

        } catch (Exception e) {
            e.printStackTrace();
            String detalhe = e.getMessage() != null ? e.getMessage() : e.getClass().getSimpleName();
            resp.sendRedirect("aluno.jsp?msg=erro&detalhe=" +
                    URLEncoder.encode(detalhe, "UTF-8"));
        }
    }
}