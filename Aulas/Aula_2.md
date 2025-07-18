# 📘 Aula 2 – Criando Tabelas e Tipos de Dados no SQL

## 🎯 Objetivos da Aula
- Compreender como criar tabelas no SQL
- Conhecer os principais tipos de dados
- Aprender sobre constraints e validações
- Praticar criação de estruturas de banco de dados
- Entender boas práticas de modelagem

---

## 🧠 Teoria

### Comando CREATE TABLE
O comando `CREATE TABLE` é fundamental para definir a estrutura de dados no SQL. Ele permite:
- **Definir colunas** com nomes e tipos específicos
- **Estabelecer constraints** para integridade dos dados
- **Configurar valores padrão** para facilitar inserções
- **Criar relacionamentos** entre tabelas

### Estrutura Básica:
```sql
CREATE TABLE nome_tabela (
  coluna1 tipo_dados [constraints],
  coluna2 tipo_dados [constraints],
  ...
);
```

---

## 📋 Tipos de Dados Fundamentais

### Tipos Numéricos

| Tipo | Descrição | Exemplo | Uso |
|------|-----------|---------|-----|
| `INTEGER` | Números inteiros | `42, -15, 1000` | IDs, contadores |
| `BIGINT` | Inteiros grandes | `123456789012345` | IDs únicos longos |
| `DECIMAL(x,y)` | Números decimais precisos | `10.99, 1234.56` | Preços, valores monetários |
| `NUMERIC(x,y)` | Similar ao DECIMAL | `10.99, 1234.56` | Cálculos financeiros |
| `REAL` | Números de ponto flutuante | `3.14159` | Cálculos científicos |
| `SERIAL` | Auto-incremento | `1, 2, 3, 4...` | Chaves primárias |

### Tipos de Texto

| Tipo | Descrição | Exemplo | Uso |
|------|-----------|---------|-----|
| `VARCHAR(n)` | Texto com limite | `'João Silva'` | Nomes, emails |
| `CHAR(n)` | Texto fixo | `'BR'` | Códigos, siglas |
| `TEXT` | Texto ilimitado | `'Descrição longa...'` | Descrições, comentários |
| `JSON` | Dados JSON | `'{"key": "value"}'` | Dados estruturados |

### Tipos de Data e Hora

| Tipo | Descrição | Exemplo | Uso |
|------|-----------|---------|-----|
| `DATE` | Apenas data | `'2024-01-15'` | Datas de nascimento |
| `TIME` | Apenas hora | `'14:30:00'` | Horários |
| `TIMESTAMP` | Data e hora | `'2024-01-15 14:30:00'` | Logs, auditoria |
| `INTERVAL` | Período de tempo | `'2 hours'` | Durações |

### Tipos Booleanos e Binários

| Tipo | Descrição | Exemplo | Uso |
|------|-----------|---------|-----|
| `BOOLEAN` | Verdadeiro/Falso | `TRUE, FALSE` | Flags, status |
| `BYTEA` | Dados binários | `'\xDEADBEEF'` | Imagens, arquivos |

---

## 🔧 Constraints (Restrições)

### Constraints de Integridade

| Constraint | Função | Exemplo |
|------------|--------|---------|
| `PRIMARY KEY` | Chave primária única | `id SERIAL PRIMARY KEY` |
| `FOREIGN KEY` | Chave estrangeira | `usuario_id INTEGER REFERENCES usuarios(id)` |
| `UNIQUE` | Valor único | `email VARCHAR(100) UNIQUE` |
| `NOT NULL` | Campo obrigatório | `nome VARCHAR(100) NOT NULL` |
| `CHECK` | Validação personalizada | `idade INTEGER CHECK (idade >= 0)` |
| `DEFAULT` | Valor padrão | `ativo BOOLEAN DEFAULT TRUE` |

### Exemplo Prático com Constraints:

```sql
CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  idade INTEGER CHECK (idade >= 0 AND idade <= 150),
  data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  ativo BOOLEAN DEFAULT TRUE
);
```

---

## 📌 Exemplos Práticos

### Exemplo 1: Tabela de Produtos

```sql
CREATE TABLE produtos (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(200) NOT NULL,
  descricao TEXT,
  preco DECIMAL(10,2) NOT NULL CHECK (preco > 0),
  categoria VARCHAR(100),
  em_estoque BOOLEAN DEFAULT TRUE,
  estoque INTEGER DEFAULT 0 CHECK (estoque >= 0),
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Exemplo 2: Tabela de Pedidos

```sql
CREATE TABLE pedidos (
  id SERIAL PRIMARY KEY,
  cliente_id INTEGER NOT NULL REFERENCES clientes(id),
  data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(50) DEFAULT 'Pendente' CHECK (status IN ('Pendente', 'Aprovado', 'Cancelado')),
  valor_total DECIMAL(10,2) NOT NULL CHECK (valor_total >= 0),
  observacoes TEXT
);
```

---

## 🧪 Exercícios Práticos

### Exercício 1: Conceitos Básicos

1. **Qual a diferença entre VARCHAR(100) e TEXT?**
   - `VARCHAR(100)`: Texto com limite de 100 caracteres, mais eficiente para textos curtos
   - `TEXT`: Texto ilimitado, melhor para descrições longas

2. **O que o tipo SERIAL faz automaticamente?**
   - Cria uma sequência auto-incrementável
   - Gera automaticamente valores únicos (1, 2, 3, 4...)
   - É ideal para chaves primárias

### Exercício 2: Criação de Tabela de Clientes

✅ **Crie uma tabela clientes com as seguintes colunas:**
- `id`: autoincrementável e chave primária
- `nome`: texto até 150 caracteres
- `email`: texto até 100 caracteres
- `nascimento`: data de nascimento
- `ativo`: booleano

```sql
CREATE TABLE clientes (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  nascimento DATE,
  ativo BOOLEAN DEFAULT TRUE
);
```

### Exercício 3: Tabela de Cursos

**Crie uma tabela chamada cursos com:**
- `id`: serial
- `titulo`: texto até 120 caracteres
- `duracao`: número inteiro (em horas)
- `gratuito`: booleano
- `inicio`: data

```sql
CREATE TABLE cursos (
  id SERIAL PRIMARY KEY,
  titulo VARCHAR(120) NOT NULL,
  duracao INTEGER NOT NULL CHECK (duracao > 0),
  gratuito BOOLEAN DEFAULT FALSE,
  inicio DATE NOT NULL
);
```

### Exercício 4: Tabela de Instrutores

**Crie uma tabela de instrutores com validações:**

```sql
CREATE TABLE instrutores (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  especialidade VARCHAR(100),
  salario DECIMAL(10,2) CHECK (salario > 0),
  data_contratacao DATE NOT NULL,
  ativo BOOLEAN DEFAULT TRUE
);
```

---

## 🎯 Boas Práticas

### Nomenclatura
- ✅ Use nomes descritivos: `usuarios`, `produtos`, `pedidos`
- ✅ Evite abreviações: `user` → `usuario`
- ✅ Use snake_case para nomes de tabelas e colunas

### Tipos de Dados
- ✅ Use `VARCHAR` para textos com limite conhecido
- ✅ Use `TEXT` para descrições longas
- ✅ Use `DECIMAL` para valores monetários
- ✅ Use `TIMESTAMP` para logs e auditoria

### Constraints
- ✅ Sempre defina `PRIMARY KEY`
- ✅ Use `NOT NULL` para campos obrigatórios
- ✅ Adicione `CHECK` para validações importantes
- ✅ Use `DEFAULT` para valores comuns

### Performance
- ✅ Evite colunas desnecessárias
- ✅ Use tipos apropriados para economizar espaço
- ✅ Considere índices para consultas frequentes

---

## 🚀 Comandos Úteis

### Visualizar Estrutura da Tabela:
```sql
-- PostgreSQL
\d nome_tabela

-- MySQL
DESCRIBE nome_tabela;

-- SQLite
.schema nome_tabela
```

### Modificar Tabela Existente:
```sql
-- Adicionar coluna
ALTER TABLE usuarios ADD COLUMN telefone VARCHAR(20);

-- Modificar tipo de dados
ALTER TABLE usuarios ALTER COLUMN idade TYPE INTEGER;

-- Adicionar constraint
ALTER TABLE usuarios ADD CONSTRAINT check_idade CHECK (idade >= 0);
```

### Remover Tabela:
```sql
-- Remove apenas os dados
TRUNCATE TABLE usuarios;

-- Remove a tabela completamente
DROP TABLE usuarios;
```

---

## 📝 Exercícios Adicionais

### Exercício 5: Sistema de Biblioteca
Crie as tabelas para um sistema de biblioteca:

```sql
-- Tabela de Livros
CREATE TABLE livros (
  id SERIAL PRIMARY KEY,
  titulo VARCHAR(200) NOT NULL,
  autor VARCHAR(150) NOT NULL,
  isbn VARCHAR(13) UNIQUE,
  ano_publicacao INTEGER CHECK (ano_publicacao > 0),
  quantidade INTEGER DEFAULT 1 CHECK (quantidade >= 0)
);

-- Tabela de Empréstimos
CREATE TABLE emprestimos (
  id SERIAL PRIMARY KEY,
  livro_id INTEGER NOT NULL REFERENCES livros(id),
  usuario_id INTEGER NOT NULL REFERENCES usuarios(id),
  data_emprestimo DATE NOT NULL DEFAULT CURRENT_DATE,
  data_devolucao DATE,
  devolvido BOOLEAN DEFAULT FALSE
);
```

### Exercício 6: Validações Avançadas
Crie uma tabela com validações complexas:

```sql
CREATE TABLE funcionarios (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  cpf VARCHAR(14) UNIQUE NOT NULL,
  salario DECIMAL(10,2) NOT NULL CHECK (salario >= 1000),
  data_admissao DATE NOT NULL,
  data_demissao DATE CHECK (data_demissao > data_admissao),
  departamento VARCHAR(100) NOT NULL,
  ativo BOOLEAN DEFAULT TRUE
);
```

---

## 🚀 Próximos Passos
- Aula 3: Inserção e consulta de dados (INSERT, SELECT)
- Aula 4: Filtros e ordenação (WHERE, ORDER BY)
- Aula 5: Funções agregadas (COUNT, SUM, AVG)
- Aula 6: Relacionamentos entre tabelas (JOIN)

---

## 📚 Recursos Adicionais
- [PostgreSQL Data Types](https://www.postgresql.org/docs/current/datatype.html)
- [MySQL Data Types](https://dev.mysql.com/doc/refman/8.0/en/data-types.html)
- [SQLite Data Types](https://www.sqlite.org/datatype3.html)
- [Database Design Best Practices](https://www.postgresql.org/docs/current/ddl.html)

---

*Última atualização: Janeiro 2024*