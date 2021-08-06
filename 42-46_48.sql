--42
SELECT oc.ship, oc.battle FROM Outcomes oc
WHERE result = 'sunk'

--43
SELECT bt.name FROM Battles bt
WHERE YEAR(bt.date) NOT IN
(SELECT sh.launched FROM Ships sh
JOIN Battles bt ON sh.launched = YEAR(bt.date))

--44
SELECT ship FROM
(SELECT name ship FROM Ships
UNION
SELECT ship FROM Outcomes) t1
WHERE ship LIKE 'r%' OR ship LIKE 'R%'

--45
SELECT ship FROM
(SELECT name ship FROM Ships
UNION
SELECT ship FROM Outcomes) t1
WHERE ship LIKE '% % %'

--46
select sh.name, cl.displacement, cl.numguns from outcomes ou
join ships sh on sh.name = ou.ship
join classes cl on sh.class = cl.class
where battle = 'Guadalcanal'
UNION
select ou.ship, cl.displacement, cl.numguns from outcomes ou
left join classes cl on cl.class = ou.ship
where ou.ship not in 
(select name from ships)
and battle = 'Guadalcanal'

--47
--Nope. Too much for me

--48
select cl.class from classes cl
join ships sh on sh.class = cl.class
join outcomes ou on ou.ship = sh.name and result = 'sunk'
union
(select cl.class from classes cl
join outcomes ou on cl.class = ou.ship and result = 'sunk'
except 
select cl.class from classes cl
join outcomes ou on cl.class = ou.ship and result = 'sunk'
where ou.ship in (select name from ships)
)