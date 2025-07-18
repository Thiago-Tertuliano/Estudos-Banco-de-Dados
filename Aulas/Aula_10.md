# 🎯 Aula 10 – Filtros de Grupos: HAVING

## 🎯 Objetivos da Aula
- Compreender o conceito e uso do HAVING
- Diferenciar WHERE e HAVING corretamente
- Aprender quando usar cada tipo de filtro
- Praticar filtros de grupos em cenários reais
- Entender a ordem de execução das cláusulas SQL

---

## 🧠 Teoria

### HAVING - O que é?
O `HAVING` serve para filtrar os grupos criados pelo `GROUP BY`, semelhante ao `WHERE` mas que funciona **após** a agregação.

### Conceito Fundamental:
- ✅ **Filtra grupos** após agregação
- ✅ **Usa funções agregadas** nas condições
- ✅ **Complementa GROUP BY** para análises específicas
- ✅ **Permite filtros complexos** em resultados agrupados

---

## 📊 Sintaxe Básica

### Estrutura:
```sql
SELECT coluna_agrupamento, funcao_agregada(coluna)
FROM tabela
GROUP BY coluna_agrupamento
HAVING condicao_com_funcao_agregada;
```

### Exemplo Prático:
Queremos listar produtos vendidos mais de 10 vezes:

```sql
SELECT produto, SUM(quantidade) AS total_vendido
FROM vendas
GROUP BY produto
HAVING SUM(quantidade) > 10;
```

---

## 🔍 Diferença WHERE x HAVING

### Conceito:
- **WHERE**: Filtra **linhas individuais** antes da agregação
- **HAVING**: Filtra **grupos** depois da agregação

### Ordem de Execução:
1. **FROM** - Seleciona tabelas
2. **WHERE** - Filtra linhas individuais
3. **GROUP BY** - Agrupa registros
4. **HAVING** - Filtra grupos
5. **SELECT** - Seleciona colunas
6. **ORDER BY** - Ordena resultados

### Exemplos Comparativos:

#### WHERE (Filtra Linhas)
```sql
-- Filtra produtos com preço > 100 antes de agrupar
SELECT categoria, COUNT(*) AS total_produtos
FROM produtos
WHERE preco > 100
GROUP BY categoria;
```

#### HAVING (Filtra Grupos)
```sql
-- Filtra categorias com mais de 5 produtos após agrupar
SELECT categoria, COUNT(*) AS total_produtos
FROM produtos
GROUP BY categoria
HAVING COUNT(*) > 5;
```

---

## 🎯 Exemplos Práticos

### 1. Categorias com Muitos Produtos
```sql
SELECT 
  categoria,
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio
FROM produtos
GROUP BY categoria
HAVING COUNT(*) >= 3;
```

### 2. Clientes com Muitos Pedidos
```sql
SELECT 
  c.nome AS cliente,
  COUNT(*) AS total_pedidos,
  SUM(pe.valor_total) AS valor_total
FROM clientes c
JOIN pedidos pe ON c.id = pe.cliente_id
GROUP BY c.nome
HAVING COUNT(*) >= 2;
```

### 3. Cursos com Duração Média Alta
```sql
SELECT 
  gratuito,
  COUNT(*) AS total_cursos,
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
  EXTRACT(MONTH FROM data_pedido) AS mes,
  COUNT(*) AS total_pedidos,
  SUM(valor_total) AS receita_total,
  AVG(valor_total) AS ticket_medio
FROM pedidos
GROUP BY EXTRACT(MONTH FROM data_pedido)
HAVING SUM(valor_total) > 10000;
```

### 2. Produtos com Alto Valor de Estoque
```sql
SELECT 
  categoria,
  COUNT(*) AS total_produtos,
  SUM(estoque * preco) AS valor_total_estoque
FROM produtos
GROUP BY categoria
HAVING SUM(estoque * preco) > 50000;
```

### 3. Instrutores com Muitos Cursos
```sql
SELECT 
  i.nome AS instrutor,
  COUNT(*) AS total_cursos,
  AVG(c.duracao) AS duracao_media
FROM instrutores i
JOIN cursos c ON i.id = c.instrutor_id
GROUP BY i.nome
HAVING COUNT(*) >= 2 AND AVG(c.duracao) > 10;
```

---

## 🔀 Combinando WHERE e HAVING

### Conceito
Você pode usar `WHERE` e `HAVING` na mesma consulta para filtros em diferentes níveis.

### Exemplos:

#### 1. Produtos Ativos com Muitos Itens
```sql
SELECT 
  categoria,
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio
FROM produtos
WHERE ativo = TRUE  -- Filtra produtos ativos
GROUP BY categoria
HAVING COUNT(*) > 3;  -- Filtra categorias com muitos produtos
```

#### 2. Clientes Ativos com Alto Valor
```sql
SELECT 
  c.nome AS cliente,
  COUNT(*) AS total_pedidos,
  SUM(pe.valor_total) AS valor_total
FROM clientes c
JOIN pedidos pe ON c.id = pe.cliente_id
WHERE c.ativo = TRUE  -- Filtra clientes ativos
GROUP BY c.nome
HAVING SUM(pe.valor_total) > 1000;  -- Filtra clientes com alto valor
```

#### 3. Cursos Gratuitos com Duração Média Alta
```sql
SELECT 
  instrutor_id,
  COUNT(*) AS total_cursos,
  AVG(duracao) AS duracao_media
FROM cursos
WHERE gratuito = TRUE  -- Filtra cursos gratuitos
GROUP BY instrutor_id
HAVING AVG(duracao) > 20;  -- Filtra instrutores com cursos longos
```

---

## 📊 Funções Agregadas no HAVING

### 1. COUNT() no HAVING
```sql
-- Categorias com mais de 5 produtos
SELECT categoria, COUNT(*) AS total_produtos
FROM produtos
GROUP BY categoria
HAVING COUNT(*) > 5;

-- Clientes com mais de 3 pedidos
SELECT c.nome, COUNT(*) AS total_pedidos
FROM clientes c
JOIN pedidos pe ON c.id = pe.cliente_id
GROUP BY c.nome
HAVING COUNT(*) > 3;
```

### 2. SUM() no HAVING
```sql
-- Categorias com valor total de estoque alto
SELECT categoria, SUM(estoque * preco) AS valor_estoque
FROM produtos
GROUP BY categoria
HAVING SUM(estoque * preco) > 100000;

-- Clientes com alto valor total de compras
SELECT c.nome, SUM(pe.valor_total) AS valor_total
FROM clientes c
JOIN pedidos pe ON c.id = pe.cliente_id
GROUP BY c.nome
HAVING SUM(pe.valor_total) > 5000;
```

### 3. AVG() no HAVING
```sql
-- Categorias com preço médio alto
SELECT categoria, AVG(preco) AS preco_medio
FROM produtos
GROUP BY categoria
HAVING AVG(preco) > 500;

-- Instrutores com duração média alta
SELECT i.nome, AVG(c.duracao) AS duracao_media
FROM instrutores i
JOIN cursos c ON i.id = c.instrutor_id
GROUP BY i.nome
HAVING AVG(c.duracao) > 15;
```

---

## 📝 Exercícios Práticos

### Exercício 1: Filtros Básicos com HAVING

**1. Liste os tipos de curso (gratuito ou pago) que têm mais de 3 cursos cadastrados:**
```sql
SELECT 
  gratuito,
  COUNT(*) AS total_cursos
FROM cursos
GROUP BY gratuito
HAVING COUNT(*) > 3;
```

**2. Liste clientes ativos que tenham pelo menos 2 pedidos:**
```sql
SELECT 
  c.nome AS cliente,
  COUNT(*) AS total_pedidos
FROM clientes c
JOIN pedidos pe ON c.id = pe.cliente_id
WHERE c.ativo = TRUE
GROUP BY c.nome
HAVING COUNT(*) >= 2;
```

**3. Crie uma consulta que mostre grupos com duração média maior que 20 horas:**
```sql
SELECT 
  gratuito,
  AVG(duracao) AS duracao_media
FROM cursos
GROUP BY gratuito
HAVING AVG(duracao) > 20;
```

### Exercício 2: Filtros Avançados

**1. Categorias com valor total de estoque alto:**
```sql
SELECT 
  categoria,
  COUNT(*) AS total_produtos,
  SUM(estoque * preco) AS valor_total_estoque
FROM produtos
GROUP BY categoria
HAVING SUM(estoque * preco) > 50000;
```

**2. Instrutores com muitos cursos e duração média alta:**
```sql
SELECT 
  i.nome AS instrutor,
  COUNT(*) AS total_cursos,
  AVG(c.duracao) AS duracao_media
FROM instrutores i
JOIN cursos c ON i.id = c.instrutor_id
GROUP BY i.nome
HAVING COUNT(*) >= 2 AND AVG(c.duracao) > 15;
```

**3. Meses com alta receita:**
```sql
SELECT 
  EXTRACT(MONTH FROM data_pedido) AS mes,
  COUNT(*) AS total_pedidos,
  SUM(valor_total) AS receita_total
FROM pedidos
GROUP BY EXTRACT(MONTH FROM data_pedido)
HAVING SUM(valor_total) > 10000;
```

### Exercício 3: Cenários Complexos

**1. Análise de produtos por categoria com múltiplos critérios:**
```sql
SELECT 
  categoria,
  COUNT(*) AS total_produtos,
  COUNT(CASE WHEN estoque > 0 THEN 1 END) AS produtos_em_estoque,
  AVG(preco) AS preco_medio,
  SUM(estoque * preco) AS valor_total_estoque
FROM produtos
WHERE ativo = TRUE
GROUP BY categoria
HAVING COUNT(*) >= 2 AND AVG(preco) > 100;
```

**2. Clientes VIP com análise completa:**
```sql
SELECT 
  c.nome AS cliente,
  COUNT(*) AS total_pedidos,
  SUM(pe.valor_total) AS valor_total,
  AVG(pe.valor_total) AS ticket_medio
FROM clientes c
JOIN pedidos pe ON c.id = pe.cliente_id
WHERE c.ativo = TRUE
GROUP BY c.nome
HAVING COUNT(*) >= 3 AND SUM(pe.valor_total) > 2000;
```

---

## ⚠️ Armadilhas Comuns

### 1. Usar WHERE com Funções Agregadas
```sql
-- ❌ ERRO: WHERE não aceita funções agregadas
SELECT categoria, COUNT(*) FROM produtos 
WHERE COUNT(*) > 5 
GROUP BY categoria;

-- ✅ CORRETO: Use HAVING para funções agregadas
SELECT categoria, COUNT(*) FROM produtos 
GROUP BY categoria 
HAVING COUNT(*) > 5;
```

### 2. Ordem Incorreta de Cláusulas
```sql
-- ❌ Ordem incorreta
SELECT categoria, COUNT(*) FROM produtos 
HAVING COUNT(*) > 5 
GROUP BY categoria;

-- ✅ Ordem correta: SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY
SELECT categoria, COUNT(*) FROM produtos 
GROUP BY categoria 
HAVING COUNT(*) > 5;
```

### 3. Confundir Filtros de Linha vs Grupo
```sql
-- ❌ Filtra grupos quando deveria filtrar linhas
SELECT categoria, COUNT(*) FROM produtos 
GROUP BY categoria 
HAVING preco > 100;

-- ✅ Filtra linhas antes de agrupar
SELECT categoria, COUNT(*) FROM produtos 
WHERE preco > 100 
GROUP BY categoria;
```

---

## 🚀 Dicas de Performance

### 1. Use WHERE Antes de HAVING
```sql
-- ✅ Mais eficiente: filtra linhas primeiro
SELECT categoria, COUNT(*) FROM produtos 
WHERE ativo = TRUE 
GROUP BY categoria 
HAVING COUNT(*) > 5;

-- ❌ Menos eficiente: agrupa tudo primeiro
SELECT categoria, COUNT(*) FROM produtos 
GROUP BY categoria 
HAVING COUNT(*) > 5 AND ativo = TRUE;
```

### 2. Índices para Condições HAVING
```sql
-- ✅ Índices ajudam em consultas com HAVING
CREATE INDEX idx_produtos_categoria ON produtos(categoria);
CREATE INDEX idx_pedidos_cliente_id ON pedidos(cliente_id);
```

### 3. Evite HAVING Desnecessário
```sql
-- ✅ Use WHERE quando possível
SELECT categoria, COUNT(*) FROM produtos 
WHERE preco > 100 
GROUP BY categoria;

-- ❌ HAVING desnecessário
SELECT categoria, COUNT(*) FROM produtos 
GROUP BY categoria 
HAVING MIN(preco) > 100;
```

---

## 🎯 Boas Práticas

### 1. Sempre Use Aliases Descritivos
```sql
-- ✅ Aliases claros
SELECT categoria, COUNT(*) AS total_produtos
FROM produtos
GROUP BY categoria
HAVING COUNT(*) > 5;

-- ❌ Alias confuso
SELECT categoria, COUNT(*) AS c
FROM produtos
GROUP BY categoria
HAVING COUNT(*) > 5;
```

### 2. Documente Consultas Complexas
```sql
-- ✅ Consulta bem documentada
SELECT 
  categoria,
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio
FROM produtos
WHERE ativo = TRUE  -- Filtra produtos ativos
GROUP BY categoria  -- Agrupa por categoria
HAVING COUNT(*) > 3  -- Apenas categorias com muitos produtos
ORDER BY total_produtos DESC;  -- Ordena por quantidade
```

### 3. Teste Condições Separadamente
```sql
-- ✅ Teste cada condição
-- Primeiro: verifique grupos básicos
SELECT categoria, COUNT(*) FROM produtos GROUP BY categoria;

-- Depois: adicione HAVING
SELECT categoria, COUNT(*) FROM produtos 
GROUP BY categoria 
HAVING COUNT(*) > 5;
```

---

## 🚀 Próximos Passos
- Aula 11: Junção de tabelas (JOIN)
- Aula 12: Subconsultas avançadas
- Aula 13: Window Functions
- Aula 14: Índices e otimização

---

## 📚 Recursos Adicionais
- [PostgreSQL HAVING](https://www.postgresql.org/docs/current/sql-select.html#SQL-HAVING)
- [MySQL HAVING](https://dev.mysql.com/doc/refman/8.0/en/select.html)
- [SQLite HAVING](https://www.sqlite.org/lang_select.html#having)
- [SQL Performance with HAVING](https://www.postgresql.org/docs/current/performance-tips.html)

---

## 💡 Dicas Importantes

### ✅ Dicas para HAVING:
- Use HAVING apenas para filtrar grupos após agregação
- Combine WHERE e HAVING para filtros em diferentes níveis
- Sempre teste condições HAVING separadamente
- Use aliases descritivos para clareza

### ❌ Erros Comuns:
- Usar WHERE com funções agregadas
- Confundir ordem das cláusulas SQL
- Não considerar performance ao usar HAVING
- Esquecer de usar WHERE quando possível

---

*Última atualização: Janeiro 2024*

