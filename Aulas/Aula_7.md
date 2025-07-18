# 🧾 Aula 7 – Aliases (AS): Renomeando Colunas e Tabelas

## 🎯 Objetivos da Aula
- Compreender o uso de aliases com AS
- Aprender a renomear colunas para melhor legibilidade
- Dominar aliases de tabelas para joins
- Praticar aliases em cenários reais
- Entender boas práticas de nomenclatura

---

## 🧠 Teoria

### Aliases (Apelidos)
O comando `AS` permite renomear colunas ou dar apelidos para tabelas, tornando os resultados mais legíveis e facilitando o uso em consultas complexas.

### Vantagens dos Aliases:
- ✅ **Legibilidade** - Nomes mais claros e descritivos
- ✅ **Conveniência** - Evita conflitos de nomes
- ✅ **Manutenibilidade** - Código mais organizado
- ✅ **Performance** - Facilita joins e consultas complexas

---

## 🔤 Renomeando Colunas

### Conceito
O alias de coluna permite dar nomes mais descritivos e claros para as colunas retornadas.

### Sintaxe:
```sql
SELECT coluna AS novo_nome FROM tabela;
```

### Exemplo Básico:
```sql
SELECT nome AS nome_do_curso, duracao AS horas
FROM cursos;
```
**Resultado:** A coluna `nome` aparece como `nome_do_curso` e `duracao` como `horas`.

### Exemplos Práticos:

#### 1. Aliases Descritivos
```sql
SELECT 
  nome AS nome_completo,
  email AS endereco_email,
  data_cadastro AS data_registro
FROM clientes;
```

#### 2. Aliases para Cálculos
```sql
SELECT 
  nome,
  preco AS preco_atual,
  preco * 1.1 AS preco_com_aumento,
  preco * 0.9 AS preco_com_desconto
FROM produtos;
```

#### 3. Aliases para Funções
```sql
SELECT 
  nome,
  LENGTH(nome) AS tamanho_nome,
  UPPER(nome) AS nome_maiusculo,
  EXTRACT(YEAR FROM data_cadastro) AS ano_cadastro
FROM clientes;
```

---

## 🧩 Renomeando Tabelas

### Conceito
O alias de tabela permite dar apelidos curtos para tabelas, economizando escrita e melhorando clareza em joins.

### Sintaxe:
```sql
SELECT colunas FROM tabela AS alias;
```

### Exemplo Básico:
```sql
SELECT c.nome AS curso, c.duracao
FROM cursos AS c;
```
**Resultado:** A tabela `cursos` é apelidada de `c`, economizando escrita.

### Exemplos Práticos:

#### 1. Alias Simples
```sql
SELECT c.nome, c.duracao, c.gratuito
FROM cursos AS c;
```

#### 2. Múltiplas Tabelas
```sql
SELECT 
  c.nome AS curso,
  i.nome AS instrutor,
  c.duracao AS horas
FROM cursos AS c
JOIN instrutores AS i ON c.instrutor_id = i.id;
```

#### 3. Alias Descritivo
```sql
SELECT 
  produtos.nome AS nome_produto,
  categorias.nome AS nome_categoria
FROM produtos AS produtos
JOIN categorias AS categorias ON produtos.categoria_id = categorias.id;
```

---

## 🧠 AS Opcional

### Conceito
O `AS` é opcional em SQL. Você pode usar diretamente o novo nome, mas usar `AS` torna o código mais claro.

### Exemplos:

#### Com AS (Recomendado)
```sql
SELECT nome AS nome_completo FROM clientes;
```

#### Sem AS (Funciona, mas menos claro)
```sql
SELECT nome nome_completo FROM clientes;
```

### Boas Práticas:
- ✅ **Use AS** para maior clareza
- ✅ **Mantenha consistência** no projeto
- ✅ **Use nomes descritivos** para aliases
- ✅ **Evite abreviações** confusas

---

## 🎯 Casos de Uso Avançados

### 1. Aliases em Subconsultas
```sql
SELECT 
  p.nome AS produto,
  p.preco AS preco_atual,
  (SELECT AVG(preco) FROM produtos) AS preco_medio
FROM produtos AS p
WHERE p.preco > (SELECT AVG(preco) FROM produtos);
```

### 2. Aliases em Funções Agregadas
```sql
SELECT 
  categoria AS categoria_produto,
  COUNT(*) AS total_produtos,
  AVG(preco) AS preco_medio,
  MAX(preco) AS preco_maximo
FROM produtos
GROUP BY categoria;
```

### 3. Aliases em Joins Complexos
```sql
SELECT 
  c.nome AS cliente,
  p.nome AS produto,
  pe.data_pedido AS data_compra,
  pe.valor_total AS valor_pago
FROM clientes AS c
JOIN pedidos AS pe ON c.id = pe.cliente_id
JOIN produtos AS p ON pe.produto_id = p.id;
```

---

## 📊 Aliases com Expressões

### 1. Cálculos Matemáticos
```sql
SELECT 
  nome AS produto,
  preco AS preco_original,
  preco * 0.9 AS preco_com_desconto,
  preco * 1.2 AS preco_com_lucro
FROM produtos;
```

### 2. Concatenação de Strings
```sql
SELECT 
  nome AS nome_cliente,
  CONCAT(nome, ' - ', email) AS cliente_completo,
  UPPER(nome) AS nome_maiusculo
FROM clientes;
```

### 3. Condicionais com CASE
```sql
SELECT 
  nome AS produto,
  preco AS preco_atual,
  CASE 
    WHEN preco < 100 THEN 'Econômico'
    WHEN preco < 500 THEN 'Médio'
    ELSE 'Premium'
  END AS categoria_preco
FROM produtos;
```

---

## 🚀 Aliases em Consultas Complexas

### 1. Múltiplas Tabelas com Joins
```sql
SELECT 
  c.nome AS cliente,
  p.nome AS produto,
  cat.nome AS categoria,
  pe.data_pedido AS data_compra
FROM clientes AS c
JOIN pedidos AS pe ON c.id = pe.cliente_id
JOIN produtos AS p ON pe.produto_id = p.id
JOIN categorias AS cat ON p.categoria_id = cat.id;
```

### 2. Subconsultas com Aliases
```sql
SELECT 
  p.nome AS produto,
  p.preco AS preco_atual,
  (SELECT AVG(preco) FROM produtos WHERE categoria = p.categoria) AS preco_medio_categoria
FROM produtos AS p;
```

### 3. Aliases em UNION
```sql
SELECT nome AS item, preco AS valor FROM produtos
UNION
SELECT nome AS item, salario AS valor FROM funcionarios;
```

---

## 📝 Exercícios Práticos

### Exercício 1: Aliases de Colunas

**1. Mostre a tabela de clientes com as colunas nome_completo, email_pessoal e data_nascimento:**
```sql
SELECT 
  nome AS nome_completo,
  email AS email_pessoal,
  nascimento AS data_nascimento
FROM clientes;
```

**2. Mostre os cursos com titulo, horas_totais e se são gratuitos_ou_nao:**
```sql
SELECT 
  titulo AS titulo,
  duracao AS horas_totais,
  gratuito AS gratuitos_ou_nao
FROM cursos;
```

**3. Apelide a tabela cursos como c e selecione somente c.nome e c.duracao:**
```sql
SELECT c.nome, c.duracao
FROM cursos AS c;
```

### Exercício 2: Aliases Avançados

**1. Produtos com preço em reais e dólares:**
```sql
SELECT 
  nome AS produto,
  preco AS preco_reais,
  preco / 5.5 AS preco_dolares
FROM produtos;
```

**2. Clientes com idade calculada:**
```sql
SELECT 
  nome AS nome_cliente,
  nascimento AS data_nascimento,
  EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM nascimento) AS idade
FROM clientes;
```

**3. Cursos com duração em horas e minutos:**
```sql
SELECT 
  titulo AS nome_curso,
  duracao AS horas_totais,
  duracao * 60 AS minutos_totais
FROM cursos;
```

### Exercício 3: Aliases em Joins

**1. Clientes e seus pedidos com aliases descritivos:**
```sql
SELECT 
  c.nome AS nome_cliente,
  p.nome AS nome_produto,
  pe.data_pedido AS data_compra,
  pe.valor_total AS valor_pago
FROM clientes AS c
JOIN pedidos AS pe ON c.id = pe.cliente_id
JOIN produtos AS p ON pe.produto_id = p.id;
```

**2. Cursos e instrutores com aliases:**
```sql
SELECT 
  c.titulo AS nome_curso,
  i.nome AS nome_instrutor,
  c.duracao AS horas_curso
FROM cursos AS c
JOIN instrutores AS i ON c.instrutor_id = i.id;
```

---

## 🎯 Boas Práticas

### 1. Nomenclatura de Aliases
```sql
-- ✅ Descritivo e claro
SELECT nome AS nome_completo_cliente FROM clientes;

-- ❌ Confuso e abreviado
SELECT nome AS n FROM clientes;
```

### 2. Consistência
```sql
-- ✅ Padrão consistente
SELECT 
  nome AS nome_cliente,
  email AS email_cliente,
  telefone AS telefone_cliente
FROM clientes;

-- ❌ Inconsistente
SELECT 
  nome AS nome_cliente,
  email AS email,
  telefone AS tel
FROM clientes;
```

### 3. Clareza em Joins
```sql
-- ✅ Aliases claros para múltiplas tabelas
SELECT 
  c.nome AS cliente,
  p.nome AS produto
FROM clientes AS c
JOIN pedidos AS pe ON c.id = pe.cliente_id
JOIN produtos AS p ON pe.produto_id = p.id;

-- ❌ Sem aliases (confuso)
SELECT 
  clientes.nome,
  produtos.nome
FROM clientes
JOIN pedidos ON clientes.id = pedidos.cliente_id
JOIN produtos ON pedidos.produto_id = produtos.id;
```

---

## ⚠️ Armadilhas Comuns

### 1. Conflito de Nomes
```sql
-- ❌ Erro: coluna ambígua
SELECT nome FROM clientes AS c JOIN produtos AS p;

-- ✅ Correto: especificar tabela
SELECT c.nome AS nome_cliente, p.nome AS nome_produto 
FROM clientes AS c JOIN produtos AS p;
```

### 2. Alias Desnecessário
```sql
-- ❌ Alias desnecessário
SELECT nome AS nome FROM clientes;

-- ✅ Sem alias quando não necessário
SELECT nome FROM clientes;
```

### 3. Nomes Confusos
```sql
-- ❌ Nomes confusos
SELECT nome AS n, email AS e FROM clientes;

-- ✅ Nomes descritivos
SELECT nome AS nome_cliente, email AS email_cliente FROM clientes;
```

---

## 🚀 Dicas de Performance

### 1. Aliases em Consultas Complexas
- ✅ Use aliases para reduzir digitação
- ✅ Mantenha aliases consistentes
- ✅ Use nomes descritivos para clareza

### 2. Aliases em Joins
- ✅ Sempre use aliases em múltiplas tabelas
- ✅ Evite conflitos de nomes
- ✅ Mantenha padrão de nomenclatura

### 3. Aliases em Subconsultas
- ✅ Use aliases para clareza
- ✅ Evite aliases muito longos
- ✅ Mantenha consistência

---

## 🚀 Próximos Passos
- Aula 8: Funções agregadas (COUNT, SUM, AVG, MAX, MIN)
- Aula 9: Agrupamento de dados (GROUP BY, HAVING)
- Aula 10: Junção de tabelas (JOIN)
- Aula 11: Subconsultas avançadas

---

## 📚 Recursos Adicionais
- [PostgreSQL Column Aliases](https://www.postgresql.org/docs/current/sql-select.html#SQL-SELECT-LIST)
- [MySQL Aliases](https://dev.mysql.com/doc/refman/8.0/en/problems-with-alias.html)
- [SQLite Aliases](https://www.sqlite.org/lang_select.html#resultset)
- [SQL Best Practices](https://www.postgresql.org/docs/current/style-guide.html)

---

## 💡 Dicas Importantes

### ✅ Dicas para Aliases:
- Use AS para maior clareza
- Mantenha nomes descritivos e consistentes
- Use aliases em joins complexos
- Evite abreviações confusas

### ❌ Erros Comuns:
- Esquecer AS em aliases de colunas
- Usar nomes confusos para aliases
- Não usar aliases em joins complexos
- Criar aliases desnecessários

---

*Última atualização: Janeiro 2024*