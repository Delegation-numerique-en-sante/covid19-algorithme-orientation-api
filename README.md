# Covid19-Orientation

## Introduction

Covid19-Orientation est une implémentation en Elixir/Phoenix de l'[algorithme d'orientation du Covid-19](https://github.com/Delegation-numerique-en-sante/covid19-algorithme-orientation).

Ce paquet inclut :

- [l'implémentation de l'algorithme](https://github.com/Delegation-numerique-en-sante/covid-19-orientation-elixir/blob/master/lib/covid19_orientation/test_orientation.ex)
- [une API Web](https://github.com/Delegation-numerique-en-sante/covid-19-orientation-elixir/blob/master/test/covid19_orientation_web/controllers/orientation_controller/create_test.exs)
- [le schéma des données](https://github.com/Delegation-numerique-en-sante/covid-19-orientation-elixir/blob/master/openAPI.json)

## Installation

Ce paquet requiert Erlang et Elixir.

Plateformes supportées :

- distributions GNU/Linux (en particulier Debian and Ubuntu) ;
- Mac OS X ;

Nous recommandons l'utilisation de Kerl pour Erlang et Kiex pour Elixir.

Une fois installés :

```sh
git clone git@github.com:Delegation-numerique-en-sante/covid-19-orientation-elixir.git
cd covid19-orientation-elixir
mix deps.get
```

## Lancer l'API

```sh
mix phx.server
```

Visitez http://localhost:4000/openapi
Visitez http://localhost:4000/swagger

[Screenshot du Swagger](https://github.com/Delegation-numerique-en-sante/covid-19-orientation-elixir/blob/master/swagger.png)

## Générer le schéma de données OpenAPI

```sh
mix spec
```

## Lancer les test

```sh
mix test
```

# Example d'appel à l'API

```sh
curl -X POST "http://localhost:4000/orientation" -H "accept: application/json" -H "Content-Type: application/json" -H "x-csrf-token: LzNwkByMKJyAPKWkwblAFDipbWjQAIl1gkAhngbceq-iXhUvH4ngM" -d "{\"orientation\":{\"pronostiques\":{\"age\":70,\"cancer\":true,\"cardiaque\":true,\"diabetique\":true,\"enceinte\":true,\"immunodeprime\":true,\"insuffisance_renale\":true,\"maladie_chronique_foie\":true,\"poids\":65.5,\"respiratoire\":true,\"taille\":1.73,\"traitement_immunosuppresseur\":true},\"supplementaires\":{\"code_postal\":\"75000\"},\"symptomes\":{\"anosmie\":true,\"diarrhee\":true,\"diffs_alim_boire\":true,\"essoufle\":true,\"fatigue\":true,\"mal_de_gorge\":true,\"temperature\":37.5,\"toux\":true}}}" | jq "."

...

{
  "data": {
    "conclusion": {
      "code": "FIN3"
    },
    "pronostiques": {
      "age": 70,
      "cancer": true,
      "cardiaque": true,
      "diabetique": true,
      "enceinte": true,
      "immunodeprime": true,
      "insuffisance_renale": true,
      "maladie_chronique_foie": true,
      "poids": 65.5,
      "respiratoire": true,
      "taille": 1.73,
      "traitement_immunosuppresseur": true
    },
    "statistiques": {
      "au_moins_30_imc": false,
      "au_moins_39_de_temperature": false,
      "au_moins_70_ans": true,
      "cardiaque": true,
      "entre_50_et_69_ans": false,
      "facteurs_gravite": 3,
      "facteurs_gravite_majeurs": 2,
      "facteurs_gravite_mineurs": 1,
      "facteurs_pronostique": 10,
      "fievre": false,
      "moins_de_15_ans": false,
      "moins_de_50_ans": false,
      "moins_de_70_ans": false
    },
    "supplementaires": {
      "code_postal": "75000"
    },
    "symptomes": {
      "anosmie": true,
      "diarrhee": true,
      "diffs_alim_boire": true,
      "essoufle": true,
      "fatigue": true,
      "mal_de_gorge": true,
      "temperature": 37.5,
      "toux": true
    }
  }
}
```

# Contribution

N'hésitez pas à ouvrir une issue ou à proposer une pull request.

# Licence

AGPL-3.0
