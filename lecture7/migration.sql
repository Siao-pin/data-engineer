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
ALTER TABLE nds.artists ALTER COLUMN name DROP NOT NULL;
ALTER TABLE nds.music ALTER COLUMN music_key DROP NOT NULL;
ALTER TABLE nds.music ALTER COLUMN year DROP NOT NULL;
ALTER TABLE nds.music ALTER COLUMN album DROP NOT NULL;
ALTER TABLE nds.music ALTER COLUMN price DROP NOT NULL;
ALTER TABLE nds.music ALTER COLUMN cost DROP NOT NULL;
ALTER TABLE nds.music ALTER COLUMN status DROP NOT NULL;
ALTER TABLE nds.music ALTER COLUMN start_ts DROP NOT NULL;
ALTER TABLE nds.music ALTER COLUMN end_ts DROP NOT NULL;

UPDATE nds.films SET title = replace(trim(title), '\n', '');

ALTER TABLE nds.films ADD COLUMN version int DEFAULT 1;
CREATE TABLE nds.films_tmp
AS
SELECT id, start_ts, row_number() OVER (PARTITION BY film_key ORDER BY start_ts) AS version
FROM nds.films;

VACUUM;
UPDATE nds.films SET version = tmp.version
FROM nds.films_tmp tmp
WHERE nds.films.id = tmp.id AND nds.films.start_ts = tmp.start_ts;

DROP TABLE nds.films_tmp;
VACUUM;

ALTER TABLE nds.store ADD COLUMN version smallint default 1;
UPDATE nds.store SET date_close = date_close + 1 WHERE date_close <> '2999-12-31';

ALTER TABLE nds.book ADD COLUMN version int DEFAULT 1;
CREATE TABLE nds.book_tmp
AS
SELECT id, start_ts, row_number() OVER (PARTITION BY book_key ORDER BY start_ts) AS version
FROM nds.book;

VACUUM;
UPDATE nds.book SET version = tmp.version
FROM nds.book_tmp tmp
WHERE nds.book.id = tmp.id AND nds.book.start_ts = tmp.start_ts;

DROP TABLE nds.book_tmp;
VACUUM;

ALTER TABLE nds.music ADD COLUMN version int DEFAULT 1;
CREATE TABLE nds.music_tmp
AS
SELECT id, start_ts, row_number() OVER (PARTITION BY music_key ORDER BY start_ts) AS version
FROM nds.music;

VACUUM;
UPDATE nds.music SET version = tmp.version
FROM nds.music_tmp tmp
WHERE nds.music.id = tmp.id AND nds.music.start_ts = tmp.start_ts;

DROP TABLE nds.book_tmp;
VACUUM;
