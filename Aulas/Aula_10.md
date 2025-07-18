🎯 Aula 10 – HAVING
O que é?
O HAVING serve para filtrar os grupos criados pelo GROUP BY, semelhante ao WHERE mas que funciona após a agregação.

Exemplo:
Queremos listar produtos vendidos mais de 10 vezes:

sql
Copy
Edit
SELECT produto, SUM(quantidade) AS total_vendido
FROM vendas
GROUP BY produto
HAVING SUM(quantidade) > 10;
Diferença WHERE x HAVING
WHERE filtra linhas antes da agregação.

HAVING filtra grupos depois da agregação.

📝 Exercícios
Liste os tipos de curso (gratuito ou pago) que têm mais de 3 cursos cadastrados.

Liste clientes ativos que tenham pelo menos 2 pedidos (supondo uma tabela de pedidos).

Crie uma consulta que mostre grupos com duração média maior que 20 horas.

