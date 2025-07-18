-- =====================================================
-- EXERCÍCIOS AULA 5: OPERADORES LÓGICOS E FILTROS AVANÇADOS
-- =====================================================

-- =====================================================
-- PREPARAÇÃO: Criação das Tabelas e Dados
-- =====================================================

-- Crie as tabelas necessárias para os exercícios
CREATE TABLE funcionarios (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  salario DECIMAL(10,2) NOT NULL CHECK (salario > 0),
  departamento VARCHAR(100) NOT NULL,
  data_admissao DATE NOT NULL,
  data_nascimento DATE,
  cidade VARCHAR(100),
  estado VARCHAR(2),
  ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE projetos (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(200) NOT NULL,
  descricao TEXT,
  orcamento DECIMAL(12,2),
  data_inicio DATE,
  data_fim DATE,
  status VARCHAR(50) DEFAULT 'Em Andamento' CHECK (status IN ('Em Andamento', 'Concluído', 'Cancelado', 'Pausado')),
  prioridade VARCHAR(20) DEFAULT 'Média' CHECK (prioridade IN ('Baixa', 'Média', 'Alta', 'Crítica')),
  ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE tarefas (
  id SERIAL PRIMARY KEY,
  titulo VARCHAR(200) NOT NULL,
  descricao TEXT,
  projeto_id INTEGER NOT NULL,
  funcionario_id INTEGER,
  data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  data_limite DATE,
  data_conclusao DATE,
  status VARCHAR(50) DEFAULT 'Pendente' CHECK (status IN ('Pendente', 'Em Andamento', 'Concluída', 'Cancelada')),
  prioridade VARCHAR(20) DEFAULT 'Média' CHECK (prioridade IN ('Baixa', 'Média', 'Alta', 'Crítica')),
  horas_estimadas INTEGER,
  horas_reais INTEGER
);

-- Insira dados de exemplo
INSERT INTO funcionarios (nome, email, salario, departamento, data_admissao, data_nascimento, cidade, estado) VALUES
('João Silva', 'joao@empresa.com', 3500.00, 'TI', '2023-01-15', '1990-05-15', 'São Paulo', 'SP'),
('Maria Santos', 'maria@empresa.com', 4200.00, 'RH', '2023-03-20', '1985-08-22', 'Rio de Janeiro', 'RJ'),
('Pedro Costa', 'pedro@empresa.com', 3800.00, 'Vendas', '2023-06-10', '1992-03-10', 'Belo Horizonte', 'MG'),
('Ana Oliveira', 'ana@empresa.com', 3200.00, 'TI', '2023-02-01', '1988-12-05', 'São Paulo', 'SP'),
('Carlos Ferreira', 'carlos@empresa.com', 4500.00, 'Marketing', '2023-04-15', '1995-07-18', 'Curitiba', 'PR'),
('Lucia Pereira', 'lucia@empresa.com', 3600.00, 'Financeiro', '2023-05-20', '1991-11-30', 'Porto Alegre', 'RS'),
('Roberto Alves', 'roberto@empresa.com', 4100.00, 'Vendas', '2023-07-01', '1987-04-22', 'Salvador', 'BA'),
('Fernanda Lima', 'fernanda@empresa.com', 3900.00, 'TI', '2023-08-10', '1993-09-14', 'Brasília', 'DF'),
('Marcos Souza', 'marcos@empresa.com', 3400.00, 'RH', '2023-09-05', '1989-06-12', 'São Paulo', 'SP'),
('Patricia Costa', 'patricia@empresa.com', 4300.00, 'Marketing', '2023-10-01', '1994-03-25', 'Rio de Janeiro', 'RJ');

INSERT INTO projetos (nome, descricao, orcamento, data_inicio, data_fim, status, prioridade) VALUES
('Sistema ERP', 'Desenvolvimento de sistema ERP completo', 50000.00, '2024-01-01', '2024-06-30', 'Em Andamento', 'Alta'),
('Site Corporativo', 'Redesign do site da empresa', 15000.00, '2024-02-01', '2024-04-30', 'Em Andamento', 'Média'),
('App Mobile', 'Desenvolvimento de aplicativo mobile', 30000.00, '2024-03-01', '2024-08-31', 'Em Andamento', 'Alta'),
('Migração BD', 'Migração de banco de dados', 8000.00, '2024-01-15', '2024-03-15', 'Concluído', 'Crítica'),
('Treinamento TI', 'Programa de treinamento para equipe TI', 5000.00, '2024-02-15', '2024-05-15', 'Em Andamento', 'Baixa'),
('Automação RH', 'Automação de processos de RH', 12000.00, '2024-01-20', '2024-04-20', 'Pausado', 'Média'),
('Segurança', 'Implementação de políticas de segurança', 25000.00, '2024-03-01', '2024-07-31', 'Em Andamento', 'Crítica'),
('Backup Cloud', 'Migração de backup para cloud', 10000.00, '2024-02-01', '2024-03-31', 'Concluído', 'Alta');

INSERT INTO tarefas (titulo, descricao, projeto_id, funcionario_id, data_limite, status, prioridade, horas_estimadas, horas_reais) VALUES
('Análise de Requisitos', 'Levantamento de requisitos do sistema ERP', 1, 1, '2024-02-15', 'Concluída', 'Alta', 40, 45),
('Design da Interface', 'Criação do design das telas do ERP', 1, 4, '2024-03-01', 'Em Andamento', 'Alta', 60, 35),
('Desenvolvimento Backend', 'Implementação da API do sistema', 1, 8, '2024-04-15', 'Em Andamento', 'Alta', 120, 80),
('Layout Responsivo', 'Adaptação do site para mobile', 2, 4, '2024-03-15', 'Concluída', 'Média', 30, 28),
('Integração API', 'Integração com APIs externas', 2, 1, '2024-04-01', 'Pendente', 'Média', 40, NULL),
('Prototipagem App', 'Criação de protótipos do app mobile', 3, 4, '2024-03-30', 'Em Andamento', 'Alta', 50, 30),
('Testes de Segurança', 'Execução de testes de penetração', 7, 8, '2024-05-15', 'Pendente', 'Crítica', 80, NULL),
('Documentação API', 'Criação da documentação da API', 1, 1, '2024-05-01', 'Pendente', 'Média', 20, NULL),
('Configuração Servidor', 'Configuração do ambiente de produção', 1, 8, '2024-06-01', 'Pendente', 'Alta', 16, NULL),
('Treinamento Usuários', 'Preparação de material de treinamento', 1, 2, '2024-06-15', 'Pendente', 'Média', 24, NULL);

-- =====================================================
-- EXERCÍCIO 1: Operadores AND
-- =====================================================

-- 1.1 Liste funcionários do departamento TI E com salário maior que 3000
SELECT * FROM funcionarios 
WHERE departamento = 'TI' AND salario > 3000;

-- 1.2 Liste projetos com orçamento maior que 20000 E status 'Em Andamento'
SELECT * FROM projetos 
WHERE orcamento > 20000 AND status = 'Em Andamento';

-- 1.3 Liste tarefas com prioridade 'Alta' E status 'Em Andamento'
SELECT * FROM tarefas 
WHERE prioridade = 'Alta' AND status = 'Em Andamento';

-- 1.4 Liste funcionários ativos E nascidos após 1990
SELECT * FROM funcionarios 
WHERE ativo = TRUE AND data_nascimento > '1990-01-01';

-- 1.5 Liste projetos críticos E com data de início em 2024
SELECT * FROM projetos 
WHERE prioridade = 'Crítica' AND data_inicio >= '2024-01-01';

-- =====================================================
-- EXERCÍCIO 2: Operadores OR
-- =====================================================

-- 2.1 Liste funcionários de TI OU Marketing
SELECT * FROM funcionarios 
WHERE departamento = 'TI' OR departamento = 'Marketing';

-- 2.2 Liste projetos com prioridade 'Alta' OU 'Crítica'
SELECT * FROM projetos 
WHERE prioridade = 'Alta' OR prioridade = 'Crítica';

-- 2.3 Liste tarefas concluídas OU canceladas
SELECT * FROM tarefas 
WHERE status = 'Concluída' OR status = 'Cancelada';

-- 2.4 Liste funcionários de São Paulo OU Rio de Janeiro
SELECT * FROM funcionarios 
WHERE cidade = 'São Paulo' OR cidade = 'Rio de Janeiro';

-- 2.5 Liste projetos com orçamento maior que 30000 OU status 'Concluído'
SELECT * FROM projetos 
WHERE orcamento > 30000 OR status = 'Concluído';

-- =====================================================
-- EXERCÍCIO 3: Operador NOT
-- =====================================================

-- 3.1 Liste funcionários que NÃO são do departamento TI
SELECT * FROM funcionarios 
WHERE NOT departamento = 'TI';

-- 3.2 Liste projetos que NÃO estão em andamento
SELECT * FROM projetos 
WHERE NOT status = 'Em Andamento';

-- 3.3 Liste tarefas que NÃO são de prioridade baixa
SELECT * FROM tarefas 
WHERE NOT prioridade = 'Baixa';

-- 3.4 Liste funcionários que NÃO são de São Paulo
SELECT * FROM funcionarios 
WHERE NOT cidade = 'São Paulo';

-- 3.5 Liste projetos que NÃO são críticos
SELECT * FROM projetos 
WHERE NOT prioridade = 'Crítica';

-- =====================================================
-- EXERCÍCIO 4: Combinações de Operadores
-- =====================================================

-- 4.1 Liste funcionários de TI OU Marketing E com salário maior que 3500
SELECT * FROM funcionarios 
WHERE (departamento = 'TI' OR departamento = 'Marketing') AND salario > 3500;

-- 4.2 Liste projetos críticos OU de alta prioridade E em andamento
SELECT * FROM projetos 
WHERE (prioridade = 'Crítica' OR prioridade = 'Alta') AND status = 'Em Andamento';

-- 4.3 Liste tarefas concluídas OU em andamento E com prioridade alta
SELECT * FROM tarefas 
WHERE (status = 'Concluída' OR status = 'Em Andamento') AND prioridade = 'Alta';

-- 4.4 Liste funcionários ativos E (de TI OU Marketing) E com salário entre 3000 e 5000
SELECT * FROM funcionarios 
WHERE ativo = TRUE AND (departamento = 'TI' OR departamento = 'Marketing') 
  AND salario BETWEEN 3000 AND 5000;

-- 4.5 Liste projetos (críticos OU com orçamento > 20000) E não concluídos
SELECT * FROM projetos 
WHERE (prioridade = 'Crítica' OR orcamento > 20000) AND NOT status = 'Concluído';

-- =====================================================
-- EXERCÍCIO 5: Operadores IN e NOT IN
-- =====================================================

-- 5.1 Liste funcionários dos departamentos TI, Marketing e Vendas
SELECT * FROM funcionarios 
WHERE departamento IN ('TI', 'Marketing', 'Vendas');

-- 5.2 Liste projetos com status 'Em Andamento' ou 'Concluído'
SELECT * FROM projetos 
WHERE status IN ('Em Andamento', 'Concluído');

-- 5.3 Liste tarefas com prioridade 'Alta' ou 'Crítica'
SELECT * FROM tarefas 
WHERE prioridade IN ('Alta', 'Crítica');

-- 5.4 Liste funcionários que NÃO são dos departamentos RH e Financeiro
SELECT * FROM funcionarios 
WHERE departamento NOT IN ('RH', 'Financeiro');

-- 5.5 Liste projetos que NÃO têm status 'Cancelado' ou 'Pausado'
SELECT * FROM projetos 
WHERE status NOT IN ('Cancelado', 'Pausado');

-- =====================================================
-- EXERCÍCIO 6: Operadores LIKE e NOT LIKE
-- =====================================================

-- 6.1 Liste funcionários cujo nome começa com 'João'
SELECT * FROM funcionarios 
WHERE nome LIKE 'João%';

-- 6.2 Liste projetos cujo nome contém 'Sistema'
SELECT * FROM projetos 
WHERE nome LIKE '%Sistema%';

-- 6.3 Liste tarefas cujo título contém 'Desenvolvimento'
SELECT * FROM tarefas 
WHERE titulo LIKE '%Desenvolvimento%';

-- 6.4 Liste funcionários cujo email NÃO termina com '@empresa.com'
SELECT * FROM funcionarios 
WHERE email NOT LIKE '%@empresa.com';

-- 6.5 Liste projetos cujo nome NÃO contém 'App'
SELECT * FROM projetos 
WHERE nome NOT LIKE '%App%';

-- =====================================================
-- EXERCÍCIO 7: Operadores IS NULL e IS NOT NULL
-- =====================================================

-- 7.1 Liste tarefas sem funcionário responsável
SELECT * FROM tarefas 
WHERE funcionario_id IS NULL;

-- 7.2 Liste tarefas com funcionário responsável
SELECT * FROM tarefas 
WHERE funcionario_id IS NOT NULL;

-- 7.3 Liste tarefas sem data de conclusão
SELECT * FROM tarefas 
WHERE data_conclusao IS NULL;

-- 7.4 Liste tarefas com horas reais preenchidas
SELECT * FROM tarefas 
WHERE horas_reais IS NOT NULL;

-- 7.5 Liste projetos sem data de fim
SELECT * FROM projetos 
WHERE data_fim IS NULL;

-- =====================================================
-- EXERCÍCIO 8: Operadores BETWEEN e NOT BETWEEN
-- =====================================================

-- 8.1 Liste funcionários com salário entre 3000 e 4000
SELECT * FROM funcionarios 
WHERE salario BETWEEN 3000 AND 4000;

-- 8.2 Liste projetos com orçamento entre 10000 e 30000
SELECT * FROM projetos 
WHERE orcamento BETWEEN 10000 AND 30000;

-- 8.3 Liste tarefas com horas estimadas entre 20 e 60
SELECT * FROM tarefas 
WHERE horas_estimadas BETWEEN 20 AND 60;

-- 8.4 Liste funcionários com data de admissão entre 2023-01-01 e 2023-06-30
SELECT * FROM funcionarios 
WHERE data_admissao BETWEEN '2023-01-01' AND '2023-06-30';

-- 8.5 Liste projetos que NÃO têm orçamento entre 5000 e 15000
SELECT * FROM projetos 
WHERE orcamento NOT BETWEEN 5000 AND 15000;

-- =====================================================
-- EXERCÍCIO 9: Filtros Complexos
-- =====================================================

-- 9.1 Liste funcionários ativos, de TI ou Marketing, com salário > 3000, ordenados por salário
SELECT * FROM funcionarios 
WHERE ativo = TRUE 
  AND (departamento = 'TI' OR departamento = 'Marketing')
  AND salario > 3000
ORDER BY salario DESC;

-- 9.2 Liste projetos críticos ou de alta prioridade, em andamento, com orçamento > 20000
SELECT * FROM projetos 
WHERE (prioridade = 'Crítica' OR prioridade = 'Alta')
  AND status = 'Em Andamento'
  AND orcamento > 20000;

-- 9.3 Liste tarefas em andamento ou pendentes, com prioridade alta, com funcionário responsável
SELECT * FROM tarefas 
WHERE (status = 'Em Andamento' OR status = 'Pendente')
  AND prioridade = 'Alta'
  AND funcionario_id IS NOT NULL;

-- 9.4 Liste funcionários nascidos entre 1985 e 1995, ativos, ordenados por nome
SELECT * FROM funcionarios 
WHERE data_nascimento BETWEEN '1985-01-01' AND '1995-12-31'
  AND ativo = TRUE
ORDER BY nome;

-- 9.5 Liste projetos iniciados em 2024, não concluídos, com orçamento conhecido
SELECT * FROM projetos 
WHERE data_inicio >= '2024-01-01'
  AND status != 'Concluído'
  AND orcamento IS NOT NULL;

-- =====================================================
-- EXERCÍCIO 10: Desafios Avançados
-- =====================================================

-- 10.1 Liste funcionários que trabalham em projetos críticos
SELECT DISTINCT f.* 
FROM funcionarios f
JOIN tarefas t ON f.id = t.funcionario_id
JOIN projetos p ON t.projeto_id = p.id
WHERE p.prioridade = 'Crítica';

-- 10.2 Liste projetos com tarefas atrasadas (data limite < hoje e não concluídas)
SELECT DISTINCT p.* 
FROM projetos p
JOIN tarefas t ON p.id = t.projeto_id
WHERE t.data_limite < CURRENT_DATE 
  AND t.status NOT IN ('Concluída', 'Cancelada');

-- 10.3 Liste funcionários que têm tarefas com prioridade alta E crítica
SELECT DISTINCT f.* 
FROM funcionarios f
JOIN tarefas t ON f.id = t.funcionario_id
WHERE t.prioridade IN ('Alta', 'Crítica')
  AND f.ativo = TRUE;

-- 10.4 Liste projetos com orçamento acima da média E em andamento
SELECT * FROM projetos 
WHERE orcamento > (SELECT AVG(orcamento) FROM projetos)
  AND status = 'Em Andamento';

-- 10.5 Liste tarefas que excederam o tempo estimado (horas reais > horas estimadas)
SELECT * FROM tarefas 
WHERE horas_reais IS NOT NULL 
  AND horas_estimadas IS NOT NULL
  AND horas_reais > horas_estimadas;

-- =====================================================
-- LIMPEZA (OPCIONAL - DESCOMENTE PARA EXCLUIR AS TABELAS)
-- =====================================================

-- DROP TABLE IF EXISTS tarefas;
-- DROP TABLE IF EXISTS projetos;
-- DROP TABLE IF EXISTS funcionarios; 