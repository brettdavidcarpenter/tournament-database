- Table definitions for the tournament project.
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
create table Matches(id serial primary key, winner integer references Players (id), loser integer references Players (id));
--
create view standings as
    select players.id, players.name,
      COUNT(CASE WHEN players.id = winner THEN 1 END) AS wins,
      COUNT(winner + loser) AS matches
    FROM players LEFT JOIN matches
    ON players.id = matches.winner or players.id = matches.loser
    GROUP BY players.id ORDER BY wins DESC;
