<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.CursoDisciplina" %>
<%@ page import="model.SemestreLetivo" %>
<!DOCTYPE html>
<html>
<head>
    <title>Nova Matrícula</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Nova Matrícula — RA: <%= request.getAttribute("ra") %></span>
    </div>
</nav>

<div class="container mt-4">

    <form action="matricula" method="post">

        <input type="hidden" name="ra" value="<%= request.getAttribute("ra") %>">

        <div class="mb-4">
            <label class="form-label fw-bold">Semestre Letivo</label>
            <select name="idSemestre" class="form-select" required>
                <option value="">Selecione o semestre...</option>
                <%
                    List<SemestreLetivo> semestres = (List<SemestreLetivo>) request.getAttribute("semestres");
                    if (semestres != null) {
                        for (SemestreLetivo s : semestres) {
                %>
                <option value="<%= s.getIdSemestre() %>">
                    <%= s.getAno() %> — <%= s.getSemestre() %>º Semestre
                </option>
                <%
                        }
                    }
                %>
            </select>
        </div>

        <h5 class="mb-3">Disciplinas Disponíveis</h5>

        <%
            List<CursoDisciplina> disponiveis = (List<CursoDisciplina>) request.getAttribute("disponiveis");
            if (disponiveis != null && !disponiveis.isEmpty()) {
        %>
        <table class="table table-hover table-bordered shadow">
            <thead class="table-dark">
            <tr>
                <th>Selecionar</th>
                <th>Disciplina</th>
                <th>Dia</th>
                <th>Horário</th>
                <th>Horas/Semana</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (CursoDisciplina cd : disponiveis) {
            %>
            <tr>

                <td class="text-center">
                    <input type="radio" name="idCursoDisciplina"
                           value="<%= cd.getIdCursoDisciplina() %>" required>
                </td>
                <td><%= cd.getDisciplina().getNome() %></td>
                <td><%= cd.getDiaSemana() %></td>
                <td><%= cd.getHorario().getDescricao() %></td>
                <td><%= cd.getDisciplina().getHorasSemanais() %>h</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>

        <button type="submit" class="btn btn-success">Confirmar Matrícula</button>
        <%
            } else {
        %>
        <div class="alert alert-info">Não há disciplinas disponíveis para matrícula.</div>
        <%
            }
        %>

        <a href="matricula?ra=<%= request.getAttribute("ra") %>"
           class="btn btn-secondary ms-2">← Voltar</a>
    </form>

</div>

</body>
</html>
