<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Buscar Aluno</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Matrícula — Buscar Aluno</span>
    </div>
</nav>

<div class="container mt-5" style="max-width: 480px">

    <%
        String msg = request.getParameter("msg");
        String detalhe = request.getParameter("detalhe");
        if ("erro".equals(msg)) {
    %>
    <div class="alert alert-danger">
        Erro!
        <% if (detalhe != null && !detalhe.isEmpty()) { %>
            <br><small><strong>Detalhe:</strong> <%= detalhe %></small>
        <% } %>
    </div>
    <% } %>

    <div class="card p-4 shadow">
        <h5 class="mb-3">Digite o RA do aluno</h5>
        <form action="matricula" method="get">
            <div class="mb-3">
                <label>RA</label>
                <input type="number" name="ra" class="form-control" required autofocus>
            </div>
            <button type="submit" class="btn btn-primary w-100">Buscar</button>
        </form>
    </div>

    <a href="index.jsp" class="btn btn-secondary mt-3">← Voltar</a>
</div>

</body>
</html>
