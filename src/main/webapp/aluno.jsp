<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cadastro de Aluno</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <script>
        // Máscara CPF
        function mascaraCPF(input) {
            let v = input.value.replace(/\D/g, '');
            v = v.replace(/(\d{3})(\d)/, '$1.$2');
            v = v.replace(/(\d{3})(\d)/, '$1.$2');
            v = v.replace(/(\d{3})(\d{1,2})$/, '$1-$2');
            input.value = v;
        }

        // Validação simples
        function validarForm() {
            let cpf = document.getElementById("cpf").value;
            let nome = document.getElementById("nome").value;

            if (nome.length < 3) {
                alert("Nome muito curto");
                return false;
            }

            if (cpf.length < 14) {
                alert("CPF inválido");
                return false;
            }

            return true;
        }
    </script>
</head>

<body class="bg-light">

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Cadastro de Aluno</span>
    </div>
</nav>

<div class="container mt-4">

    <%
        String msg = request.getParameter("msg");
        String detalhe = request.getParameter("detalhe");
        if ("ok".equals(msg)) {
    %>
    <div class="alert alert-success">Aluno cadastrado com sucesso!</div>
    <%
    } else if ("erro".equals(msg)) {
    %>
    <div class="alert alert-danger">
        Erro ao cadastrar aluno!
        <% if (detalhe != null && !detalhe.isEmpty()) { %>
        <br><small><strong>Detalhe:</strong> <%= detalhe %></small>
        <% } %>
    </div>
    <%
        }
    %>

    <form action="aluno" method="post" onsubmit="return validarForm()" class="card p-4 shadow">

        <h4 class="mb-3">Dados Pessoais</h4>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label>Nome</label>
                <input type="text" id="nome" name="nome" class="form-control" required>
            </div>

            <div class="col-md-6 mb-3">
                <label>CPF</label>
                <input type="text" id="cpf" name="cpf" class="form-control"
                       onkeyup="mascaraCPF(this)" maxlength="14" required>
            </div>
        </div>

        <div class="mb-3">
            <label>Data de Nascimento</label>
            <input type="date" name="data_nascimento" class="form-control" required>
        </div>

        <h4 class="mt-4 mb-3">Contatos</h4>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label>Email Pessoal</label>
                <input type="email" name="email_pessoal" class="form-control" required>
            </div>

            <div class="col-md-6 mb-3">
                <label>Email Corporativo</label>
                <input type="email" name="email_corporativo" class="form-control" required>
            </div>
        </div>

        <h4 class="mt-4 mb-3">Formacao</h4>

        <div class="mb-3">
            <label>Data de Conclusao</label>
            <input type="date" name="data_conclusao" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Instituicao</label>
            <input type="text" name="instituicao" class="form-control" required>
        </div>

        <h4 class="mt-4 mb-3">Vestibular</h4>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label>Pontuacao</label>
                <input type="number" step="0.01" name="pontuacao" class="form-control" required>
            </div>

            <div class="col-md-6 mb-3">
                <label>Posicao</label>
                <input type="number" name="posicao" class="form-control" required>
            </div>
        </div>

        <h4 class="mt-4 mb-3">Ingresso</h4>

        <!-- ✅ CAMPOS NOVOS: ano_ingresso e semestre_ingresso que faltavam -->
        <div class="row">
            <div class="col-md-6 mb-3">
                <label>Ano de Ingresso</label>
                <input type="number" name="ano_ingresso" class="form-control"
                       placeholder="Ex: 2024" required>
            </div>

            <div class="col-md-6 mb-3">
                <label>Semestre de Ingresso</label>
                <select name="semestre_ingresso" class="form-control">
                    <option value="1">1º Semestre</option>
                    <option value="2">2º Semestre</option>
                </select>
            </div>
        </div>

        <h4 class="mt-4 mb-3">Curso</h4>

        <div class="mb-3">
            <label>Curso</label>
            <select name="curso" class="form-control">
                <option value="1">Sistemas de Informação</option>
                <option value="2">Engenharia</option>
                <option value="3">Administração</option>
            </select>
        </div>

        <div class="mb-3">
            <label>Turno</label>
            <select name="turno" class="form-control">
                <option value="Manhã">Manhã</option>
                <option value="Tarde">Tarde</option>
                <option value="Noite">Noite</option>
            </select>
        </div>

        <div class="mt-4">
            <button type="submit" class="btn btn-primary">Cadastrar</button>
            <a href="index.jsp" class="btn btn-secondary">Voltar</a>
        </div>

    </form>

</div>

</body>
</html>
