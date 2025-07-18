-- =====================================================
-- EXERCÍCIOS AULA 9: AGRUPAMENTO DE DADOS (GROUP BY)
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
('Fernanda Lima', 'fernanda@empresa.com', 3900.00, 'Marketing', '2023-08-10', '1993-09-14');

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
(6, 'Cabo HDMI', 'Cabo', 10, 25.00, '2024-01-24 12:15:00', 0);

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
(5, '2024-01-24 12:15:00', 250.00, 'Cancelado', 0);

-- =====================================================
-- EXERCÍCIO 1: Agrupamento Básico
-- =====================================================

-- 1.1 Agrupe funcionários por departamento e conte quantos há em cada
SELECT 
  departamento,
  COUNT(*) AS total_funcionarios
FROM funcionarios
GROUP BY departamento;

-- 1.2 Agrupe produtos por categoria e conte quantos há em cada
SELECT 
  categoria,
  COUNT(*) AS total_produtos
FROM produtos
GROUP BY categoria;

-- 1.3 Agrupe vendas por categoria e calcule o total vendido
SELECT 
  categoria,
  COUNT(*) AS total_vendas,
  SUM(quantidade * preco_unitario) AS valor_total_vendas
FROM vendas
GROUP BY categoria;

-- 1.4 Agrupe pedidos por status e conte quantos há em cada
SELECT 
  status,
  COUNT(*) AS total_pedidos
FROM pedidos
GROUP BY status;

-- =====================================================
-- EXERCÍCIO 2: Agrupamento com Múltiplas Funções
-- =====================================================

-- 2.1 Funcionários por departamento com estatísticas salariais
SELECT 
  departamento,
  COUNT(*) AS total_funcionarios,
  AVG(salario) AS salario_medio,
  MAX(salario) AS maior_salario,
  MIN(salario) AS menor_salario,
  SUM(salario) AS folha_salarial_total
FROM funcionarios
GROUP BY departamento;

-- 2.2 Produtos por categoria com estatísticas de preço e estoque
SELECT 
  categoria,
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio,
  MAX(preco) AS produto_mais_caro,
  MIN(preco) AS produto_mais_barato,
  SUM(estoque) AS estoque_total,
  SUM(preco * estoque) AS valor_total_estoque
FROM produtos
GROUP BY categoria;

-- 2.3 Vendas por categoria com análise de desconto
SELECT 
  categoria,
  COUNT(*) AS total_vendas,
  SUM(quantidade) AS total_itens_vendidos,
  AVG(preco_unitario) AS preco_medio_unitario,
  AVG(desconto) AS desconto_medio,
  SUM(quantidade * preco_unitario) AS valor_total_bruto,
  SUM(quantidade * preco_unitario * (1 - desconto/100)) AS valor_total_liquido
FROM vendas
GROUP BY categoria;

-- 2.4 Pedidos por status com análise de valor
SELECT 
  status,
  COUNT(*) AS total_pedidos,
  AVG(valor_total) AS valor_medio_pedidos,
  MAX(valor_total) AS pedido_maior_valor,
  MIN(valor_total) AS pedido_menor_valor,
  SUM(valor_total) AS valor_total_pedidos
FROM pedidos
GROUP BY status;

-- =====================================================
-- EXERCÍCIO 3: Agrupamento por Múltiplas Colunas
-- =====================================================

-- 3.1 Funcionários por departamento e status ativo
SELECT 
  departamento,
  ativo,
  COUNT(*) AS total_funcionarios,
  AVG(salario) AS salario_medio
FROM funcionarios
GROUP BY departamento, ativo;

-- 3.2 Produtos por categoria e fornecedor
SELECT 
  categoria,
  fornecedor,
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio,
  SUM(estoque) AS estoque_total
FROM produtos
GROUP BY categoria, fornecedor;

-- 3.3 Vendas por funcionário e categoria
SELECT 
  f.nome AS nome_funcionario,
  f.departamento AS departamento_funcionario,
  v.categoria AS categoria_produto,
  COUNT(v.id) AS total_vendas,
  SUM(v.quantidade * v.preco_unitario) AS valor_total_vendas
FROM funcionarios f
JOIN vendas v ON f.id = v.funcionario_id
GROUP BY f.nome, f.departamento, v.categoria;

-- 3.4 Pedidos por status e desconto aplicado
SELECT 
  status,
  CASE 
    WHEN desconto = 0 THEN 'Sem Desconto'
    WHEN desconto <= 10 THEN 'Desconto Baixo'
    WHEN desconto <= 20 THEN 'Desconto Médio'
    ELSE 'Desconto Alto'
  END AS tipo_desconto,
  COUNT(*) AS total_pedidos,
  AVG(valor_total) AS valor_medio
FROM pedidos
GROUP BY status, 
  CASE 
    WHEN desconto = 0 THEN 'Sem Desconto'
    WHEN desconto <= 10 THEN 'Desconto Baixo'
    WHEN desconto <= 20 THEN 'Desconto Médio'
    ELSE 'Desconto Alto'
  END;

-- =====================================================
-- EXERCÍCIO 4: Agrupamento com Expressões
-- =====================================================

-- 4.1 Funcionários por faixa salarial
SELECT 
  CASE 
    WHEN salario < 3500 THEN 'Baixo'
    WHEN salario < 4000 THEN 'Médio'
    ELSE 'Alto'
  END AS faixa_salarial,
  COUNT(*) AS total_funcionarios,
  AVG(salario) AS salario_medio
FROM funcionarios
GROUP BY 
  CASE 
    WHEN salario < 3500 THEN 'Baixo'
    WHEN salario < 4000 THEN 'Médio'
    ELSE 'Alto'
  END;

-- 4.2 Produtos por faixa de preço
SELECT 
  CASE 
    WHEN preco < 100 THEN 'Econômico'
    WHEN preco < 500 THEN 'Médio'
    WHEN preco < 1000 THEN 'Alto'
    ELSE 'Premium'
  END AS faixa_preco,
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio,
  SUM(estoque) AS estoque_total
FROM produtos
GROUP BY 
  CASE 
    WHEN preco < 100 THEN 'Econômico'
    WHEN preco < 500 THEN 'Médio'
    WHEN preco < 1000 THEN 'Alto'
    ELSE 'Premium'
  END;

-- 4.3 Vendas por período (mês)
SELECT 
  EXTRACT(MONTH FROM data_venda) AS mes,
  COUNT(*) AS total_vendas,
  SUM(quantidade * preco_unitario) AS valor_total_vendas,
  AVG(quantidade * preco_unitario) AS ticket_medio
FROM vendas
GROUP BY EXTRACT(MONTH FROM data_venda)
ORDER BY mes;

-- 4.4 Pedidos por período (mês) e status
SELECT 
  EXTRACT(MONTH FROM data_pedido) AS mes,
  status,
  COUNT(*) AS total_pedidos,
  SUM(valor_total) AS valor_total_pedidos,
  AVG(valor_total) AS valor_medio_pedidos
FROM pedidos
GROUP BY EXTRACT(MONTH FROM data_pedido), status
ORDER BY mes, status;

-- =====================================================
-- EXERCÍCIO 5: Agrupamento com JOINs
-- =====================================================

-- 5.1 Vendas por funcionário com informações do funcionário
SELECT 
  f.nome AS nome_funcionario,
  f.departamento AS departamento_funcionario,
  COUNT(v.id) AS total_vendas,
  SUM(v.quantidade * v.preco_unitario) AS valor_total_vendas,
  AVG(v.quantidade * v.preco_unitario) AS ticket_medio
FROM funcionarios f
LEFT JOIN vendas v ON f.id = v.funcionario_id
GROUP BY f.id, f.nome, f.departamento;

-- 5.2 Produtos por fornecedor com estatísticas
SELECT 
  fornecedor AS nome_fornecedor,
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio,
  MAX(preco) AS produto_mais_caro,
  MIN(preco) AS produto_mais_barato,
  SUM(estoque) AS estoque_total,
  SUM(preco * estoque) AS valor_total_estoque
FROM produtos
GROUP BY fornecedor;

-- 5.3 Análise de vendas por categoria e funcionário
SELECT 
  f.nome AS nome_funcionario,
  v.categoria AS categoria_produto,
  COUNT(v.id) AS total_vendas,
  SUM(v.quantidade) AS total_itens_vendidos,
  SUM(v.quantidade * v.preco_unitario) AS valor_total_vendas
FROM funcionarios f
JOIN vendas v ON f.id = v.funcionario_id
GROUP BY f.nome, v.categoria
ORDER BY f.nome, valor_total_vendas DESC;

-- =====================================================
-- EXERCÍCIO 6: Agrupamento com Condicionais
-- =====================================================

-- 6.1 Funcionários por departamento com análise de status
SELECT 
  departamento,
  COUNT(*) AS total_funcionarios,
  COUNT(CASE WHEN ativo = TRUE THEN 1 END) AS funcionarios_ativos,
  COUNT(CASE WHEN ativo = FALSE THEN 1 END) AS funcionarios_inativos,
  AVG(salario) AS salario_medio
FROM funcionarios
GROUP BY departamento;

-- 6.2 Produtos por categoria com análise de estoque
SELECT 
  categoria,
  COUNT(*) AS total_produtos,
  COUNT(CASE WHEN estoque > 0 THEN 1 END) AS produtos_em_estoque,
  COUNT(CASE WHEN estoque = 0 THEN 1 END) AS produtos_sem_estoque,
  AVG(preco) AS preco_medio,
  SUM(estoque) AS estoque_total
FROM produtos
GROUP BY categoria;

-- 6.3 Vendas por categoria com análise de desconto
SELECT 
  categoria,
  COUNT(*) AS total_vendas,
  COUNT(CASE WHEN desconto = 0 THEN 1 END) AS vendas_sem_desconto,
  COUNT(CASE WHEN desconto > 0 THEN 1 END) AS vendas_com_desconto,
  AVG(desconto) AS desconto_medio,
  SUM(quantidade * preco_unitario) AS valor_total_bruto,
  SUM(quantidade * preco_unitario * (1 - desconto/100)) AS valor_total_liquido
FROM vendas
GROUP BY categoria;

-- 6.4 Pedidos por status com análise de desconto
SELECT 
  status,
  COUNT(*) AS total_pedidos,
  COUNT(CASE WHEN desconto = 0 THEN 1 END) AS pedidos_sem_desconto,
  COUNT(CASE WHEN desconto > 0 THEN 1 END) AS pedidos_com_desconto,
  AVG(desconto) AS desconto_medio,
  AVG(valor_total) AS valor_medio_pedidos,
  SUM(valor_total) AS valor_total_pedidos
FROM pedidos
GROUP BY status;

-- =====================================================
-- EXERCÍCIO 7: Desafios Avançados
-- =====================================================

-- 7.1 Análise de performance por departamento
SELECT 
  departamento,
  COUNT(*) AS total_funcionarios,
  AVG(salario) AS salario_medio,
  MAX(salario) AS maior_salario,
  MIN(salario) AS menor_salario,
  SUM(salario) AS folha_salarial_total,
  ROUND(AVG(EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM data_nascimento)), 1) AS idade_media
FROM funcionarios
GROUP BY departamento
ORDER BY salario_medio DESC;

-- 7.2 Relatório de produtos por categoria com análise completa
SELECT 
  categoria,
  COUNT(*) AS total_produtos,
  COUNT(CASE WHEN estoque > 0 THEN 1 END) AS produtos_em_estoque,
  COUNT(CASE WHEN estoque = 0 THEN 1 END) AS produtos_sem_estoque,
  AVG(preco) AS preco_medio,
  MAX(preco) AS produto_mais_caro,
  MIN(preco) AS produto_mais_barato,
  SUM(estoque) AS estoque_total,
  SUM(preco * estoque) AS valor_total_estoque,
  COUNT(DISTINCT fornecedor) AS total_fornecedores
FROM produtos
GROUP BY categoria
ORDER BY total_produtos DESC;

-- 7.3 Análise de vendas por funcionário e período
SELECT 
  f.nome AS nome_funcionario,
  f.departamento AS departamento_funcionario,
  EXTRACT(MONTH FROM v.data_venda) AS mes_venda,
  COUNT(v.id) AS total_vendas,
  SUM(v.quantidade) AS total_itens_vendidos,
  SUM(v.quantidade * v.preco_unitario) AS valor_total_vendas,
  AVG(v.quantidade * v.preco_unitario) AS ticket_medio,
  AVG(v.desconto) AS desconto_medio
FROM funcionarios f
LEFT JOIN vendas v ON f.id = v.funcionario_id
GROUP BY f.nome, f.departamento, EXTRACT(MONTH FROM v.data_venda)
ORDER BY f.nome, mes_venda;

-- 7.4 Análise de pedidos por período com tendências
SELECT 
  EXTRACT(MONTH FROM data_pedido) AS mes,
  EXTRACT(DAY FROM data_pedido) AS dia_semana,
  status,
  COUNT(*) AS total_pedidos,
  SUM(valor_total) AS valor_total_pedidos,
  AVG(valor_total) AS valor_medio_pedidos,
  COUNT(CASE WHEN desconto > 0 THEN 1 END) AS pedidos_com_desconto,
  AVG(desconto) AS desconto_medio
FROM pedidos
GROUP BY EXTRACT(MONTH FROM data_pedido), EXTRACT(DAY FROM data_pedido), status
ORDER BY mes, dia_semana, status;

-- =====================================================
-- LIMPEZA (OPCIONAL - DESCOMENTE PARA EXCLUIR AS TABELAS)
-- =====================================================

-- DROP TABLE IF EXISTS pedidos;
-- DROP TABLE IF EXISTS vendas;
-- DROP TABLE IF EXISTS produtos;
-- DROP TABLE IF EXISTS funcionarios; 