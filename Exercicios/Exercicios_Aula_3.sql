-- =====================================================
-- EXERCÍCIOS AULA 3: INSERINDO DADOS COM INSERT
-- =====================================================

-- =====================================================
-- PREPARAÇÃO: Criação das Tabelas Base
-- =====================================================

-- Crie as tabelas necessárias para os exercícios
CREATE TABLE clientes (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  telefone VARCHAR(20),
  data_nascimento DATE,
  ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE produtos (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(200) NOT NULL,
  descricao TEXT,
  preco DECIMAL(10,2) NOT NULL CHECK (preco > 0),
  categoria VARCHAR(100),
  estoque INTEGER DEFAULT 0 CHECK (estoque >= 0),
  ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE cursos (
  id SERIAL PRIMARY KEY,
  titulo VARCHAR(200) NOT NULL,
  descricao TEXT,
  duracao INTEGER NOT NULL CHECK (duracao > 0),
  gratuito BOOLEAN DEFAULT FALSE,
  inicio DATE,
  instrutor VARCHAR(100),
  ativo BOOLEAN DEFAULT TRUE
);

-- =====================================================
-- EXERCÍCIO 1: Inserção Básica
-- =====================================================

-- 1.1 Insira 3 clientes na tabela clientes
INSERT INTO clientes (nome, email, telefone, data_nascimento) VALUES
('João Silva', 'joao@email.com', '(11) 99999-9999', '1990-05-15'),
('Maria Santos', 'maria@email.com', '(11) 88888-8888', '1985-08-22'),
('Pedro Costa', 'pedro@email.com', '(11) 77777-7777', '1992-03-10');

-- 1.2 Insira 5 produtos na tabela produtos
INSERT INTO produtos (nome, descricao, preco, categoria, estoque) VALUES
('Notebook Dell', 'Notebook Dell Inspiron 15 polegadas', 3500.00, 'Eletrônicos', 10),
('Mouse Wireless', 'Mouse sem fio com 3 botões', 89.90, 'Periféricos', 50),
('Teclado Mecânico', 'Teclado mecânico com switches blue', 299.00, 'Periféricos', 25),
('Monitor 24"', 'Monitor LED 24 polegadas Full HD', 899.00, 'Monitores', 15),
('SSD 500GB', 'SSD SATA 500GB para notebook', 399.00, 'Armazenamento', 30);

-- 1.3 Insira 4 cursos na tabela cursos
INSERT INTO cursos (titulo, descricao, duracao, gratuito, inicio, instrutor) VALUES
('Introdução ao SQL', 'Curso básico de SQL para iniciantes', 20, TRUE, '2024-02-01', 'Ana Silva'),
('Desenvolvimento Web', 'HTML, CSS e JavaScript', 40, FALSE, '2024-03-15', 'Carlos Santos'),
('Python Avançado', 'Programação avançada em Python', 30, FALSE, '2024-04-01', 'Maria Costa'),
('Banco de Dados', 'Modelagem e administração de BD', 25, TRUE, '2024-05-10', 'Pedro Lima');

-- =====================================================
-- EXERCÍCIO 2: Inserção com Valores Padrão
-- =====================================================

-- 2.1 Insira clientes usando apenas campos obrigatórios
INSERT INTO clientes (nome, email) VALUES
('Ana Oliveira', 'ana@email.com'),
('Carlos Ferreira', 'carlos@email.com');

-- 2.2 Insira produtos usando valores padrão
INSERT INTO produtos (nome, preco) VALUES
('Produto Teste 1', 100.00),
('Produto Teste 2', 200.00);

-- 2.3 Insira cursos gratuitos
INSERT INTO cursos (titulo, duracao, gratuito) VALUES
('Git Básico', 10, TRUE),
('Docker Introdução', 15, TRUE);

-- =====================================================
-- EXERCÍCIO 3: Inserção Múltipla
-- =====================================================

-- 3.1 Insira vários clientes de uma vez
INSERT INTO clientes (nome, email, telefone, data_nascimento) VALUES
('Fernanda Lima', 'fernanda@email.com', '(11) 66666-6666', '1988-12-05'),
('Roberto Alves', 'roberto@email.com', '(11) 55555-5555', '1995-07-18'),
('Lucia Pereira', 'lucia@email.com', '(11) 44444-4444', '1991-11-30'),
('Marcos Souza', 'marcos@email.com', '(11) 33333-3333', '1987-04-22');

-- 3.2 Insira vários produtos de uma vez
INSERT INTO produtos (nome, descricao, preco, categoria, estoque) VALUES
('Webcam HD', 'Webcam 1080p com microfone', 150.00, 'Periféricos', 20),
('Headset Gamer', 'Headset com microfone e RGB', 250.00, 'Periféricos', 15),
('Impressora Laser', 'Impressora monocromática', 800.00, 'Impressão', 8),
('Scanner A4', 'Scanner de mesa A4', 300.00, 'Impressão', 12),
('Cabo HDMI', 'Cabo HDMI 2 metros', 25.00, 'Cabo', 100);

-- 3.3 Insira vários cursos de uma vez
INSERT INTO cursos (titulo, descricao, duracao, gratuito, inicio, instrutor) VALUES
('React Básico', 'Introdução ao React.js', 25, FALSE, '2024-06-01', 'Ana Silva'),
('Node.js', 'Desenvolvimento backend com Node.js', 30, FALSE, '2024-07-01', 'Carlos Santos'),
('MongoDB', 'Banco de dados NoSQL', 20, TRUE, '2024-08-01', 'Maria Costa'),
('AWS Cloud', 'Serviços da Amazon Web Services', 35, FALSE, '2024-09-01', 'Pedro Lima');

-- =====================================================
-- EXERCÍCIO 4: Inserção com Diferentes Tipos de Dados
-- =====================================================

-- 4.1 Insira clientes com diferentes tipos de dados
INSERT INTO clientes (nome, email, telefone, data_nascimento, ativo) VALUES
('Teste Booleano', 'teste@email.com', '(11) 11111-1111', '2000-01-01', TRUE),
('Teste Null', 'teste2@email.com', NULL, NULL, FALSE);

-- 4.2 Insira produtos com valores decimais
INSERT INTO produtos (nome, preco, estoque) VALUES
('Produto Decimal', 99.99, 5),
('Produto Zero', 0.01, 0);

-- 4.3 Insira cursos com diferentes durações
INSERT INTO cursos (titulo, duracao, gratuito) VALUES
('Curso Rápido', 5, TRUE),
('Curso Longo', 60, FALSE);

-- =====================================================
-- EXERCÍCIO 5: Inserção com Constraints
-- =====================================================

-- 5.1 Teste inserção com email duplicado (deve falhar)
-- INSERT INTO clientes (nome, email) VALUES ('Teste Duplicado', 'joao@email.com');

-- 5.2 Teste inserção com preço negativo (deve falhar)
-- INSERT INTO produtos (nome, preco) VALUES ('Produto Negativo', -50.00);

-- 5.3 Teste inserção com estoque negativo (deve falhar)
-- INSERT INTO produtos (nome, preco, estoque) VALUES ('Produto Negativo', 100.00, -5);

-- 5.4 Teste inserção com duração zero (deve falhar)
-- INSERT INTO cursos (titulo, duracao) VALUES ('Curso Zero', 0);

-- =====================================================
-- EXERCÍCIO 6: Inserção com SELECT
-- =====================================================

-- 6.1 Crie uma tabela de backup de clientes
CREATE TABLE clientes_backup AS SELECT * FROM clientes WHERE 1=0;

-- 6.2 Insira dados de clientes ativos na tabela de backup
INSERT INTO clientes_backup 
SELECT * FROM clientes WHERE ativo = TRUE;

-- 6.3 Crie uma tabela de produtos premium
CREATE TABLE produtos_premium (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(200) NOT NULL,
  preco DECIMAL(10,2) NOT NULL,
  categoria VARCHAR(100)
);

-- 6.4 Insira produtos caros na tabela premium
INSERT INTO produtos_premium (nome, preco, categoria)
SELECT nome, preco, categoria 
FROM produtos 
WHERE preco > 500;

-- =====================================================
-- EXERCÍCIO 7: Inserção Condicional
-- =====================================================

-- 7.1 Insira apenas produtos que não existem
INSERT INTO produtos (nome, preco, categoria)
SELECT 'Novo Produto', 150.00, 'Teste'
WHERE NOT EXISTS (
  SELECT 1 FROM produtos WHERE nome = 'Novo Produto'
);

-- 7.2 Insira apenas cursos gratuitos que não existem
INSERT INTO cursos (titulo, duracao, gratuito)
SELECT 'Novo Curso Gratuito', 10, TRUE
WHERE NOT EXISTS (
  SELECT 1 FROM cursos WHERE titulo = 'Novo Curso Gratuito'
);

-- =====================================================
-- EXERCÍCIO 8: Inserção com Subconsultas
-- =====================================================

-- 8.1 Crie uma tabela de pedidos
CREATE TABLE pedidos (
  id SERIAL PRIMARY KEY,
  cliente_id INTEGER NOT NULL,
  produto_id INTEGER NOT NULL,
  quantidade INTEGER NOT NULL CHECK (quantidade > 0),
  data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 8.2 Insira pedidos usando IDs de clientes e produtos existentes
INSERT INTO pedidos (cliente_id, produto_id, quantidade)
SELECT 
  c.id,
  p.id,
  1
FROM clientes c
CROSS JOIN produtos p
WHERE c.ativo = TRUE AND p.ativo = TRUE
LIMIT 5;

-- =====================================================
-- EXERCÍCIO 9: Inserção com Valores Calculados
-- =====================================================

-- 9.1 Crie uma tabela de vendas
CREATE TABLE vendas (
  id SERIAL PRIMARY KEY,
  produto_id INTEGER NOT NULL,
  quantidade INTEGER NOT NULL,
  preco_unitario DECIMAL(10,2) NOT NULL,
  valor_total DECIMAL(10,2) NOT NULL,
  data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 9.2 Insira vendas com valor total calculado
INSERT INTO vendas (produto_id, quantidade, preco_unitario, valor_total)
SELECT 
  id,
  2,
  preco,
  preco * 2
FROM produtos
WHERE ativo = TRUE
LIMIT 3;

-- =====================================================
-- EXERCÍCIO 10: Inserção com Valores Padrão Avançados
-- =====================================================

-- 10.1 Crie uma tabela de logs
CREATE TABLE logs (
  id SERIAL PRIMARY KEY,
  acao VARCHAR(50) NOT NULL,
  tabela VARCHAR(50) NOT NULL,
  registro_id INTEGER,
  data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  usuario VARCHAR(100) DEFAULT 'Sistema'
);

-- 10.2 Insira logs de inserção
INSERT INTO logs (acao, tabela, registro_id)
SELECT 
  'INSERT',
  'clientes',
  id
FROM clientes
WHERE ativo = TRUE;

-- =====================================================
-- EXERCÍCIO 11: Verificação de Inserções
-- =====================================================

-- 11.1 Verifique quantos registros foram inseridos
SELECT 'clientes' AS tabela, COUNT(*) AS total FROM clientes
UNION ALL
SELECT 'produtos' AS tabela, COUNT(*) AS total FROM produtos
UNION ALL
SELECT 'cursos' AS tabela, COUNT(*) AS total FROM cursos;

-- 11.2 Verifique os últimos registros inseridos
SELECT 'clientes' AS tabela, nome, id FROM clientes ORDER BY id DESC LIMIT 3
UNION ALL
SELECT 'produtos' AS tabela, nome, id FROM produtos ORDER BY id DESC LIMIT 3
UNION ALL
SELECT 'cursos' AS tabela, titulo, id FROM cursos ORDER BY id DESC LIMIT 3;

-- 11.3 Verifique dados específicos
SELECT 
  nome,
  email,
  CASE WHEN ativo THEN 'Ativo' ELSE 'Inativo' END AS status
FROM clientes
ORDER BY nome;

-- =====================================================
-- EXERCÍCIO 12: Desafios Avançados
-- =====================================================

-- 12.1 Insira dados com validação de formato
INSERT INTO clientes (nome, email, telefone)
SELECT 
  'Cliente Teste',
  'teste' || id || '@email.com',
  '(' || LPAD(id::text, 2, '0') || ') ' || LPAD(id::text, 4, '0') || '-' || LPAD(id::text, 4, '0')
FROM generate_series(1, 3) AS id;

-- 12.2 Insira produtos com preços variados
INSERT INTO produtos (nome, preco, categoria)
SELECT 
  'Produto ' || id,
  (RANDOM() * 1000 + 10)::DECIMAL(10,2),
  CASE 
    WHEN id % 3 = 0 THEN 'Eletrônicos'
    WHEN id % 3 = 1 THEN 'Periféricos'
    ELSE 'Outros'
  END
FROM generate_series(1, 5) AS id;

-- 12.3 Insira cursos com datas futuras
INSERT INTO cursos (titulo, duracao, gratuito, inicio)
SELECT 
  'Curso ' || id,
  10 + (id * 5),
  CASE WHEN id % 2 = 0 THEN TRUE ELSE FALSE END,
  CURRENT_DATE + (id * 7)
FROM generate_series(1, 4) AS id;

-- =====================================================
-- LIMPEZA (OPCIONAL - DESCOMENTE PARA EXCLUIR AS TABELAS)
-- =====================================================

-- DROP TABLE IF EXISTS vendas;
-- DROP TABLE IF EXISTS pedidos;
-- DROP TABLE IF EXISTS logs;
-- DROP TABLE IF EXISTS produtos_premium;
-- DROP TABLE IF EXISTS clientes_backup;
-- DROP TABLE IF EXISTS cursos;
-- DROP TABLE IF EXISTS produtos;
-- DROP TABLE IF EXISTS clientes; 