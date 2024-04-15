-- General Instructions
-- 1.	The .sql files are run automatically, so please ensure that there are no syntax errors in the file. If we are unable to run your file, you get an automatic reduction to 0 marks.
-- Comment in MYSQL 

-- 1
SELECT player_name FROM player
WHERE batting_hand = 'Left-hand bat' AND country_name = 'England'
ORDER BY player_name;

-- 2
SELECT 
    player_name,
    TIMESTAMPDIFF(YEAR, dob, '2018-12-02') AS age
FROM 
    player
WHERE 
    bowling_skill = 'Legbreak googly'
    AND TIMESTAMPDIFF(YEAR, dob, '2018-12-02') >= 28
ORDER BY 
    age DESC,
    player_name;

-- 3
SELECT match_id, toss_winner
FROM match
WHERE toss_decision = 'bat'
ORDER BY match_id;

-- 4
SELECT over_id, runs_scored
FROM batsman_scored
WHERE match_id = 335987 AND runs_scored <= 7
ORDER BY runs_scored DESC, over_id;

-- 5
SELECT DISTINCT player.player_name
FROM player
JOIN Batsman_Out ON player.player_id = Batsman_Out.player_out
WHERE Batsman_Out.kind_out = 'Bowled'
ORDER BY player.player_name;

-- 6
SELECT match.match_id, 
       Team1.name AS team_1, 
       Team2.name AS team_2, 
       WinningTeam.name AS winning_team_name, 
       match.win_margin
FROM match
JOIN team AS Team1 ON match.team_1 = Team1.team_id
JOIN team AS Team2 ON match.team_2 = Team2.team_id
JOIN team AS WinningTeam ON match.match_winner = WinningTeam.team_id
WHERE match.win_margin >= 60
ORDER BY match.win_margin, match.match_id;

-- 7
SELECT player_name 
FROM player 
WHERE batting_hand = 'Left_Hand bat' 
AND dob >= '1988-12-02'
ORDER BY player_name;

-- 8
SELECT match_id, SUM(runs_scored) AS total_runs
FROM batsman_scored
GROUP BY match_id
ORDER BY match_id;

-- 9
SELECT 
    r.match_id,
    MAX(r.runs_scored) AS maximum_runs,
    p.player_name
FROM 
    batsman_scored r
JOIN 
    Ball_By_Ball b ON r.match_id = b.match_id AND r.over_id = b.over_id
JOIN 
    player p ON b.bowler = p.player_id
GROUP BY 
    r.match_id
ORDER BY 
    r.match_id ASC;

-- 10
SELECT player.player_name, COUNT(wicket_taken.kind_out) AS number
FROM wicket_taken
JOIN player ON wicket_taken.player_out = player.player_id
WHERE wicket_taken.kind_out = 'run out'
GROUP BY wicket_taken.player_out
ORDER BY number DESC, player.player_name;

-- 11
SELECT kind_out AS out_type, COUNT(kind_out) AS number
FROM wicket_taken
GROUP BY kind_out
ORDER BY number DESC, kind_out;

-- 12
SELECT team.name, COUNT(match.man_of_the_match) AS number
FROM match
JOIN team ON match.man_of_the_match = team.team_id
GROUP BY team.name
ORDER BY team.name;

-- 13
SELECT venue
FROM (SELECT venue, ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC, venue) AS row_num
      FROM extra_runs
      WHERE extra_type = 'wides'
      GROUP BY venue) AS sub
WHERE row_num = 1;

-- 14
SELECT venue
FROM (
    SELECT venue, COUNT(*) AS wins_count
    FROM match
    WHERE toss_decision = 'field' AND toss_winner = team_bowling AND match_winner = team_bowling
    GROUP BY venue
    ORDER BY wins_count DESC, venue
) AS venue_wins;

-- 15
SELECT 
    p.player_name
FROM 
    player p
JOIN 
    (
        SELECT 
            b.bowler AS player_id,
            SUM(b.runs_given) AS total_runs_given,
            COUNT(po.player_out) AS total_wickets_taken
        FROM 
            ball_by_ball b
        LEFT JOIN 
            wicket_taken po ON b.match_id = po.match_id
                         AND b.over_id = po.over_id
                         AND b.ball_id = po.ball_id
                         AND b.innings_no = po.innings_no
        WHERE 
            po.kind_out IS NOT NULL
        GROUP BY 
            b.bowler
    ) AS bowling_stats ON p.player_id = bowling_stats.player_id
ORDER BY 
    (bowling_stats.total_runs_given / NULLIF(bowling_stats.total_wickets_taken, 0)),
    p.player_name
LIMIT 1;

-- 16
SELECT player.player_name, team.name
FROM player
JOIN player_match ON player.player_id = player_match.player_id
JOIN team ON player_match.team_id = team.team_id
JOIN match ON player_match.match_id = match.match_id
WHERE player_match.role = 'CaptainKeeper' AND match.match_winner = player_match.team_id
ORDER BY player.player_name;

-- 17
SELECT player.player_name, SUM(batsman_scored.runs_scored) AS runs_scored
FROM player
JOIN Ball_By_Ball ON player.player_id = Ball_By_Ball.striker OR player.player_id = Ball_By_Ball.non_striker
JOIN batsman_scored ON Ball_By_Ball.match_id = batsman_scored.match_id AND Ball_By_Ball.innings_no = batsman_scored.innings_no AND Ball_By_Ball.over_id = batsman_scored.over_id AND Ball_By_Ball.ball_id = batsman_scored.ball_id
GROUP BY player.player_name
HAVING SUM(batsman_scored.runs_scored) >= 50
ORDER BY runs_scored DESC, player.player_name;

-- 18
SELECT player.player_name
FROM player
JOIN Ball_By_Ball ON player.player_id = Ball_By_Ball.striker OR player.player_id = Ball_By_Ball.non_striker
JOIN batsman_scored ON Ball_By_Ball.match_id = batsman_scored.match_id AND Ball_By_Ball.innings_no = batsman_scored.innings_no AND Ball_By_Ball.over_id = batsman_scored.over_id AND Ball_By_Ball.ball_id = batsman_scored.ball_id
JOIN match ON Ball_By_Ball.match_id = match.match_id
WHERE batsman_scored.runs_scored >= 100 AND match.match_winner != Ball_By_Ball.team_batting
ORDER BY player.player_name;

-- 19
SELECT match.match_id, match.venue
FROM match
JOIN team AS T1 ON match.team_1 = T1.team_id
JOIN team AS T2 ON match.team_2 = T2.team_id
WHERE (T1.name = 'KKR' OR T2.name = 'KKR') AND match.match_winner != (SELECT team_id FROM team WHERE name = 'KKR')
ORDER BY match.match_id;

-- 20
SELECT player.player_name
FROM player
JOIN Ball_By_Ball ON player.player_id = Ball_By_Ball.striker OR player.player_id = Ball_By_Ball.non_striker
JOIN match ON Ball_By_Ball.match_id = match.match_id
WHERE match.season_id = 5
GROUP BY player.player_name
ORDER BY SUM(Ball_By_Ball.runs_scored) / COUNT(DISTINCT match.match_id) DESC, player.player_name
LIMIT 10;