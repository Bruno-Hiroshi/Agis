<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Aluno" %>

<!DOCTYPE html>
<html>
<head>
    <title>Lista de Alunos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Alunos</span>
        <a href="aluno.jsp" class="btn btn-success btn-sm">+ Novo Aluno</a>
    </div>
</nav>

<div class="container mt-4">

    <input type="text" id="busca" class="form-control mb-3" placeholder="Buscar aluno...">

    <table class="table table-hover table-bordered shadow">
        <thead class="table-dark">
        <tr>
            <th>RA</th>
            <th>Nome</th>
            <th>CPF</th>
            <th>Ações</th>
        </tr>
        </thead>

        <tbody id="tabela">
        <%
            List<Aluno> alunos = (List<Aluno>) request.getAttribute("alunos");
            if (alunos != null && !alunos.isEmpty()) {
                for (Aluno a : alunos) {
        %>
        <tr>
            <td><%= a.getRa() %></td>
            <td><%= a.getNome() %></td>
            <td><%= a.getCpf() %></td>
            <td>
                <a href="aluno?acao=editar&ra=<%= a.getRa() %>" class="btn btn-warning btn-sm">Editar</a>
                <a href="aluno?acao=excluir&ra=<%= a.getRa() %>"
                   class="btn btn-danger btn-sm"
                   onclick="return confirm('Tem certeza que deseja excluir?')">Excluir</a>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="4" class="text-center">Nenhum aluno cadastrado.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

</div>

<script>
    document.getElementById("busca").addEventListener("keyup", function() {
        let filtro = this.value.toLowerCase();
        let linhas = document.querySelectorAll("#tabela tr");
        linhas.forEach(linha => {
            let texto = linha.innerText.toLowerCase();
            linha.style.display = texto.includes(filtro) ? "" : "none";
        });
    });
</script>

</body>
</html>
