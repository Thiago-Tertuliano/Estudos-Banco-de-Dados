🧮 Aula 9 – GROUP BY
O que faz?
Agrupa os registros que têm o mesmo valor em uma ou mais colunas, para aplicar funções agregadas.

Exemplo prático:
Imagine que temos uma tabela de vendas com colunas produto e quantidade.

Queremos saber a quantidade total vendida por produto:

sql
Copy
Edit
SELECT produto, SUM(quantidade) AS total_vendido
FROM vendas
GROUP BY produto;
Regras importantes:
Toda coluna no SELECT que não é uma função agregada deve estar no GROUP BY.

Você pode agrupar por múltiplas colunas.

Exemplo com múltiplas colunas:
sql
Copy
Edit
SELECT cliente, produto, SUM(quantidade) AS total_vendido
FROM vendas
GROUP BY cliente, produto;
📝 Exercício
Considere a tabela cursos com coluna gratuito e duracao.

Liste a quantidade de cursos gratuitos e pagos.

Liste a duração média dos cursos por tipo (gratuito e pago).

Agrupe os clientes por status ativo e conte quantos há em cada grupo.

