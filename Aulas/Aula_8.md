# 📈 Aula 8 – Funções de Agregação

## 🎯 Objetivos da Aula
- Compreender funções de agregação e seus usos
- Dominar COUNT, SUM, AVG, MAX, MIN
- Aprender a usar aliases com funções agregadas
- Praticar agregações em cenários reais
- Entender quando e como usar cada função

---

## 🧠 Teoria

### Funções de Agregação
As funções de agregação servem para resumir dados, calculando valores baseados em grupos de registros. São fundamentais para relatórios e análises de dados.

### Características:
- ✅ **Resumem dados** - Transformam múltiplas linhas em um valor
- ✅ **Ignoram NULL** - Valores nulos são automaticamente excluídos
- ✅ **Retornam um valor** - Sempre retornam um único resultado
- ✅ **Podem ser combinadas** - Use múltiplas funções na mesma consulta

---

## ✅ COUNT() – Contando Registros

### Conceito
A função `COUNT()` conta o número de registros que atendem a uma condição.

### Sintaxe:
```sql
SELECT COUNT(coluna) FROM tabela [WHERE condição];
```

### Exemplos Práticos:

#### 1. Contar Todos os Registros
```sql
SELECT COUNT(*) FROM cursos;
```
**Resultado:** Conta quantos cursos existem.

#### 2. Contar com Filtro
```sql
SELECT COUNT(*) FROM cursos WHERE gratuito = TRUE;
```
**Resultado:** Conta quantos cursos são gratuitos.

#### 3. Contar Valores Não Nulos
```sql
-- Conta apenas clientes com email
SELECT COUNT(email) FROM clientes;

-- Conta apenas produtos com preço
SELECT COUNT(preco) FROM produtos WHERE preco > 0;
```

#### 4. Contar Valores Únicos
```sql
-- Conta categorias únicas
SELECT COUNT(DISTINCT categoria) FROM produtos;

-- Conta emails únicos
SELECT COUNT(DISTINCT email) FROM clientes;
```

---

## ➕ SUM() – Somando Valores

### Conceito
A função `SUM()` soma todos os valores de uma coluna numérica.

### Sintaxe:
```sql
SELECT SUM(coluna) FROM tabela [WHERE condição];
```

### Exemplos Práticos:

#### 1. Soma Básica
```sql
SELECT SUM(duracao) FROM cursos;
```
**Resultado:** Soma a duração de todos os cursos.

#### 2. Soma com Filtro
```sql
-- Soma duração dos cursos gratuitos
SELECT SUM(duracao) FROM cursos WHERE gratuito = TRUE;

-- Soma preços dos produtos em estoque
SELECT SUM(preco) FROM produtos WHERE estoque > 0;
```

#### 3. Soma de Cálculos
```sql
-- Soma do valor total de vendas
SELECT SUM(quantidade * preco_unitario) FROM vendas;

-- Soma com desconto aplicado
SELECT SUM(preco * 0.9) FROM produtos WHERE categoria = 'Eletrônicos';
```

---

## 📉 AVG() – Média dos Valores

### Conceito
A função `AVG()` calcula a média aritmética dos valores de uma coluna.

### Sintaxe:
```sql
SELECT AVG(coluna) FROM tabela [WHERE condição];
```

### Exemplos Práticos:

#### 1. Média Básica
```sql
SELECT AVG(duracao) FROM cursos;
```
**Resultado:** Calcula a média da duração dos cursos.

#### 2. Média com Filtro
```sql
-- Média de idade dos clientes ativos
SELECT AVG(idade) FROM clientes WHERE ativo = TRUE;

-- Média de preço por categoria
SELECT AVG(preco) FROM produtos WHERE categoria = 'Eletrônicos';
```

#### 3. Média com Arredondamento
```sql
-- Média arredondada para 2 casas decimais
SELECT ROUND(AVG(preco), 2) AS preco_medio FROM produtos;

-- Média de idade como inteiro
SELECT ROUND(AVG(idade)) AS idade_media FROM clientes;
```

---

## 🟢 MAX() e 🔴 MIN() – Valores Extremos

### Conceito
- `MAX()` retorna o maior valor de uma coluna
- `MIN()` retorna o menor valor de uma coluna

### Sintaxe:
```sql
SELECT MAX(coluna) FROM tabela [WHERE condição];
SELECT MIN(coluna) FROM tabela [WHERE condição];
```

### Exemplos Práticos:

#### 1. Valores Extremos Básicos
```sql
SELECT MAX(duracao) FROM cursos;
SELECT MIN(duracao) FROM cursos;
```
**Resultado:** Mostra o curso mais longo e o mais curto.

#### 2. Extremos com Filtros
```sql
-- Maior preço de eletrônicos
SELECT MAX(preco) FROM produtos WHERE categoria = 'Eletrônicos';

-- Menor idade de clientes ativos
SELECT MIN(idade) FROM clientes WHERE ativo = TRUE;
```

#### 3. Extremos de Texto
```sql
-- Nome alfabeticamente maior
SELECT MAX(nome) FROM clientes;

-- Nome alfabeticamente menor
SELECT MIN(nome) FROM clientes;
```

---

## 🧠 Combinando Funções com Aliases

### Conceito
Você pode usar múltiplas funções de agregação na mesma consulta e dar nomes descritivos com aliases.

### Exemplo Básico:
```sql
SELECT COUNT(*) AS total_cursos,
       AVG(duracao) AS media_duracao
FROM cursos;
```

### Exemplos Práticos:

#### 1. Estatísticas Completas
```sql
SELECT 
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio,
  MAX(preco) AS preco_maximo,
  MIN(preco) AS preco_minimo,
  SUM(preco) AS valor_total_estoque
FROM produtos;
```

#### 2. Estatísticas por Categoria
```sql
SELECT 
  categoria,
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio,
  MAX(preco) AS preco_maximo,
  MIN(preco) AS preco_minimo
FROM produtos
GROUP BY categoria;
```

#### 3. Análise de Clientes
```sql
SELECT 
  COUNT(*) AS total_clientes,
  COUNT(email) AS clientes_com_email,
  AVG(idade) AS idade_media,
  MAX(idade) AS idade_maxima,
  MIN(idade) AS idade_minima
FROM clientes
WHERE ativo = TRUE;
```

---

## 🎯 Casos de Uso Avançados

### 1. Análise de Vendas
```sql
SELECT 
  COUNT(*) AS total_vendas,
  SUM(valor_total) AS receita_total,
  AVG(valor_total) AS ticket_medio,
  MAX(valor_total) AS maior_venda,
  MIN(valor_total) AS menor_venda
FROM pedidos
WHERE data_pedido >= CURRENT_DATE - INTERVAL '30 days';
```

### 2. Relatório de Produtos
```sql
SELECT 
  categoria,
  COUNT(*) AS quantidade_produtos,
  SUM(estoque) AS estoque_total,
  AVG(preco) AS preco_medio,
  MAX(preco) AS produto_mais_caro,
  MIN(preco) AS produto_mais_barato
FROM produtos
GROUP BY categoria
ORDER BY quantidade_produtos DESC;
```

### 3. Análise de Cursos
```sql
SELECT 
  COUNT(*) AS total_cursos,
  COUNT(CASE WHEN gratuito = TRUE THEN 1 END) AS cursos_gratuitos,
  COUNT(CASE WHEN gratuito = FALSE THEN 1 END) AS cursos_pagos,
  AVG(duracao) AS duracao_media,
  SUM(duracao) AS horas_totais
FROM cursos;
```

---

## 📊 Funções com Condicionais

### 1. COUNT com CASE
```sql
SELECT 
  COUNT(*) AS total_clientes,
  COUNT(CASE WHEN idade < 25 THEN 1 END) AS jovens,
  COUNT(CASE WHEN idade BETWEEN 25 AND 50 THEN 1 END) AS adultos,
  COUNT(CASE WHEN idade > 50 THEN 1 END) AS idosos
FROM clientes;
```

### 2. SUM com CASE
```sql
SELECT 
  SUM(CASE WHEN categoria = 'Eletrônicos' THEN preco ELSE 0 END) AS valor_eletronicos,
  SUM(CASE WHEN categoria = 'Livros' THEN preco ELSE 0 END) AS valor_livros,
  SUM(CASE WHEN categoria = 'Roupas' THEN preco ELSE 0 END) AS valor_roupas
FROM produtos;
```

### 3. AVG com Filtros Condicionais
```sql
SELECT 
  AVG(CASE WHEN gratuito = TRUE THEN duracao END) AS media_duracao_gratuitos,
  AVG(CASE WHEN gratuito = FALSE THEN duracao END) AS media_duracao_pagos
FROM cursos;
```

---

## 📝 Exercícios Práticos

### Exercício 1: Funções Básicas

**1. Conte quantos clientes existem na tabela clientes:**
```sql
SELECT COUNT(*) AS total_clientes FROM clientes;
```

**2. Calcule a média de idade dos clientes:**
```sql
SELECT AVG(idade) AS idade_media FROM clientes;
```

**3. Descubra o curso com maior duração:**
```sql
SELECT MAX(duracao) AS maior_duracao FROM cursos;
```

**4. Some a duração dos cursos gratuitos:**
```sql
SELECT SUM(duracao) AS total_horas_gratuitos 
FROM cursos WHERE gratuito = TRUE;
```

### Exercício 2: Análises Avançadas

**1. Estatísticas completas de produtos:**
```sql
SELECT 
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio,
  MAX(preco) AS preco_maximo,
  MIN(preco) AS preco_minimo,
  SUM(estoque) AS estoque_total
FROM produtos;
```

**2. Análise de clientes por faixa etária:**
```sql
SELECT 
  COUNT(*) AS total_clientes,
  COUNT(CASE WHEN idade < 25 THEN 1 END) AS jovens,
  COUNT(CASE WHEN idade BETWEEN 25 AND 50 THEN 1 END) AS adultos,
  COUNT(CASE WHEN idade > 50 THEN 1 END) AS idosos
FROM clientes;
```

**3. Relatório de vendas por mês:**
```sql
SELECT 
  EXTRACT(MONTH FROM data_pedido) AS mes,
  COUNT(*) AS total_pedidos,
  SUM(valor_total) AS receita_total,
  AVG(valor_total) AS ticket_medio
FROM pedidos
GROUP BY EXTRACT(MONTH FROM data_pedido)
ORDER BY mes;
```

### Exercício 3: Cenários Reais

**1. Dashboard de e-commerce:**
```sql
SELECT 
  COUNT(*) AS total_produtos,
  COUNT(CASE WHEN estoque > 0 THEN 1 END) AS produtos_em_estoque,
  COUNT(CASE WHEN estoque = 0 THEN 1 END) AS produtos_sem_estoque,
  AVG(preco) AS preco_medio,
  SUM(estoque * preco) AS valor_total_estoque
FROM produtos;
```

**2. Análise de cursos por tipo:**
```sql
SELECT 
  COUNT(*) AS total_cursos,
  COUNT(CASE WHEN gratuito = TRUE THEN 1 END) AS cursos_gratuitos,
  COUNT(CASE WHEN gratuito = FALSE THEN 1 END) AS cursos_pagos,
  AVG(duracao) AS duracao_media,
  SUM(duracao) AS horas_totais_disponiveis
FROM cursos;
```

---

## ⚠️ Armadilhas Comuns

### 1. COUNT(*) vs COUNT(coluna)
```sql
-- ✅ Conta todos os registros
SELECT COUNT(*) FROM clientes;

-- ✅ Conta apenas valores não nulos
SELECT COUNT(email) FROM clientes;

-- ❌ Pode dar resultado diferente
SELECT COUNT(*) FROM clientes WHERE email IS NOT NULL;
```

### 2. AVG com Valores Nulos
```sql
-- ✅ AVG ignora NULL automaticamente
SELECT AVG(idade) FROM clientes;

-- ❌ Não é necessário filtrar NULL
SELECT AVG(idade) FROM clientes WHERE idade IS NOT NULL;
```

### 3. Soma com Valores Negativos
```sql
-- ✅ Soma todos os valores
SELECT SUM(preco) FROM produtos;

-- ✅ Soma apenas valores positivos
SELECT SUM(CASE WHEN preco > 0 THEN preco ELSE 0 END) FROM produtos;
```

---

## 🚀 Dicas de Performance

### 1. Índices para Agregações
```sql
-- ✅ Índice melhora performance de COUNT
CREATE INDEX idx_clientes_ativo ON clientes(ativo);

-- ✅ Índice para agregações por categoria
CREATE INDEX idx_produtos_categoria ON produtos(categoria);
```

### 2. Filtros Antes de Agregar
```sql
-- ✅ Filtra antes de agregar
SELECT COUNT(*) FROM clientes WHERE ativo = TRUE;

-- ❌ Agrega tudo e depois filtra
SELECT COUNT(*) FROM clientes HAVING ativo = TRUE;
```

### 3. Uso Eficiente de DISTINCT
```sql
-- ✅ Mais eficiente
SELECT COUNT(DISTINCT categoria) FROM produtos;

-- ❌ Menos eficiente
SELECT COUNT(*) FROM (SELECT DISTINCT categoria FROM produtos);
```

---

## 🚀 Próximos Passos
- Aula 9: Agrupamento de dados (GROUP BY, HAVING)
- Aula 10: Junção de tabelas (JOIN)
- Aula 11: Subconsultas avançadas
- Aula 12: Window Functions

---

## 📚 Recursos Adicionais
- [PostgreSQL Aggregate Functions](https://www.postgresql.org/docs/current/functions-aggregate.html)
- [MySQL Aggregate Functions](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html)
- [SQLite Aggregate Functions](https://www.sqlite.org/lang_aggfunc.html)
- [SQL Performance with Aggregates](https://www.postgresql.org/docs/current/performance-tips.html)

---

## 💡 Dicas Importantes

### ✅ Dicas para Funções de Agregação:
- Use aliases descritivos para resultados
- Considere valores NULL em seus cálculos
- Use filtros antes de agregar para melhor performance
- Teste funções em dados pequenos primeiro

### ❌ Erros Comuns:
- Confundir COUNT(*) com COUNT(coluna)
- Não considerar valores NULL
- Usar agregações sem GROUP BY incorretamente
- Esquecer de usar aliases para clareza

---

*Última atualização: Janeiro 2024*

