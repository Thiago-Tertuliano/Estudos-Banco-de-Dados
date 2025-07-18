# 📊 Aula 6 – Ordenação e Limitação: ORDER BY e LIMIT

## 🎯 Objetivos da Aula
- Compreender como ordenar resultados com ORDER BY
- Dominar ordenação crescente e decrescente
- Aprender a limitar resultados com LIMIT
- Praticar ordenação múltipla e paginação
- Entender otimização de consultas ordenadas

---

## 🧠 Teoria

### Ordenação de Resultados
A ordenação é fundamental para apresentar dados de forma organizada e útil. O `ORDER BY` permite organizar os resultados de acordo com critérios específicos.

### Limitação de Resultados
O `LIMIT` é essencial para controlar a quantidade de dados retornados, melhorando performance e usabilidade.

---

## 📊 Comando ORDER BY

### Conceito
O `ORDER BY` ordena os resultados de uma consulta baseado em uma ou mais colunas.

### Sintaxe Básica:
```sql
SELECT colunas FROM tabela ORDER BY coluna [ASC|DESC];
```

### Exemplo Básico:
```sql
SELECT * FROM cursos ORDER BY duracao;
```
**Resultado:** Ordena os cursos pela duração (do menor para o maior).

---

## ⬆️⬇️ Tipos de Ordenação

### Ordenação Crescente (ASC - Padrão)
```sql
-- Ordem crescente (padrão)
SELECT * FROM cursos ORDER BY nome ASC;

-- Equivalente (ASC é opcional)
SELECT * FROM cursos ORDER BY nome;
```

### Ordem Decrescente (DESC)
```sql
-- Ordem decrescente
SELECT * FROM cursos ORDER BY duracao DESC;
```

### Exemplos Práticos:

#### 1. Ordenação por Preço
```sql
-- Produtos do mais barato ao mais caro
SELECT nome, preco FROM produtos ORDER BY preco ASC;

-- Produtos do mais caro ao mais barato
SELECT nome, preco FROM produtos ORDER BY preco DESC;
```

#### 2. Ordenação por Data
```sql
-- Clientes mais antigos primeiro
SELECT nome, data_cadastro FROM clientes ORDER BY data_cadastro ASC;

-- Clientes mais recentes primeiro
SELECT nome, data_cadastro FROM clientes ORDER BY data_cadastro DESC;
```

#### 3. Ordenação por Texto
```sql
-- Nomes em ordem alfabética
SELECT nome FROM clientes ORDER BY nome ASC;

-- Nomes em ordem alfabética reversa
SELECT nome FROM clientes ORDER BY nome DESC;
```

---

## 🎯 Ordenação Múltipla

### Conceito
Você pode ordenar por múltiplas colunas, criando uma hierarquia de critérios.

### Sintaxe:
```sql
SELECT colunas FROM tabela 
ORDER BY coluna1 [ASC|DESC], coluna2 [ASC|DESC], ...;
```

### Exemplos Práticos:

#### 1. Ordenação por Categoria e Preço
```sql
-- Produtos ordenados por categoria e depois por preço
SELECT nome, categoria, preco FROM produtos 
ORDER BY categoria ASC, preco DESC;
```

#### 2. Ordenação por Status e Nome
```sql
-- Clientes ativos primeiro, depois por nome
SELECT nome, ativo FROM clientes 
ORDER BY ativo DESC, nome ASC;
```

#### 3. Ordenação por Data e ID
```sql
-- Pedidos mais recentes primeiro, depois por ID
SELECT id, data_pedido, valor_total FROM pedidos 
ORDER BY data_pedido DESC, id ASC;
```

---

## 🔀 Comando LIMIT

### Conceito
O `LIMIT` restringe o número de linhas retornadas pela consulta.

### Sintaxe:
```sql
SELECT colunas FROM tabela LIMIT quantidade;
```

### Exemplo Básico:
```sql
SELECT * FROM cursos LIMIT 5;
```
**Resultado:** Mostra apenas os 5 primeiros cursos encontrados.

### Exemplos Práticos:

#### 1. Limitar Resultados Básicos
```sql
-- Primeiros 10 clientes
SELECT nome, email FROM clientes LIMIT 10;

-- Primeiros 5 produtos
SELECT nome, preco FROM produtos LIMIT 5;
```

#### 2. Limitar com Ordenação
```sql
-- 3 produtos mais caros
SELECT nome, preco FROM produtos ORDER BY preco DESC LIMIT 3;

-- 5 clientes mais recentes
SELECT nome, data_cadastro FROM clientes ORDER BY data_cadastro DESC LIMIT 5;
```

---

## 📄 Paginação com OFFSET

### Conceito
O `OFFSET` permite "pular" um número específico de linhas, útil para paginação.

### Sintaxe:
```sql
SELECT colunas FROM tabela LIMIT quantidade OFFSET quantidade_pular;
```

### Exemplos Práticos:

#### 1. Paginação Simples
```sql
-- Página 1: Primeiros 10 clientes
SELECT nome, email FROM clientes LIMIT 10 OFFSET 0;

-- Página 2: Próximos 10 clientes
SELECT nome, email FROM clientes LIMIT 10 OFFSET 10;

-- Página 3: Próximos 10 clientes
SELECT nome, email FROM clientes LIMIT 10 OFFSET 20;
```

#### 2. Paginação com Ordenação
```sql
-- Página 1: 10 produtos mais caros
SELECT nome, preco FROM produtos ORDER BY preco DESC LIMIT 10 OFFSET 0;

-- Página 2: Próximos 10 produtos mais caros
SELECT nome, preco FROM produtos ORDER BY preco DESC LIMIT 10 OFFSET 10;
```

---

## 🚀 Combinações Avançadas

### 1. Top N com Ordenação
```sql
-- Top 5 produtos mais caros
SELECT nome, preco, categoria FROM produtos 
ORDER BY preco DESC LIMIT 5;
```

### 2. Ordenação Múltipla com Limite
```sql
-- 10 clientes ativos ordenados por nome
SELECT nome, email, ativo FROM clientes 
WHERE ativo = TRUE 
ORDER BY nome ASC LIMIT 10;
```

### 3. Paginação Completa
```sql
-- Página 3 de produtos (20 por página)
SELECT nome, preco FROM produtos 
ORDER BY nome ASC 
LIMIT 20 OFFSET 40;
```

---

## 🎯 Casos de Uso Específicos

### 1. Dashboard de Vendas
```sql
-- Top 10 produtos mais vendidos
SELECT nome, quantidade_vendida FROM produtos 
ORDER BY quantidade_vendida DESC LIMIT 10;
```

### 2. Relatório de Clientes
```sql
-- 20 clientes mais antigos
SELECT nome, data_cadastro FROM clientes 
ORDER BY data_cadastro ASC LIMIT 20;
```

### 3. Lista de Cursos
```sql
-- 5 cursos gratuitos mais longos
SELECT titulo, duracao FROM cursos 
WHERE gratuito = TRUE 
ORDER BY duracao DESC LIMIT 5;
```

### 4. Produtos por Categoria
```sql
-- 3 produtos mais caros de cada categoria
SELECT nome, categoria, preco FROM produtos 
ORDER BY categoria ASC, preco DESC LIMIT 3;
```

---

## 📝 Exercícios Práticos

### Exercício 1: Ordenação Básica

**1. Liste os 10 clientes mais recentes (ordenados por data_cadastro desc):**
```sql
SELECT nome, data_cadastro FROM clientes 
ORDER BY data_cadastro DESC LIMIT 10;
```

**2. Liste os 3 cursos com menor duração:**
```sql
SELECT titulo, duracao FROM cursos 
ORDER BY duracao ASC LIMIT 3;
```

**3. Liste os 5 cursos gratuitos com maior duração:**
```sql
SELECT titulo, duracao FROM cursos 
WHERE gratuito = TRUE 
ORDER BY duracao DESC LIMIT 5;
```

### Exercício 2: Ordenação Múltipla

**1. Produtos ordenados por categoria e preço (mais caros primeiro):**
```sql
SELECT nome, categoria, preco FROM produtos 
ORDER BY categoria ASC, preco DESC;
```

**2. Clientes ordenados por status (ativos primeiro) e nome:**
```sql
SELECT nome, ativo FROM clientes 
ORDER BY ativo DESC, nome ASC;
```

**3. Cursos ordenados por gratuito (gratuitos primeiro) e duração:**
```sql
SELECT titulo, gratuito, duracao FROM cursos 
ORDER BY gratuito DESC, duracao ASC;
```

### Exercício 3: Paginação

**1. Página 2 de produtos (10 por página):**
```sql
SELECT nome, preco FROM produtos 
ORDER BY nome ASC LIMIT 10 OFFSET 10;
```

**2. Top 5 produtos mais caros de eletrônicos:**
```sql
SELECT nome, preco FROM produtos 
WHERE categoria = 'Eletrônicos' 
ORDER BY preco DESC LIMIT 5;
```

**3. 10 clientes mais antigos que estão ativos:**
```sql
SELECT nome, data_cadastro FROM clientes 
WHERE ativo = TRUE 
ORDER BY data_cadastro ASC LIMIT 10;
```

---

## 🚀 Otimização de Performance

### 1. Índices para Ordenação
```sql
-- Criar índice para melhorar performance de ordenação
CREATE INDEX idx_produtos_preco ON produtos(preco);
CREATE INDEX idx_clientes_data_cadastro ON clientes(data_cadastro);
```

### 2. Ordem das Condições
```sql
-- ✅ Eficiente: WHERE antes de ORDER BY
SELECT nome, preco FROM produtos 
WHERE categoria = 'Eletrônicos' 
ORDER BY preco DESC LIMIT 10;

-- ❌ Menos eficiente: ORDER BY antes de filtrar
SELECT nome, preco FROM produtos 
ORDER BY preco DESC LIMIT 10;
```

### 3. Uso Inteligente do LIMIT
```sql
-- ✅ Sempre use LIMIT em consultas grandes
SELECT * FROM produtos ORDER BY nome LIMIT 100;

-- ❌ Pode retornar milhares de registros
SELECT * FROM produtos ORDER BY nome;
```

---

## ⚠️ Armadilhas Comuns

### 1. Ordem Incorreta de Operações
```sql
-- ❌ Erro: WHERE depois de ORDER BY
SELECT nome FROM clientes ORDER BY nome WHERE ativo = TRUE;

-- ✅ Correto: WHERE antes de ORDER BY
SELECT nome FROM clientes WHERE ativo = TRUE ORDER BY nome;
```

### 2. OFFSET sem LIMIT
```sql
-- ❌ Pode retornar muitos registros
SELECT * FROM produtos OFFSET 10;

-- ✅ Correto: sempre use LIMIT com OFFSET
SELECT * FROM produtos LIMIT 10 OFFSET 10;
```

### 3. Ordenação por Colunas Não Indexadas
```sql
-- ❌ Pode ser lento em grandes tabelas
SELECT * FROM produtos ORDER BY descricao;

-- ✅ Mais eficiente com índice
CREATE INDEX idx_produtos_descricao ON produtos(descricao);
```

---

## 🎯 Dicas de Performance

### 1. Índices para Ordenação
- ✅ Crie índices em colunas frequentemente ordenadas
- ✅ Use índices compostos para ordenação múltipla
- ✅ Considere índices parciais para filtros comuns

### 2. Limitação Inteligente
- ✅ Sempre use LIMIT em consultas de produção
- ✅ Use OFFSET para paginação eficiente
- ✅ Evite OFFSET muito grandes

### 3. Ordenação Eficiente
- ✅ Ordene apenas quando necessário
- ✅ Use colunas indexadas para ordenação
- ✅ Considere ordenação no aplicativo para grandes datasets

---

## 🚀 Próximos Passos
- Aula 7: Funções agregadas (COUNT, SUM, AVG, MAX, MIN)
- Aula 8: Agrupamento de dados (GROUP BY, HAVING)
- Aula 9: Junção de tabelas (JOIN)
- Aula 10: Subconsultas avançadas

---

## 📚 Recursos Adicionais
- [PostgreSQL ORDER BY](https://www.postgresql.org/docs/current/sql-select.html#SQL-ORDERBY)
- [MySQL ORDER BY](https://dev.mysql.com/doc/refman/8.0/en/order-by-optimization.html)
- [SQLite ORDER BY](https://www.sqlite.org/lang_select.html#orderby)
- [SQL Performance with ORDER BY](https://www.postgresql.org/docs/current/performance-tips.html)

---

## 💡 Dicas Importantes

### ✅ Dicas para Ordenação e Limitação:
- Sempre use LIMIT em consultas de produção
- Crie índices para colunas ordenadas frequentemente
- Use OFFSET para paginação eficiente
- Teste performance de consultas complexas

### ❌ Erros Comuns:
- Esquecer LIMIT em consultas grandes
- Usar OFFSET sem LIMIT
- Ordenar por colunas não indexadas
- Não considerar performance em grandes datasets

---

*Última atualização: Janeiro 2024*