<%@ page import="model.Aluno" %>

<%
    Aluno a = (Aluno) request.getAttribute("aluno");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Editar Aluno</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container mt-5">

    <h2>Editar Aluno</h2>

    <form action="aluno" method="post" class="card p-4 shadow">

        <input type="hidden" name="acao" value="atualizar">

        <div class="mb-3">
            <label>RA</label>
            <input type="text" name="ra" class="form-control" value="<%= a.getRa() %>" readonly>
        </div>

        <div class="mb-3">
            <label>Nome</label>
            <input type="text" name="nome" class="form-control" value="<%= a.getNome() %>">
        </div>

        <div class="mb-3">
            <label>CPF</label>
            <input type="text" name="cpf" class="form-control" value="<%= a.getCpf() %>">
        </div>

        <button class="btn btn-primary">Atualizar</button>
        <a href="aluno" class="btn btn-secondary">Voltar</a>

    </form>

</div>

</body>
</html>