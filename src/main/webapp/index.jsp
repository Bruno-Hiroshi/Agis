<!DOCTYPE html>
<html>
<head>
    <title>Sistema Academico</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Sistema Academico</span>
    </div>
</nav>

<div class="container mt-5">

    <div class="row text-center">

        <div class="col-md-4">
            <div class="card shadow p-3">
                <h4>Alunos</h4>
                <a href="aluno.jsp" class="btn btn-primary">Cadastrar</a>
                <a href="aluno" class="btn btn-outline-primary mt-2">Listar</a>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card shadow p-3">
                <h4>Matriculas</h4>
                <a href="matricula.jsp" class="btn btn-success">Matricular</a>
            </div>
        </div>

    </div>

</div>

</body>
</html>