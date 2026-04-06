package controller;

import dao.MatriculaDAO;
import model.CursoDisciplina;
import model.Matricula;
import model.SemestreLetivo;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

@WebServlet("/matricula")
public class MatriculaServlet extends HttpServlet {

    private MatriculaDAO dao = new MatriculaDAO();

    //Faz a lista de matricula
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String acao = req.getParameter("acao");
        String raParam = req.getParameter("ra");

        try {
            if (raParam == null || raParam.isEmpty()) {
                req.getRequestDispatcher("buscarAluno.jsp").forward(req, resp);
                return;
            }

            long ra = Long.parseLong(raParam);

            if ("minhas".equals(acao)) {
                List<Matricula> matriculas = dao.listarPorAluno(ra);
                req.setAttribute("matriculas", matriculas);
                req.setAttribute("ra", ra);
                req.getRequestDispatcher("listarMatriculas.jsp").forward(req, resp);

            } else {
                List<CursoDisciplina> disponiveis = dao.listarDisponiveisPorAluno(ra);
                List<SemestreLetivo> semestres = dao.listarSemestres();
                req.setAttribute("disponiveis", disponiveis);
                req.setAttribute("semestres", semestres);
                req.setAttribute("ra", ra);
                req.getRequestDispatcher("matricula.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("buscarAluno.jsp?msg=erro&detalhe=" +
                    URLEncoder.encode(e.getMessage() != null ? e.getMessage() : "Erro desconhecido", "UTF-8"));
        }
    }

    //Joga pro SQL
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            req.setCharacterEncoding("UTF-8");

            long ra = Long.parseLong(req.getParameter("ra"));
            int cd = Integer.parseInt(req.getParameter("idCursoDisciplina"));
            int semestre = Integer.parseInt(req.getParameter("idSemestre"));

            dao.matricular(ra, cd, semestre);

            resp.sendRedirect("matricula?acao=minhas&ra=" + ra);

        } catch (Exception e) {
            e.printStackTrace();
            String detalhe = e.getMessage() != null ? e.getMessage() : e.getClass().getSimpleName();
            String ra = req.getParameter("ra");
            resp.sendRedirect("matricula?ra=" + ra + "&msg=erro&detalhe=" +
                    URLEncoder.encode(detalhe, "UTF-8"));
        }
    }
}