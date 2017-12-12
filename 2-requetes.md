SQL, premières requêtes
===

# `CREATE TABLE` : création d’une table
```sql
CREATE TABLE architect (
  id          INTEGER PRIMARY KEY,
  name        TEXT NOT NULL,
  firstname   TEXT,
  birth       TEXT,
  death       TEXT,
  birthdpt    TEXT REFERENCES dpt(code),
  deathplace  TEXT,
  barts       BOOLEAN NOT NULL DEFAULT 0,
  bartsyear   INTEGER,
  training    TEXT,
  rating      INTEGER,
  fatherWork  INTEGER REFERENCES fatherWork(id)
);
```

# `INSERT INTO` : insertion de données
```sql
INSERT INTO hasSkills(archid, skill, fromdate, todate) VALUES
  (1,"tout",1849,1864),
  (7,"tout",1845,1848),
  (7,"église",1848,1850),
  (7,"séminaire",1848,1850),
  (5,"cathédrale",1848,1850),
  (5,"tout",1850,1875),
  (8,"tout",1843,1848),
  (8,"séminaire",1848,1854);
```

# Autres opérations sur les données

## `ALTER TABLE` : modification d’une table
https://www.sqlite.org/lang_altertable.html
```sql
ALTER TABLE architect RENAME curator;
```

## `DROP TABLE` : suppression d’une table
https://www.sqlite.org/lang_droptable.html
```sql
DROP TABLE architect;
```

## `DELETE` : suppression de données
https://www.sqlite.org/lang_delete.html
```sql
DELETE architect WHERE name='Durant';
```

# Les clauses `SELECT` et `FROM`
> **Pour les exercices suivants, ouvrir la base [architectes.db](./architectes.db) avec le client [DB Browser for SQLite](http://sqlitebrowser.org/).**

* La clause SELECT indique la liste des attributs constituant le résultat.
* La clause FROM indique la table dans laquelle on effectue la requête.
```sql
SELECT * FROM architect;
```
```sql
SELECT name, firstname, birth FROM architect;
```

* Alias `AS`
```sql
SELECT name AS nom, firstname AS prénom FROM architect;
```

# La clause `WHERE` : filtrer les résultats
```sql
SELECT * FROM architect WHERE birthdpt=75;
```
* **Opérateurs de comparaison** : `<`, `<=`, `>`, `>=`, `=`, `!=` ou `<>`
```sql
SELECT * FROM architect WHERE birth>1805;
SELECT * FROM architect WHERE birth>'1805';
```
* **Opérateurs intégrés** : `BETWEEN`, `IN`, `LIKE`, `IS`, `IS NOT`
```sql
SELECT * FROM architect WHERE barts IS NOT 0;
```
```sql
SELECT * FROM architect WHERE firstname LIKE ('%Paul%');
```

* **Opérateurs logiques** : `NOT`, `AND`, `OR`
```sql
SELECT * FROM architect WHERE birth>1805 AND barts IS NOT 0;
```

* **Opérateur de concaténation** : `||`
```sql
SELECT name || ', ' || firstname FROM architect;
```
(ATTENTION! Retrouvons-nous tous les résultats ?)

# Les clauses `DISTINCT`, `ORDER BY` et `LIMIT`
La clause `DISTINCT` permet de supprimer les doublons dans le résultat d'une requête.
```sql
SELECT skill FROM hasSkills;
```
```sql
SELECT DISTINCT skill FROM hasSkills;
```

La clause `ORDER BY [ASC ou DESC]` permet de trier les résultats d’une requête.
```sql
SELECT * FROM architect;
```
```sql
SELECT * FROM architect ORDER BY birth;
```
```sql
SELECT * FROM architect ORDER BY birth DESC;
```
La clause `LIMIT` indique le nombre maximal de lignes dans le résultat.
```sql
SELECT * FROM architect ORDER BY birth DESC LIMIT 5;
```
