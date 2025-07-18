🧠 Aula 5 – Filtrando com AND, OR e NOT
Esses operadores lógicos permitem combinar várias condições nas consultas com WHERE.

🔗 AND – Todas as condições devem ser verdadeiras
sql
Copy
Edit
SELECT * FROM cursos
WHERE gratuito = TRUE AND duracao > 10;
Só retorna cursos gratuitos com mais de 10 horas.

🔀 OR – Uma das condições deve ser verdadeira
sql
Copy
Edit
SELECT * FROM cursos
WHERE gratuito = TRUE OR duracao > 10;
Retorna cursos gratuitos ou com mais de 10 horas, ou ambos.

🚫 NOT – Inverte a condição
sql
Copy
Edit
SELECT * FROM clientes
WHERE NOT ativo;
Retorna os clientes que não estão ativos.

🧪 Exemplo combinado:
sql
Copy
Edit
SELECT * FROM clientes
WHERE ativo = TRUE AND nascimento < '2000-01-01';
Retorna clientes ativos nascidos antes do ano 2000.

📝 Exercício
Liste os cursos que são gratuitos e têm mais de 15 horas.

Liste os clientes que não estão ativos ou nasceram depois de 2005.

Liste os cursos que não são gratuitos e duram menos que 10 horas.

