-- =====================================================
-- EXERCÍCIOS AULA 1: INTRODUÇÃO AO SQL
-- =====================================================

-- =====================================================
-- EXERCÍCIO 1: Criação de Tabelas Básicas
-- =====================================================

-- 1.1 Crie uma tabela de clientes com os seguintes campos:
-- id (chave primária auto-incremento)
-- nome (texto, obrigatório)
-- email (texto, único, obrigatório)
-- telefone (texto)
-- data_nascimento (data)
-- ativo (booleano, padrão true)

CREATE TABLE clientes (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  telefone VARCHAR(20),
  data_nascimento DATE,
  ativo BOOLEAN DEFAULT TRUE
);

-- 1.2 Crie uma tabela de produtos com os seguintes campos:
-- id (chave primária auto-incremento)
-- nome (texto, obrigatório)
-- descricao (texto longo)
-- preco (decimal com 2 casas, obrigatório, maior que 0)
-- categoria (texto)
-- estoque (inteiro, padrão 0, não negativo)
-- ativo (booleano, padrão true)

CREATE TABLE produtos (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(200) NOT NULL,
  descricao TEXT,
  preco DECIMAL(10,2) NOT NULL CHECK (preco > 0),
  categoria VARCHAR(100),
  estoque INTEGER DEFAULT 0 CHECK (estoque >= 0),
  ativo BOOLEAN DEFAULT TRUE
);

-- =====================================================
-- EXERCÍCIO 2: Inserção de Dados
-- =====================================================

-- 2.1 Insira 3 clientes na tabela clientes
INSERT INTO clientes (nome, email, telefone, data_nascimento) VALUES
('João Silva', 'joao@email.com', '(11) 99999-9999', '1990-05-15'),
('Maria Santos', 'maria@email.com', '(11) 88888-8888', '1985-08-22'),
('Pedro Costa', 'pedro@email.com', '(11) 77777-7777', '1992-03-10');

-- 2.2 Insira 5 produtos na tabela produtos
INSERT INTO produtos (nome, descricao, preco, categoria, estoque) VALUES
('Notebook Dell', 'Notebook Dell Inspiron 15 polegadas', 3500.00, 'Eletrônicos', 10),
('Mouse Wireless', 'Mouse sem fio com 3 botões', 89.90, 'Periféricos', 50),
('Teclado Mecânico', 'Teclado mecânico com switches blue', 299.00, 'Periféricos', 25),
('Monitor 24"', 'Monitor LED 24 polegadas Full HD', 899.00, 'Monitores', 15),
('SSD 500GB', 'SSD SATA 500GB para notebook', 399.00, 'Armazenamento', 30);

-- =====================================================
-- EXERCÍCIO 3: Consultas Básicas
-- =====================================================

-- 3.1 Liste todos os clientes
SELECT * FROM clientes;

-- 3.2 Liste todos os produtos
SELECT * FROM produtos;

-- 3.3 Liste apenas os nomes e emails dos clientes
SELECT nome, email FROM clientes;

-- 3.4 Liste apenas os nomes e preços dos produtos
SELECT nome, preco FROM produtos;

-- =====================================================
-- EXERCÍCIO 4: Filtros Básicos
-- =====================================================

-- 4.1 Liste apenas clientes ativos
SELECT * FROM clientes WHERE ativo = TRUE;

-- 4.2 Liste produtos com preço maior que R$ 100
SELECT * FROM produtos WHERE preco > 100;

-- 4.3 Liste produtos da categoria 'Periféricos'
SELECT * FROM produtos WHERE categoria = 'Periféricos';

-- 4.4 Liste produtos com estoque maior que 0
SELECT * FROM produtos WHERE estoque > 0;

-- =====================================================
-- EXERCÍCIO 5: Ordenação
-- =====================================================

-- 5.1 Liste clientes ordenados por nome (A-Z)
SELECT * FROM clientes ORDER BY nome ASC;

-- 5.2 Liste produtos ordenados por preço (mais caro primeiro)
SELECT * FROM produtos ORDER BY preco DESC;

-- 5.3 Liste produtos ordenados por categoria e depois por nome
SELECT * FROM produtos ORDER BY categoria, nome;

-- =====================================================
-- EXERCÍCIO 6: Limitação de Resultados
-- =====================================================

-- 6.1 Liste apenas os 3 primeiros clientes
SELECT * FROM clientes LIMIT 3;

-- 6.2 Liste os 3 produtos mais caros
SELECT * FROM produtos ORDER BY preco DESC LIMIT 3;

-- 6.3 Liste os 2 produtos com menor estoque
SELECT * FROM produtos ORDER BY estoque ASC LIMIT 2;

-- =====================================================
-- EXERCÍCIO 7: Aliases
-- =====================================================

-- 7.1 Liste produtos com alias para as colunas
SELECT 
  nome AS nome_produto,
  preco AS preco_atual,
  categoria AS categoria_produto
FROM produtos;

-- 7.2 Liste clientes com alias para as colunas
SELECT 
  nome AS nome_cliente,
  email AS email_cliente,
  ativo AS cliente_ativo
FROM clientes;

-- =====================================================
-- EXERCÍCIO 8: Funções Agregadas Básicas
-- =====================================================

-- 8.1 Conte quantos clientes existem
SELECT COUNT(*) AS total_clientes FROM clientes;

-- 8.2 Conte quantos produtos existem
SELECT COUNT(*) AS total_produtos FROM produtos;

-- 8.3 Calcule a média de preços dos produtos
SELECT AVG(preco) AS preco_medio FROM produtos;

-- 8.4 Encontre o produto mais caro
SELECT MAX(preco) AS produto_mais_caro FROM produtos;

-- 8.5 Encontre o produto mais barato
SELECT MIN(preco) AS produto_mais_barato FROM produtos;

-- =====================================================
-- EXERCÍCIO 9: Agrupamento Básico
-- =====================================================

-- 9.1 Agrupe produtos por categoria e conte quantos há em cada
SELECT categoria, COUNT(*) AS total_produtos
FROM produtos
GROUP BY categoria;

-- 9.2 Calcule a média de preço por categoria
SELECT categoria, AVG(preco) AS preco_medio
FROM produtos
GROUP BY categoria;

-- 9.3 Calcule o total de estoque por categoria
SELECT categoria, SUM(estoque) AS total_estoque
FROM produtos
GROUP BY categoria;

-- =====================================================
-- EXERCÍCIO 10: Desafios
-- =====================================================

-- 10.1 Liste produtos com preço entre R$ 100 e R$ 500
SELECT * FROM produtos WHERE preco BETWEEN 100 AND 500;

-- 10.2 Liste produtos que contêm a palavra 'Mouse' no nome
SELECT * FROM produtos WHERE nome LIKE '%Mouse%';

-- 10.3 Liste produtos ordenados por preço (mais barato primeiro) limitado a 3
SELECT * FROM produtos ORDER BY preco ASC LIMIT 3;

-- 10.4 Calcule o valor total do estoque (preço * quantidade)
SELECT 
  nome,
  preco,
  estoque,
  (preco * estoque) AS valor_total_estoque
FROM produtos;

-- =====================================================
-- EXERCÍCIO 11: Análise de Dados
-- =====================================================

-- 11.1 Estatísticas completas dos produtos
SELECT 
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio,
  MAX(preco) AS preco_maximo,
  MIN(preco) AS preco_minimo,
  SUM(estoque) AS total_estoque
FROM produtos;

-- 11.2 Produtos por categoria com estatísticas
SELECT 
  categoria,
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio,
  SUM(estoque) AS total_estoque
FROM produtos
GROUP BY categoria
ORDER BY total_produtos DESC;

-- 11.3 Produtos com estoque baixo (menos de 20 unidades)
SELECT 
  nome,
  categoria,
  estoque,
  preco
FROM produtos
WHERE estoque < 20
ORDER BY estoque ASC;

-- =====================================================
-- LIMPEZA (OPCIONAL - DESCOMENTE PARA EXCLUIR AS TABELAS)
-- =====================================================

-- DROP TABLE IF EXISTS produtos;
-- DROP TABLE IF EXISTS clientes; 