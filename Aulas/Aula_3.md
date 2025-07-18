# 💾 Aula 3 – Inserindo Dados com INSERT INTO

## 🎯 Objetivos da Aula
- Compreender como inserir dados em tabelas SQL
- Dominar diferentes formas de inserção
- Aprender sobre valores padrão e constraints
- Praticar inserção de dados em cenários reais
- Entender tratamento de erros na inserção

---

## 🧠 Teoria

### Comando INSERT INTO
O comando `INSERT INTO` é fundamental para adicionar dados em uma tabela. É o primeiro passo para popular um banco de dados com informações.

### Sintaxe Básica:
```sql
INSERT INTO nome_da_tabela (coluna1, coluna2, ...)
VALUES (valor1, valor2, ...);
```

### Regras Importantes:
- ✅ **Ordem dos valores** deve corresponder à ordem das colunas
- ✅ **Strings** devem estar entre aspas simples (`'texto'`)
- ✅ **Números** não precisam de aspas
- ✅ **Datas** devem estar no formato `'YYYY-MM-DD'`
- ✅ **Booleanos** usam `TRUE` ou `FALSE` sem aspas
- ✅ **Campos SERIAL** são preenchidos automaticamente

---

## 📋 Tipos de Inserção

### 1. Inserção Completa (Especificando Todas as Colunas)

```sql
INSERT INTO usuarios (id, nome, email, idade, ativo)
VALUES (1, 'João Silva', 'joao@email.com', 25, TRUE);
```

### 2. Inserção Parcial (Apenas Colunas Necessárias)

```sql
INSERT INTO usuarios (nome, email, idade)
VALUES ('Maria Santos', 'maria@email.com', 30);
```

### 3. Inserção Múltipla (Vários Registros)

```sql
INSERT INTO usuarios (nome, email, idade) VALUES
('Ana Costa', 'ana@email.com', 28),
('Pedro Lima', 'pedro@email.com', 35),
('Carla Souza', 'carla@email.com', 22);
```

### 4. Inserção com SELECT (Dados de Outra Tabela)

```sql
INSERT INTO usuarios_backup (nome, email, idade)
SELECT nome, email, idade FROM usuarios WHERE ativo = TRUE;
```

---

## 🧪 Exemplos Práticos

### Exemplo 1: Inserir Cliente

```sql
INSERT INTO clientes (nome, email, nascimento, ativo)
VALUES ('Ana Silva', 'ana@email.com', '1990-05-12', TRUE);
```

### Exemplo 2: Inserir Curso

```sql
INSERT INTO cursos (titulo, duracao, gratuito, inicio)
VALUES ('Lógica de Programação', 20, TRUE, '2025-08-01');
```

### Exemplo 3: Inserir Produto

```sql
INSERT INTO produtos (nome, preco, categoria, estoque)
VALUES ('Notebook Dell Inspiron', 3500.00, 'Eletrônicos', 10);
```

### Exemplo 4: Inserir Pedido

```sql
INSERT INTO pedidos (cliente_id, data_pedido, status, valor_total)
VALUES (1, CURRENT_TIMESTAMP, 'Pendente', 150.00);
```

---

## 🔧 Valores Padrão e Constraints

### Campos com DEFAULT
Quando uma coluna tem valor padrão, você pode omiti-la:

```sql
-- Tabela com campos DEFAULT
CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  ativo BOOLEAN DEFAULT TRUE
);

-- Inserção sem especificar campos com DEFAULT
INSERT INTO usuarios (nome, email)
VALUES ('João Silva', 'joao@email.com');
-- data_cadastro será CURRENT_TIMESTAMP
-- ativo será TRUE
```

### Campos SERIAL
Campos auto-incrementáveis não precisam ser especificados:

```sql
-- O campo 'id' será preenchido automaticamente
INSERT INTO usuarios (nome, email, idade)
VALUES ('Maria Santos', 'maria@email.com', 25);
```

---

## ⚠️ Tratamento de Erros

### Erros Comuns e Soluções:

#### 1. Violação de UNIQUE
```sql
-- ERRO: Email já existe
INSERT INTO usuarios (nome, email) VALUES ('João', 'joao@email.com');

-- SOLUÇÃO: Use INSERT ... ON CONFLICT (PostgreSQL)
INSERT INTO usuarios (nome, email) 
VALUES ('João', 'joao@email.com')
ON CONFLICT (email) DO UPDATE SET nome = EXCLUDED.nome;
```

#### 2. Violação de NOT NULL
```sql
-- ERRO: Campo obrigatório não informado
INSERT INTO usuarios (email) VALUES ('joao@email.com');

-- SOLUÇÃO: Sempre informe campos NOT NULL
INSERT INTO usuarios (nome, email) VALUES ('João', 'joao@email.com');
```

#### 3. Violação de CHECK
```sql
-- ERRO: Idade negativa
INSERT INTO usuarios (nome, email, idade) VALUES ('João', 'joao@email.com', -5);

-- SOLUÇÃO: Respeite as constraints
INSERT INTO usuarios (nome, email, idade) VALUES ('João', 'joao@email.com', 25);
```

#### 4. Violação de FOREIGN KEY
```sql
-- ERRO: Cliente inexistente
INSERT INTO pedidos (cliente_id, valor_total) VALUES (999, 100.00);

-- SOLUÇÃO: Use um cliente_id válido
INSERT INTO pedidos (cliente_id, valor_total) VALUES (1, 100.00);
```

---

## 📝 Exercícios Práticos

### Exercício 1: Inserção Básica

**Insira 2 clientes na tabela clientes, com dados reais ou fictícios:**

```sql
INSERT INTO clientes (nome, email, nascimento, ativo) VALUES
('Carlos Oliveira', 'carlos@email.com', '1985-03-15', TRUE),
('Fernanda Lima', 'fernanda@email.com', '1992-07-22', TRUE);
```

### Exercício 2: Inserção de Cursos

**Insira 2 cursos na tabela cursos, com durações e datas diferentes:**

```sql
INSERT INTO cursos (titulo, duracao, gratuito, inicio) VALUES
('Introdução ao SQL', 15, TRUE, '2024-02-01'),
('Desenvolvimento Web', 40, FALSE, '2024-03-15');
```

### Exercício 3: Inserção Múltipla

**Insira vários produtos de uma vez:**

```sql
INSERT INTO produtos (nome, preco, categoria, estoque) VALUES
('Mouse Wireless', 89.90, 'Periféricos', 50),
('Teclado Mecânico', 299.00, 'Periféricos', 25),
('Monitor 24"', 899.00, 'Monitores', 15),
('SSD 500GB', 399.00, 'Armazenamento', 30);
```

### Exercício 4: Cenário Real - E-commerce

**Crie e popule um sistema de e-commerce:**

```sql
-- 1. Criar tabelas
CREATE TABLE categorias (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE produtos (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(200) NOT NULL,
  preco DECIMAL(10,2) NOT NULL CHECK (preco > 0),
  categoria_id INTEGER REFERENCES categorias(id),
  estoque INTEGER DEFAULT 0 CHECK (estoque >= 0)
);

-- 2. Inserir categorias
INSERT INTO categorias (nome) VALUES
('Eletrônicos'),
('Livros'),
('Roupas'),
('Casa e Jardim');

-- 3. Inserir produtos
INSERT INTO produtos (nome, preco, categoria_id, estoque) VALUES
('Smartphone Samsung', 1299.00, 1, 20),
('Livro SQL Completo', 89.90, 2, 50),
('Camiseta Básica', 29.90, 3, 100),
('Vaso Decorativo', 45.00, 4, 30);
```

---

## 🎯 Boas Práticas

### Nomenclatura e Formatação
- ✅ Use **aspas simples** para strings: `'texto'`
- ✅ Use **aspas duplas** apenas para identificadores especiais
- ✅ **Booleanos** sem aspas: `TRUE`, `FALSE`
- ✅ **Datas** no formato ISO: `'2024-01-15'`

### Performance
- ✅ Use **INSERT múltiplo** para muitos registros
- ✅ **Desative índices** temporariamente para inserções massivas
- ✅ Use **transações** para inserções críticas

### Segurança
- ✅ **Valide dados** antes da inserção
- ✅ Use **prepared statements** em aplicações
- ✅ **Trate erros** adequadamente

---

## 🚀 Comandos Avançados

### Inserção com Retorno (PostgreSQL)
```sql
INSERT INTO usuarios (nome, email)
VALUES ('João Silva', 'joao@email.com')
RETURNING id, nome, data_cadastro;
```

### Inserção Condicional
```sql
-- Insere apenas se não existir
INSERT INTO usuarios (nome, email)
SELECT 'João Silva', 'joao@email.com'
WHERE NOT EXISTS (
  SELECT 1 FROM usuarios WHERE email = 'joao@email.com'
);
```

### Inserção com Subconsulta
```sql
INSERT INTO pedidos (cliente_id, valor_total)
SELECT id, 0 FROM clientes WHERE ativo = TRUE;
```

---

## 📊 Verificação de Dados

### Comandos para Verificar Inserções:

```sql
-- Contar registros
SELECT COUNT(*) FROM usuarios;

-- Ver últimos registros inseridos
SELECT * FROM usuarios ORDER BY id DESC LIMIT 5;

-- Verificar dados específicos
SELECT nome, email FROM usuarios WHERE ativo = TRUE;

-- Verificar constraints
SELECT column_name, is_nullable, column_default 
FROM information_schema.columns 
WHERE table_name = 'usuarios';
```

---

## 🚀 Próximos Passos
- Aula 4: Consultando dados (SELECT básico)
- Aula 5: Filtros e ordenação (WHERE, ORDER BY)
- Aula 6: Funções e agregações
- Aula 7: Atualização de dados (UPDATE)

---

## 📚 Recursos Adicionais
- [PostgreSQL INSERT](https://www.postgresql.org/docs/current/sql-insert.html)
- [MySQL INSERT](https://dev.mysql.com/doc/refman/8.0/en/insert.html)
- [SQLite INSERT](https://www.sqlite.org/lang_insert.html)
- [SQL INSERT Best Practices](https://www.postgresql.org/docs/current/sql-insert.html)

---

## 💡 Dicas Importantes

### ✅ Dicas para Inserção:
- O campo `id` (tipo SERIAL) não precisa ser informado
- Use `FALSE` sem aspas para valores booleanos
- Sempre teste inserções em ambiente de desenvolvimento
- Mantenha backup antes de inserções massivas
- Use transações para operações críticas

### ❌ Erros Comuns:
- Esquecer aspas em strings
- Usar aspas em booleanos
- Não respeitar constraints
- Inserir dados em ordem errada
- Não tratar erros de inserção

---

*Última atualização: Janeiro 2024*