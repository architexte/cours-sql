PRAGMA encoding = 'UTF-8';
-- base SQLite des architectes diocésains, ENC

-- Quelques références utiles
--   Datatypes In SQLite: http://www.sqlite.org/datatype3.html#section_2_2
--   Clés étrangères et rowid: http://www.sqlite.org/foreignkeys.html
--   Keywords (noms réservés): http://www.sqlite.org/lang_keywords.html
--   Auto-incrémentation des IDs: https://www.sqlite.org/autoinc.html


CREATE TABLE architect (
  id          INTEGER PRIMARY KEY,                     -- ! identifiant numérique
  name        TEXT NOT NULL,                           -- ! patronyme
  firstname   TEXT,                                    -- ? prénom
  birth       TEXT,                                    -- ? date de naissance, AAAA-MM-JJ
  death       TEXT,                                    -- ? date de mort, AAAA-MM-JJ
  birthdpt    TEXT NULL REFERENCES dpt(code),          -- ? département de naissance
  deathdpt    TEXT NULL REFERENCES dpt(code),          -- ? lieu de mort
  barts       BOOLEAN NOT NULL DEFAULT 0,              -- ? formation aux beaux-arts (oui/non)
  bartsyear   INTEGER,                                 -- ? année de promotion aux beaux-arts
  training    TEXT,                                    -- ? champ libre, description des autre(s) formation(s)
  rating      INTEGER,                                 -- ? appréciation de la hiérarchie en 1853 (note de 1 à 4)
  fatherWork  INTEGER NULL REFERENCES fatherWork(id)   -- ? milieu professionnel du père. NB: pour l’exercice, on considère que le père exerce une unique profession
);

-- liste d’autorité des bâtiments
CREATE TABLE building (
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  label       TEXT NOT NULL                            -- ! nom normalisé du bâtiment ("ville, bâtiment")
);

-- les interventions des architectes sur les bâtiments
CREATE TABLE restore (
  archid      INTEGER NOT NULL REFERENCES architect(id),
  buildingid  INTEGER NOT NULL REFERENCES building(id)
  --, wheniso     INTEGER NOT NULL
);

CREATE TABLE hasParents (
  archid      INTEGER NOT NULL REFERENCES architect(id),
  parentid    INTEGER NOT NULL REFERENCES architect(id),
  UNIQUE(archid, parentid) ON CONFLICT REPLACE
);

-- liste d’autorité des professions paternelles
CREATE TABLE fatherWork (
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  label       TEXT
);

-- fonction comme architecte diocésain
CREATE TABLE job (
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  label       TEXT
);

CREATE TABLE hasJobs (
  archid      INTEGER NOT NULL REFERENCES architect(id),
  jobid       INTEGER NOT NULL REFERENCES job(id),
  fromdate    INTEGER,                                 -- date de début
  todate      INTEGER,                                 -- date de fin
  diocese     TEXT NULL REFERENCES dpt(code)           -- diocèse
);

-- liste d’autorité des compétences des architectes diocésains
CREATE TABLE skill (
  label       TEXT PRIMARY KEY                         -- à discuter durement...
);

CREATE TABLE hasSkills (
  archid      INTEGER NOT NULL REFERENCES architect(id),
  skill       TEXT NOT NULL REFERENCES skill(label),
  fromdate    INTEGER,
  todate      INTEGER
);

CREATE TABLE dpt (
  code        TEXT UNIQUE NOT NULL,                    -- ! code du département
  label       TEXT NOT NULL                            -- ! nom du département
);
