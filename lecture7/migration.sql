ALTER TABLE nds.films_age ALTER COLUMN name DROP NOT NULL;
ALTER TABLE nds.films_category ALTER COLUMN name DROP NOT NULL;
ALTER TABLE nds.films_genre ALTER COLUMN name DROP NOT NULL;
ALTER TABLE nds.films ALTER COLUMN film_key DROP NOT NULL;
ALTER TABLE nds.films ALTER COLUMN title DROP NOT NULL;
ALTER TABLE nds.films ALTER COLUMN price DROP NOT NULL;
ALTER TABLE nds.films ALTER COLUMN cost DROP NOT NULL;
ALTER TABLE nds.films ALTER COLUMN status DROP NOT NULL;
ALTER TABLE nds.films ALTER COLUMN start_ts DROP NOT NULL;
ALTER TABLE nds.films ALTER COLUMN end_ts DROP NOT NULL;

UPDATE nds.films SET end_ts = end_ts + 1 WHERE end_ts <> '2999-12-31';
UPDATE nds.films SET title = replace(trim(title), '\n', '');

ALTER TABLE nds.films ADD COLUMN version int DEFAULT 1;
CREATE TABLE nds.films_tmp
AS
SELECT id, start_ts, row_number() OVER (PARTITION BY film_key ORDER BY start_ts) AS version
FROM nds.films;

VACUUM;
UPDATE nds.films SET version = tmp.version
FROM nds.films_tmp tmp
WHERE nds.films.id = tmp.id AND nds.films.start_ts = tmp.start_ts
AND tmp.version > 1;

DROP TABLE nds.films_tmp;
VACUUM;
