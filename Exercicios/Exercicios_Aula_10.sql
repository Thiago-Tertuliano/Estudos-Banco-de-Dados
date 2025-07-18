-- =====================================================
-- EXERCÍCIOS AULA 10: FILTROS DE GRUPOS (HAVING)
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
  ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE vendas (
  id SERIAL PRIMARY KEY,
  funcionario_id INTEGER NOT NULL,
  produto VARCHAR(200) NOT NULL,
  categoria VARCHAR(100),
  quantidade INTEGER NOT NULL CHECK (quantidade > 0),
  preco_unitario DECIMAL(10,2) NOT NULL,
  data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  desconto DECIMAL(5,2) DEFAULT 0
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

CREATE TABLE pedidos (
  id SERIAL PRIMARY KEY,
  cliente_id INTEGER NOT NULL,
  data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  valor_total DECIMAL(10,2) NOT NULL CHECK (valor_total > 0),
  status VARCHAR(50) DEFAULT 'Pendente' CHECK (status IN ('Pendente', 'Aprovado', 'Cancelado')),
  desconto DECIMAL(5,2) DEFAULT 0
);

-- Insira dados de exemplo
INSERT INTO funcionarios (nome, email, salario, departamento, data_admissao, data_nascimento) VALUES
('João Silva', 'joao@empresa.com', 3500.00, 'Vendas', '2023-01-15', '1990-05-15'),
('Maria Santos', 'maria@empresa.com', 4200.00, 'Marketing', '2023-03-20', '1985-08-22'),
('Pedro Costa', 'pedro@empresa.com', 3800.00, 'Vendas', '2023-06-10', '1992-03-10'),
('Ana Oliveira', 'ana@empresa.com', 3200.00, 'TI', '2023-02-01', '1988-12-05'),
('Carlos Ferreira', 'carlos@empresa.com', 4500.00, 'Marketing', '2023-04-15', '1995-07-18'),
('Lucia Pereira', 'lucia@empresa.com', 3600.00, 'Vendas', '2023-05-20', '1991-11-30'),
('Roberto Alves', 'roberto@empresa.com', 4100.00, 'TI', '2023-07-01', '1987-04-22'),
('Fernanda Lima', 'fernanda@empresa.com', 3900.00, 'Marketing', '2023-08-10', '1993-09-14'),
('Marcos Souza', 'marcos@empresa.com', 3400.00, 'Vendas', '2023-09-05', '1989-06-12'),
('Patricia Costa', 'patricia@empresa.com', 4300.00, 'Marketing', '2023-10-01', '1994-03-25');

INSERT INTO vendas (funcionario_id, produto, categoria, quantidade, preco_unitario, data_venda, desconto) VALUES
(1, 'Notebook Dell', 'Eletrônicos', 2, 3500.00, '2024-01-15 10:30:00', 5.00),
(2, 'Mouse Wireless', 'Periféricos', 5, 89.90, '2024-01-16 14:20:00', 0),
(3, 'Teclado Mecânico', 'Periféricos', 3, 299.00, '2024-01-17 09:15:00', 10.00),
(1, 'Monitor 24"', 'Monitores', 1, 899.00, '2024-01-18 16:45:00', 0),
(4, 'SSD 500GB', 'Armazenamento', 4, 399.00, '2024-01-19 11:30:00', 15.00),
(2, 'Webcam HD', 'Periféricos', 2, 150.00, '2024-01-20 13:20:00', 0),
(3, 'Headset Gamer', 'Periféricos', 1, 250.00, '2024-01-21 15:10:00', 0),
(1, 'Impressora Laser', 'Impressão', 1, 800.00, '2024-01-22 10:45:00', 20.00),
(5, 'Scanner A4', 'Impressão', 2, 300.00, '2024-01-23 14:30:00', 0),
(6, 'Cabo HDMI', 'Cabo', 10, 25.00, '2024-01-24 12:15:00', 0),
(1, 'Notebook Dell', 'Eletrônicos', 1, 3500.00, '2024-01-25 09:30:00', 0),
(2, 'Mouse Wireless', 'Periféricos', 3, 89.90, '2024-01-26 11:45:00', 5.00),
(3, 'Teclado Mecânico', 'Periféricos', 2, 299.00, '2024-01-27 14:20:00', 0);

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
('Cabo HDMI', 'Cabo HDMI 2 metros', 25.00, 'Cabo', 100, 'Genérico'),
('Notebook HP', 'Notebook HP Pavilion 14 polegadas', 2800.00, 'Eletrônicos', 5, 'HP'),
('Monitor 27"', 'Monitor LED 27 polegadas 4K', 1200.00, 'Monitores', 8, 'Samsung');

INSERT INTO pedidos (cliente_id, data_pedido, valor_total, status, desconto) VALUES
(1, '2024-01-15 10:30:00', 3500.00, 'Aprovado', 0),
(2, '2024-01-16 14:20:00', 179.80, 'Aprovado', 5.00),
(3, '2024-01-17 09:15:00', 299.00, 'Pendente', 0),
(4, '2024-01-18 16:45:00', 899.00, 'Aprovado', 10.00),
(5, '2024-01-19 11:30:00', 798.00, 'Cancelado', 0),
(1, '2024-01-20 13:20:00', 150.00, 'Aprovado', 0),
(2, '2024-01-21 15:10:00', 250.00, 'Aprovado', 0),
(3, '2024-01-22 10:45:00', 640.00, 'Pendente', 20.00),
(4, '2024-01-23 14:30:00', 300.00, 'Aprovado', 0),
(5, '2024-01-24 12:15:00', 250.00, 'Cancelado', 0),
(1, '2024-01-25 09:30:00', 2800.00, 'Aprovado', 0),
(2, '2024-01-26 11:45:00', 1200.00, 'Aprovado', 10.00),
(3, '2024-01-27 14:20:00', 450.00, 'Pendente', 0);

-- =====================================================
-- EXERCÍCIO 1: Filtros Básicos com HAVING
-- =====================================================

-- 1.1 Departamentos com mais de 2 funcionários
SELECT 
  departamento,
  COUNT(*) AS total_funcionarios
FROM funcionarios
GROUP BY departamento
HAVING COUNT(*) > 2;

-- 1.2 Categorias de produtos com mais de 2 produtos
SELECT 
  categoria,
  COUNT(*) AS total_produtos
FROM produtos
GROUP BY categoria
HAVING COUNT(*) > 2;

-- 1.3 Funcionários que fizeram mais de 2 vendas
SELECT 
  f.nome AS nome_funcionario,
  f.departamento AS departamento_funcionario,
  COUNT(v.id) AS total_vendas
FROM funcionarios f
JOIN vendas v ON f.id = v.funcionario_id
GROUP BY f.nome, f.departamento
HAVING COUNT(v.id) > 2;

-- 1.4 Categorias com valor total de vendas maior que 1000
SELECT 
  categoria,
  COUNT(*) AS total_vendas,
  SUM(quantidade * preco_unitario) AS valor_total_vendas
FROM vendas
GROUP BY categoria
HAVING SUM(quantidade * preco_unitario) > 1000;

-- =====================================================
-- EXERCÍCIO 2: HAVING com Funções Agregadas
-- =====================================================

-- 2.1 Departamentos com salário médio maior que 3800
SELECT 
  departamento,
  COUNT(*) AS total_funcionarios,
  AVG(salario) AS salario_medio
FROM funcionarios
GROUP BY departamento
HAVING AVG(salario) > 3800;

-- 2.2 Categorias de produtos com preço médio maior que 500
SELECT 
  categoria,
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio
FROM produtos
GROUP BY categoria
HAVING AVG(preco) > 500;

-- 2.3 Funcionários com ticket médio maior que 500
SELECT 
  f.nome AS nome_funcionario,
  f.departamento AS departamento_funcionario,
  COUNT(v.id) AS total_vendas,
  AVG(v.quantidade * v.preco_unitario) AS ticket_medio
FROM funcionarios f
JOIN vendas v ON f.id = v.funcionario_id
GROUP BY f.nome, f.departamento
HAVING AVG(v.quantidade * v.preco_unitario) > 500;

-- 2.4 Categorias com desconto médio maior que 5%
SELECT 
  categoria,
  COUNT(*) AS total_vendas,
  AVG(desconto) AS desconto_medio
FROM vendas
GROUP BY categoria
HAVING AVG(desconto) > 5;

-- =====================================================
-- EXERCÍCIO 3: Combinando WHERE e HAVING
-- =====================================================

-- 3.1 Funcionários ativos por departamento com mais de 2 funcionários
SELECT 
  departamento,
  COUNT(*) AS total_funcionarios,
  AVG(salario) AS salario_medio
FROM funcionarios
WHERE ativo = TRUE
GROUP BY departamento
HAVING COUNT(*) > 2;

-- 3.2 Produtos ativos por categoria com estoque total maior que 50
SELECT 
  categoria,
  COUNT(*) AS total_produtos,
  SUM(estoque) AS estoque_total
FROM produtos
WHERE ativo = TRUE
GROUP BY categoria
HAVING SUM(estoque) > 50;

-- 3.3 Vendas com desconto por categoria (apenas vendas com desconto)
SELECT 
  categoria,
  COUNT(*) AS total_vendas,
  AVG(desconto) AS desconto_medio,
  SUM(quantidade * preco_unitario) AS valor_total_vendas
FROM vendas
WHERE desconto > 0
GROUP BY categoria
HAVING COUNT(*) >= 2;

-- 3.4 Pedidos aprovados por cliente com valor total maior que 1000
SELECT 
  cliente_id,
  COUNT(*) AS total_pedidos,
  SUM(valor_total) AS valor_total_pedidos
FROM pedidos
WHERE status = 'Aprovado'
GROUP BY cliente_id
HAVING SUM(valor_total) > 1000;

-- =====================================================
-- EXERCÍCIO 4: HAVING com Múltiplas Condições
-- =====================================================

-- 4.1 Departamentos com mais de 2 funcionários E salário médio maior que 3500
SELECT 
  departamento,
  COUNT(*) AS total_funcionarios,
  AVG(salario) AS salario_medio
FROM funcionarios
GROUP BY departamento
HAVING COUNT(*) > 2 AND AVG(salario) > 3500;

-- 4.2 Categorias com mais de 2 produtos E preço médio maior que 200
SELECT 
  categoria,
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio
FROM produtos
GROUP BY categoria
HAVING COUNT(*) > 2 AND AVG(preco) > 200;

-- 4.3 Funcionários com mais de 2 vendas E ticket médio maior que 300
SELECT 
  f.nome AS nome_funcionario,
  f.departamento AS departamento_funcionario,
  COUNT(v.id) AS total_vendas,
  AVG(v.quantidade * v.preco_unitario) AS ticket_medio
FROM funcionarios f
JOIN vendas v ON f.id = v.funcionario_id
GROUP BY f.nome, f.departamento
HAVING COUNT(v.id) > 2 AND AVG(v.quantidade * v.preco_unitario) > 300;

-- 4.4 Categorias com valor total de vendas maior que 500 E desconto médio menor que 10%
SELECT 
  categoria,
  COUNT(*) AS total_vendas,
  SUM(quantidade * preco_unitario) AS valor_total_vendas,
  AVG(desconto) AS desconto_medio
FROM vendas
GROUP BY categoria
HAVING SUM(quantidade * preco_unitario) > 500 AND AVG(desconto) < 10;

-- =====================================================
-- EXERCÍCIO 5: HAVING com Expressões Complexas
-- =====================================================

-- 5.1 Departamentos com folha salarial maior que 10000
SELECT 
  departamento,
  COUNT(*) AS total_funcionarios,
  SUM(salario) AS folha_salarial_total
FROM funcionarios
GROUP BY departamento
HAVING SUM(salario) > 10000;

-- 5.2 Categorias com valor total de estoque maior que 50000
SELECT 
  categoria,
  COUNT(*) AS total_produtos,
  SUM(preco * estoque) AS valor_total_estoque
FROM produtos
GROUP BY categoria
HAVING SUM(preco * estoque) > 50000;

-- 5.3 Funcionários com valor total de vendas maior que 5000
SELECT 
  f.nome AS nome_funcionario,
  f.departamento AS departamento_funcionario,
  COUNT(v.id) AS total_vendas,
  SUM(v.quantidade * v.preco_unitario) AS valor_total_vendas
FROM funcionarios f
JOIN vendas v ON f.id = v.funcionario_id
GROUP BY f.nome, f.departamento
HAVING SUM(v.quantidade * v.preco_unitario) > 5000;

-- 5.4 Clientes com valor total de pedidos maior que 2000
SELECT 
  cliente_id,
  COUNT(*) AS total_pedidos,
  SUM(valor_total) AS valor_total_pedidos
FROM pedidos
GROUP BY cliente_id
HAVING SUM(valor_total) > 2000;

-- =====================================================
-- EXERCÍCIO 6: HAVING com Subconsultas
-- =====================================================

-- 6.1 Departamentos com salário médio acima da média geral
SELECT 
  departamento,
  COUNT(*) AS total_funcionarios,
  AVG(salario) AS salario_medio
FROM funcionarios
GROUP BY departamento
HAVING AVG(salario) > (SELECT AVG(salario) FROM funcionarios);

-- 6.2 Categorias com preço médio acima da média geral
SELECT 
  categoria,
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio
FROM produtos
GROUP BY categoria
HAVING AVG(preco) > (SELECT AVG(preco) FROM produtos);

-- 6.3 Funcionários com ticket médio acima da média geral
SELECT 
  f.nome AS nome_funcionario,
  f.departamento AS departamento_funcionario,
  COUNT(v.id) AS total_vendas,
  AVG(v.quantidade * v.preco_unitario) AS ticket_medio
FROM funcionarios f
JOIN vendas v ON f.id = v.funcionario_id
GROUP BY f.nome, f.departamento
HAVING AVG(v.quantidade * v.preco_unitario) > (
  SELECT AVG(quantidade * preco_unitario) FROM vendas
);

-- =====================================================
-- EXERCÍCIO 7: Casos de Uso Avançados
-- =====================================================

-- 7.1 Análise de performance por departamento (apenas departamentos com mais de 2 funcionários)
SELECT 
  departamento,
  COUNT(*) AS total_funcionarios,
  AVG(salario) AS salario_medio,
  MAX(salario) AS maior_salario,
  MIN(salario) AS menor_salario,
  SUM(salario) AS folha_salarial_total
FROM funcionarios
WHERE ativo = TRUE
GROUP BY departamento
HAVING COUNT(*) > 2 AND AVG(salario) > 3500
ORDER BY salario_medio DESC;

-- 7.2 Relatório de produtos por categoria (apenas categorias com muitos produtos)
SELECT 
  categoria,
  COUNT(*) AS total_produtos,
  COUNT(CASE WHEN estoque > 0 THEN 1 END) AS produtos_em_estoque,
  AVG(preco) AS preco_medio,
  SUM(estoque) AS estoque_total,
  SUM(preco * estoque) AS valor_total_estoque
FROM produtos
WHERE ativo = TRUE
GROUP BY categoria
HAVING COUNT(*) >= 2 AND SUM(estoque) > 20
ORDER BY total_produtos DESC;

-- 7.3 Análise de vendas por funcionário (apenas funcionários com muitas vendas)
SELECT 
  f.nome AS nome_funcionario,
  f.departamento AS departamento_funcionario,
  COUNT(v.id) AS total_vendas,
  SUM(v.quantidade) AS total_itens_vendidos,
  SUM(v.quantidade * v.preco_unitario) AS valor_total_vendas,
  AVG(v.quantidade * v.preco_unitario) AS ticket_medio
FROM funcionarios f
JOIN vendas v ON f.id = v.funcionario_id
GROUP BY f.nome, f.departamento
HAVING COUNT(v.id) >= 2 AND SUM(v.quantidade * v.preco_unitario) > 1000
ORDER BY valor_total_vendas DESC;

-- 7.4 Análise de pedidos por cliente (apenas clientes com muitos pedidos)
SELECT 
  cliente_id,
  COUNT(*) AS total_pedidos,
  COUNT(CASE WHEN status = 'Aprovado' THEN 1 END) AS pedidos_aprovados,
  SUM(valor_total) AS valor_total_pedidos,
  AVG(valor_total) AS valor_medio_pedidos
FROM pedidos
GROUP BY cliente_id
HAVING COUNT(*) >= 2 AND SUM(valor_total) > 500
ORDER BY valor_total_pedidos DESC;

-- =====================================================
-- EXERCÍCIO 8: Desafios Avançados
-- =====================================================

-- 8.1 Top 3 departamentos por salário médio (apenas com mais de 2 funcionários)
SELECT 
  departamento,
  COUNT(*) AS total_funcionarios,
  AVG(salario) AS salario_medio,
  SUM(salario) AS folha_salarial_total
FROM funcionarios
WHERE ativo = TRUE
GROUP BY departamento
HAVING COUNT(*) > 2
ORDER BY salario_medio DESC
LIMIT 3;

-- 8.2 Categorias premium (produtos caros e em estoque)
SELECT 
  categoria,
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio,
  SUM(estoque) AS estoque_total,
  SUM(preco * estoque) AS valor_total_estoque
FROM produtos
WHERE ativo = TRUE
GROUP BY categoria
HAVING AVG(preco) > 500 AND SUM(estoque) > 10
ORDER BY valor_total_estoque DESC;

-- 8.3 Funcionários VIP (muitas vendas e alto valor)
SELECT 
  f.nome AS nome_funcionario,
  f.departamento AS departamento_funcionario,
  COUNT(v.id) AS total_vendas,
  SUM(v.quantidade * v.preco_unitario) AS valor_total_vendas,
  AVG(v.quantidade * v.preco_unitario) AS ticket_medio
FROM funcionarios f
JOIN vendas v ON f.id = v.funcionario_id
GROUP BY f.nome, f.departamento
HAVING COUNT(v.id) >= 3 AND SUM(v.quantidade * v.preco_unitario) > 2000
ORDER BY valor_total_vendas DESC;

-- 8.4 Clientes VIP (muitos pedidos e alto valor)
SELECT 
  cliente_id,
  COUNT(*) AS total_pedidos,
  COUNT(CASE WHEN status = 'Aprovado' THEN 1 END) AS pedidos_aprovados,
  SUM(valor_total) AS valor_total_pedidos,
  AVG(valor_total) AS valor_medio_pedidos
FROM pedidos
GROUP BY cliente_id
HAVING COUNT(*) >= 3 AND SUM(valor_total) > 1000
ORDER BY valor_total_pedidos DESC;

-- =====================================================
-- LIMPEZA (OPCIONAL - DESCOMENTE PARA EXCLUIR AS TABELAS)
-- =====================================================

-- DROP TABLE IF EXISTS pedidos;
-- DROP TABLE IF EXISTS vendas;
-- DROP TABLE IF EXISTS produtos;
-- DROP TABLE IF EXISTS funcionarios; 