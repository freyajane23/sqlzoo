#SELECT from Nobel Tutorial#
/*https://sqlzoo.net/wiki/SELECT_from_Nobel_Tutorial*/
#12
/*Find all details of the prize won by EUGENE O'NEILL.*/
select *
from nobel
where winner = 'EUGENE O''NEILL'
#13
/*List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order*/
select winner, yr, subject
from nobel
where winner like 'Sir%'
order by yr desc, winner
#14
/*Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.*/
/*Need to change the SQL engine to MYSQL in setting in the top right of the page*/
SELECT winner, subject
FROM nobel
WHERE yr=1984
ORDER BY subject IN ('Physics','Chemistry'),subject,winner

#SELECT within SELECT Tutorial#
/*https://sqlzoo.net/wiki/SELECT_within_SELECT_Tutorial*/
#5
/*Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.*/
/*Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.*/
select name,  concat(round(population*100/(select population from world where name='Germany'),0),'%')
from world
where continent='Europe'


