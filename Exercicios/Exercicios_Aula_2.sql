-- =====================================================
-- EXERCÍCIOS AULA 2: CRIANDO TABELAS E TIPOS DE DADOS
-- =====================================================

-- =====================================================
-- EXERCÍCIO 1: Tipos de Dados Básicos
-- =====================================================

-- 1.1 Crie uma tabela de usuários com diferentes tipos de dados
CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  idade INTEGER CHECK (idade >= 0),
  altura DECIMAL(3,2), -- altura em metros (ex: 1.75)
  data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  ativo BOOLEAN DEFAULT TRUE
);

-- 1.2 Crie uma tabela de produtos com tipos numéricos
CREATE TABLE produtos (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(200) NOT NULL,
  preco DECIMAL(10,2) NOT NULL CHECK (preco > 0),
  peso DECIMAL(5,2), -- peso em kg
  quantidade INTEGER DEFAULT 0 CHECK (quantidade >= 0),
  ativo BOOLEAN DEFAULT TRUE
);

-- =====================================================
-- EXERCÍCIO 2: Constraints e Validações
-- =====================================================

-- 2.1 Crie uma tabela de funcionários com constraints
CREATE TABLE funcionarios (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  cpf VARCHAR(14) UNIQUE NOT NULL,
  salario DECIMAL(10,2) NOT NULL CHECK (salario >= 1000),
  data_admissao DATE NOT NULL,
  departamento VARCHAR(100) NOT NULL,
  ativo BOOLEAN DEFAULT TRUE
);

-- 2.2 Crie uma tabela de pedidos com validações
CREATE TABLE pedidos (
  id SERIAL PRIMARY KEY,
  cliente_id INTEGER NOT NULL,
  data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  valor_total DECIMAL(10,2) NOT NULL CHECK (valor_total > 0),
  status VARCHAR(50) DEFAULT 'Pendente' CHECK (status IN ('Pendente', 'Aprovado', 'Cancelado')),
  observacoes TEXT
);

-- =====================================================
-- EXERCÍCIO 3: Tipos de Texto
-- =====================================================

-- 3.1 Crie uma tabela de artigos com diferentes tipos de texto
CREATE TABLE artigos (
  id SERIAL PRIMARY KEY,
  titulo VARCHAR(200) NOT NULL,
  resumo VARCHAR(500),
  conteudo TEXT,
  autor VARCHAR(100) NOT NULL,
  data_publicacao DATE,
  tags VARCHAR(300) -- tags separadas por vírgula
);

-- 3.2 Crie uma tabela de configurações com CHAR fixo
CREATE TABLE configuracoes (
  id SERIAL PRIMARY KEY,
  chave VARCHAR(50) UNIQUE NOT NULL,
  valor TEXT,
  tipo VARCHAR(20) NOT NULL,
  ativo BOOLEAN DEFAULT TRUE
);

-- =====================================================
-- EXERCÍCIO 4: Tipos de Data e Hora
-- =====================================================

-- 4.1 Crie uma tabela de eventos com diferentes tipos de data
CREATE TABLE eventos (
  id SERIAL PRIMARY KEY,
  titulo VARCHAR(200) NOT NULL,
  data_inicio DATE NOT NULL,
  hora_inicio TIME,
  data_fim DATE,
  hora_fim TIME,
  data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4.2 Crie uma tabela de logs de sistema
CREATE TABLE logs_sistema (
  id SERIAL PRIMARY KEY,
  nivel VARCHAR(20) NOT NULL CHECK (nivel IN ('INFO', 'WARNING', 'ERROR')),
  mensagem TEXT NOT NULL,
  data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  usuario VARCHAR(100),
  ip VARCHAR(45)
);

-- =====================================================
-- EXERCÍCIO 5: Tipos Booleanos e Especiais
-- =====================================================

-- 5.1 Crie uma tabela de configurações de usuário
CREATE TABLE configuracoes_usuario (
  id SERIAL PRIMARY KEY,
  usuario_id INTEGER NOT NULL,
  receber_email BOOLEAN DEFAULT TRUE,
  receber_sms BOOLEAN DEFAULT FALSE,
  modo_escuro BOOLEAN DEFAULT FALSE,
  notificacoes_push BOOLEAN DEFAULT TRUE,
  data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5.2 Crie uma tabela de permissões
CREATE TABLE permissoes (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) UNIQUE NOT NULL,
  descricao TEXT,
  ativo BOOLEAN DEFAULT TRUE,
  data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- EXERCÍCIO 6: Inserção de Dados com Diferentes Tipos
-- =====================================================

-- 6.1 Insira dados na tabela usuarios
INSERT INTO usuarios (nome, email, idade, altura) VALUES
('Ana Silva', 'ana@email.com', 25, 1.65),
('Carlos Santos', 'carlos@email.com', 30, 1.80),
('Maria Costa', 'maria@email.com', 28, 1.70);

-- 6.2 Insira dados na tabela produtos
INSERT INTO produtos (nome, preco, peso, quantidade) VALUES
('Notebook Dell', 3500.00, 2.5, 10),
('Mouse Wireless', 89.90, 0.15, 50),
('Teclado Mecânico', 299.00, 0.8, 25);

-- 6.3 Insira dados na tabela funcionarios
INSERT INTO funcionarios (nome, email, cpf, salario, data_admissao, departamento) VALUES
('João Silva', 'joao@empresa.com', '123.456.789-00', 3500.00, '2023-01-15', 'TI'),
('Maria Santos', 'maria@empresa.com', '987.654.321-00', 4200.00, '2023-03-20', 'RH'),
('Pedro Costa', 'pedro@empresa.com', '456.789.123-00', 3800.00, '2023-06-10', 'Vendas');

-- =====================================================
-- EXERCÍCIO 7: Consultas com Diferentes Tipos
-- =====================================================

-- 7.1 Liste usuários com altura maior que 1.70m
SELECT nome, altura FROM usuarios WHERE altura > 1.70;

-- 7.2 Liste produtos com peso menor que 1kg
SELECT nome, peso FROM produtos WHERE peso < 1.0;

-- 7.3 Liste funcionários com salário entre 3000 e 4000
SELECT nome, salario FROM funcionarios WHERE salario BETWEEN 3000 AND 4000;

-- 7.4 Liste usuários ativos ordenados por idade
SELECT nome, idade FROM usuarios WHERE ativo = TRUE ORDER BY idade;

-- =====================================================
-- EXERCÍCIO 8: Funções com Tipos de Data
-- =====================================================

-- 8.1 Calcule a idade dos usuários
SELECT 
  nome,
  idade,
  EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM data_cadastro) AS anos_cadastro
FROM usuarios;

-- 8.2 Liste funcionários contratados em 2023
SELECT nome, data_admissao FROM funcionarios 
WHERE EXTRACT(YEAR FROM data_admissao) = 2023;

-- 8.3 Calcule quantos dias cada funcionário trabalha na empresa
SELECT 
  nome,
  data_admissao,
  CURRENT_DATE - data_admissao AS dias_empresa
FROM funcionarios;

-- =====================================================
-- EXERCÍCIO 9: Validações e Constraints
-- =====================================================

-- 9.1 Teste a constraint de salário mínimo
-- INSERT INTO funcionarios (nome, email, cpf, salario, data_admissao, departamento) 
-- VALUES ('Teste', 'teste@email.com', '111.222.333-44', 500.00, '2023-01-01', 'TI');
-- Isso deve gerar erro devido ao CHECK (salario >= 1000)

-- 9.2 Teste a constraint de idade
-- INSERT INTO usuarios (nome, email, idade) 
-- VALUES ('Teste', 'teste@email.com', -5);
-- Isso deve gerar erro devido ao CHECK (idade >= 0)

-- 9.3 Teste a constraint de email único
-- INSERT INTO usuarios (nome, email, idade) 
-- VALUES ('Teste', 'ana@email.com', 25);
-- Isso deve gerar erro devido ao UNIQUE no email

-- =====================================================
-- EXERCÍCIO 10: Modificação de Tabelas
-- =====================================================

-- 10.1 Adicione uma coluna de telefone na tabela usuarios
ALTER TABLE usuarios ADD COLUMN telefone VARCHAR(20);

-- 10.2 Adicione uma coluna de categoria na tabela produtos
ALTER TABLE produtos ADD COLUMN categoria VARCHAR(100);

-- 10.3 Modifique o tipo da coluna altura para permitir valores maiores
ALTER TABLE usuarios ALTER COLUMN altura TYPE DECIMAL(4,2);

-- 10.4 Adicione uma constraint de check para telefone
ALTER TABLE usuarios ADD CONSTRAINT check_telefone 
CHECK (telefone IS NULL OR telefone ~ '^\([0-9]{2}\) [0-9]{4,5}-[0-9]{4}$');

-- =====================================================
-- EXERCÍCIO 11: Análise de Tipos de Dados
-- =====================================================

-- 11.1 Liste todos os tipos de dados usados nas tabelas
SELECT 
  table_name,
  column_name,
  data_type,
  is_nullable,
  column_default
FROM information_schema.columns 
WHERE table_schema = 'public' 
  AND table_name IN ('usuarios', 'produtos', 'funcionarios')
ORDER BY table_name, ordinal_position;

-- 11.2 Verifique as constraints das tabelas
SELECT 
  table_name,
  constraint_name,
  constraint_type
FROM information_schema.table_constraints 
WHERE table_schema = 'public' 
  AND table_name IN ('usuarios', 'produtos', 'funcionarios')
ORDER BY table_name, constraint_name;

-- =====================================================
-- EXERCÍCIO 12: Desafios Avançados
-- =====================================================

-- 12.1 Crie uma tabela de configurações com JSON
CREATE TABLE configuracoes_avancadas (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) UNIQUE NOT NULL,
  configuracao JSONB,
  data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 12.2 Insira dados JSON na tabela
INSERT INTO configuracoes_avancadas (nome, configuracao) VALUES
('tema_sistema', '{"cor_primaria": "#007bff", "cor_secundaria": "#6c757d", "modo_escuro": false}'),
('notificacoes', '{"email": true, "sms": false, "push": true, "horario_inicio": "08:00", "horario_fim": "18:00"}');

-- 12.3 Consulte dados JSON
SELECT 
  nome,
  configuracao->>'cor_primaria' AS cor_primaria,
  configuracao->>'modo_escuro' AS modo_escuro
FROM configuracoes_avancadas 
WHERE nome = 'tema_sistema';

-- =====================================================
-- LIMPEZA (OPCIONAL - DESCOMENTE PARA EXCLUIR AS TABELAS)
-- =====================================================

-- DROP TABLE IF EXISTS configuracoes_avancadas;
-- DROP TABLE IF EXISTS permissoes;
-- DROP TABLE IF EXISTS configuracoes_usuario;
-- DROP TABLE IF EXISTS logs_sistema;
-- DROP TABLE IF EXISTS eventos;
-- DROP TABLE IF EXISTS configuracoes;
-- DROP TABLE IF EXISTS artigos;
-- DROP TABLE IF EXISTS pedidos;
-- DROP TABLE IF EXISTS funcionarios;
-- DROP TABLE IF EXISTS produtos;
-- DROP TABLE IF EXISTS usuarios; 