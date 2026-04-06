<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Matricula" %>
<!DOCTYPE html>
<html>
<head>
    <title>Minhas Matrículas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Minhas Matrículas</span>
        <a href="matricula?ra=<%= request.getAttribute("ra") %>"
           class="btn btn-success btn-sm">+ Nova Matrícula</a>
    </div>
</nav>

<div class="container mt-4">

    <h5 class="mb-3">RA: <strong><%= request.getAttribute("ra") %></strong></h5>

    <table class="table table-hover table-bordered shadow">
        <thead class="table-dark">
        <tr>
            <th>#</th>
            <th>Disciplina</th>
            <th>Ano/Semestre</th>
            <th>Status</th>
            <th>Nota Final</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Matricula> matriculas = (List<Matricula>) request.getAttribute("matriculas");
            if (matriculas != null && !matriculas.isEmpty()) {
                for (Matricula m : matriculas) {
        %>
        <tr>
            <td><%= m.getIdMatricula() %></td>
            <td><%= m.getCursoDisciplina().getDisciplina().getNome() %></td>
            <td><%= m.getSemestre().getAno() %>/<%= m.getSemestre().getSemestre() %>º</td>
            <td>

                <%
                    String status = m.getStatus();
                    String badge = "secondary";
                    if ("Aprovado".equals(status)) badge = "success";
                    else if ("Reprovado".equals(status)) badge = "danger";
                    else if ("Matriculado".equals(status)) badge = "primary";
                    else if ("Trancado".equals(status)) badge = "warning";
                    else if ("Cancelado".equals(status)) badge = "dark";
                %>
                <span class="badge bg-<%= badge %>"><%= status %></span>
            </td>
            <td><%= m.getNotaFinal() != null ? m.getNotaFinal() : "-" %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="5" class="text-center">Nenhuma matrícula encontrada.</td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <a href="buscarAluno.jsp" class="btn btn-secondary">← Voltar</a>

</div>
</body>
</html>
