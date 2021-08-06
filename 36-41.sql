--36
SELECT cl.class FROM Classes cl
WHERE cl.class IN
(SELECT sh.name class FROM Ships sh
UNION
SELECT oc.ship class FROM Outcomes oc
)

--37
SELECT class FROM 
(SELECT cl.class, sh.name FROM Classes cl
JOIN Ships sh ON cl.class = sh.class
UNION
SELECT cl.class, oc.ship FROM Classes cl
JOIN Outcomes oc ON oc.ship = cl.class
) t1
GROUP BY class
HAVING COUNT(*) = 1

--38
SELECT country FROM classes
WHERE type = 'bb'
AND country IN 
(SELECT country FROM Classes WHERE type = 'bc')
GROUP BY country

--39
SELECT oc.ship FROM Outcomes oc
JOIN Battles bt ON oc.battle = bt.name
WHERE oc.result = 'damaged'
AND oc.ship IN
(SELECT oc2.ship FROM Outcomes oc2
JOIN Battles bt2 ON oc2.battle = bt2.name
WHERE bt2.date > bt.date
)
GROUP BY oc.ship

--40
SELECT maker, MIN(type) FROM product
GROUP BY maker
HAVING COUNT(DISTINCT type) = 1 AND COUNT(model) > 1

--41
SELECT pr.maker, 
CASE
    WHEN MIN(ISNULL(price, -10)) = -10 THEN NULL
    ELSE MAX(price)
END 'max price' FROM product pr
JOIN 
(SELECT model, price FROM laptop
UNION
SELECT model, price FROM pc
UNION
SELECT model, price FROM printer) t1
ON t1.model = pr.model
GROUP BY pr.maker