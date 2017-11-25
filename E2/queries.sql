-- 1.Indique por ordem alfabética descendente o nome de todos os produtos com classificação de comércio justo igual ou superior a B – em que A é a melhor classificação.

SELECT P.nome
FROM Produto P
WHERE P.comercioJusto IN ('A', 'B')
ORDER BY P.nome DESC

-- 2. Indique o sexo e a idade de cada um dos dependentes do consumidor com email 'marcolina@hotmail.com'.

SELECT D.sexo, D.nascimento
FROM Dependente D, Consumidor C
WHERE D.consumidor = C.numero AND C.email = 'marcolina@hotmail.com'

-- 3. Email dos consumidores que compraram gasolina.

SELECT C.email
FROM Consumidor C, compra COMP
WHERE C.numero = COMP.consumidor AND COMP.produto = 1 AND COMP.prodMarca = 16

-- 4. Email do(s) consumidor(es) que comprou mais gasolina.

SELECT MAX(COMP.quantidade)
FROM Consumidor C, compra COMP
WHERE C.numero = COMP.consumidor AND COMP.produto = 1 AND COMP.prodMarca = 16

-- 5. Determine a pegada ecológica associada a cada um dos produtos do tipo lar.
