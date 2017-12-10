-- 1. Indique por ordem alfabética descendente o nome de todos os produtos com
-- classificação de comércio justo igual ou superior a B – em que A é a melhor
-- classificação.

SELECT P.nome
FROM Produto P
WHERE P.comercioJusto IN ('A', 'B')
ORDER BY P.nome DESC;


-- 2. Indique o sexo e a idade de cada um dos dependentes do consumidor com email
-- 'marcolina@hotmail.com'.

SELECT D.sexo, year(CURDATE()) - year(D.nascimento) as Idade
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

SELECT P.nome, SUM((C.percentagem / 100) * E.pegadaEcologica) as "Pegada Ecologica"
FROM Produto P, composto C, Elemento E
WHERE P.tipo = 'lar' AND C.produto = P.codigo AND C.prodMarca = P.marca AND C.elemento = E.codigo
GROUP BY P.nome;

-- 6. Nome do(s) produto(s) mais prejudicial para a saúde – quanto maiores os valores
-- no atributo “saúde”, mais prejudiciais são para a mesma.

SELECT PROD.nome 
FROM Produto PROD,Elemento ELEM, composto COMP 
Where PROD.marca = COMP.prodMarca AND ELEM.codigo = COMP.elemento 
Group BY PROD.nome 
HAVING SUM(saude * (percentagem / 100)) = (Select SUM(ELEM.saude * (COMP.percentagem / 100)) AS sum_saude 
                                           FROM Produto PROD, Elemento ELEM, composto COMP 
                                           Where PROD.marca = COMP.prodMarca 
                                           AND ELEM.codigo = COMP.elemento 
                                           Group BY PROD.nome 
                                           ORDER BY sum_saude Desc 
                                           LIMIT 1);

-- 7. Liste o sexo e a idade de todas as pessoas abrangidas por esta base de dados –
-- consumidores e seus dependentes.
	
SELECT Consumidor.sexo, year(CURDATE()) - year(Consumidor.nascimento) as Idade FROM Consumidor
UNION ALL
SELECT Dependente.sexo, year(CURDATE()) - year(Dependente.nascimento) as Idade FROM Dependente;

-- 8. Email do(s) consumidor(es) que registou compras implicando menor pegada
-- ecológica – ter em conta o número de dependentes, dividindo a mesma pelo
-- número de pessoas no agregado (consumidor + número de dependentes).

CREATE VIEW pegadaEcologica AS
SELECT P.codigo as "Codigo", P.marca as "Marca", SUM((C.percentagem / 100) * E.pegadaEcologica) as "Pegada"
FROM Produto P, composto C, Elemento E
WHERE P.codigo = C.produto AND P.marca = C.prodMarca AND C.elemento = E.codigo
GROUP BY P.codigo, P.marca;

SELECT C.email
FROM pegadaEcologica Pe, compra COMP, Consumidor C LEFT OUTER JOIN Dependente D ON (D.consumidor = C.numero)
WHERE Pe.Codigo = COMP.produto AND Pe.Marca = COMP.prodMarca AND COMP.consumidor = C.numero
GROUP BY C.numero
HAVING (SUM(COMP.quantidade * Pe.Pegada) / 1 + COUNT(DISTINCT D.numero)) <= ALL (SELECT (SUM(COMP.quantidade * Pe.Pegada) / 1 + COUNT(DISTINCT D.numero))
FROM pegadaEcologica Pe, compra COMP, Consumidor C LEFT OUTER JOIN Dependente D ON (D.consumidor = C.numero)
WHERE Pe.Codigo = COMP.produto AND Pe.Marca = COMP.prodMarca AND COMP.consumidor = C.numero
GROUP BY C.numero);

-- 9. Email dos consumidores que realizaram compras que incluem todos os
-- elementos mencionados na tabela “Elemento”.

SELECT C.email
FROM Consumidor C, Elemento E, compra COMP, composto CO
WHERE C.numero = COMP.consumidor AND CO.produto = COMP.produto AND CO.prodMarca = COMP.prodMarca
GROUP BY C.numero
HAVING COUNT(DISTINCT CO.elemento) = (SELECT COUNT(*)
FROM Elemento E);
