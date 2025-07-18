# ✅ Aula 1 – Introdução ao SQL e Banco de Dados Relacionais

## 🎯 Objetivos da Aula
- Compreender o que é SQL e sua importância
- Entender o conceito de bancos de dados relacionais
- Conhecer os principais comandos SQL
- Aprender a estrutura básica de uma tabela
- Praticar com exemplos reais

---

## 🧠 Teoria

### O que é SQL?
**SQL** (Structured Query Language) é a linguagem padrão para trabalhar com bancos de dados relacionais. É uma linguagem declarativa que permite:
- **Criar** e **modificar** estruturas de dados
- **Inserir**, **consultar**, **atualizar** e **deletar** dados
- **Gerenciar** permissões e segurança
- **Controlar** transações e integridade dos dados

### Banco de Dados Relacional
Um banco relacional organiza os dados em **tabelas** (linhas e colunas), onde:
- Cada **tabela** representa uma entidade (ex: usuários, produtos, pedidos)
- Cada **linha** representa um registro individual
- Cada **coluna** representa um atributo específico
- As **relações** entre tabelas são estabelecidas através de chaves

#### Vantagens dos Bancos Relacionais:
✅ **Integridade dos dados** - Garantem consistência
✅ **Flexibilidade** - Fácil modificação da estrutura
✅ **Padrão** - Linguagem SQL universal
✅ **Segurança** - Controle de acesso robusto
✅ **Escalabilidade** - Suportam grandes volumes de dados

---

## 📦 Sistemas de Banco de Dados

### Principais SGBDs (Sistemas de Gerenciamento de Banco de Dados):

| SGBD | Características | Melhor Para |
|------|----------------|-------------|
| **PostgreSQL** ✅ | Open source, robusto, ACID | Aplicações complexas, dados críticos |
| **MySQL/MariaDB** | Popular, fácil de usar | Web applications, startups |
| **SQLite** | Arquivo único, sem servidor | Aplicações móveis, desenvolvimento |
| **SQL Server** | Microsoft, enterprise | Grandes empresas, Windows |
| **Oracle DB** | Enterprise, alta performance | Corporações, dados massivos |

---

## 🔧 Principais Comandos SQL

### Comandos DDL (Data Definition Language)
Comandos para **definir** a estrutura do banco:

| Comando | Função | Exemplo |
|---------|--------|---------|
| `CREATE` | Cria tabelas, bancos, índices | `CREATE TABLE usuarios (...)` |
| `ALTER` | Modifica estruturas existentes | `ALTER TABLE usuarios ADD COLUMN...` |
| `DROP` | Remove estruturas | `DROP TABLE usuarios` |
| `TRUNCATE` | Remove todos os dados | `TRUNCATE TABLE usuarios` |

### Comandos DML (Data Manipulation Language)
Comandos para **manipular** os dados:

| Comando | Função | Exemplo |
|---------|--------|---------|
| `INSERT` | Insere novos dados | `INSERT INTO usuarios VALUES (...)` |
| `SELECT` | Consulta dados | `SELECT * FROM usuarios` |
| `UPDATE` | Atualiza dados existentes | `UPDATE usuarios SET nome = 'João'` |
| `DELETE` | Remove dados específicos | `DELETE FROM usuarios WHERE id = 1` |

---

## 📄 Estrutura de uma Tabela

### Exemplo Prático - Tabela de Usuários:

```sql
CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  idade INTEGER CHECK (idade >= 0),
  data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  ativo BOOLEAN DEFAULT TRUE
);
```

### Explicação dos Tipos de Dados:

| Tipo | Descrição | Exemplo |
|------|-----------|---------|
| `SERIAL` | Auto-incremento | `1, 2, 3, 4...` |
| `VARCHAR(n)` | Texto com limite | `VARCHAR(100)` |
| `INTEGER` | Número inteiro | `25, 30, 45` |
| `BOOLEAN` | Verdadeiro/Falso | `TRUE, FALSE` |
| `TIMESTAMP` | Data e hora | `2024-01-15 14:30:00` |

### Constraint (Restrições):

| Constraint | Função |
|------------|--------|
| `PRIMARY KEY` | Chave primária única |
| `NOT NULL` | Campo obrigatório |
| `UNIQUE` | Valor único na tabela |
| `CHECK` | Validação personalizada |
| `DEFAULT` | Valor padrão |

---

## 🎯 Conceitos Importantes

### Chave Primária (PRIMARY KEY)
- **Identifica unicamente** cada registro
- **Não pode ser nula** nem duplicada
- Geralmente usa `SERIAL` para auto-incremento
- Exemplo: `id SERIAL PRIMARY KEY`

### Chave Estrangeira (FOREIGN KEY)
- **Conecta** tabelas relacionadas
- Mantém **integridade referencial**
- Exemplo: `usuario_id INTEGER REFERENCES usuarios(id)`

### Índices
- **Aceleram** consultas
- Criados automaticamente para chaves primárias
- Podem ser criados manualmente para otimização

---

## 📝 Exercícios Práticos

### Exercício 1: Conceitos Básicos
1. **O que significa SQL?**
   - Structured Query Language
   - Linguagem para consultar dados estruturados

2. **Cite 2 vantagens de usar um banco de dados relacional:**
   - Integridade dos dados garantida
   - Flexibilidade para modificações
   - Padrão universal (SQL)
   - Segurança robusta

3. **O que faz o comando SELECT?**
   - Consulta e retorna dados de uma ou mais tabelas
   - Permite filtrar, ordenar e agrupar resultados

4. **Para que serve a coluna id SERIAL PRIMARY KEY?**
   - Identifica unicamente cada registro
   - Auto-incrementa automaticamente
   - Garante que não há duplicatas

### Exercício 2: Criação de Tabelas
Crie uma tabela para um sistema de e-commerce:

```sql
CREATE TABLE produtos (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(200) NOT NULL,
  preco DECIMAL(10,2) NOT NULL CHECK (preco > 0),
  categoria VARCHAR(100),
  estoque INTEGER DEFAULT 0 CHECK (estoque >= 0),
  data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Exercício 3: Inserção de Dados
Insira alguns produtos na tabela:

```sql
INSERT INTO produtos (nome, preco, categoria, estoque) VALUES
('Notebook Dell', 3500.00, 'Eletrônicos', 10),
('Mouse Wireless', 89.90, 'Periféricos', 50),
('Teclado Mecânico', 299.00, 'Periféricos', 25);
```

### Exercício 4: Consultas Básicas
1. **Liste todos os produtos:**
   ```sql
   SELECT * FROM produtos;
   ```

2. **Produtos da categoria 'Periféricos':**
   ```sql
   SELECT nome, preco FROM produtos WHERE categoria = 'Periféricos';
   ```

3. **Produtos com preço acima de R$ 100:**
   ```sql
   SELECT nome, preco FROM produtos WHERE preco > 100 ORDER BY preco DESC;
   ```

---

## 🚀 Próximos Passos
- Aula 2: Consultas avançadas (JOIN, GROUP BY, HAVING)
- Aula 3: Subconsultas e funções agregadas
- Aula 4: Índices e otimização de performance
- Aula 5: Transações e integridade de dados

---

## 📚 Recursos Adicionais
- [Documentação PostgreSQL](https://www.postgresql.org/docs/)
- [W3Schools SQL Tutorial](https://www.w3schools.com/sql/)
- [SQLZoo](https://sqlzoo.net/) - Exercícios interativos
- [PostgreSQL Exercises](https://pgexercises.com/) - Prática avançada

---

*Última atualização: Janeiro 2024*