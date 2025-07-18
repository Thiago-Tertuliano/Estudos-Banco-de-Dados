-- =====================================================
-- EXERCÍCIOS AULA 7: ALIASES (AS) - RENOMEANDO COLUNAS E TABELAS
-- =====================================================

-- =====================================================
-- PREPARAÇÃO: Criação das Tabelas e Dados
-- =====================================================

-- Crie as tabelas necessárias para os exercícios
CREATE TABLE clientes (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  telefone VARCHAR(20),
  data_nascimento DATE,
  cidade VARCHAR(100),
  estado VARCHAR(2),
  ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE produtos (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(200) NOT NULL,
  descricao TEXT,
  preco DECIMAL(10,2) NOT NULL CHECK (preco > 0),
  categoria VARCHAR(100),
  estoque INTEGER DEFAULT 0 CHECK (estoque >= 0),
  fornecedor VARCHAR(100),
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

CREATE TABLE vendas (
  id SERIAL PRIMARY KEY,
  cliente_id INTEGER NOT NULL,
  produto_id INTEGER NOT NULL,
  quantidade INTEGER NOT NULL CHECK (quantidade > 0),
  preco_unitario DECIMAL(10,2) NOT NULL,
  data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  desconto DECIMAL(5,2) DEFAULT 0
);

-- Insira dados de exemplo
INSERT INTO clientes (nome, email, telefone, data_nascimento, cidade, estado) VALUES
('João Silva', 'joao@email.com', '(11) 99999-9999', '1990-05-15', 'São Paulo', 'SP'),
('Maria Santos', 'maria@email.com', '(11) 88888-8888', '1985-08-22', 'Rio de Janeiro', 'RJ'),
('Pedro Costa', 'pedro@email.com', '(11) 77777-7777', '1992-03-10', 'Belo Horizonte', 'MG'),
('Ana Oliveira', 'ana@email.com', '(11) 66666-6666', '1988-12-05', 'São Paulo', 'SP'),
('Carlos Ferreira', 'carlos@email.com', '(11) 55555-5555', '1995-07-18', 'Curitiba', 'PR');

INSERT INTO produtos (nome, descricao, preco, categoria, estoque, fornecedor) VALUES
('Notebook Dell', 'Notebook Dell Inspiron 15 polegadas', 3500.00, 'Eletrônicos', 10, 'Dell'),
('Mouse Wireless', 'Mouse sem fio com 3 botões', 89.90, 'Periféricos', 50, 'Logitech'),
('Teclado Mecânico', 'Teclado mecânico com switches blue', 299.00, 'Periféricos', 25, 'Corsair'),
('Monitor 24"', 'Monitor LED 24 polegadas Full HD', 899.00, 'Monitores', 15, 'LG'),
('SSD 500GB', 'SSD SATA 500GB para notebook', 399.00, 'Armazenamento', 30, 'Samsung');

INSERT INTO cursos (titulo, descricao, duracao, gratuito, inicio, instrutor) VALUES
('Introdução ao SQL', 'Curso básico de SQL para iniciantes', 20, TRUE, '2024-02-01', 'Ana Silva'),
('Desenvolvimento Web', 'HTML, CSS e JavaScript', 40, FALSE, '2024-03-15', 'Carlos Santos'),
('Python Avançado', 'Programação avançada em Python', 30, FALSE, '2024-04-01', 'Maria Costa'),
('Banco de Dados', 'Modelagem e administração de BD', 25, TRUE, '2024-05-10', 'Pedro Lima'),
('Git Básico', 'Controle de versão com Git', 10, TRUE, '2024-06-01', 'Ana Silva');

INSERT INTO vendas (cliente_id, produto_id, quantidade, preco_unitario, data_venda, desconto) VALUES
(1, 1, 1, 3500.00, '2024-01-15 10:30:00', 0),
(2, 2, 2, 89.90, '2024-01-16 14:20:00', 5.00),
(3, 3, 1, 299.00, '2024-01-17 09:15:00', 0),
(4, 4, 1, 899.00, '2024-01-18 16:45:00', 10.00),
(5, 5, 2, 399.00, '2024-01-19 11:30:00', 0);

-- =====================================================
-- EXERCÍCIO 1: Aliases de Colunas Básicos
-- =====================================================

-- 1.1 Liste clientes com aliases descritivos para as colunas
SELECT 
  nome AS nome_completo_cliente,
  email AS endereco_email,
  telefone AS numero_telefone,
  data_nascimento AS data_nascimento_cliente
FROM clientes;

-- 1.2 Liste produtos com aliases para preço e estoque
SELECT 
  nome AS nome_produto,
  preco AS preco_atual,
  estoque AS quantidade_estoque,
  categoria AS categoria_produto
FROM produtos;

-- 1.3 Liste cursos com aliases para duração e status
SELECT 
  titulo AS nome_curso,
  duracao AS horas_duracao,
  gratuito AS curso_gratuito,
  instrutor AS nome_instrutor
FROM cursos;

-- 1.4 Liste vendas com aliases para valores
SELECT 
  cliente_id AS id_cliente,
  produto_id AS id_produto,
  quantidade AS qtd_vendida,
  preco_unitario AS preco_unitario_venda,
  desconto AS desconto_aplicado
FROM vendas;

-- =====================================================
-- EXERCÍCIO 2: Aliases com Cálculos
-- =====================================================

-- 2.1 Produtos com preço em reais e dólares (cotação 5.5)
SELECT 
  nome AS nome_produto,
  preco AS preco_reais,
  preco / 5.5 AS preco_dolares
FROM produtos;

-- 2.2 Produtos com preço com desconto de 10%
SELECT 
  nome AS nome_produto,
  preco AS preco_original,
  preco * 0.9 AS preco_com_desconto
FROM produtos;

-- 2.3 Vendas com valor total calculado
SELECT 
  cliente_id AS id_cliente,
  produto_id AS id_produto,
  quantidade AS qtd_vendida,
  preco_unitario AS preco_unit,
  (quantidade * preco_unitario) AS valor_total_bruto,
  (quantidade * preco_unitario * (1 - desconto/100)) AS valor_total_liquido
FROM vendas;

-- 2.4 Cursos com duração em horas e minutos
SELECT 
  titulo AS nome_curso,
  duracao AS horas_totais,
  duracao * 60 AS minutos_totais
FROM cursos;

-- =====================================================
-- EXERCÍCIO 3: Aliases com Funções
-- =====================================================

-- 3.1 Clientes com idade calculada
SELECT 
  nome AS nome_cliente,
  data_nascimento AS data_nascimento_cliente,
  EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM data_nascimento) AS idade_cliente
FROM clientes;

-- 3.2 Produtos com tamanho do nome
SELECT 
  nome AS nome_produto,
  LENGTH(nome) AS tamanho_nome_produto,
  UPPER(nome) AS nome_produto_maiusculo
FROM produtos;

-- 3.3 Cursos com informações formatadas
SELECT 
  titulo AS nome_curso,
  LENGTH(titulo) AS tamanho_titulo,
  CASE 
    WHEN gratuito THEN 'Gratuito'
    ELSE 'Pago'
  END AS tipo_curso
FROM cursos;

-- 3.4 Vendas com data formatada
SELECT 
  cliente_id AS id_cliente,
  produto_id AS id_produto,
  TO_CHAR(data_venda, 'DD/MM/YYYY HH24:MI') AS data_hora_venda
FROM vendas;

-- =====================================================
-- EXERCÍCIO 4: Aliases de Tabelas
-- =====================================================

-- 4.1 Use alias 'c' para tabela clientes
SELECT 
  c.nome AS nome_cliente,
  c.email AS email_cliente,
  c.cidade AS cidade_cliente
FROM clientes AS c;

-- 4.2 Use alias 'p' para tabela produtos
SELECT 
  p.nome AS nome_produto,
  p.preco AS preco_produto,
  p.categoria AS categoria_produto
FROM produtos AS p;

-- 4.3 Use alias 'cur' para tabela cursos
SELECT 
  cur.titulo AS nome_curso,
  cur.duracao AS horas_curso,
  cur.instrutor AS instrutor_curso
FROM cursos AS cur;

-- 4.4 Use alias 'v' para tabela vendas
SELECT 
  v.cliente_id AS id_cliente,
  v.produto_id AS id_produto,
  v.quantidade AS qtd_vendida
FROM vendas AS v;

-- =====================================================
-- EXERCÍCIO 5: Aliases em Joins
-- =====================================================

-- 5.1 Clientes e seus produtos comprados
SELECT 
  c.nome AS nome_cliente,
  p.nome AS nome_produto,
  v.quantidade AS qtd_comprada,
  v.preco_unitario AS preco_pago
FROM clientes AS c
JOIN vendas AS v ON c.id = v.cliente_id
JOIN produtos AS p ON v.produto_id = p.id;

-- 5.2 Produtos com informações de venda
SELECT 
  p.nome AS nome_produto,
  p.categoria AS categoria_produto,
  v.quantidade AS qtd_vendida,
  (v.quantidade * v.preco_unitario) AS valor_total_venda
FROM produtos AS p
JOIN vendas AS v ON p.id = v.produto_id;

-- 5.3 Cursos com informações do instrutor (simulado)
SELECT 
  cur.titulo AS nome_curso,
  cur.duracao AS horas_curso,
  cur.instrutor AS nome_instrutor,
  CASE 
    WHEN cur.gratuito THEN 'Gratuito'
    ELSE 'Pago'
  END AS tipo_curso
FROM cursos AS cur;

-- =====================================================
-- EXERCÍCIO 6: Aliases com Expressões Complexas
-- =====================================================

-- 6.1 Produtos com classificação de preço
SELECT 
  nome AS nome_produto,
  preco AS preco_atual,
  CASE 
    WHEN preco < 100 THEN 'Econômico'
    WHEN preco < 500 THEN 'Médio'
    ELSE 'Premium'
  END AS categoria_preco
FROM produtos;

-- 6.2 Clientes com status baseado na idade
SELECT 
  nome AS nome_cliente,
  data_nascimento AS data_nascimento_cliente,
  EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM data_nascimento) AS idade_cliente,
  CASE 
    WHEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM data_nascimento) < 25 THEN 'Jovem'
    WHEN EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM data_nascimento) < 50 THEN 'Adulto'
    ELSE 'Idoso'
  END AS faixa_etaria
FROM clientes;

-- 6.3 Cursos com classificação de duração
SELECT 
  titulo AS nome_curso,
  duracao AS horas_duracao,
  CASE 
    WHEN duracao < 10 THEN 'Curso Rápido'
    WHEN duracao < 30 THEN 'Curso Médio'
    ELSE 'Curso Longo'
  END AS tipo_duracao
FROM cursos;

-- =====================================================
-- EXERCÍCIO 7: Aliases em Subconsultas
-- =====================================================

-- 7.1 Produtos com preço acima da média
SELECT 
  p.nome AS nome_produto,
  p.preco AS preco_produto,
  (SELECT AVG(preco) FROM produtos) AS preco_medio_geral
FROM produtos AS p
WHERE p.preco > (SELECT AVG(preco) FROM produtos);

-- 7.2 Clientes com idade acima da média
SELECT 
  c.nome AS nome_cliente,
  EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM c.data_nascimento) AS idade_cliente,
  (SELECT AVG(EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM data_nascimento)) FROM clientes) AS idade_media
FROM clientes AS c
WHERE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM c.data_nascimento) > 
  (SELECT AVG(EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM data_nascimento)) FROM clientes);

-- 7.3 Cursos com duração acima da média
SELECT 
  cur.titulo AS nome_curso,
  cur.duracao AS horas_curso,
  (SELECT AVG(duracao) FROM cursos) AS duracao_media_geral
FROM cursos AS cur
WHERE cur.duracao > (SELECT AVG(duracao) FROM cursos);

-- =====================================================
-- EXERCÍCIO 8: Aliases com Funções Agregadas
-- =====================================================

-- 8.1 Estatísticas de produtos com aliases
SELECT 
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio,
  MAX(preco) AS produto_mais_caro,
  MIN(preco) AS produto_mais_barato,
  SUM(estoque) AS estoque_total
FROM produtos;

-- 8.2 Estatísticas de clientes com aliases
SELECT 
  COUNT(*) AS total_clientes,
  COUNT(email) AS clientes_com_email,
  COUNT(telefone) AS clientes_com_telefone,
  AVG(EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM data_nascimento)) AS idade_media
FROM clientes;

-- 8.3 Estatísticas de vendas com aliases
SELECT 
  COUNT(*) AS total_vendas,
  SUM(quantidade) AS total_itens_vendidos,
  AVG(preco_unitario) AS preco_medio_unitario,
  SUM(quantidade * preco_unitario) AS valor_total_vendas
FROM vendas;

-- =====================================================
-- EXERCÍCIO 9: Aliases em UNION
-- =====================================================

-- 9.1 União de produtos e cursos com aliases
SELECT 
  nome AS item,
  preco AS valor,
  'Produto' AS tipo
FROM produtos
UNION
SELECT 
  titulo AS item,
  duracao AS valor,
  'Curso' AS tipo
FROM cursos;

-- 9.2 União de clientes e produtos com informações básicas
SELECT 
  nome AS nome_item,
  'Cliente' AS tipo_item
FROM clientes
UNION
SELECT 
  nome AS nome_item,
  'Produto' AS tipo_item
FROM produtos;

-- =====================================================
-- EXERCÍCIO 10: Desafios Avançados
-- =====================================================

-- 10.1 Relatório completo de vendas com aliases descritivos
SELECT 
  c.nome AS nome_cliente,
  p.nome AS nome_produto,
  p.categoria AS categoria_produto,
  v.quantidade AS qtd_comprada,
  v.preco_unitario AS preco_unitario_venda,
  v.desconto AS desconto_aplicado,
  (v.quantidade * v.preco_unitario) AS valor_total_bruto,
  (v.quantidade * v.preco_unitario * (1 - v.desconto/100)) AS valor_total_liquido,
  TO_CHAR(v.data_venda, 'DD/MM/YYYY HH24:MI') AS data_hora_compra
FROM clientes AS c
JOIN vendas AS v ON c.id = v.cliente_id
JOIN produtos AS p ON v.produto_id = p.id;

-- 10.2 Análise de produtos por categoria com aliases
SELECT 
  p.categoria AS categoria_produto,
  COUNT(*) AS total_produtos_categoria,
  AVG(p.preco) AS preco_medio_categoria,
  MAX(p.preco) AS produto_mais_caro_categoria,
  MIN(p.preco) AS produto_mais_barato_categoria,
  SUM(p.estoque) AS estoque_total_categoria,
  SUM(p.estoque * p.preco) AS valor_total_estoque_categoria
FROM produtos AS p
GROUP BY p.categoria;

-- 10.3 Relatório de cursos com informações detalhadas
SELECT 
  cur.titulo AS nome_curso,
  cur.duracao AS horas_duracao,
  cur.instrutor AS nome_instrutor,
  CASE 
    WHEN cur.gratuito THEN 'Gratuito'
    ELSE 'Pago'
  END AS tipo_curso,
  CASE 
    WHEN cur.duracao < 10 THEN 'Curso Rápido'
    WHEN cur.duracao < 30 THEN 'Curso Médio'
    ELSE 'Curso Longo'
  END AS classificacao_duracao,
  TO_CHAR(cur.inicio, 'DD/MM/YYYY') AS data_inicio_curso
FROM cursos AS cur;

-- =====================================================
-- LIMPEZA (OPCIONAL - DESCOMENTE PARA EXCLUIR AS TABELAS)
-- =====================================================

-- DROP TABLE IF EXISTS vendas;
-- DROP TABLE IF EXISTS cursos;
-- DROP TABLE IF EXISTS produtos;
-- DROP TABLE IF EXISTS clientes; 