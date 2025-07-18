📈 Aula 8 – Funções de Agregação
Essas funções servem para resumir dados. Muito úteis em relatórios e análises.

✅ COUNT() – Conta registros
sql
Copy
Edit
SELECT COUNT(*) FROM cursos;
Conta quantos cursos existem.

sql
Copy
Edit
SELECT COUNT(*) FROM cursos WHERE gratuito = true;
Conta quantos cursos são gratuitos.

➕ SUM() – Soma valores
sql
Copy
Edit
SELECT SUM(duracao) FROM cursos;
Soma a duração de todos os cursos.

📉 AVG() – Média dos valores
sql
Copy
Edit
SELECT AVG(duracao) FROM cursos;
Calcula a média da duração dos cursos.

🟢 MAX() e 🔴 MIN() – Valor máximo e mínimo
sql
Copy
Edit
SELECT MAX(duracao) FROM cursos;
SELECT MIN(duracao) FROM cursos;
Mostra o curso mais longo e o mais curto.

🧠 Com alias
sql
Copy
Edit
SELECT COUNT(*) AS total_cursos,
       AVG(duracao) AS media_duracao
FROM cursos;
📝 Exercício
Conte quantos clientes existem na tabela clientes.

Calcule a média de idade dos clientes.

Descubra o curso com maior duração.

Some a duração dos cursos gratuitos.

