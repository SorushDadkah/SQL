-- Trying out new indentation for cleaner read?

-- 1. List the films where the yr is 1962 [Show id, title].
SELECT id, title
FROM movie
WHERE yr = 1962;

-- 2. Give year of 'Citizen Kane'.
SELECT yr 
FROM movie
WHERE title = 'Citizen Kane';

-- 3. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
SELECT 
    id, title, yr
FROM 
    movie
WHERE 
    title LIKE '%Star Trek%'
ORDER BY 
    yr;

-- 4. What id number does the actor 'Glenn Close' have?
SELECT 
    id
FROM 
    actor
WHERE 
    name = 'Glenn Close';

-- 5. What is the id of the film 'Casablanca'?
SELECT
    id
FROM
    movie
WHERE 
    title = 'Casablanca';

-- 6. Obtain the cast list for 'Casablanca'.
SELECT
    actor.name
FROM
    actor
        JOIN casting 
            ON actor.id = casting.actorid
        JOIN movie 
            ON movie.id = casting.movieid
WHERE 
    movie.id = 11768;

-- 7. Obtain the cast list for the film 'Alien'.
SELECT 
    actor.name
FROM 
    actor
        JOIN casting
            ON actor.id = casting.actorid
        JOIN movie 
            ON casting.movieid = movie.id
WHERE 
    movie.id = '10522';

-- 8. List the films in which 'Harrison Ford' has appeared.
SELECT
    movie.title
FROM 
    movie
        JOIN casting 
            ON movie.id = casting.movieid
        JOIN actor   
            ON casting.actorid = actor.id
WHERE
    actor.name = 'Harrison Ford';

-- 9. List the films where 'Harrison Ford' has appeared - but not in the starring role.
SELECT
    movie.title
FROM 
    movie
        JOIN casting 
            ON movie.id = casting.movieid
        JOIN actor
            ON actor.id = casting.actorid
WHERE 
    actor.name = 'Harrison Ford'
AND 
    casting.ord != 1;

-- 10. List the films together with the leading star for all 1962 films.
SELECT
    movie.title, actor.name
FROM 
    movie
        JOIN casting
            ON movie.id = casting.movieid
        JOIN actor
            ON actor.id = casting.actorid
WHERE 
    movie.yr = 1962 
AND 
    casting.ord = 1;

-- 11. Which were the busiest years for 'John Travolta', 
-- show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT 
    movie.yr, COUNT(movie.title) "Movies"
FROM
    movie
        JOIN casting
            ON movie.id = casting.movieid
        JOIN actor
            ON casting.actorid = actor.id
WHERE
    actor.name = 'John Travolta'
GROUP BY 
    movie.yr
HAVING 
    Movies > 2;

-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT 
    movie.title, actor.name
FROM 
    movie
        JOIN casting 
            ON casting.movieid = movie.id
        JOIN actor   
            ON casting.actorid = actor.id
WHERE 
    movie.id IN (SELECT movie.id
                 FROM movie
                    JOIN casting ON movie.id = casting.movieid
                    JOIN actor   ON casting.actorid = actor.id
                 WHERE actor.name = 'Julie Andrews')
AND 
    casting.ord = 1;

-- 13. Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.
SELECT
    actor.name
FROM
    actor
        JOIN casting 
            ON casting.actorid = actor.id
WHERE 
    casting.ord = 1
GROUP BY
    actor.name
HAVING 
    COUNT(casting.ord) >= 30
ORDER BY 
    actor.name;

-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT 
    movie.title, COUNT(casting.actorid) AS "Actors"
FROM
    movie
        JOIN casting
            ON movie.id = casting.movieid
WHERE 
    movie.yr = 1978
GROUP BY
    movie.title
ORDER BY
    Actors DESC, movie.title;

-- 15. List all the people who have worked with 'Art Garfunkel'.
SELECT 
    actor.name
FROM
    actor
        JOIN casting
            ON actor.id = casting.actorid
WHERE 
    casting.movieid IN (SELECT casting.movieid
                        FROM casting
                        WHERE casting.actorid = 1112)
AND 
    actor.name != 'Art Garfunkel';

-- Join Quiz 2

-- 1. Select the statement which lists the unfortunate directors of the movies which have caused financial loses (gross < budget).
SELECT
    [name]
FROM 
    actor 
        JOIN movie 
            ON actor.id = director
WHERE 
    gross < budget;

-- 2. Select the correct example of JOINing three tables.
SELECT 
    *
FROM
    actor
        JOIN casting
            ON actor.id = actorid
        JOIN movie 
            ON movie.id = movieid;

-- 3. Select the statement that shows the list of actors called 'John' by order of number of movies in which they acted.
SELECT
    actor.name, COUNT(casting.movieid) "Movies"
FROM
    actor
        JOIN casting
            ON actor.id = casting.actorid
WHERE 
    actor.name LIKE 'John%'
GROUP BY
    actor.name
ORDER BY 
    Movies DESC;

-- 4. Select the result that would be obtained from the following code:
-- Answer: Table-B
SELECT title 
FROM movie JOIN casting ON (movieid=movie.id)
           JOIN actor   ON (actorid=actor.id)
WHERE name = 'Paul Hogan' AND ord = 1;

 -- 5. Select the statement that lists all the actors that starred in movies directed by Ridley Scott who has id 351.
SELECT 
    name
FROM
    movie
        JOIN casting 
            ON movie.id = movieid
        JOIN actor
            ON actor.id = actorid
WHERE 
    ord = 1 AND director = 351;

-- 6. There are two sensible ways to connect movie and actor. 
    --They are:
    -- 1. link the director column in movies with the primary key in actor
    -- 2. connect the primary keys of movie and actor via the casting table

--7. Select the result that would be obtained from the following code:
-- Answer: Table-B
 SELECT title, yr 
   FROM movie, casting, actor 
  WHERE name='Robert De Niro' AND movieid=movie.id AND actorid=actor.id AND ord = 3;

