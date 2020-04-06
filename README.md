# Covid19-Algorithme-Questionnaire

## Introduction

Covid19-Questionnaire est une implémentation en Elixir de l'[algorithme d'orientation du COVID19](https://github.com/Delegation-numerique-en-sante/covid19-algorithme-questionnaire) officiellement publié par le ministère des Solidarités et de la Santé.

L'algorithme est défini par un comité scientifique, appelé CovidTélé, réunissant des médecins et co-piloté par l'AP-HP et l'Institut Pasteur.

Afin que toutes les initiatives qui participent à la gestion de la crise sanitaire s'appuient sur les mêmes recommendations, le ministère des Solidarités et de la Santé conseille la réutilisation de cet algorithme.

## Ce que contient ce dépôt

- une implémentation de l'algorithme
- une API Web
- le schéma de données en format OpenAPI 3.0 (OAS 3.0)

## Installation

Ce paquet requiert Erlang et Elixir.

Plateformes supportées :

- distributions GNU/Linux (en particulier Debian and Ubuntu)
- Mac OS X

Nous recommandons l'utilisation de Kerl pour Erlang et Kiex pour Elixir.

Une fois installés :

```sh
git clone git@github.com:Delegation-numerique-en-sante/covid19-algorithme-questionnaire-elixir.git
cd covid19-algorithme-questionnaire-elixir
make install
```

## Pour lancer l'API

```sh
make serve
```

Visitez http://localhost:4000/openapi pour avoir le json brut

Visitez http://localhost:4000/swagger pour Swagger

## Lancer les tests

```sh
make test
```

## Générer le fichier de spécification OpenAPI 3.0

```sh
make gen-spec
```

# Contribuer

Les contributions sont les bienvenues, sous forme d'/issues/ ou de /pull
requests/.

# Licence

2020 Délégation ministérielle du numérique en santé et les contributeurs du dépôt.

Le code source de cette application est publié sous licence MIT.
