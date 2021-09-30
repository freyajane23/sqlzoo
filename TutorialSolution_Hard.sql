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
#7
/*Find the largest country (by area) in each continent, show the continent, the name and the area:*/
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)
#8
/* List  each continent and the name of the country that comes first alphabetically.*/
select continent, name from world x
where name <= All(select name from world y
              where x.continent=y.continent)
#9
/*Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.*/
select name, continent, population from world x
where 25000000 >= All(select population from world y where x.continent=y.continent)

#10
/* Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.*/
select name, continent from world as x
where population/3 >= All(select population from world y 
                        where x.continent=y.continent 
                        and x.name != y.name)
 
 #The JOIN OPERATION#
 /*https://sqlzoo.net/wiki/The_JOIN_operation*/
#13
/*List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.*/
SELECT
    mdate,
    team1,
    SUM( CASE WHEN teamid = team1 THEN 1 ELSE 0 END ) AS score1,
    team2,
    SUM( CASE WHEN teamid = team2 THEN 1 ELSE 0 END ) AS score2
FROM game LEFT JOIN goal
    ON id = matchid
GROUP BY mdate, team1, team2
ORDER BY mdate, matchid, team1, team2

#More Join#
/*https://sqlzoo.net/wiki/More_JOIN_operations*/
#12
List the film title and the leading actor for all of the films 'Julie Andrews' played in.
Did you get "Little Miss Marker twice"?
/*need to use the movie id not the title*/
select distinct title, name
from movie
left join casting on movie.id=casting.movieid
left join actor on actor.id=casting.actorid
where ord=1 and movieid in (
select movieid 
from casting
join actor on actor.id=casting.actorid
where name='Julie Andrews'
 )
 
# the old one I did earlier. This gets "Little Miss Marker twice" Should not use title as a unique id to link the table#
 select distinct movieid, title, name
from movie
left join casting on movie.id=casting.movieid
left join actor on actor.id=casting.actorid
where ord=1 and title in (
select title 
from movie
left join casting on movie.id=casting.movieid
left join actor on actor.id=casting.actorid
where name='Julie Andrews'
 )

# 13
# Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.#
select name
from actor
where id in (select actorid
from casting
where ord=1
group by actorid
having sum(ord)>=15)
order by name

#better answer#
SELECT name
FROM casting JOIN actor ON actorid = actor.id
WHERE ord = 1
GROUP BY name
HAVING count(movieid) >= 30
ORDER BY name;

#15
/*List all the people who have worked with 'Art Garfunkel'.*/ 
/*Need to exclude Art Garfunkel in the result*/
 SELECT actor.name  FROM casting
       JOIN movie ON movie.id=casting.movieid
      JOIN actor ON  actor.id=casting.actorid
     WHERE actor.name !='Art Garfunkel'
    AND
       movie.id IN(SELECT movie.id FROM casting
           JOIN movie ON movie.id=casting.movieid
       JOIN actor ON  actor.id=casting.actorid
        WHERE actor.name='Art Garfunkel')
 
 #Window Functions
/*https://sqlzoo.net/wiki/Window_functions*/
/*You can use SELECT within SELECT to pick out only the winners in Edinburgh.*/

SELECT constituency,party
  FROM ge X
 WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
   AND yr  = 2017 
AND VOTES >= ALL(SELECT VOTES FROM GE Y WHERE X.constituency=Y.constituency AND Y.YR=2017)
ORDER BY constituency,VOTES DESC



