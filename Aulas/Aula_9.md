# 🧮 Aula 9 – Agrupamento de Dados: GROUP BY

## 🎯 Objetivos da Aula
- Compreender o conceito de agrupamento com GROUP BY
- Aprender a usar funções agregadas com grupos
- Dominar agrupamento por múltiplas colunas
- Praticar filtros com HAVING
- Entender diferenças entre WHERE e HAVING

---

## 🧠 Teoria

### GROUP BY - O que faz?
O `GROUP BY` agrupa os registros que têm o mesmo valor em uma ou mais colunas, permitindo aplicar funções agregadas a cada grupo separadamente.

### Conceito Fundamental:
- ✅ **Agrupa registros** com valores iguais
- ✅ **Permite agregações** por grupo
- ✅ **Reduz resultados** para análise
- ✅ **Facilita relatórios** e dashboards

---

## 📊 Sintaxe Básica

### Estrutura:
```sql
SELECT coluna_agrupamento, funcao_agregada(coluna)
FROM tabela
GROUP BY coluna_agrupamento;
```

### Exemplo Prático:
Imagine que temos uma tabela de vendas com colunas `produto` e `quantidade`.

Queremos saber a quantidade total vendida por produto:

```sql
SELECT produto, SUM(quantidade) AS total_vendido
FROM vendas
GROUP BY produto;
```

---

## 📋 Regras Importantes

### 1. Regra Principal
**Toda coluna no SELECT que não é uma função agregada deve estar no GROUP BY.**

### 2. Exemplos de Regras:

#### ✅ Correto
```sql
SELECT categoria, COUNT(*) AS total_produtos
FROM produtos
GROUP BY categoria;
```

#### ❌ Incorreto
```sql
SELECT categoria, nome, COUNT(*) AS total_produtos
FROM produtos
GROUP BY categoria;
-- ERRO: 'nome' não está no GROUP BY
```

### 3. Agrupamento por Múltiplas Colunas
```sql
SELECT cliente, produto, SUM(quantidade) AS total_vendido
FROM vendas
GROUP BY cliente, produto;
```

---

## 🎯 Exemplos Práticos

### 1. Agrupamento Simples por Categoria
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

### 2. Agrupamento por Status de Cliente
```sql
SELECT 
  ativo,
  COUNT(*) AS total_clientes,
  AVG(idade) AS idade_media,
  COUNT(email) AS clientes_com_email
FROM clientes
GROUP BY ativo;
```

### 3. Agrupamento por Tipo de Curso
```sql
SELECT 
  gratuito,
  COUNT(*) AS total_cursos,
  AVG(duracao) AS duracao_media,
  SUM(duracao) AS horas_totais
FROM cursos
GROUP BY gratuito;
```

---

## 🔀 Agrupamento por Múltiplas Colunas

### Conceito
Você pode agrupar por várias colunas simultaneamente, criando subgrupos mais específicos.

### Exemplos:

#### 1. Produtos por Categoria e Status
```sql
SELECT 
  categoria,
  estoque > 0 AS em_estoque,
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio
FROM produtos
GROUP BY categoria, estoque > 0;
```

#### 2. Vendas por Cliente e Produto
```sql
SELECT 
  c.nome AS cliente,
  p.nome AS produto,
  COUNT(*) AS total_pedidos,
  SUM(pe.valor_total) AS valor_total
FROM clientes c
JOIN pedidos pe ON c.id = pe.cliente_id
JOIN produtos p ON pe.produto_id = p.id
GROUP BY c.nome, p.nome;
```

#### 3. Cursos por Instrutor e Tipo
```sql
SELECT 
  i.nome AS instrutor,
  c.gratuito,
  COUNT(*) AS total_cursos,
  AVG(c.duracao) AS duracao_media
FROM instrutores i
JOIN cursos c ON i.id = c.instrutor_id
GROUP BY i.nome, c.gratuito;
```

---

## 🔍 Filtros com HAVING

### Conceito
O `HAVING` permite filtrar grupos após a agregação, diferente do `WHERE` que filtra registros individuais.

### Diferenças:
- **WHERE**: Filtra registros **antes** da agregação
- **HAVING**: Filtra grupos **depois** da agregação

### Exemplos:

#### 1. Categorias com Muitos Produtos
```sql
SELECT 
  categoria,
  COUNT(*) AS total_produtos
FROM produtos
GROUP BY categoria
HAVING COUNT(*) > 5;
```

#### 2. Clientes com Muitos Pedidos
```sql
SELECT 
  c.nome AS cliente,
  COUNT(*) AS total_pedidos,
  SUM(pe.valor_total) AS valor_total
FROM clientes c
JOIN pedidos pe ON c.id = pe.cliente_id
GROUP BY c.nome
HAVING COUNT(*) >= 3;
```

#### 3. Cursos com Duração Média Alta
```sql
SELECT 
  gratuito,
  AVG(duracao) AS duracao_media
FROM cursos
GROUP BY gratuito
HAVING AVG(duracao) > 15;
```

---

## 🚀 Casos de Uso Avançados

### 1. Análise de Vendas por Período
```sql
SELECT 
  EXTRACT(YEAR FROM data_pedido) AS ano,
  EXTRACT(MONTH FROM data_pedido) AS mes,
  COUNT(*) AS total_pedidos,
  SUM(valor_total) AS receita_total,
  AVG(valor_total) AS ticket_medio
FROM pedidos
GROUP BY EXTRACT(YEAR FROM data_pedido), EXTRACT(MONTH FROM data_pedido)
ORDER BY ano, mes;
```

### 2. Relatório de Produtos por Categoria
```sql
SELECT 
  categoria,
  COUNT(*) AS total_produtos,
  COUNT(CASE WHEN estoque > 0 THEN 1 END) AS produtos_em_estoque,
  COUNT(CASE WHEN estoque = 0 THEN 1 END) AS produtos_sem_estoque,
  AVG(preco) AS preco_medio,
  SUM(estoque * preco) AS valor_total_estoque
FROM produtos
GROUP BY categoria
HAVING COUNT(*) >= 2
ORDER BY total_produtos DESC;
```

### 3. Análise de Clientes por Faixa Etária
```sql
SELECT 
  CASE 
    WHEN idade < 25 THEN 'Jovem'
    WHEN idade BETWEEN 25 AND 50 THEN 'Adulto'
    ELSE 'Idoso'
  END AS faixa_etaria,
  COUNT(*) AS total_clientes,
  AVG(idade) AS idade_media,
  COUNT(CASE WHEN ativo = TRUE THEN 1 END) AS clientes_ativos
FROM clientes
GROUP BY 
  CASE 
    WHEN idade < 25 THEN 'Jovem'
    WHEN idade BETWEEN 25 AND 50 THEN 'Adulto'
    ELSE 'Idoso'
  END;
```

---

## 📝 Exercícios Práticos

### Exercício 1: Agrupamento Básico

**1. Liste a quantidade de cursos gratuitos e pagos:**
```sql
SELECT 
  gratuito,
  COUNT(*) AS total_cursos
FROM cursos
GROUP BY gratuito;
```

**2. Liste a duração média dos cursos por tipo (gratuito e pago):**
```sql
SELECT 
  gratuito,
  AVG(duracao) AS duracao_media
FROM cursos
GROUP BY gratuito;
```

**3. Agrupe os clientes por status ativo e conte quantos há em cada grupo:**
```sql
SELECT 
  ativo,
  COUNT(*) AS total_clientes
FROM clientes
GROUP BY ativo;
```

### Exercício 2: Agrupamento Múltiplo

**1. Produtos por categoria e status de estoque:**
```sql
SELECT 
  categoria,
  estoque > 0 AS em_estoque,
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio
FROM produtos
GROUP BY categoria, estoque > 0;
```

**2. Cursos por instrutor e tipo (gratuito/pago):**
```sql
SELECT 
  i.nome AS instrutor,
  c.gratuito,
  COUNT(*) AS total_cursos,
  AVG(c.duracao) AS duracao_media
FROM instrutores i
JOIN cursos c ON i.id = c.instrutor_id
GROUP BY i.nome, c.gratuito;
```

**3. Vendas por cliente e mês:**
```sql
SELECT 
  c.nome AS cliente,
  EXTRACT(MONTH FROM pe.data_pedido) AS mes,
  COUNT(*) AS total_pedidos,
  SUM(pe.valor_total) AS valor_total
FROM clientes c
JOIN pedidos pe ON c.id = pe.cliente_id
GROUP BY c.nome, EXTRACT(MONTH FROM pe.data_pedido);
```

### Exercício 3: Filtros com HAVING

**1. Categorias com mais de 3 produtos:**
```sql
SELECT 
  categoria,
  COUNT(*) AS total_produtos
FROM produtos
GROUP BY categoria
HAVING COUNT(*) > 3;
```

**2. Clientes que fizeram mais de 2 pedidos:**
```sql
SELECT 
  c.nome AS cliente,
  COUNT(*) AS total_pedidos
FROM clientes c
JOIN pedidos pe ON c.id = pe.cliente_id
GROUP BY c.nome
HAVING COUNT(*) > 2;
```

**3. Cursos com duração média maior que 10 horas:**
```sql
SELECT 
  gratuito,
  AVG(duracao) AS duracao_media
FROM cursos
GROUP BY gratuito
HAVING AVG(duracao) > 10;
```

---

## ⚠️ Armadilhas Comuns

### 1. Esquecer Colunas no GROUP BY
```sql
-- ❌ Erro: coluna não agrupada
SELECT categoria, nome, COUNT(*) FROM produtos GROUP BY categoria;

-- ✅ Correto: incluir todas as colunas não agregadas
SELECT categoria, nome, COUNT(*) FROM produtos GROUP BY categoria, nome;
```

### 2. Confundir WHERE e HAVING
```sql
-- ❌ WHERE não funciona com funções agregadas
SELECT categoria, COUNT(*) FROM produtos WHERE COUNT(*) > 5 GROUP BY categoria;

-- ✅ HAVING para filtrar grupos
SELECT categoria, COUNT(*) FROM produtos GROUP BY categoria HAVING COUNT(*) > 5;
```

### 3. Ordem Incorreta de Operações
```sql
-- ❌ Ordem incorreta
SELECT categoria, COUNT(*) FROM produtos HAVING COUNT(*) > 5 GROUP BY categoria;

-- ✅ Ordem correta: SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY
SELECT categoria, COUNT(*) FROM produtos GROUP BY categoria HAVING COUNT(*) > 5;
```

---

## 🚀 Dicas de Performance

### 1. Índices para GROUP BY
```sql
-- ✅ Índice melhora performance de agrupamento
CREATE INDEX idx_produtos_categoria ON produtos(categoria);
CREATE INDEX idx_clientes_ativo ON clientes(ativo);
```

### 2. Filtros Antes do Agrupamento
```sql
-- ✅ Filtra antes de agrupar (mais eficiente)
SELECT categoria, COUNT(*) FROM produtos 
WHERE preco > 100 
GROUP BY categoria;

-- ❌ Filtra depois de agrupar (menos eficiente)
SELECT categoria, COUNT(*) FROM produtos 
GROUP BY categoria 
HAVING AVG(preco) > 100;
```

### 3. Agrupamento Inteligente
```sql
-- ✅ Agrupa apenas o necessário
SELECT categoria, COUNT(*) FROM produtos GROUP BY categoria;

-- ❌ Agrupa desnecessariamente
SELECT categoria, nome, COUNT(*) FROM produtos GROUP BY categoria, nome;
```

---

## 🎯 Boas Práticas

### 1. Nomenclatura de Aliases
```sql
-- ✅ Aliases descritivos
SELECT categoria, COUNT(*) AS total_produtos FROM produtos GROUP BY categoria;

-- ❌ Alias confuso
SELECT categoria, COUNT(*) AS c FROM produtos GROUP BY categoria;
```

### 2. Ordenação de Resultados
```sql
-- ✅ Ordena resultados agrupados
SELECT categoria, COUNT(*) AS total 
FROM produtos 
GROUP BY categoria 
ORDER BY total DESC;
```

### 3. Documentação de Consultas Complexas
```sql
-- ✅ Consulta bem documentada
SELECT 
  categoria,
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio
FROM produtos
WHERE ativo = TRUE  -- Filtra produtos ativos
GROUP BY categoria  -- Agrupa por categoria
HAVING COUNT(*) > 1  -- Apenas categorias com mais de 1 produto
ORDER BY total_produtos DESC;  -- Ordena por quantidade
```

---

## 🚀 Próximos Passos
- Aula 10: Junção de tabelas (JOIN)
- Aula 11: Subconsultas avançadas
- Aula 12: Window Functions
- Aula 13: Índices e otimização

---

## 📚 Recursos Adicionais
- [PostgreSQL GROUP BY](https://www.postgresql.org/docs/current/sql-select.html#SQL-GROUPBY)
- [MySQL GROUP BY](https://dev.mysql.com/doc/refman/8.0/en/group-by-optimization.html)
- [SQLite GROUP BY](https://www.sqlite.org/lang_select.html#groupby)
- [SQL Performance with GROUP BY](https://www.postgresql.org/docs/current/performance-tips.html)

---

## 💡 Dicas Importantes

### ✅ Dicas para GROUP BY:
- Sempre inclua colunas não agregadas no GROUP BY
- Use HAVING para filtrar grupos, não WHERE
- Considere performance ao agrupar grandes tabelas
- Use aliases descritivos para resultados

### ❌ Erros Comuns:
- Esquecer colunas no GROUP BY
- Confundir WHERE e HAVING
- Não considerar ordem das operações
- Agrupar desnecessariamente

---

*Última atualização: Janeiro 2024*

