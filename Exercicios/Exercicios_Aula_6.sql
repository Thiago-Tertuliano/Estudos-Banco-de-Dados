-- =====================================================
-- EXERCÍCIOS AULA 6: ORDENAÇÃO E LIMITAÇÃO DE RESULTADOS
-- =====================================================

-- =====================================================
-- PREPARAÇÃO: Criação das Tabelas e Dados
-- =====================================================

-- Crie as tabelas necessárias para os exercícios
CREATE TABLE alunos (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  data_nascimento DATE,
  curso VARCHAR(100),
  nota_media DECIMAL(4,2),
  semestre INTEGER,
  ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE professores (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  departamento VARCHAR(100),
  salario DECIMAL(10,2),
  data_contratacao DATE,
  ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE disciplinas (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(200) NOT NULL,
  codigo VARCHAR(20) UNIQUE NOT NULL,
  creditos INTEGER,
  carga_horaria INTEGER,
  departamento VARCHAR(100),
  ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE notas (
  id SERIAL PRIMARY KEY,
  aluno_id INTEGER NOT NULL,
  disciplina_id INTEGER NOT NULL,
  professor_id INTEGER NOT NULL,
  nota DECIMAL(4,2) CHECK (nota >= 0 AND nota <= 10),
  data_avaliacao DATE,
  tipo_avaliacao VARCHAR(50) DEFAULT 'Prova' CHECK (tipo_avaliacao IN ('Prova', 'Trabalho', 'Apresentação', 'Projeto'))
);

-- Insira dados de exemplo
INSERT INTO alunos (nome, email, data_nascimento, curso, nota_media, semestre) VALUES
('Ana Silva', 'ana@universidade.com', '2000-03-15', 'Ciência da Computação', 8.5, 4),
('Carlos Santos', 'carlos@universidade.com', '1999-07-22', 'Engenharia de Software', 7.8, 6),
('Maria Costa', 'maria@universidade.com', '2001-11-08', 'Sistemas de Informação', 9.2, 3),
('Pedro Oliveira', 'pedro@universidade.com', '1998-05-30', 'Ciência da Computação', 6.9, 8),
('Lucia Ferreira', 'lucia@universidade.com', '2002-01-12', 'Engenharia de Software', 8.7, 2),
('Roberto Lima', 'roberto@universidade.com', '1997-09-25', 'Sistemas de Informação', 7.5, 7),
('Fernanda Alves', 'fernanda@universidade.com', '2000-12-03', 'Ciência da Computação', 9.0, 5),
('Marcos Pereira', 'marcos@universidade.com', '1999-04-18', 'Engenharia de Software', 8.1, 6),
('Patricia Souza', 'patricia@universidade.com', '2001-08-14', 'Sistemas de Informação', 7.3, 4),
('João Silva', 'joao@universidade.com', '1998-06-20', 'Ciência da Computação', 8.9, 7);

INSERT INTO professores (nome, email, departamento, salario, data_contratacao) VALUES
('Dr. José Silva', 'jose@universidade.com', 'Computação', 8500.00, '2018-03-01'),
('Dra. Maria Santos', 'maria.prof@universidade.com', 'Computação', 9200.00, '2019-08-15'),
('Dr. Carlos Costa', 'carlos.prof@universidade.com', 'Matemática', 7800.00, '2020-01-10'),
('Dra. Ana Oliveira', 'ana.prof@universidade.com', 'Computação', 8900.00, '2017-06-20'),
('Dr. Pedro Ferreira', 'pedro.prof@universidade.com', 'Física', 8200.00, '2021-02-01'),
('Dra. Lucia Lima', 'lucia.prof@universidade.com', 'Computação', 9500.00, '2016-09-15'),
('Dr. Roberto Alves', 'roberto.prof@universidade.com', 'Matemática', 7600.00, '2022-03-01'),
('Dra. Fernanda Pereira', 'fernanda.prof@universidade.com', 'Computação', 8800.00, '2018-11-10');

INSERT INTO disciplinas (nome, codigo, creditos, carga_horaria, departamento) VALUES
('Programação I', 'COMP101', 4, 60, 'Computação'),
('Cálculo I', 'MAT101', 4, 60, 'Matemática'),
('Algoritmos e Estruturas de Dados', 'COMP201', 4, 60, 'Computação'),
('Banco de Dados', 'COMP301', 4, 60, 'Computação'),
('Programação II', 'COMP102', 4, 60, 'Computação'),
('Cálculo II', 'MAT102', 4, 60, 'Matemática'),
('Sistemas Operacionais', 'COMP401', 4, 60, 'Computação'),
('Redes de Computadores', 'COMP501', 4, 60, 'Computação'),
('Física I', 'FIS101', 4, 60, 'Física'),
('Estatística', 'MAT201', 3, 45, 'Matemática');

INSERT INTO notas (aluno_id, disciplina_id, professor_id, nota, data_avaliacao, tipo_avaliacao) VALUES
(1, 1, 1, 9.0, '2024-01-15', 'Prova'),
(1, 2, 3, 8.5, '2024-01-20', 'Prova'),
(2, 1, 1, 7.5, '2024-01-15', 'Prova'),
(2, 3, 2, 8.0, '2024-02-01', 'Trabalho'),
(3, 1, 1, 9.5, '2024-01-15', 'Prova'),
(3, 4, 4, 9.0, '2024-02-10', 'Projeto'),
(4, 2, 3, 6.5, '2024-01-20', 'Prova'),
(4, 5, 1, 7.0, '2024-02-05', 'Prova'),
(5, 1, 1, 8.8, '2024-01-15', 'Prova'),
(5, 3, 2, 9.2, '2024-02-01', 'Apresentação'),
(6, 4, 4, 7.8, '2024-02-10', 'Projeto'),
(6, 6, 3, 7.5, '2024-02-15', 'Prova'),
(7, 1, 1, 9.3, '2024-01-15', 'Prova'),
(7, 7, 6, 8.9, '2024-03-01', 'Trabalho'),
(8, 2, 3, 8.0, '2024-01-20', 'Prova'),
(8, 5, 1, 8.2, '2024-02-05', 'Prova'),
(9, 3, 2, 7.1, '2024-02-01', 'Trabalho'),
(9, 8, 8, 7.4, '2024-03-05', 'Projeto'),
(10, 1, 1, 9.1, '2024-01-15', 'Prova'),
(10, 4, 4, 8.7, '2024-02-10', 'Projeto');

-- =====================================================
-- EXERCÍCIO 1: Ordenação Básica (ORDER BY)
-- =====================================================

-- 1.1 Liste alunos ordenados por nome (A-Z)
SELECT * FROM alunos ORDER BY nome ASC;

-- 1.2 Liste professores ordenados por salário (maior primeiro)
SELECT * FROM professores ORDER BY salario DESC;

-- 1.3 Liste disciplinas ordenadas por código
SELECT * FROM disciplinas ORDER BY codigo ASC;

-- 1.4 Liste notas ordenadas por data (mais recente primeiro)
SELECT * FROM notas ORDER BY data_avaliacao DESC;

-- 1.5 Liste alunos ordenados por nota média (maior primeiro)
SELECT * FROM alunos ORDER BY nota_media DESC;

-- =====================================================
-- EXERCÍCIO 2: Ordenação Múltipla
-- =====================================================

-- 2.1 Liste alunos ordenados por curso e depois por nome
SELECT * FROM alunos ORDER BY curso, nome;

-- 2.2 Liste professores ordenados por departamento e depois por salário (maior primeiro)
SELECT * FROM professores ORDER BY departamento, salario DESC;

-- 2.3 Liste disciplinas ordenadas por departamento e depois por carga horária (maior primeiro)
SELECT * FROM disciplinas ORDER BY departamento, carga_horaria DESC;

-- 2.4 Liste notas ordenadas por tipo de avaliação e depois por nota (maior primeiro)
SELECT * FROM notas ORDER BY tipo_avaliacao, nota DESC;

-- 2.5 Liste alunos ordenados por semestre e depois por nota média (maior primeiro)
SELECT * FROM alunos ORDER BY semestre, nota_media DESC;

-- =====================================================
-- EXERCÍCIO 3: Ordenação com Filtros
-- =====================================================

-- 3.1 Liste alunos ativos ordenados por nome
SELECT * FROM alunos WHERE ativo = TRUE ORDER BY nome;

-- 3.2 Liste professores com salário maior que 8000, ordenados por salário
SELECT * FROM professores WHERE salario > 8000 ORDER BY salario DESC;

-- 3.3 Liste disciplinas de Computação ordenadas por código
SELECT * FROM disciplinas WHERE departamento = 'Computação' ORDER BY codigo;

-- 3.4 Liste notas com nota maior que 8, ordenadas por data
SELECT * FROM notas WHERE nota > 8 ORDER BY data_avaliacao DESC;

-- 3.5 Liste alunos com nota média maior que 8, ordenados por curso e nome
SELECT * FROM alunos WHERE nota_media > 8 ORDER BY curso, nome;

-- =====================================================
-- EXERCÍCIO 4: Limitação de Resultados (LIMIT)
-- =====================================================

-- 4.1 Liste apenas os 3 primeiros alunos
SELECT * FROM alunos LIMIT 3;

-- 4.2 Liste os 5 professores com maior salário
SELECT * FROM professores ORDER BY salario DESC LIMIT 5;

-- 4.3 Liste as 3 notas mais recentes
SELECT * FROM notas ORDER BY data_avaliacao DESC LIMIT 3;

-- 4.4 Liste os 2 alunos com menor nota média
SELECT * FROM alunos ORDER BY nota_media ASC LIMIT 2;

-- 4.5 Liste as 4 disciplinas com maior carga horária
SELECT * FROM disciplinas ORDER BY carga_horaria DESC LIMIT 4;

-- =====================================================
-- EXERCÍCIO 5: Combinação de Ordenação e Limitação
-- =====================================================

-- 5.1 Liste os 3 alunos com maior nota média
SELECT * FROM alunos ORDER BY nota_media DESC LIMIT 3;

-- 5.2 Liste os 5 professores mais antigos (ordenados por data de contratação)
SELECT * FROM professores ORDER BY data_contratacao ASC LIMIT 5;

-- 5.3 Liste as 3 notas mais altas
SELECT * FROM notas ORDER BY nota DESC LIMIT 3;

-- 5.4 Liste os 2 alunos mais jovens (ordenados por data de nascimento)
SELECT * FROM alunos ORDER BY data_nascimento DESC LIMIT 2;

-- 5.5 Liste as 4 disciplinas de Computação ordenadas por código
SELECT * FROM disciplinas WHERE departamento = 'Computação' ORDER BY codigo LIMIT 4;

-- =====================================================
-- EXERCÍCIO 6: Ordenação com Aliases
-- =====================================================

-- 6.1 Liste alunos com alias e ordenados por nota média
SELECT 
  nome AS nome_aluno,
  curso AS curso_aluno,
  nota_media AS media_notas
FROM alunos 
ORDER BY media_notas DESC;

-- 6.2 Liste professores com alias e ordenados por salário
SELECT 
  nome AS nome_professor,
  departamento AS dept_professor,
  salario AS salario_professor
FROM professores 
ORDER BY salario_professor DESC;

-- 6.3 Liste disciplinas com alias e ordenadas por carga horária
SELECT 
  nome AS nome_disciplina,
  codigo AS codigo_disciplina,
  carga_horaria AS horas_disciplina
FROM disciplinas 
ORDER BY horas_disciplina DESC;

-- =====================================================
-- EXERCÍCIO 7: Ordenação com Funções Agregadas
-- =====================================================

-- 7.1 Liste departamentos ordenados por número de professores
SELECT 
  departamento,
  COUNT(*) AS total_professores
FROM professores 
GROUP BY departamento 
ORDER BY total_professores DESC;

-- 7.2 Liste cursos ordenados por média das notas dos alunos
SELECT 
  curso,
  AVG(nota_media) AS media_curso
FROM alunos 
GROUP BY curso 
ORDER BY media_curso DESC;

-- 7.3 Liste tipos de avaliação ordenados por média das notas
SELECT 
  tipo_avaliacao,
  AVG(nota) AS media_nota
FROM notas 
GROUP BY tipo_avaliacao 
ORDER BY media_nota DESC;

-- 7.4 Liste departamentos ordenados por média salarial
SELECT 
  departamento,
  AVG(salario) AS media_salario
FROM professores 
GROUP BY departamento 
ORDER BY media_salario DESC;

-- =====================================================
-- EXERCÍCIO 8: Ordenação com Subconsultas
-- =====================================================

-- 8.1 Liste alunos com nota média acima da média geral, ordenados por nota
SELECT * FROM alunos 
WHERE nota_media > (SELECT AVG(nota_media) FROM alunos)
ORDER BY nota_media DESC;

-- 8.2 Liste professores com salário acima da média do departamento
SELECT p.* FROM professores p
WHERE p.salario > (
  SELECT AVG(salario) 
  FROM professores 
  WHERE departamento = p.departamento
)
ORDER BY p.salario DESC;

-- 8.3 Liste disciplinas com carga horária maior que a média, ordenadas por carga
SELECT * FROM disciplinas 
WHERE carga_horaria > (SELECT AVG(carga_horaria) FROM disciplinas)
ORDER BY carga_horaria DESC;

-- =====================================================
-- EXERCÍCIO 9: Ordenação com JOINs
-- =====================================================

-- 9.1 Liste notas com nome do aluno e disciplina, ordenadas por nota
SELECT 
  a.nome AS nome_aluno,
  d.nome AS nome_disciplina,
  n.nota,
  n.data_avaliacao
FROM notas n
JOIN alunos a ON n.aluno_id = a.id
JOIN disciplinas d ON n.disciplina_id = d.id
ORDER BY n.nota DESC;

-- 9.2 Liste professores com número de disciplinas que lecionam, ordenados por quantidade
SELECT 
  p.nome AS nome_professor,
  p.departamento,
  COUNT(DISTINCT n.disciplina_id) AS total_disciplinas
FROM professores p
JOIN notas n ON p.id = n.professor_id
GROUP BY p.id, p.nome, p.departamento
ORDER BY total_disciplinas DESC;

-- 9.3 Liste alunos com suas melhores notas, ordenados por nota
SELECT 
  a.nome AS nome_aluno,
  a.curso,
  MAX(n.nota) AS melhor_nota
FROM alunos a
JOIN notas n ON a.id = n.aluno_id
GROUP BY a.id, a.nome, a.curso
ORDER BY melhor_nota DESC;

-- =====================================================
-- EXERCÍCIO 10: Desafios Avançados
-- =====================================================

-- 10.1 Liste os top 3 alunos por curso (maior nota média)
SELECT 
  nome,
  curso,
  nota_media,
  ROW_NUMBER() OVER (PARTITION BY curso ORDER BY nota_media DESC) AS ranking
FROM alunos
ORDER BY curso, nota_media DESC;

-- 10.2 Liste professores com ranking de salário por departamento
SELECT 
  nome,
  departamento,
  salario,
  RANK() OVER (PARTITION BY departamento ORDER BY salario DESC) AS ranking_salario
FROM professores
ORDER BY departamento, ranking_salario;

-- 10.3 Liste disciplinas com ranking de carga horária
SELECT 
  nome,
  codigo,
  carga_horaria,
  DENSE_RANK() OVER (ORDER BY carga_horaria DESC) AS ranking_carga
FROM disciplinas
ORDER BY ranking_carga;

-- 10.4 Liste alunos com percentil de nota média
SELECT 
  nome,
  curso,
  nota_media,
  PERCENT_RANK() OVER (ORDER BY nota_media) AS percentil
FROM alunos
ORDER BY nota_media DESC;

-- 10.5 Liste notas com média móvel de 3 períodos
SELECT 
  aluno_id,
  data_avaliacao,
  nota,
  AVG(nota) OVER (
    ORDER BY data_avaliacao 
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
  ) AS media_movel
FROM notas
ORDER BY data_avaliacao;

-- =====================================================
-- LIMPEZA (OPCIONAL - DESCOMENTE PARA EXCLUIR AS TABELAS)
-- =====================================================

-- DROP TABLE IF EXISTS notas;
-- DROP TABLE IF EXISTS disciplinas;
-- DROP TABLE IF EXISTS professores;
-- DROP TABLE IF EXISTS alunos; 