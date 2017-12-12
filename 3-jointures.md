SQL, les jointures
===

# Les jointures
C’est l’opération de base dès que l’on souhaite combiner des données réparties dans plusieurs tables.

Comment afficher les compétences (*skills*) de chaque architecte ?
```sql
SELECT name, skill FROM architect, hasSkills;
```
On obtient le **produit cartésien** (11x40 = 440 résultats).  
Il faut donc supprimer les résultats aberrants par une condition :
```sql
SELECT name, skill FROM architect, hasSkills
  WHERE id = archid;
```
```sql
SELECT name, skill FROM architect, hasSkills
  WHERE architect.id = hasSkills.archid;
```

# Les fonctions d’agrégation
Permettent d'exprimer des conditions sur des groupes de lignes, et de constituer le résultat : https://www.sqlite.org/lang_aggfunc.html
* `COUNT() (expression)`        compte le nombre de lignes.
* `AVG() (expression)`          calcule la moyenne de expression.
* `MIN() (expression)`          calcule la valeur minimale de expression.
* `MAX() (expression)`          calcule la valeur maximale de expression.
* `SUM() (expression)`          calcule la somme de expression

Par exemple, on peut calculer le nombre d’architectes dans notre base :
```sql
SELECT COUNT(*) FROM architect;
```
```sql
SELECT COUNT(*) FROM architect WHERE barts=1;
```

# La clause `GROUP BY`
`GROUP BY` groupe les lignes sélectionnées en se basant sur la valeur de colonnes spécifiées pour chaque ligne et renvoie une seule ligne par groupe.

Calculer le nombre de restaurations suivies par chaque architecte (id) :
```sql
SELECT archid, COUNT(*) FROM restore GROUP BY archid;
```

Sélectionner les 3 architectes (id) qui ont suivi le plus de restaurations :
```sql
SELECT archid, COUNT(*) AS chantiers FROM restore
  GROUP BY archid
  ORDER BY chantiers
  DESC LIMIT 3;
```
Afficher les noms et prénoms des 3 architectes qui ont suivi le plus de restaurations (**ça commence à chauffer…**) :
```sql
SELECT name || ', ' || firstname, chantiers
  FROM
    Architect,
    (SELECT archid, COUNT(buildingid) AS chantiers
      FROM restore
      GROUP BY archid ORDER BY chantiers DESC LIMIT 3)
WHERE architect.id = archid;
```
Un **subselect** est un SELECT imbriqué dans un autre SELECT.

# La clause `HAVING`
`HAVING` agit comme le filtre `WHERE`, mais permet de filtrer non plus les données, mais les opérations résultant des regroupements.

Sélectionner les architectes qui ont suivi une unique restauration :
```sql
SELECT archid, COUNT(buildingid) AS restauration_count
  FROM restore
  GROUP BY archid
  HAVING restauration_count = 1;
```
NB. La clause `WHERE` renverrait ici une erreur, car le filtrage ne porte pas sur la notion de lignes, mais sur la notion de sous-ensemble de la table. Le filtre doit porter sur chacun des groupes calculés.

# Exploiter ses données : les interventions d’architectes
Notre base est structurée et renseignée. Nous pouvons produire et exporter la donnée pour visualiser le réseau des interventions des architectes sur les différents bâtiments.
```sql
SELECT
  architect.name || '_' || architect.id AS architecte,
  building.label AS bâtiment
  FROM architect, building, restore
  WHERE
    architect.id = restore.archid AND
    building.id = restore.buildingid;
```
* Exporter les données en [CSV](https://fr.wikipedia.org/wiki/Comma-separated_values).
* Extraire le réseau depuis la table (CSV) de résultats avec [Table 2 Net](http://tools.medialab.sciences-po.fr/table2net/).
* Visualiser le réseau avec [manylines](http://tools.medialab.sciences-po.fr/manylines) et/ou l’analyser avec [Gephi](https://gephi.org/).
