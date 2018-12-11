-- JOINS
-- Trying new indentation for a cleaner read?

--1. Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
SELECT
    matchid, player
FROM 
    goal
WHERE 
    teamid = 'GER';

--2. Show id, stadium, team1, team2 for just game 1012
SELECT
    id, stadium, team1, team2
FROM 
    game
WHERE
    id = 1012;

--3. Modify it to show the player, teamid, stadium and mdate for every German goal.
SELECT
    goal.player, goal.teamid, ga.stadium, ga.mdate
FROM
    goal 
        JOIN game ga
            ON goal.matchid = ga.id
WHERE 
    teamid = 'GER';

--4. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT
    ga.team1, ga.team2, goal.player
FROM
    game ga
        JOIN goal goal 
            ON ga.id = goal.matchid
WHERE 
    goal.player LIKE 'Mario%';

--5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT
    goal.player, goal.teamid, e.coach, goal.gtime
FROM
    goal 
        JOIN eteam e 
            ON goal.teamid = e.id
WHERE 
    goal.gtime <= 10;

--6. List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT
    ga.mdate, e.teamname
FROM
    game ga
        JOIN eteam e 
            ON ga.team1 = e.id
WHERE 
    e.coach = 'Fernando Santos';

--7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT 
    goal.player
FROM 
    goal
        JOIN game ga
            ON goal.matchid = ga.id
WHERE ga.stadium = 'National Stadium, Warsaw';

--8. Instead show the name of all players who scored a goal against Germany.
SELECT DISTINCT
    goal.player
FROM
    goal
        JOIN game ga 
            ON goal.matchid = ga.id
WHERE 
    (ga.team1 = 'GER' OR ga.team2 = 'GER')
AND 
    goal.teamid <> 'GER';

--9. Show teamname and the total number of goals scored.
SELECT
    e.teamname, COUNT(goal.teamid)
FROM
    eteam e
        JOIN goal goal
            ON e.id = goal.teamid
GROUP BY 
    e.teamname;

--10. Show the stadium and the number of goals scored in each stadium.
SELECT
    ga.stadium, COUNT(goal.teamid)
FROM
    game ga
        JOIN goal goal
            ON ga.id = goal.matchid
GROUP BY 
    ga.stadium;

--11. For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT
    ga.id, ga.mdate, COUNT(goal.teamid)
FROM
    game ga
        JOIN goal goal
            ON ga.id = goal.matchid
WHERE
    (ga.team1 = 'POL' OR ga.team2 = 'POL')
GROUP BY
    ga.id, ga.mdate;

--12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT
    goal.matchid, game.mdate, COUNT(goal.teamid) 
FROM
    goal 
        JOIN game 
            ON goal.matchid = game.id 
WHERE
    goal.teamid = 'GER'
GROUP BY
    goal.matchid, game.mdate;

--13. List every match with the goals scored by each team as shown. 
--    This will use "CASE WHEN" which has not been explained in any previous exercises.
--  Sort your result by mdate, matchid, team1 and team2.
SELECT
    game.mdate, game.team1,
        COUNT(CASE WHEN game.team1 = goal.teamid THEN 1 ELSE 0 END) AS score1,
        game.team2,
        COUNT(CASE WHEN game.team2 = goal.teamid THEN 1 ELSE 0 END) AS score2,
        goal.matchid
FROM
    game
        LEFT JOIN goal
            ON game.id = goal.matchid
GROUP BY
    game.id

-- JOIN QUIZ

--1. You want to find the stadium where player 'Dimitris Salpingidis' scored.
SELECT 
    game.stadium, player
FROM 
    game
        JOIN goal
            ON game.id = goal.matchid
WHERE
    player = 'Dimitris Salpingidis';

--2. You JOIN the tables goal and eteam in an SQL statement. Indicate the list of column names that may be used in the SELECT line:
--Answer: matchid, teamid, player, gtime, id, teamname, coach

--3. Select the code which shows players, their team and the amount of goals they scored against Greece(GRE).
SELECT 
    goal.player, goal.teamid, COUNT(goal.teamid)
FROM 
    game 
        JOIN goal
            ON game.id = goal.matchid
WHERE 
    (game.team1 = 'GRE' OR game.team2 = 'GRE')
AND 
    goal.teamid != 'GRE'
GROUP BY 
    goal.player, goal.teamid;

--4. Select the result that would be obtained from this code:
--Answer: a

--5. Select the code which would show the player and their team for those who have scored against Poland(POL) in National Stadium, Warsaw.
SELECT DISTINCT player, 
                teamid 
FROM 
    game
        JOIN goal 
            ON matchid = id 
WHERE 
    stadium = 'National Stadium, Warsaw' 
AND 
    (team1 = 'POL' OR team2 = 'POL')
AND 
    teamid != 'POL';

--6. Select the code which shows the player, their team and the time they scored, for players who have played in Stadion Miejski (Wroclaw) but not against Italy(ITA).
SELECT
    goal.player, goal.teamid, goal.gtime
FROM 
    goal
        JOIN game
            ON goal.matchid = game.id
WHERE 
    game.stadium = 'Stadion Miejski (Wroclaw)'
AND 
    (( teamid = team2 AND team1 != 'ITA') OR ( teamid = team1 AND team2 != 'ITA'));

--7. Select the result that would be obtained from this code:
--Answer: B