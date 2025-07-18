🔍 Aula 4 – Consultas Simples com SELECT
🧠 Teoria
O comando SELECT é usado para consultar dados de uma ou mais tabelas.

📌 Sintaxe:
sql
Copy
Edit
SELECT coluna1, coluna2 FROM nome_da_tabela;
Para consultar todas as colunas, usamos o asterisco:

sql
Copy
Edit
SELECT * FROM nome_da_tabela;
🧪 Exemplos:
1. Ver todos os clientes:
sql
Copy
Edit
SELECT * FROM clientes;
2. Ver apenas nomes e e-mails dos clientes:
sql
Copy
Edit
SELECT nome, email FROM clientes;
3. Ver apenas os cursos gratuitos:
sql
Copy
Edit
SELECT * FROM cursos WHERE gratuito = TRUE;
4. Ver cursos com mais de 10 horas:
sql
Copy
Edit
SELECT * FROM cursos WHERE duracao > 10;
⚙️ Operadores comuns:
Operador	Significado
=	Igual
!=	Diferente
>	Maior
<	Menor
>=	Maior ou igual
<=	Menor ou igual

📝 Exercício
Liste todos os clientes cadastrados.

Mostre somente os nomes dos cursos com duração maior que 15.

Liste os clientes que estão ativos.

Liste os cursos com início após 2025-07-30.