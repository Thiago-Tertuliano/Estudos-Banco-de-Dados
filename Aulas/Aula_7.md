🧾 Aula 7 – Usando AS para dar nomes mais claros
O AS permite renomear colunas ou dar apelidos para tabelas. Isso deixa o resultado mais legível ou facilita o uso em joins.

🔤 Renomeando colunas
sql
Copy
Edit
SELECT nome AS nome_do_curso, duracao AS horas
FROM cursos;
Agora a coluna nome aparece como nome_do_curso e duracao como horas.

🧩 Renomeando tabelas (útil em joins)
sql
Copy
Edit
SELECT c.nome AS curso, c.duracao
FROM cursos AS c;
A tabela cursos é apelidada de c. Isso economiza escrita e melhora a clareza em joins.

🧠 Dica:
O AS é opcional. Você pode usar direto assim:

sql
Copy
Edit
SELECT nome nome_do_curso FROM cursos;
Mas usar AS ajuda a manter o código mais claro.

📝 Exercício
Mostre a tabela de clientes com as colunas nome_completo, email_pessoal e data_nascimento.

Mostre os cursos com titulo, horas_totais e se são gratuitos_ou_nao.

Apelide a tabela cursos como c e selecione somente c.nome e c.duracao.