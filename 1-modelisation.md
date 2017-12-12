Base de données relationnelle
===
introduction avec [SQLite](https://www.sqlite.org/index.html)

# Introduction
## Objectifs de la séance
* Comprendre les principaux concepts :
  * table
  * champ
  * types de données
  * enregistrement
  * association
  * cardinalité
  * schéma
  * etc.
* Cerner les principaux écueils de la modélisation
* Construire sa première base.
* Écrire des requêtes et exporter les résultats.

## Une base prosopographique ; un mail d’Olivier…
> “[À partir de notices], nous déterminerons une liste de champs (...) :
> * patronyme (unique, obligatoire)
> * prénom (unique)
> * date de naissance (unique)
> * date de mort (unique)
> * poste d’architecte diocésain (multiple)
> * fonction comme architecte diocésain, ie architecte/inspecteur/suppléant/honoraire (unique pour chaque poste)
> * date de début (unique)
> * date de fin (unique)
> * diocèse (unique)
> ...”

# Une première base

## Le tableur
|name|firstname|bith|job|from|to|
|----|---------|----|---|----|--|
|Abadie|Paul (fils)|1812-12-10|architecte|1881|1884|
|Abadie|Paul (fils)|1812-12-10|inspecteur|1872|1884|
|Béziers-Lafosse|Albert|1840|inspecteur|1881|1905|
|Millet|Eugène|1819-05-21|architecte|1848|1875|
|Millet|Eugène|1819-05-21|inspecteur|1875|1879|
|Reynaud|François Léonce|1803|inspecteur|1853|1856|

## Problèmes ?

### Insertion
* Unicité : comment empêcher de représenter plusieurs fois le même architecte ?
* Intégrité : un architecte peut apparaître plusieurs fois et décrit de différentes
manières (birth)

### Modification
* Maintenir la cohérence des données : si je modifie la date de naissance d’Eugène
Millet (architecte), comment garantir le report de l’information pour Millet (inspecteur) ?

## Restructuration (relation)

### Table `architect`
|id|name|firstname|birth|
|--|----|---------|-----|
|1|Abadie|Paul (fils)|1812-12-10|
|2|Béziers-Lafosse|Albert|1840|
|3|Millet|Eugène|1819-05-21|
|4|Reynaud|François Léonce|1803|

### Table `job`
|id|label|
|--|-----|
|1|architecte|
|2|inspecteur|

### Table de relation `hasJob`
|archid|jobid|from|to|
|------|-----|----|--|
|1|1|1881|1884|
|1|2|1872|1884|
|2|2|1881|1905|
|3|1|1848|1875|
|3|2|1875|1879|
|4|2|1853|1856|

# Des notices à la base
* nom
* prénom
* date de naissance
* date de mort
* département de naissance
* lieu de mort
* formation aux beaux-arts
* année de promotion aux beaux-arts
* autre(s) formation(s)
* domaine(s) de compétence (cathédrale|séminaire|églises paroissiales|tout)
* appréciation de la hiérarchie en 1853
* milieu professionnel du père
* parenté avec un autre membre de la base
* poste(s) d’architecte diocésain
  * attributions (architecte|inspecteur|suppléant|honoraire)
  * date de début (unique)
  * date de fin (unique)
  * diocèse (unique)
* chantier(s)

# Modèle entité-association – Exercice
À partir de ces entrées de notice, définir :
* les **entités** de notre base prosopographique ;
* les **attributs** des entités ;
* les **clés primaires** (comment “identifier” chaque individu des entités ?) ;
* les **types** des différents attributs ([voir la doc](http://www.sqlite.org/datatype3.html#section_2_2)) ;
* les **associations** (une liaison qui a une signification précise entre deux entités) ;
* les **cardinalités** (0,1) à (1,n) ;
* les **#clés étrangères** (comment référencer la colonne d’une autre table ?) ;
* bref, définir le **schéma** de notre base de données prosopographique !
