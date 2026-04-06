CREATE DATABASE AGIS
USE AGIS

CREATE TABLE curso (
  id_curso INT PRIMARY KEY CHECK (id_curso BETWEEN 0 AND 100),
  nome  VARCHAR(150) NOT NULL,
  carga_horaria  INT NOT NULL CHECK (carga_horaria > 0),
  sigla VARCHAR(10) NOT NULL UNIQUE,
  nota_enade INT CHECK (nota_enade BETWEEN 1 AND 5)
)

CREATE TABLE disciplina (
  id_disciplina  INT PRIMARY KEY CHECK (id_disciplina >= 1001),
  nome VARCHAR(100)  NOT NULL,
  horas_semanais  INT NOT NULL CHECK (horas_semanais > 0)
);

CREATE TABLE curso_disciplina (
  id_curso_disciplina INT  PRIMARY KEY IDENTITY(1,1),
  id_curso  INT NOT NULL,
  id_disciplina INT NOT NULL,
  dia_semana VARCHAR(12) NOT NULL CHECK (dia_semana IN ('Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado')),
  hora_inicio TIME NOT NULL,
  hora_fim  TIME NOT NULL,

  CONSTRAINT fk_cd_curso
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso),

  CONSTRAINT fk_cd_disciplina
    FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina),

  CONSTRAINT uq_curso_disciplina
    UNIQUE (id_curso, id_disciplina),

  CONSTRAINT chk_horario
    CHECK (hora_fim > hora_inicio)
);

CREATE TABLE conteudo (
  id_conteudo INT PRIMARY KEY IDENTITY(1,1),
  id_disciplina INT NOT NULL,
  descricao VARCHAR(255) NOT NULL,
  ordem INT NOT NULL CHECK (ordem BETWEEN 1 AND 15),

  CONSTRAINT fk_conteudo_disciplina
     FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina)
     ON DELETE CASCADE,

  CONSTRAINT uq_ordem_por_disciplina
     UNIQUE (id_disciplina, ordem)
);

CREATE TABLE aluno (
  ra INT PRIMARY KEY IDENTITY(1,1),
  cpf CHAR(11) NOT NULL UNIQUE,
  nome VARCHAR(150) NOT NULL,
  nome_social VARCHAR(150) NULL,
  data_nascimento DATE NOT NULL,
  email_pessoal  VARCHAR(150) NOT NULL,
  email_corporativo  VARCHAR(150) NOT NULL UNIQUE,
  data_conclusao_segundo_grau DATE NOT NULL,
  instituicao_segundo_grau VARCHAR(150) NOT NULL,
  pontuacao_vestibular DECIMAL(8,2) NOT NULL,
  posicao_vestibular INT NOT NULL CHECK (posicao_vestibular > 0),
  ano_ingresso INT NOT NULL,
  semestre_ingresso INT NOT NULL CHECK (semestre_ingresso IN (1, 2)),
  semestre_limite INT NOT NULL CHECK (semestre_limite IN (1, 2)),
  ano_limite INT NOT NULL,
  id_curso INT NOT NULL,
  turno VARCHAR(10) NOT NULL CHECK (turno IN ('Manhã', 'Tarde', 'Noite')),

  CONSTRAINT fk_aluno_curso
     FOREIGN KEY (id_curso) REFERENCES curso(id_curso),

  CONSTRAINT chk_ano_limite
     CHECK (
            ano_limite > ano_ingresso OR
            (ano_limite = ano_ingresso AND semestre_limite > semestre_ingresso)
            )
)


CREATE TABLE telefone_aluno (
  id_telefone INT PRIMARY KEY IDENTITY(1,1),
  ra INT NOT NULL,
  telefone VARCHAR(15) NOT NULL,

  CONSTRAINT fk_telefone_aluno
    FOREIGN KEY (ra) REFERENCES aluno(ra)
      ON DELETE CASCADE
)



CREATE TABLE semestre_letivo (
  id_semestre INT PRIMARY KEY IDENTITY(1,1),
  ano INT NOT NULL,
  semestre INT NOT NULL CHECK (semestre IN (1, 2)),
  data_inicio DATE NOT NULL,
  data_fim DATE NOT NULL,

  CONSTRAINT uq_semestre_letivo
     UNIQUE (ano, semestre),

  CONSTRAINT chk_datas_semestre
     CHECK (data_fim > data_inicio)
)

CREATE TABLE matricula (
  id_matricula INT PRIMARY KEY IDENTITY(1,1),
  ra INT             NOT NULL,
  id_curso_disciplina INT NOT NULL,
  id_semestre INT NOT NULL,
  status VARCHAR(15) NOT NULL DEFAULT 'Matriculado'
      CHECK (status IN ('Matriculado', 'Aprovado', 'Reprovado', 'Trancado', 'Cancelado')),
  nota_final DECIMAL(4,2) NULL CHECK (nota_final BETWEEN 0 AND 10),

  CONSTRAINT fk_matricula_aluno
     FOREIGN KEY (ra) REFERENCES aluno(ra),

  CONSTRAINT fk_matricula_curso_disciplina
     FOREIGN KEY (id_curso_disciplina) REFERENCES curso_disciplina(id_curso_disciplina),

  CONSTRAINT fk_matricula_semestre
     FOREIGN KEY (id_semestre) REFERENCES semestre_letivo(id_semestre),

  CONSTRAINT uq_matricula
     UNIQUE (ra, id_curso_disciplina, id_semestre)
)

CREATE TABLE horario (
 id_horario INT PRIMARY KEY IDENTITY(1,1),
 hora_inicio TIME NOT NULL,
 hora_fim TIME NOT NULL,
 qtd_aulas INT NOT NULL,
 descricao VARCHAR(50) NOT NULL,

 CONSTRAINT uq_horario UNIQUE (hora_inicio, hora_fim)
)

INSERT INTO horario (hora_inicio, hora_fim, qtd_aulas, descricao) VALUES
  ('13:00', '16:30', 4, '13h00 - 16h30 (4 aulas)'),
  ('13:00', '14:40', 2, '13h00 - 14h40 (2 aulas)'),
  ('14:50', '18:20', 4, '14h50 - 18h20 (4 aulas)'),
  ('14:50', '16:30', 2, '14h50 - 16h30 (2 aulas)'),
  ('16:40', '18:20', 2, '16h40 - 18h20 (2 aulas)');
GO

ALTER TABLE curso_disciplina DROP CONSTRAINT chk_horario;
ALTER TABLE curso_disciplina DROP COLUMN hora_inicio;
ALTER TABLE curso_disciplina DROP COLUMN hora_fim;

ALTER TABLE curso_disciplina ADD id_horario INT NOT NULL;

ALTER TABLE curso_disciplina
    ADD CONSTRAINT fk_cd_horario
        FOREIGN KEY (id_horario) REFERENCES horario(id_horario);
GO

CREATE OR ALTER PROCEDURE validar_cpf
    @cpf        CHAR(11),
    @valido     BIT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET @valido = 0;

    IF @cpf IN ('00000000000','11111111111','22222222222','33333333333',
                '44444444444','55555555555','66666666666','77777777777',
                '88888888888','99999999999')
        RETURN;

    IF LEN(@cpf) <> 11 OR @cpf NOT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
        RETURN;

    DECLARE @soma   INT = 0;
    DECLARE @resto  INT;
    DECLARE @d1     INT;
    DECLARE @d2     INT;


    SET @soma =
            CAST(SUBSTRING(@cpf,1,1) AS INT) * 10 +
            CAST(SUBSTRING(@cpf,2,1) AS INT) * 9  +
            CAST(SUBSTRING(@cpf,3,1) AS INT) * 8  +
            CAST(SUBSTRING(@cpf,4,1) AS INT) * 7  +
            CAST(SUBSTRING(@cpf,5,1) AS INT) * 6  +
            CAST(SUBSTRING(@cpf,6,1) AS INT) * 5  +
            CAST(SUBSTRING(@cpf,7,1) AS INT) * 4  +
            CAST(SUBSTRING(@cpf,8,1) AS INT) * 3  +
            CAST(SUBSTRING(@cpf,9,1) AS INT) * 2;

    SET @resto = @soma % 11;
    SET @d1 = CASE WHEN @resto < 2 THEN 0 ELSE 11 - @resto END;

    IF @d1 <> CAST(SUBSTRING(@cpf,10,1) AS INT)
        RETURN;


    SET @soma =
            CAST(SUBSTRING(@cpf,1,1) AS INT) * 11 +
            CAST(SUBSTRING(@cpf,2,1) AS INT) * 10 +
            CAST(SUBSTRING(@cpf,3,1) AS INT) * 9  +
            CAST(SUBSTRING(@cpf,4,1) AS INT) * 8  +
            CAST(SUBSTRING(@cpf,5,1) AS INT) * 7  +
            CAST(SUBSTRING(@cpf,6,1) AS INT) * 6  +
            CAST(SUBSTRING(@cpf,7,1) AS INT) * 5  +
            CAST(SUBSTRING(@cpf,8,1) AS INT) * 4  +
            CAST(SUBSTRING(@cpf,9,1) AS INT) * 3  +
            CAST(SUBSTRING(@cpf,10,1) AS INT) * 2;

    SET @resto = @soma % 11;
    SET @d2 = CASE WHEN @resto < 2 THEN 0 ELSE 11 - @resto END;

    IF @d2 <> CAST(SUBSTRING(@cpf,11,1) AS INT)
        RETURN;

    SET @valido = 1;
END;
GO

CREATE OR ALTER PROCEDURE sp_validar_idade
    @data_nascimento    DATE,
    @valido             BIT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET @valido = 0;

    IF DATEDIFF(YEAR, @data_nascimento, GETDATE()) -
       CASE
           WHEN MONTH(@data_nascimento) > MONTH(GETDATE()) THEN 1
           WHEN MONTH(@data_nascimento) = MONTH(GETDATE())
               AND DAY(@data_nascimento)   > DAY(GETDATE())   THEN 1
           ELSE 0
           END >= 16
        SET @valido = 1;
END;
GO

CREATE OR ALTER PROCEDURE calcular_prazo_graduacao
    @ano_ingresso       INT,
    @semestre_ingresso  INT,
    @ano_limite         INT OUTPUT,
    @semestre_limite    INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SET @ano_limite      = @ano_ingresso + 5;
    SET @semestre_limite = @semestre_ingresso;
END;
GO

CREATE OR ALTER PROCEDURE sp_gerar_ra
    @ano_ingresso       INT,
    @semestre_ingresso  INT,
    @ra                 BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sufixo     INT;
    DECLARE @candidato  BIGINT;

    SET @candidato = 0;
    WHILE @candidato = 0 OR EXISTS (SELECT 1 FROM aluno WHERE ra = @candidato)
        BEGIN
            SET @sufixo    = ABS(CHECKSUM(NEWID())) % 9000 + 1000; -- 1000 a 9999
            SET @candidato = CAST(@ano_ingresso AS BIGINT) * 100000
                + @semestre_ingresso            * 10000
                + @sufixo;
        END;

    SET @ra = @candidato;
END;
GO

CREATE OR ALTER PROCEDURE sp_inserir_aluno
    @cpf                            CHAR(11),
    @nome                           VARCHAR(150),
    @nome_social                    VARCHAR(150)    = NULL,
    @data_nascimento                DATE,
    @email_pessoal                  VARCHAR(150),
    @email_corporativo              VARCHAR(150),
    @data_conclusao_segundo_grau    DATE,
    @instituicao_segundo_grau       VARCHAR(150),
    @pontuacao_vestibular           DECIMAL(8,2),
    @posicao_vestibular             INT,
    @ano_ingresso                   INT,
    @semestre_ingresso              INT,
    @id_curso                       INT,
    @turno                          VARCHAR(10),
    @ra_gerado                      BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;

    BEGIN TRY

        DECLARE @cpf_valido BIT;
        EXEC validar_cpf @cpf, @cpf_valido OUTPUT;
        IF @cpf_valido = 0
            THROW 50001, 'CPF inválido.', 1;

        DECLARE @idade_valida BIT;
        EXEC sp_validar_idade @data_nascimento, @idade_valida OUTPUT;
        IF @idade_valida = 0
            THROW 50002, 'Aluno deve ter idade igual ou superior a 16 anos.', 1;

        DECLARE @ano_limite         INT;
        DECLARE @semestre_limite    INT;
        EXEC calcular_prazo_graduacao
             @ano_ingresso, @semestre_ingresso,
             @ano_limite OUTPUT, @semestre_limite OUTPUT;

        DECLARE @ra BIGINT;
        EXEC sp_gerar_ra @ano_ingresso, @semestre_ingresso, @ra OUTPUT;

        SET IDENTITY_INSERT aluno ON;
        INSERT INTO aluno (
            ra, cpf, nome, nome_social, data_nascimento,
            email_pessoal, email_corporativo,
            data_conclusao_segundo_grau, instituicao_segundo_grau,
            pontuacao_vestibular, posicao_vestibular,
            ano_ingresso, semestre_ingresso,
            semestre_limite, ano_limite,
            id_curso, turno
        )
        VALUES (
                   @ra, @cpf, @nome, @nome_social, @data_nascimento,
                   @email_pessoal, @email_corporativo,
                   @data_conclusao_segundo_grau, @instituicao_segundo_grau,
                   @pontuacao_vestibular, @posicao_vestibular,
                   @ano_ingresso, @semestre_ingresso,
                   @semestre_limite, @ano_limite,
                   @id_curso, @turno
               );
        SET IDENTITY_INSERT aluno OFF;

        SET @ra_gerado = @ra;
        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE inserir_matricula
    @ra                 BIGINT,
    @id_curso_disciplina INT,
    @id_semestre        INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;

    BEGIN TRY

        IF NOT EXISTS (SELECT 1 FROM aluno WHERE ra = @ra)
            THROW 50010, 'Aluno não encontrado.', 1;

        IF NOT EXISTS (
            SELECT 1
            FROM curso_disciplina cd
                     JOIN aluno a ON a.id_curso = cd.id_curso
            WHERE cd.id_curso_disciplina = @id_curso_disciplina
              AND a.ra = @ra
        )
            THROW 50011, 'Disciplina não pertence ao curso do aluno.', 1;

        IF EXISTS (
            SELECT 1 FROM matricula
            WHERE ra = @ra
              AND id_curso_disciplina = @id_curso_disciplina
              AND id_semestre = @id_semestre
        )
            THROW 50012, 'Aluno já matriculado nessa disciplina nesse semestre.', 1;

        IF EXISTS (
            SELECT 1 FROM matricula
            WHERE ra = @ra
              AND id_curso_disciplina = @id_curso_disciplina
              AND status = 'Aprovado'
        )
            THROW 50013, 'Aluno já foi aprovado nessa disciplina.', 1;

        IF EXISTS (
            SELECT 1
            FROM matricula m
                     JOIN curso_disciplina cd_nova
                          ON cd_nova.id_curso_disciplina = @id_curso_disciplina
                     JOIN curso_disciplina cd_exist
                          ON cd_exist.id_curso_disciplina = m.id_curso_disciplina
            WHERE m.ra          = @ra
              AND m.id_semestre = @id_semestre
              AND m.status      NOT IN ('Cancelado', 'Trancado')
              AND cd_exist.dia_semana  = cd_nova.dia_semana
              AND cd_exist.hora_inicio < cd_nova.hora_fim
              AND cd_exist.hora_fim    > cd_nova.hora_inicio
        )
            THROW 50014, 'Conflito de horário com outra disciplina já matriculada.', 1;

        INSERT INTO matricula (ra, id_curso_disciplina, id_semestre, status)
        VALUES (@ra, @id_curso_disciplina, @id_semestre, 'Matriculado');

        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO


SELECT * FROM aluno
