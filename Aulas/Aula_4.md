# 🔍 Aula 4 – Consultas Simples com SELECT

## 🎯 Objetivos da Aula
- Compreender o comando SELECT e suas funcionalidades
- Aprender a filtrar dados com WHERE
- Dominar operadores de comparação
- Praticar consultas em cenários reais
- Entender ordenação e limitação de resultados

---

## 🧠 Teoria

### Comando SELECT
O comando `SELECT` é o coração das consultas SQL. É usado para recuperar dados de uma ou mais tabelas, permitindo:
- **Selecionar** colunas específicas ou todas
- **Filtrar** dados com condições
- **Ordenar** resultados
- **Limitar** quantidade de registros
- **Agrupar** e **agregar** dados

### Sintaxe Básica:
```sql
SELECT coluna1, coluna2, ... FROM nome_da_tabela [WHERE condição];
```

---

## 📋 Tipos de Consulta

### 1. Consulta de Todas as Colunas
```sql
SELECT * FROM nome_da_tabela;
```

### 2. Consulta de Colunas Específicas
```sql
SELECT coluna1, coluna2, coluna3 FROM nome_da_tabela;
```

### 3. Consulta com Filtro (WHERE)
```sql
SELECT coluna1, coluna2 FROM nome_da_tabela WHERE condição;
```

### 4. Consulta com Ordenação
```sql
SELECT coluna1, coluna2 FROM nome_da_tabela ORDER BY coluna1;
```

---

## 🧪 Exemplos Práticos

### Exemplo 1: Ver Todos os Clientes
```sql
SELECT * FROM clientes;
```

### Exemplo 2: Ver Apenas Nomes e E-mails
```sql
SELECT nome, email FROM clientes;
```

### Exemplo 3: Ver Cursos Gratuitos
```sql
SELECT * FROM cursos WHERE gratuito = TRUE;
```

### Exemplo 4: Ver Cursos com Mais de 10 Horas
```sql
SELECT * FROM cursos WHERE duracao > 10;
```

### Exemplo 5: Ver Produtos com Preço Alto
```sql
SELECT nome, preco FROM produtos WHERE preco > 1000;
```

### Exemplo 6: Ver Usuários Ativos
```sql
SELECT nome, email FROM usuarios WHERE ativo = TRUE;
```

---

## ⚙️ Operadores de Comparação

### Operadores Básicos

| Operador | Significado | Exemplo |
|----------|-------------|---------|
| `=` | Igual | `WHERE idade = 25` |
| `!=` ou `<>` | Diferente | `WHERE status != 'Inativo'` |
| `>` | Maior | `WHERE preco > 100` |
| `<` | Menor | `WHERE idade < 18` |
| `>=` | Maior ou igual | `WHERE estoque >= 10` |
| `<=` | Menor ou igual | `WHERE preco <= 50` |

### Operadores de Texto

| Operador | Significado | Exemplo |
|----------|-------------|---------|
| `LIKE` | Padrão de texto | `WHERE nome LIKE 'João%'` |
| `ILIKE` | Padrão case-insensitive | `WHERE email ILIKE '%@gmail.com'` |
| `IN` | Lista de valores | `WHERE categoria IN ('Eletrônicos', 'Livros')` |
| `BETWEEN` | Intervalo | `WHERE preco BETWEEN 10 AND 100` |

### Operadores Lógicos

| Operador | Significado | Exemplo |
|----------|-------------|---------|
| `AND` | E lógico | `WHERE ativo = TRUE AND idade > 18` |
| `OR` | OU lógico | `WHERE categoria = 'Eletrônicos' OR preco > 500` |
| `NOT` | Negação | `WHERE NOT ativo = FALSE` |

---

## 🔍 Filtros Avançados

### Filtros com LIKE
```sql
-- Nomes que começam com 'João'
SELECT * FROM clientes WHERE nome LIKE 'João%';

-- Emails que terminam com '@gmail.com'
SELECT * FROM usuarios WHERE email LIKE '%@gmail.com';

-- Nomes que contêm 'Silva'
SELECT * FROM clientes WHERE nome LIKE '%Silva%';
```

### Filtros com IN
```sql
-- Produtos de categorias específicas
SELECT * FROM produtos WHERE categoria IN ('Eletrônicos', 'Livros', 'Roupas');

-- Cursos com durações específicas
SELECT * FROM cursos WHERE duracao IN (10, 20, 30);
```

### Filtros com BETWEEN
```sql
-- Produtos com preço entre 50 e 200
SELECT * FROM produtos WHERE preco BETWEEN 50 AND 200;

-- Clientes nascidos entre 1980 e 1990
SELECT * FROM clientes WHERE nascimento BETWEEN '1980-01-01' AND '1990-12-31';
```

### Filtros com NULL
```sql
-- Produtos sem categoria
SELECT * FROM produtos WHERE categoria IS NULL;

-- Produtos com categoria definida
SELECT * FROM produtos WHERE categoria IS NOT NULL;
```

---

## 📊 Ordenação de Resultados

### Ordenação Simples
```sql
-- Ordenar por nome (crescente)
SELECT * FROM clientes ORDER BY nome;

-- Ordenar por preço (decrescente)
SELECT * FROM produtos ORDER BY preco DESC;
```

### Ordenação Múltipla
```sql
-- Ordenar por categoria e depois por preço
SELECT * FROM produtos ORDER BY categoria, preco DESC;

-- Ordenar por ativo (TRUE primeiro) e depois por nome
SELECT * FROM usuarios ORDER BY ativo DESC, nome;
```

---

## 📏 Limitação de Resultados

### LIMIT (PostgreSQL, MySQL)
```sql
-- Primeiros 5 clientes
SELECT * FROM clientes LIMIT 5;

-- Próximos 5 clientes (página 2)
SELECT * FROM clientes LIMIT 5 OFFSET 5;
```

### TOP (SQL Server)
```sql
-- Primeiros 5 clientes
SELECT TOP 5 * FROM clientes;
```

---

## 🎯 Consultas com Alias

### Alias para Colunas
```sql
-- Renomear colunas na consulta
SELECT 
  nome AS nome_completo,
  email AS endereco_email,
  idade AS anos
FROM clientes;
```

### Alias para Tabelas
```sql
-- Usar alias para tabela
SELECT c.nome, c.email 
FROM clientes c 
WHERE c.ativo = TRUE;
```

---

## 📝 Exercícios Práticos

### Exercício 1: Consultas Básicas

**1. Liste todos os clientes cadastrados:**
```sql
SELECT * FROM clientes;
```

**2. Mostre somente os nomes dos cursos com duração maior que 15:**
```sql
SELECT titulo FROM cursos WHERE duracao > 15;
```

**3. Liste os clientes que estão ativos:**
```sql
SELECT * FROM clientes WHERE ativo = TRUE;
```

**4. Liste os cursos com início após 2025-07-30:**
```sql
SELECT * FROM cursos WHERE inicio > '2025-07-30';
```

### Exercício 2: Filtros Avançados

**1. Produtos com preço entre R$ 100 e R$ 500:**
```sql
SELECT nome, preco FROM produtos WHERE preco BETWEEN 100 AND 500;
```

**2. Clientes com nome que contém 'Silva':**
```sql
SELECT * FROM clientes WHERE nome LIKE '%Silva%';
```

**3. Cursos gratuitos com duração maior que 10 horas:**
```sql
SELECT * FROM cursos WHERE gratuito = TRUE AND duracao > 10;
```

**4. Produtos de categorias específicas ordenados por preço:**
```sql
SELECT nome, preco, categoria 
FROM produtos 
WHERE categoria IN ('Eletrônicos', 'Periféricos')
ORDER BY preco DESC;
```

### Exercício 3: Cenário Real - E-commerce

**1. Produtos em estoque com preço alto:**
```sql
SELECT nome, preco, estoque 
FROM produtos 
WHERE estoque > 0 AND preco > 1000
ORDER BY preco DESC;
```

**2. Clientes ativos com email do Gmail:**
```sql
SELECT nome, email 
FROM clientes 
WHERE ativo = TRUE AND email LIKE '%@gmail.com';
```

**3. Cursos que começam em 2024:**
```sql
SELECT titulo, duracao, inicio 
FROM cursos 
WHERE inicio BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY inicio;
```

**4. Produtos sem estoque:**
```sql
SELECT nome, categoria 
FROM produtos 
WHERE estoque = 0 OR estoque IS NULL;
```

---

## 🚀 Consultas Avançadas

### Consulta com Subconsulta
```sql
-- Produtos mais caros que a média
SELECT nome, preco 
FROM produtos 
WHERE preco > (SELECT AVG(preco) FROM produtos);
```

### Consulta com CASE
```sql
-- Classificar produtos por faixa de preço
SELECT nome, preco,
  CASE 
    WHEN preco < 100 THEN 'Econômico'
    WHEN preco < 500 THEN 'Médio'
    ELSE 'Premium'
  END AS categoria_preco
FROM produtos;
```

### Consulta com DISTINCT
```sql
-- Categorias únicas de produtos
SELECT DISTINCT categoria FROM produtos WHERE categoria IS NOT NULL;
```

---

## 📊 Funções Úteis

### Funções de Texto
```sql
-- Converter para maiúsculas
SELECT UPPER(nome) FROM clientes;

-- Contar caracteres
SELECT nome, LENGTH(nome) AS tamanho FROM clientes;

-- Extrair parte do texto
SELECT email, SUBSTRING(email, 1, 5) AS inicio FROM usuarios;
```

### Funções de Data
```sql
-- Data atual
SELECT CURRENT_DATE;

-- Ano de nascimento
SELECT nome, EXTRACT(YEAR FROM nascimento) AS ano_nascimento FROM clientes;

-- Idade calculada
SELECT nome, 
  EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM nascimento) AS idade
FROM clientes;
```

---

## 🎯 Boas Práticas

### Performance
- ✅ Use `SELECT colunas` em vez de `SELECT *`
- ✅ Adicione índices em colunas filtradas frequentemente
- ✅ Use `LIMIT` para consultas grandes
- ✅ Evite `LIKE '%texto%'` em grandes tabelas

### Legibilidade
- ✅ Use alias descritivos
- ✅ Formate consultas complexas
- ✅ Comente consultas complexas
- ✅ Use nomes de colunas claros

### Segurança
- ✅ Valide entradas de usuário
- ✅ Use prepared statements
- ✅ Evite SQL injection
- ✅ Limite permissões de consulta

---

## 🚀 Próximos Passos
- Aula 5: Funções agregadas (COUNT, SUM, AVG, MAX, MIN)
- Aula 6: Agrupamento de dados (GROUP BY, HAVING)
- Aula 7: Junção de tabelas (JOIN)
- Aula 8: Subconsultas avançadas

---

## 📚 Recursos Adicionais
- [PostgreSQL SELECT](https://www.postgresql.org/docs/current/sql-select.html)
- [MySQL SELECT](https://dev.mysql.com/doc/refman/8.0/en/select.html)
- [SQLite SELECT](https://www.sqlite.org/lang_select.html)
- [SQL WHERE Clause](https://www.w3schools.com/sql/sql_where.asp)

---

## 💡 Dicas Importantes

### ✅ Dicas para Consultas:
- Sempre teste consultas em ambiente de desenvolvimento
- Use `EXPLAIN` para analisar performance
- Mantenha consultas simples e legíveis
- Use índices apropriados para melhorar performance

### ❌ Erros Comuns:
- Usar `=` com NULL (use `IS NULL`)
- Esquecer aspas em strings
- Não considerar case-sensitivity
- Usar `SELECT *` desnecessariamente

---

*Última atualização: Janeiro 2024*