<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Matrícula</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Matrícula</span>
    </div>
</nav>

<div class="container mt-5">

    <%
        String msg = request.getParameter("msg");
        String detalhe = request.getParameter("detalhe");
        if ("erro".equals(msg)) {
    %>
    <div class="alert alert-danger">
        Erro ao realizar matrícula!
        <% if (detalhe != null && !detalhe.isEmpty()) { %>
        <br><small><strong>Detalhe:</strong> <%= detalhe %></small>
        <% } %>
    </div>
    <% } %>

    <form action="matricula" method="post" class="card p-4 shadow">

        <div class="mb-3">
            <label>RA do Aluno</label>
            <input type="number" name="ra" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>ID da Disciplina (Curso/Disciplina)</label>
            <input type="number" name="idCursoDisciplina" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>ID do Semestre</label>
            <input type="number" name="idSemestre" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-success">Matricular</button>
        <a href="index.jsp" class="btn btn-secondary">Voltar</a>

    </form>

</div>

</body>
</html>
