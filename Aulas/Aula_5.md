# 🧠 Aula 5 – Operadores Lógicos: AND, OR e NOT

## 🎯 Objetivos da Aula
- Compreender operadores lógicos em SQL
- Dominar combinações de condições com AND, OR, NOT
- Aprender precedência de operadores
- Praticar filtros complexos em cenários reais
- Entender otimização de consultas lógicas

---

## 🧠 Teoria

### Operadores Lógicos
Os operadores lógicos são fundamentais para criar consultas mais sofisticadas. Eles permitem combinar múltiplas condições para filtrar dados de forma precisa.

### Tabela Verdade dos Operadores:

| A | B | A AND B | A OR B | NOT A |
|---|---|---------|--------|-------|
| TRUE | TRUE | TRUE | TRUE | FALSE |
| TRUE | FALSE | FALSE | TRUE | FALSE |
| FALSE | TRUE | FALSE | TRUE | TRUE |
| FALSE | FALSE | FALSE | FALSE | TRUE |

---

## 🔗 Operador AND

### Conceito
O operador `AND` retorna `TRUE` apenas quando **todas** as condições são verdadeiras.

### Sintaxe:
```sql
SELECT colunas FROM tabela WHERE condicao1 AND condicao2 AND condicao3;
```

### Exemplo Básico:
```sql
SELECT * FROM cursos
WHERE gratuito = TRUE AND duracao > 10;
```
**Resultado:** Só retorna cursos gratuitos com mais de 10 horas.

### Exemplos Práticos:

#### 1. Produtos com Preço e Estoque
```sql
SELECT nome, preco, estoque FROM produtos
WHERE preco > 100 AND estoque > 0;
```

#### 2. Clientes Ativos e Maiores de Idade
```sql
SELECT nome, email, idade FROM clientes
WHERE ativo = TRUE AND idade >= 18;
```

#### 3. Cursos Gratuitos com Duração Específica
```sql
SELECT titulo, duracao FROM cursos
WHERE gratuito = TRUE AND duracao BETWEEN 10 AND 30;
```

---

## 🔀 Operador OR

### Conceito
O operador `OR` retorna `TRUE` quando **pelo menos uma** das condições é verdadeira.

### Sintaxe:
```sql
SELECT colunas FROM tabela WHERE condicao1 OR condicao2 OR condicao3;
```

### Exemplo Básico:
```sql
SELECT * FROM cursos
WHERE gratuito = TRUE OR duracao > 10;
```
**Resultado:** Retorna cursos gratuitos OU com mais de 10 horas, OU ambos.

### Exemplos Práticos:

#### 1. Produtos de Categorias Específicas
```sql
SELECT nome, categoria, preco FROM produtos
WHERE categoria = 'Eletrônicos' OR categoria = 'Livros';
```

#### 2. Clientes com Email ou Telefone
```sql
SELECT nome, email, telefone FROM clientes
WHERE email IS NOT NULL OR telefone IS NOT NULL;
```

#### 3. Cursos Gratuitos ou Longos
```sql
SELECT titulo, gratuito, duracao FROM cursos
WHERE gratuito = TRUE OR duracao > 20;
```

---

## 🚫 Operador NOT

### Conceito
O operador `NOT` inverte o resultado da condição. `NOT TRUE` = `FALSE` e `NOT FALSE` = `TRUE`.

### Sintaxe:
```sql
SELECT colunas FROM tabela WHERE NOT condicao;
```

### Exemplo Básico:
```sql
SELECT * FROM clientes
WHERE NOT ativo;
```
**Resultado:** Retorna os clientes que não estão ativos.

### Exemplos Práticos:

#### 1. Produtos Não Gratuitos
```sql
SELECT nome, preco FROM produtos
WHERE NOT (preco = 0);
```

#### 2. Clientes Não Ativos
```sql
SELECT nome, email FROM clientes
WHERE NOT ativo;
```

#### 3. Cursos Não Gratuitos
```sql
SELECT titulo, duracao FROM cursos
WHERE NOT gratuito;
```

---

## 🧪 Combinações Complexas

### Exemplo 1: Múltiplas Condições
```sql
SELECT * FROM clientes
WHERE ativo = TRUE AND nascimento < '2000-01-01';
```
**Resultado:** Clientes ativos nascidos antes do ano 2000.

### Exemplo 2: OR com AND
```sql
SELECT nome, categoria, preco FROM produtos
WHERE (categoria = 'Eletrônicos' OR categoria = 'Livros') 
  AND preco > 50;
```
**Resultado:** Produtos eletrônicos OU livros com preço acima de R$ 50.

### Exemplo 3: NOT com AND
```sql
SELECT titulo, duracao FROM cursos
WHERE NOT gratuito AND duracao < 10;
```
**Resultado:** Cursos pagos com menos de 10 horas.

---

## 📊 Precedência de Operadores

### Ordem de Avaliação:
1. **Parênteses** `()`
2. **NOT**
3. **AND**
4. **OR**

### Exemplo de Precedência:
```sql
-- Sem parênteses (avaliação padrão)
SELECT * FROM produtos 
WHERE categoria = 'Eletrônicos' OR categoria = 'Livros' AND preco > 100;
-- Equivale a: categoria = 'Eletrônicos' OR (categoria = 'Livros' AND preco > 100)

-- Com parênteses (força precedência)
SELECT * FROM produtos 
WHERE (categoria = 'Eletrônicos' OR categoria = 'Livros') AND preco > 100;
```

### Exemplos de Precedência:

#### 1. Sem Parênteses (Resultado Inesperado)
```sql
SELECT nome, categoria, preco FROM produtos
WHERE categoria = 'Eletrônicos' OR categoria = 'Livros' AND preco > 100;
```

#### 2. Com Parênteses (Resultado Correto)
```sql
SELECT nome, categoria, preco FROM produtos
WHERE (categoria = 'Eletrônicos' OR categoria = 'Livros') AND preco > 100;
```

---

## 🎯 Casos de Uso Avançados

### 1. Filtros Complexos de E-commerce
```sql
SELECT nome, preco, estoque FROM produtos
WHERE (categoria = 'Eletrônicos' OR categoria = 'Periféricos')
  AND preco BETWEEN 100 AND 1000
  AND estoque > 0
  AND NOT (nome LIKE '%usado%' OR nome LIKE '%refurbished%');
```

### 2. Clientes com Critérios Múltiplos
```sql
SELECT nome, email, idade FROM clientes
WHERE (ativo = TRUE AND idade >= 18)
  OR (email LIKE '%@gmail.com' AND idade >= 16)
  OR (idade >= 21 AND NOT ativo);
```

### 3. Cursos com Filtros Específicos
```sql
SELECT titulo, duracao, gratuito FROM cursos
WHERE (gratuito = TRUE AND duracao >= 10)
  OR (NOT gratuito AND duracao <= 5)
  OR (duracao BETWEEN 15 AND 25 AND titulo LIKE '%SQL%');
```

---

## 📝 Exercícios Práticos

### Exercício 1: Operadores Básicos

**1. Liste os cursos que são gratuitos e têm mais de 15 horas:**
```sql
SELECT titulo, duracao FROM cursos
WHERE gratuito = TRUE AND duracao > 15;
```

**2. Liste os clientes que não estão ativos ou nasceram depois de 2005:**
```sql
SELECT nome, ativo, nascimento FROM clientes
WHERE NOT ativo OR nascimento > '2005-12-31';
```

**3. Liste os cursos que não são gratuitos e duram menos que 10 horas:**
```sql
SELECT titulo, gratuito, duracao FROM cursos
WHERE NOT gratuito AND duracao < 10;
```

### Exercício 2: Combinações Intermediárias

**1. Produtos eletrônicos OU livros com preço acima de R$ 100:**
```sql
SELECT nome, categoria, preco FROM produtos
WHERE (categoria = 'Eletrônicos' OR categoria = 'Livros') 
  AND preco > 100;
```

**2. Clientes ativos OU com email do Gmail:**
```sql
SELECT nome, email, ativo FROM clientes
WHERE ativo = TRUE OR email LIKE '%@gmail.com';
```

**3. Cursos gratuitos OU com duração maior que 20 horas:**
```sql
SELECT titulo, gratuito, duracao FROM cursos
WHERE gratuito = TRUE OR duracao > 20;
```

### Exercício 3: Cenários Complexos

**1. Produtos em estoque com preço alto OU produtos gratuitos:**
```sql
SELECT nome, preco, estoque FROM produtos
WHERE (estoque > 0 AND preco > 500) OR preco = 0;
```

**2. Clientes ativos nascidos entre 1980-1990 OU com email corporativo:**
```sql
SELECT nome, nascimento, email FROM clientes
WHERE (ativo = TRUE AND nascimento BETWEEN '1980-01-01' AND '1990-12-31')
  OR email LIKE '%@empresa.com';
```

**3. Cursos gratuitos com duração específica OU cursos pagos com desconto:**
```sql
SELECT titulo, gratuito, duracao, preco FROM cursos
WHERE (gratuito = TRUE AND duracao IN (10, 15, 20))
  OR (NOT gratuito AND preco < 100);
```

---

## 🚀 Otimização de Consultas

### Boas Práticas:

#### 1. Use Parênteses para Clareza
```sql
-- ✅ Claro e legível
SELECT * FROM produtos
WHERE (categoria = 'Eletrônicos' OR categoria = 'Livros') 
  AND preco > 100;

-- ❌ Pode causar confusão
SELECT * FROM produtos
WHERE categoria = 'Eletrônicos' OR categoria = 'Livros' AND preco > 100;
```

#### 2. Simplifique Condições
```sql
-- ✅ Mais eficiente
SELECT * FROM produtos
WHERE categoria IN ('Eletrônicos', 'Livros') AND preco > 100;

-- ❌ Menos eficiente
SELECT * FROM produtos
WHERE (categoria = 'Eletrônicos' OR categoria = 'Livros') AND preco > 100;
```

#### 3. Evite NOT Quando Possível
```sql
-- ✅ Mais claro
SELECT * FROM clientes WHERE ativo = FALSE;

-- ❌ Menos claro
SELECT * FROM clientes WHERE NOT ativo;
```

---

## ⚠️ Armadilhas Comuns

### 1. Confusão com Precedência
```sql
-- ❌ Resultado inesperado
SELECT * FROM produtos
WHERE categoria = 'Eletrônicos' OR categoria = 'Livros' AND preco > 100;

-- ✅ Resultado correto
SELECT * FROM produtos
WHERE (categoria = 'Eletrônicos' OR categoria = 'Livros') AND preco > 100;
```

### 2. Uso Incorreto de NOT
```sql
-- ❌ Não funciona como esperado
SELECT * FROM clientes WHERE NOT (ativo = TRUE AND idade > 18);

-- ✅ Funciona corretamente
SELECT * FROM clientes WHERE NOT ativo OR idade <= 18;
```

### 3. Condições Redundantes
```sql
-- ❌ Redundante
SELECT * FROM produtos WHERE preco > 0 AND NOT (preco <= 0);

-- ✅ Simplificado
SELECT * FROM produtos WHERE preco > 0;
```

---

## 🎯 Dicas de Performance

### 1. Ordem das Condições
```sql
-- ✅ Condição mais restritiva primeiro
SELECT * FROM produtos
WHERE preco > 1000 AND categoria = 'Eletrônicos';

-- ❌ Condição menos restritiva primeiro
SELECT * FROM produtos
WHERE categoria = 'Eletrônicos' AND preco > 1000;
```

### 2. Uso de Índices
- ✅ Use índices em colunas frequentemente filtradas
- ✅ Evite `NOT` em colunas indexadas
- ✅ Considere índices compostos para condições AND

### 3. Simplificação
- ✅ Use `IN` em vez de múltiplos `OR`
- ✅ Use `BETWEEN` em vez de `>=` AND `<=`
- ✅ Evite condições desnecessárias

---

## 🚀 Próximos Passos
- Aula 6: Funções agregadas (COUNT, SUM, AVG, MAX, MIN)
- Aula 7: Agrupamento de dados (GROUP BY, HAVING)
- Aula 8: Junção de tabelas (JOIN)
- Aula 9: Subconsultas avançadas

---

## 📚 Recursos Adicionais
- [PostgreSQL Logical Operators](https://www.postgresql.org/docs/current/functions-logical.html)
- [MySQL Logical Operators](https://dev.mysql.com/doc/refman/8.0/en/logical-operators.html)
- [SQL Operator Precedence](https://www.w3schools.com/sql/sql_operators.asp)
- [SQL Performance Best Practices](https://www.postgresql.org/docs/current/performance-tips.html)

---

## 💡 Dicas Importantes

### ✅ Dicas para Operadores Lógicos:
- Sempre use parênteses para clareza
- Teste consultas complexas passo a passo
- Considere a precedência de operadores
- Simplifique condições quando possível

### ❌ Erros Comuns:
- Esquecer parênteses em condições complexas
- Confundir precedência de operadores
- Usar NOT desnecessariamente
- Não testar consultas complexas

---

*Última atualização: Janeiro 2024*

