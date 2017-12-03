-- 1. Indique por ordem alfabética descendente o nome de todos os produtos com
-- classificação de comércio justo igual ou superior a B – em que A é a melhor
-- classificação.

SELECT P.nome
FROM Produto P
WHERE P.comercioJusto IN ('A', 'B')
ORDER BY P.nome DESC;


-- 2. Indique o sexo e a idade de cada um dos dependentes do consumidor com email
-- 'marcolina@hotmail.com'.

SELECT D.sexo, D.nascimento
FROM Dependente D, Consumidor C
WHERE D.consumidor = C.numero AND C.email = 'marcolina@hotmail.com';


-- 3. Email dos consumidores que compraram gasolina.

SELECT C.email
FROM Consumidor C, compra COMP
WHERE C.numero = COMP.consumidor AND COMP.produto = 1 AND COMP.prodMarca = 16;


-- 4. Email do(s) consumidor(es) que comprou mais gasolina.

SELECT C.email
FROM Consumidor C, compra COMP
WHERE C.numero = COMP.consumidor AND COMP.quantidade = (SELECT MAX(COMP.quantidade)
FROM compra COMP
WHERE COMP.produto = 1 AND COMP.prodMarca = 16);


-- 5. Determine a pegada ecológica associada a cada um dos produtos do tipo lar.

SELECT P.nome, C.percentagem * E.pegadaEcologica
FROM Produto P, composto C, Elemento E
WHERE P.tipo = 'lar' AND C.produto = P.codigo AND C.prodMarca = P.marca AND C.elemento = E.codigo
GROUP BY P.nome;

-- 6. Nome do(s) produto(s) mais prejudicial para a saúde – quanto maiores os valores
-- no atributo “saúde”, mais prejudiciais são para a mesma.
-- NOT COMPLETE// subquerie consegue devolver a soma das "saude" para se saber o pior
SELECT PROD.nome
FROM Produto PROD,Elemento ELEM
Where (PROD.nome) = (Select PROD.Nome,SUM(ELEM.saude) AS sum_saude
       FROM Produto PROD, Elemento ELEM, Composto COMP
       Where PROD.marca = COMP.prodMarca AND ELEM.codigo = COMP.elemento
       Group BY PROD.nome
       ORDER BY sum_saude DESC 
       LIMIT 1)
-- Devolve certo
SELECT PROD.nome
FROM Produto PROD,Elemento ELEM, Composto COMP
Where PROD.marca = COMP.prodMarca AND ELEM.codigo = COMP.elemento
       Group BY PROD.nome
       HAVING SUM(saude) = (Select SUM(ELEM.saude) AS sum_saude
                            FROM Produto PROD, Elemento ELEM, Composto COMP
                            Where PROD.marca = COMP.prodMarca AND ELEM.codigo = COMP.elemento
                            Group BY PROD.nome
                            ORDER BY sum_saude DESC)

-- 7. Liste o sexo e a idade de todas as pessoas abrangidas por esta base de dados –
-- consumidores e seus dependentes.
-- NOT COMPLETE
SELECT CONS.sexo, year(CURDATE()) - year(CONS.nascimento) as Idade
FROM Consumidor CONS
LEFT JOIN Dependente ON CONS.numero = Dependente.consumidor

-- Correct?
SELECT Consumidor.sexo, year(CURDATE()) - year(Consumidor.nascimento) as Idade FROM Consumidor
UNION ALL
SELECT Dependente.sexo, year(CURDATE()) - year(Dependente.nascimento) as Idade FROM Dependente;

-- 8. Email do(s) consumidor(es) que registou compras implicando menor pegada
-- ecológica – ter em conta o número de dependentes, dividindo a mesma pelo
-- número de pessoas no agregado (consumidor + número de dependentes).

SELECT C.email
FROM Consumidor C, compra COMP, Dependente D, Elemento E, Produto P, composto CO
WHERE C.numero = COMP.consumidor AND D.consumidor = C.numero AND COMP.produto = CO.produto AND COMP.prodMarca = CO.prodMarca AND CO.elemento = E.codigo
GROUP BY  


-- 9. Email dos consumidores que realizaram compras que incluem todos os
-- elementos mencionados na tabela “Elemento”.

SELECT C.email
FROM Consumidor C, compra COMP, Elemento E, Produto P, composto CO
WHERE C.numero = COMP.consumidor AND COMP.produto = P.codigo AND COMP.prodMarca = P.marca AND COMP.produto = CO.produto AND COMP.prodMarca = CO.prodMarca
GROUP BY c.email
HAVING COUNT (CO.elemento) = (SELECT COUNT (*)	
							  FROM Elemento E);
-- da erro nao sei pq