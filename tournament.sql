-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

--
DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;
--
\c tournament
--
create table Players(id serial primary key, name text);
--
create table Matches(winner integer, loser integer, match id integer primary key);
--
create view standings as
    select players.id, players.name, COALESCE(sum(matches.winner),0) AS wins, count(matches.winner)
    FROM players LEFT JOIN matches
    ON players.id = matches.id
    GROUP BY players.id
    ORDER BY wins DESC;
