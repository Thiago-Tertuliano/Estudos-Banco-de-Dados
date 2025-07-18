-- =====================================================
-- EXERCÍCIOS AULA 8: FUNÇÕES DE AGREGAÇÃO
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

INSERT INTO vendas (funcionario_id, produto, quantidade, preco_unitario, data_venda, desconto) VALUES
(1, 'Notebook Dell', 2, 3500.00, '2024-01-15 10:30:00', 5.00),
(2, 'Mouse Wireless', 5, 89.90, '2024-01-16 14:20:00', 0),
(3, 'Teclado Mecânico', 3, 299.00, '2024-01-17 09:15:00', 10.00),
(1, 'Monitor 24"', 1, 899.00, '2024-01-18 16:45:00', 0),
(4, 'SSD 500GB', 4, 399.00, '2024-01-19 11:30:00', 15.00),
(2, 'Webcam HD', 2, 150.00, '2024-01-20 13:20:00', 0),
(3, 'Headset Gamer', 1, 250.00, '2024-01-21 15:10:00', 0),
(1, 'Impressora Laser', 1, 800.00, '2024-01-22 10:45:00', 20.00);

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
(3, '2024-01-22 10:45:00', 640.00, 'Pendente', 20.00);

-- =====================================================
-- EXERCÍCIO 1: COUNT() - Contando Registros
-- =====================================================

-- 1.1 Conte quantos funcionários existem
SELECT COUNT(*) AS total_funcionarios FROM funcionarios;

-- 1.2 Conte quantos funcionários ativos existem
SELECT COUNT(*) AS total_funcionarios_ativos FROM funcionarios WHERE ativo = TRUE;

-- 1.3 Conte quantos produtos existem
SELECT COUNT(*) AS total_produtos FROM produtos;

-- 1.4 Conte quantos produtos estão em estoque (estoque > 0)
SELECT COUNT(*) AS produtos_em_estoque FROM produtos WHERE estoque > 0;

-- 1.5 Conte quantos pedidos foram aprovados
SELECT COUNT(*) AS pedidos_aprovados FROM pedidos WHERE status = 'Aprovado';

-- 1.6 Conte quantos departamentos diferentes existem
SELECT COUNT(DISTINCT departamento) AS total_departamentos FROM funcionarios;

-- 1.7 Conte quantas categorias de produtos existem
SELECT COUNT(DISTINCT categoria) AS total_categorias FROM produtos;

-- =====================================================
-- EXERCÍCIO 2: SUM() - Somando Valores
-- =====================================================

-- 2.1 Calcule o total de salários pagos
SELECT SUM(salario) AS total_salarios FROM funcionarios;

-- 2.2 Calcule o total de vendas (quantidade * preço unitário)
SELECT SUM(quantidade * preco_unitario) AS total_vendas FROM vendas;

-- 2.3 Calcule o valor total do estoque (preço * quantidade)
SELECT SUM(preco * estoque) AS valor_total_estoque FROM produtos;

-- 2.4 Calcule o total de pedidos aprovados
SELECT SUM(valor_total) AS total_pedidos_aprovados FROM pedidos WHERE status = 'Aprovado';

-- 2.5 Calcule o total de vendas com desconto aplicado
SELECT SUM(quantidade * preco_unitario * (1 - desconto/100)) AS total_vendas_liquido FROM vendas;

-- =====================================================
-- EXERCÍCIO 3: AVG() - Média dos Valores
-- =====================================================

-- 3.1 Calcule a média salarial dos funcionários
SELECT AVG(salario) AS salario_medio FROM funcionarios;

-- 3.2 Calcule a média de preços dos produtos
SELECT AVG(preco) AS preco_medio FROM produtos;

-- 3.3 Calcule a média de idade dos funcionários
SELECT AVG(EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM data_nascimento)) AS idade_media FROM funcionarios;

-- 3.4 Calcule a média de valor dos pedidos
SELECT AVG(valor_total) AS valor_medio_pedidos FROM pedidos;

-- 3.5 Calcule a média de quantidade vendida por venda
SELECT AVG(quantidade) AS quantidade_media_vendas FROM vendas;

-- =====================================================
-- EXERCÍCIO 4: MAX() e MIN() - Valores Extremos
-- =====================================================

-- 4.1 Encontre o funcionário com maior salário
SELECT MAX(salario) AS maior_salario FROM funcionarios;

-- 4.2 Encontre o produto mais caro
SELECT MAX(preco) AS produto_mais_caro FROM produtos;

-- 4.3 Encontre o funcionário com menor salário
SELECT MIN(salario) AS menor_salario FROM funcionarios;

-- 4.4 Encontre o produto mais barato
SELECT MIN(preco) AS produto_mais_barato FROM produtos;

-- 4.5 Encontre a maior venda (quantidade * preço)
SELECT MAX(quantidade * preco_unitario) AS maior_venda FROM vendas;

-- 4.6 Encontre o pedido de maior valor
SELECT MAX(valor_total) AS pedido_maior_valor FROM pedidos;

-- =====================================================
-- EXERCÍCIO 5: Combinando Funções com Aliases
-- =====================================================

-- 5.1 Estatísticas completas dos funcionários
SELECT 
  COUNT(*) AS total_funcionarios,
  AVG(salario) AS salario_medio,
  MAX(salario) AS maior_salario,
  MIN(salario) AS menor_salario,
  SUM(salario) AS folha_salarial_total
FROM funcionarios;

-- 5.2 Estatísticas completas dos produtos
SELECT 
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio,
  MAX(preco) AS produto_mais_caro,
  MIN(preco) AS produto_mais_barato,
  SUM(estoque) AS estoque_total,
  SUM(preco * estoque) AS valor_total_estoque
FROM produtos;

-- 5.3 Estatísticas completas das vendas
SELECT 
  COUNT(*) AS total_vendas,
  SUM(quantidade) AS total_itens_vendidos,
  AVG(preco_unitario) AS preco_medio_unitario,
  MAX(quantidade * preco_unitario) AS maior_venda,
  MIN(quantidade * preco_unitario) AS menor_venda,
  SUM(quantidade * preco_unitario) AS receita_total
FROM vendas;

-- 5.4 Estatísticas completas dos pedidos
SELECT 
  COUNT(*) AS total_pedidos,
  COUNT(CASE WHEN status = 'Aprovado' THEN 1 END) AS pedidos_aprovados,
  COUNT(CASE WHEN status = 'Pendente' THEN 1 END) AS pedidos_pendentes,
  COUNT(CASE WHEN status = 'Cancelado' THEN 1 END) AS pedidos_cancelados,
  AVG(valor_total) AS valor_medio_pedidos,
  SUM(valor_total) AS valor_total_pedidos
FROM pedidos;

-- =====================================================
-- EXERCÍCIO 6: Funções com Condicionais
-- =====================================================

-- 6.1 Análise de funcionários por departamento
SELECT 
  COUNT(*) AS total_funcionarios,
  COUNT(CASE WHEN departamento = 'Vendas' THEN 1 END) AS funcionarios_vendas,
  COUNT(CASE WHEN departamento = 'Marketing' THEN 1 END) AS funcionarios_marketing,
  COUNT(CASE WHEN departamento = 'TI' THEN 1 END) AS funcionarios_ti
FROM funcionarios;

-- 6.2 Análise de produtos por categoria
SELECT 
  COUNT(*) AS total_produtos,
  COUNT(CASE WHEN categoria = 'Eletrônicos' THEN 1 END) AS produtos_eletronicos,
  COUNT(CASE WHEN categoria = 'Periféricos' THEN 1 END) AS produtos_perifericos,
  COUNT(CASE WHEN categoria = 'Monitores' THEN 1 END) AS produtos_monitores,
  COUNT(CASE WHEN estoque > 0 THEN 1 END) AS produtos_em_estoque,
  COUNT(CASE WHEN estoque = 0 THEN 1 END) AS produtos_sem_estoque
FROM produtos;

-- 6.3 Análise de vendas por desconto
SELECT 
  COUNT(*) AS total_vendas,
  COUNT(CASE WHEN desconto = 0 THEN 1 END) AS vendas_sem_desconto,
  COUNT(CASE WHEN desconto > 0 THEN 1 END) AS vendas_com_desconto,
  AVG(CASE WHEN desconto = 0 THEN quantidade * preco_unitario END) AS media_vendas_sem_desconto,
  AVG(CASE WHEN desconto > 0 THEN quantidade * preco_unitario END) AS media_vendas_com_desconto
FROM vendas;

-- 6.4 Análise de pedidos por status
SELECT 
  COUNT(*) AS total_pedidos,
  COUNT(CASE WHEN status = 'Aprovado' THEN 1 END) AS pedidos_aprovados,
  COUNT(CASE WHEN status = 'Pendente' THEN 1 END) AS pedidos_pendentes,
  COUNT(CASE WHEN status = 'Cancelado' THEN 1 END) AS pedidos_cancelados,
  AVG(CASE WHEN status = 'Aprovado' THEN valor_total END) AS valor_medio_aprovados,
  AVG(CASE WHEN status = 'Pendente' THEN valor_total END) AS valor_medio_pendentes
FROM pedidos;

-- =====================================================
-- EXERCÍCIO 7: Casos de Uso Avançados
-- =====================================================

-- 7.1 Dashboard de e-commerce
SELECT 
  COUNT(*) AS total_produtos,
  COUNT(CASE WHEN estoque > 0 THEN 1 END) AS produtos_em_estoque,
  COUNT(CASE WHEN estoque = 0 THEN 1 END) AS produtos_sem_estoque,
  AVG(preco) AS preco_medio,
  SUM(estoque * preco) AS valor_total_estoque,
  COUNT(DISTINCT categoria) AS total_categorias
FROM produtos;

-- 7.2 Relatório de vendas por funcionário
SELECT 
  f.nome AS nome_funcionario,
  f.departamento AS departamento_funcionario,
  COUNT(v.id) AS total_vendas,
  SUM(v.quantidade * v.preco_unitario) AS valor_total_vendas,
  AVG(v.quantidade * v.preco_unitario) AS ticket_medio
FROM funcionarios f
LEFT JOIN vendas v ON f.id = v.funcionario_id
GROUP BY f.id, f.nome, f.departamento;

-- 7.3 Análise de produtos por fornecedor
SELECT 
  fornecedor AS nome_fornecedor,
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio,
  MAX(preco) AS produto_mais_caro,
  MIN(preco) AS produto_mais_barato,
  SUM(estoque) AS estoque_total
FROM produtos
GROUP BY fornecedor;

-- 7.4 Análise de pedidos por período
SELECT 
  EXTRACT(MONTH FROM data_pedido) AS mes,
  COUNT(*) AS total_pedidos,
  COUNT(CASE WHEN status = 'Aprovado' THEN 1 END) AS pedidos_aprovados,
  SUM(valor_total) AS receita_total,
  AVG(valor_total) AS ticket_medio
FROM pedidos
GROUP BY EXTRACT(MONTH FROM data_pedido)
ORDER BY mes;

-- =====================================================
-- EXERCÍCIO 8: Desafios Avançados
-- =====================================================

-- 8.1 Funcionários com salário acima da média
SELECT 
  nome AS nome_funcionario,
  salario AS salario_atual,
  (SELECT AVG(salario) FROM funcionarios) AS salario_medio_empresa
FROM funcionarios
WHERE salario > (SELECT AVG(salario) FROM funcionarios);

-- 8.2 Produtos com preço acima da média da categoria
SELECT 
  p.nome AS nome_produto,
  p.categoria AS categoria_produto,
  p.preco AS preco_produto,
  (SELECT AVG(preco) FROM produtos WHERE categoria = p.categoria) AS preco_medio_categoria
FROM produtos p
WHERE p.preco > (SELECT AVG(preco) FROM produtos WHERE categoria = p.categoria);

-- 8.3 Vendas com valor acima da média
SELECT 
  produto AS nome_produto,
  quantidade AS qtd_vendida,
  preco_unitario AS preco_unit,
  (quantidade * preco_unitario) AS valor_venda,
  (SELECT AVG(quantidade * preco_unitario) FROM vendas) AS valor_medio_vendas
FROM vendas
WHERE (quantidade * preco_unitario) > (SELECT AVG(quantidade * preco_unitario) FROM vendas);

-- 8.4 Análise de performance por departamento
SELECT 
  departamento AS nome_departamento,
  COUNT(*) AS total_funcionarios,
  AVG(salario) AS salario_medio_departamento,
  MAX(salario) AS maior_salario_departamento,
  MIN(salario) AS menor_salario_departamento,
  SUM(salario) AS folha_salarial_departamento
FROM funcionarios
GROUP BY departamento
ORDER BY salario_medio_departamento DESC;

-- =====================================================
-- LIMPEZA (OPCIONAL - DESCOMENTE PARA EXCLUIR AS TABELAS)
-- =====================================================

-- DROP TABLE IF EXISTS pedidos;
-- DROP TABLE IF EXISTS vendas;
-- DROP TABLE IF EXISTS produtos;
-- DROP TABLE IF EXISTS funcionarios; 