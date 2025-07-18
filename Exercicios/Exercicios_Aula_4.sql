-- =====================================================
-- EXERCÍCIOS AULA 4: CONSULTAS BÁSICAS COM SELECT
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
('Carlos Ferreira', 'carlos@email.com', '(11) 55555-5555', '1995-07-18', 'Curitiba', 'PR'),
('Lucia Pereira', 'lucia@email.com', '(11) 44444-4444', '1991-11-30', 'Porto Alegre', 'RS'),
('Roberto Alves', 'roberto@email.com', '(11) 33333-3333', '1987-04-22', 'Salvador', 'BA'),
('Fernanda Lima', 'fernanda@email.com', '(11) 22222-2222', '1993-09-14', 'Brasília', 'DF');

INSERT INTO produtos (nome, descricao, preco, categoria, estoque, fornecedor) VALUES
('Notebook Dell', 'Notebook Dell Inspiron 15 polegadas', 3500.00, 'Eletrônicos', 10, 'Dell'),
('Mouse Wireless', 'Mouse sem fio com 3 botões', 89.90, 'Periféricos', 50, 'Logitech'),
('Teclado Mecânico', 'Teclado mecânico com switches blue', 299.00, 'Periféricos', 25, 'Corsair'),
('Monitor 24"', 'Monitor LED 24 polegadas Full HD', 899.00, 'Monitores', 15, 'LG'),
('SSD 500GB', 'SSD SATA 500GB para notebook', 399.00, 'Armazenamento', 30, 'Samsung'),
('Webcam HD', 'Webcam 1080p com microfone', 150.00, 'Periféricos', 20, 'Logitech'),
('Headset Gamer', 'Headset com microfone e RGB', 250.00, 'Periféricos', 15, 'HyperX'),
('Impressora Laser', 'Impressora monocromática', 800.00, 'Impressão', 8, 'HP'),
('Scanner A4', 'Scanner de mesa A4', 300.00, 'Impressão', 12, 'Canon'),
('Cabo HDMI', 'Cabo HDMI 2 metros', 25.00, 'Cabo', 100, 'Genérico');

INSERT INTO vendas (cliente_id, produto_id, quantidade, preco_unitario, data_venda, desconto) VALUES
(1, 1, 1, 3500.00, '2024-01-15 10:30:00', 0),
(2, 2, 2, 89.90, '2024-01-16 14:20:00', 5.00),
(3, 3, 1, 299.00, '2024-01-17 09:15:00', 0),
(4, 4, 1, 899.00, '2024-01-18 16:45:00', 10.00),
(5, 5, 2, 399.00, '2024-01-19 11:30:00', 0),
(1, 6, 1, 150.00, '2024-01-20 13:20:00', 0),
(2, 7, 1, 250.00, '2024-01-21 15:10:00', 0),
(3, 8, 1, 800.00, '2024-01-22 10:45:00', 15.00),
(4, 9, 1, 300.00, '2024-01-23 14:30:00', 0),
(5, 10, 3, 25.00, '2024-01-24 12:15:00', 0);

-- =====================================================
-- EXERCÍCIO 1: SELECT Básico
-- =====================================================

-- 1.1 Liste todos os clientes
SELECT * FROM clientes;

-- 1.2 Liste todos os produtos
SELECT * FROM produtos;

-- 1.3 Liste todas as vendas
SELECT * FROM vendas;

-- 1.4 Liste apenas os nomes dos clientes
SELECT nome FROM clientes;

-- 1.5 Liste apenas os nomes e preços dos produtos
SELECT nome, preco FROM produtos;

-- =====================================================
-- EXERCÍCIO 2: Seleção de Colunas Específicas
-- =====================================================

-- 2.1 Liste nome, email e cidade dos clientes
SELECT nome, email, cidade FROM clientes;

-- 2.2 Liste nome, preço e estoque dos produtos
SELECT nome, preco, estoque FROM produtos;

-- 2.3 Liste cliente_id, produto_id e quantidade das vendas
SELECT cliente_id, produto_id, quantidade FROM vendas;

-- 2.4 Liste nome, categoria e fornecedor dos produtos
SELECT nome, categoria, fornecedor FROM produtos;

-- =====================================================
-- EXERCÍCIO 3: Filtros Básicos com WHERE
-- =====================================================

-- 3.1 Liste apenas clientes de São Paulo
SELECT * FROM clientes WHERE cidade = 'São Paulo';

-- 3.2 Liste produtos com preço maior que R$ 100
SELECT * FROM produtos WHERE preco > 100;

-- 3.3 Liste vendas com quantidade maior que 1
SELECT * FROM vendas WHERE quantidade > 1;

-- 3.4 Liste clientes ativos
SELECT * FROM clientes WHERE ativo = TRUE;

-- 3.5 Liste produtos da categoria 'Periféricos'
SELECT * FROM produtos WHERE categoria = 'Periféricos';

-- =====================================================
-- EXERCÍCIO 4: Operadores de Comparação
-- =====================================================

-- 4.1 Liste produtos com preço entre R$ 100 e R$ 500
SELECT * FROM produtos WHERE preco BETWEEN 100 AND 500;

-- 4.2 Liste clientes nascidos antes de 1990
SELECT * FROM clientes WHERE data_nascimento < '1990-01-01';

-- 4.3 Liste produtos com estoque menor ou igual a 20
SELECT * FROM produtos WHERE estoque <= 20;

-- 4.4 Liste vendas com desconto maior que 0
SELECT * FROM vendas WHERE desconto > 0;

-- 4.5 Liste produtos que não são da categoria 'Eletrônicos'
SELECT * FROM produtos WHERE categoria != 'Eletrônicos';

-- =====================================================
-- EXERCÍCIO 5: Operadores Lógicos
-- =====================================================

-- 5.1 Liste produtos caros E com estoque baixo
SELECT * FROM produtos WHERE preco > 500 AND estoque < 20;

-- 5.2 Liste clientes de São Paulo OU Rio de Janeiro
SELECT * FROM clientes WHERE cidade = 'São Paulo' OR cidade = 'Rio de Janeiro';

-- 5.3 Liste produtos que NÃO são da categoria 'Periféricos'
SELECT * FROM produtos WHERE NOT categoria = 'Periféricos';

-- 5.4 Liste vendas com desconto OU quantidade maior que 1
SELECT * FROM vendas WHERE desconto > 0 OR quantidade > 1;

-- 5.5 Liste produtos com preço entre 100 e 300 OU estoque maior que 50
SELECT * FROM produtos WHERE (preco BETWEEN 100 AND 300) OR estoque > 50;

-- =====================================================
-- EXERCÍCIO 6: Ordenação com ORDER BY
-- =====================================================

-- 6.1 Liste clientes ordenados por nome (A-Z)
SELECT * FROM clientes ORDER BY nome ASC;

-- 6.2 Liste produtos ordenados por preço (mais caro primeiro)
SELECT * FROM produtos ORDER BY preco DESC;

-- 6.3 Liste vendas ordenadas por data (mais recente primeiro)
SELECT * FROM vendas ORDER BY data_venda DESC;

-- 6.4 Liste produtos ordenados por categoria e depois por nome
SELECT * FROM produtos ORDER BY categoria, nome;

-- 6.5 Liste clientes ordenados por data de nascimento (mais velho primeiro)
SELECT * FROM clientes ORDER BY data_nascimento ASC;

-- =====================================================
-- EXERCÍCIO 7: Limitação de Resultados
-- =====================================================

-- 7.1 Liste apenas os 3 primeiros clientes
SELECT * FROM clientes LIMIT 3;

-- 7.2 Liste os 5 produtos mais caros
SELECT * FROM produtos ORDER BY preco DESC LIMIT 5;

-- 7.3 Liste as 3 vendas mais recentes
SELECT * FROM vendas ORDER BY data_venda DESC LIMIT 3;

-- 7.4 Liste os 2 produtos com menor estoque
SELECT * FROM produtos ORDER BY estoque ASC LIMIT 2;

-- =====================================================
-- EXERCÍCIO 8: Aliases
-- =====================================================

-- 8.1 Liste produtos com alias para as colunas
SELECT 
  nome AS nome_produto,
  preco AS preco_atual,
  categoria AS categoria_produto,
  estoque AS quantidade_estoque
FROM produtos;

-- 8.2 Liste clientes com alias para as colunas
SELECT 
  nome AS nome_cliente,
  email AS email_cliente,
  cidade AS cidade_cliente,
  ativo AS cliente_ativo
FROM clientes;

-- 8.3 Liste vendas com alias para as colunas
SELECT 
  cliente_id AS id_cliente,
  produto_id AS id_produto,
  quantidade AS qtd_vendida,
  preco_unitario AS preco_unit,
  data_venda AS data_compra
FROM vendas;

-- =====================================================
-- EXERCÍCIO 9: Funções Agregadas Básicas
-- =====================================================

-- 9.1 Conte quantos clientes existem
SELECT COUNT(*) AS total_clientes FROM clientes;

-- 9.2 Conte quantos produtos existem
SELECT COUNT(*) AS total_produtos FROM produtos;

-- 9.3 Calcule a média de preços dos produtos
SELECT AVG(preco) AS preco_medio FROM produtos;

-- 9.4 Encontre o produto mais caro
SELECT MAX(preco) AS produto_mais_caro FROM produtos;

-- 9.5 Encontre o produto mais barato
SELECT MIN(preco) AS produto_mais_barato FROM produtos;

-- 9.6 Calcule o total de estoque
SELECT SUM(estoque) AS total_estoque FROM produtos;

-- =====================================================
-- EXERCÍCIO 10: Agrupamento Básico
-- =====================================================

-- 10.1 Agrupe produtos por categoria e conte quantos há em cada
SELECT categoria, COUNT(*) AS total_produtos
FROM produtos
GROUP BY categoria;

-- 10.2 Calcule a média de preço por categoria
SELECT categoria, AVG(preco) AS preco_medio
FROM produtos
GROUP BY categoria;

-- 10.3 Calcule o total de estoque por categoria
SELECT categoria, SUM(estoque) AS total_estoque
FROM produtos
GROUP BY categoria;

-- 10.4 Agrupe clientes por cidade e conte quantos há em cada
SELECT cidade, COUNT(*) AS total_clientes
FROM clientes
GROUP BY cidade;

-- =====================================================
-- EXERCÍCIO 11: Consultas Combinadas
-- =====================================================

-- 11.1 Liste produtos caros ordenados por preço
SELECT * FROM produtos WHERE preco > 500 ORDER BY preco DESC;

-- 11.2 Liste clientes ativos ordenados por nome
SELECT * FROM clientes WHERE ativo = TRUE ORDER BY nome ASC;

-- 11.3 Liste produtos com estoque baixo ordenados por estoque
SELECT * FROM produtos WHERE estoque < 20 ORDER BY estoque ASC;

-- 11.4 Liste vendas com desconto ordenadas por data
SELECT * FROM vendas WHERE desconto > 0 ORDER BY data_venda DESC;

-- =====================================================
-- EXERCÍCIO 12: Desafios Avançados
-- =====================================================

-- 12.1 Liste produtos com preço acima da média
SELECT * FROM produtos 
WHERE preco > (SELECT AVG(preco) FROM produtos);

-- 12.2 Liste clientes que fizeram mais de uma compra
SELECT cliente_id, COUNT(*) AS total_compras
FROM vendas
GROUP BY cliente_id
HAVING COUNT(*) > 1;

-- 12.3 Liste produtos que nunca foram vendidos
SELECT p.* FROM produtos p
LEFT JOIN vendas v ON p.id = v.produto_id
WHERE v.id IS NULL;

-- 12.4 Calcule estatísticas completas dos produtos
SELECT 
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio,
  MAX(preco) AS preco_maximo,
  MIN(preco) AS preco_minimo,
  SUM(estoque) AS total_estoque,
  COUNT(DISTINCT categoria) AS total_categorias
FROM produtos;

-- =====================================================
-- LIMPEZA (OPCIONAL - DESCOMENTE PARA EXCLUIR AS TABELAS)
-- =====================================================

-- DROP TABLE IF EXISTS vendas;
-- DROP TABLE IF EXISTS produtos;
-- DROP TABLE IF EXISTS clientes; 