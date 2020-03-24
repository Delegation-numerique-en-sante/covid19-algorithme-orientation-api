defmodule Covid19Orientation.TestOrientation do
  @moduledoc """
  Test d’orientation du Covid-19.
  """

  alias __MODULE__
  alias Covid19Orientation.{Tree, TreeTraversal}

  alias Covid19OrientationWeb.Schemas.{
    Conclusion,
    Orientation,
    Statistiques
  }

  @codes ~w|fin1 fin2 fin3 fin4 fin5 fin6 fin7 fin8 fin9|a

  @seuil_moins_de_15_ans 15
  @seuil_moins_de_50_ans 50
  @seuil_moins_de_70_ans 70
  @seuil_au_moins_70_ans 70
  @seuil_imc 30.0
  @seuil_fievre 37.8
  @seuil_au_moins_39_de_temperature 39.0

  ## Opérations

  @spec evaluate(%Orientation{}) :: %Orientation{}

  def evaluate(orientation = %Orientation{}) do
    arbre()
    |> TreeTraversal.flatten()
    |> TreeTraversal.traverse(orientation)
    |> case do
      {:ok, :done} -> {:ok, fin9(orientation) |> populate_statistiques()}
      {:ok, %{key: key}} -> {:ok, key.(orientation) |> populate_statistiques()}
    end
  end

  @spec populate_statistiques(%Orientation{}) :: %Orientation{}

  def populate_statistiques(orientation = %Orientation{}) do
    Map.put(
      orientation,
      :statistiques,
      %Statistiques{}
      |> Map.from_struct()
      |> Map.keys()
      |> Enum.reduce(%Statistiques{}, fn key, statistiques ->
        statistiques
        |> Map.put(key, apply(TestOrientation, key, [orientation]))
      end)
    )
  end

  ## Algorithme

  @doc """
  Arbre de décision de l'algorithme d'orientation du Covid-19.
  """
  @spec arbre() :: [Tree.t()]

  def arbre do
    [
      %Tree{key: &fin1/1, operation: &moins_de_15_ans/1},
      %Tree{
        operation: &symptomes1/1,
        children: [
          %Tree{
            operation: &(facteurs_pronostique(&1) == 0),
            children: [
              %Tree{
                operation: &(facteurs_gravite(&1) == 0),
                children: [
                  %Tree{key: &fin2/1, operation: &moins_de_50_ans(&1)},
                  %Tree{key: &fin3/1, operation: &entre_50_et_69_ans(&1)}
                ]
              },
              %Tree{key: &fin3/1, operation: &(facteurs_gravite_mineurs(&1) == 1)}
            ]
          },
          %Tree{
            operation: &(facteurs_pronostique(&1) >= 1),
            children: [
              %Tree{key: &fin3/1, operation: &(facteurs_gravite(&1) == 0)},
              %Tree{key: &fin3/1, operation: &(facteurs_gravite_mineurs(&1) == 1)},
              %Tree{key: &fin4/1, operation: &(facteurs_gravite_mineurs(&1) == 2)}
            ]
          },
          %Tree{key: &fin5/1, operation: &(facteurs_gravite_majeurs(&1) >= 1)}
        ]
      },
      %Tree{
        operation: &symptomes2/1,
        children: [
          %Tree{
            operation: &(facteurs_pronostique(&1) == 0),
            children: [
              %Tree{key: &fin6/1, operation: &(facteurs_gravite(&1) == 0)},
              %Tree{
                operation: &(facteurs_gravite_mineurs(&1) >= 1),
                children: [
                  %Tree{key: &fin6/1, operation: &(facteurs_gravite_majeurs(&1) == 0)}
                ]
              }
            ]
          },
          %Tree{
            operation: &(facteurs_pronostique(&1) >= 1),
            children: [
              %Tree{key: &fin6/1, operation: &(facteurs_gravite(&1) == 0)},
              %Tree{key: &fin6/1, operation: &(facteurs_gravite_mineurs(&1) == 1)},
              %Tree{key: &fin4/1, operation: &(facteurs_gravite_mineurs(&1) == 2)}
            ]
          },
          %Tree{key: &fin5/1, operation: &(facteurs_gravite_majeurs(&1) >= 1)}
        ]
      },
      %Tree{
        operation: &symptomes3/1,
        children: [
          %Tree{key: &fin7/1, operation: &(facteurs_gravite(&1) == 0)},
          %Tree{key: &fin8/1, operation: &(facteurs_gravite(&1) >= 1)},
          %Tree{key: &fin8/1, operation: &(facteurs_pronostique(&1) >= 1)}
        ]
      },
      %Tree{key: &fin9/1, operation: &symptomes4/1}
    ]
  end

  @spec symptomes1(%Orientation{}) :: boolean

  def symptomes1(
        orientation = %{
          symptomes: %{
            toux: toux,
            mal_de_gorge: mal_de_gorge,
            anosmie: anosmie,
            diarrhee: diarrhee
          }
        }
      ) do
    fievre(orientation) || (toux && mal_de_gorge) || (toux && anosmie) ||
      (fievre(orientation) && diarrhee)
  end

  @spec symptomes2(%Orientation{}) :: boolean

  def symptomes2(orientation = %{symptomes: %{toux: toux}}) do
    fievre(orientation) && toux
  end

  @spec symptomes3(%Orientation{}) :: boolean

  def symptomes3(%{symptomes: %{toux: toux, mal_de_gorge: mal_de_gorge, anosmie: anosmie}}) do
    [toux, mal_de_gorge, anosmie]
    |> Enum.filter(fn symptome -> symptome end)
    |> Enum.count()
    |> Kernel.==(1)
  end

  @spec symptomes4(%Orientation{}) :: boolean

  def symptomes4(orientation = %{symptomes: symptomes}) do
    symptomes
    |> Map.from_struct()
    |> Map.put(:fievre, fievre(orientation))
    |> Enum.reduce(0, &count/2)
    |> Kernel.==(0)
  end

  ## Statistiques

  @spec moins_de_15_ans(%Orientation{}) :: boolean

  def moins_de_15_ans(%Orientation{pronostiques: %{age: nil}}), do: false

  def moins_de_15_ans(%Orientation{pronostiques: %{age: age}}) do
    age < @seuil_moins_de_15_ans
  end

  @spec moins_de_50_ans(%Orientation{}) :: boolean

  def moins_de_50_ans(%Orientation{pronostiques: %{age: nil}}), do: false

  def moins_de_50_ans(%Orientation{pronostiques: %{age: age}}) do
    age < @seuil_moins_de_50_ans
  end

  @spec entre_50_et_69_ans(%Orientation{}) :: boolean

  def entre_50_et_69_ans(%Orientation{pronostiques: %{age: nil}}), do: false

  def entre_50_et_69_ans(%Orientation{pronostiques: %{age: age}}) do
    age >= @seuil_moins_de_50_ans && age < @seuil_moins_de_70_ans
  end

  @spec moins_de_70_ans(%Orientation{}) :: boolean

  def moins_de_70_ans(%Orientation{pronostiques: %{age: nil}}), do: false

  def moins_de_70_ans(%Orientation{pronostiques: %{age: age}}) do
    age < @seuil_moins_de_70_ans
  end

  @spec au_moins_70_ans(%Orientation{}) :: boolean

  def au_moins_70_ans(%Orientation{pronostiques: %{age: nil}}), do: false

  def au_moins_70_ans(%Orientation{pronostiques: %{age: age}}) do
    age >= @seuil_au_moins_70_ans
  end

  @spec au_moins_30_imc(%Orientation{}) :: boolean

  def au_moins_30_imc(%{pronostiques: %{poids: nil}}), do: false

  def au_moins_30_imc(%{pronostiques: %{taille: nil}}), do: false

  def au_moins_30_imc(%{pronostiques: %{poids: poids, taille: taille}}) do
    poids
    |> Kernel./(:math.pow(taille, 2))
    |> Kernel.>=(@seuil_imc)
  end

  @spec fievre(%Orientation{}) :: boolean

  def fievre(%{symptomes: %{temperature: nil}}), do: true

  def fievre(%{symptomes: %{temperature: temperature}}) do
    temperature >= @seuil_fievre
  end

  @spec au_moins_39_de_temperature(%Orientation{}) :: boolean

  def au_moins_39_de_temperature(%{symptomes: %{temperature: nil}}), do: false

  def au_moins_39_de_temperature(%{symptomes: %{temperature: temperature}}) do
    temperature >= @seuil_au_moins_39_de_temperature
  end

  @spec cardiaque(%Orientation{}) :: boolean

  def cardiaque(%{pronostiques: %{cardiaque: nil}}), do: true

  def cardiaque(%{pronostiques: %{cardiaque: cardiaque}}), do: cardiaque

  @doc """
  Facteurs de gravité mineurs + majeurs.
  """
  @spec facteurs_gravite(%Orientation{}) :: integer

  def facteurs_gravite(orientation = %Orientation{}) do
    facteurs_gravite_mineurs(orientation) + facteurs_gravite_majeurs(orientation)
  end

  @doc """
  Facteur de gravité mineurs.

  - Fièvre >= 39°C
  - Fatigue : alitement > 50% du temps diurne
  """
  @spec facteurs_gravite_mineurs(%Orientation{}) :: integer

  def facteurs_gravite_mineurs(orientation = %{symptomes: symptomes}) do
    symptomes
    |> Map.take([:fatigue])
    |> Map.put(:au_moins_39_de_temperature, au_moins_39_de_temperature(orientation))
    |> Enum.reduce(0, &count/2)
  end

  @doc """
  Facteur de gravité majeurs.

  - Gêne respiratoire
  - Difficultés importantes pour s’alimenter ou boire depuis plus de 24h
  """
  @spec facteurs_gravite_majeurs(%Orientation{}) :: integer

  def facteurs_gravite_majeurs(%{symptomes: symptomes}) do
    symptomes
    |> Map.take([:essoufle, :diffs_alim_boire])
    |> Enum.reduce(0, &count/2)
  end

  @doc """
  Facteurs pronostique défavorable lié au terrain.

  - Si son âge est supérieur ou égal à 70 ans
  - Si son indice de masse corporelle est supérieur à 30 kg/m²
  - Si OUI ou Ne sait pas à la question sur l’hypertension / cardiaque
  - Si OUI pour diabétique
  - Si OUI pour a ou a eu un cancer
  - Si OUI pour maladie respiratoire ou suivi pneumologique
  - Si OUI pour insuffisance rénale
  - Si OUI pour maladie chronique du foie
  - Si OUI pour enceinte
  - Si OUI pour maladie qui diminue les défenses immunitaires
  - Si OUI pour traitement immunosuppresseur
  """
  @spec facteurs_pronostique(%Orientation{}) :: integer

  def facteurs_pronostique(orientation = %{pronostiques: pronostiques}) do
    pronostiques
    |> Map.from_struct()
    |> Map.put(:au_moins_70_ans, au_moins_70_ans(orientation))
    |> Map.put(:au_moins_30_imc, au_moins_30_imc(orientation))
    |> Map.put(:cardiaque, cardiaque(orientation))
    |> Enum.reduce(0, &count/2)
  end

  defp count({_, element}, acc) do
    case element do
      true -> acc + 1
      _ -> acc
    end
  end

  ## Conclusions possibles

  @codes
  |> Enum.each(fn function ->
    @spec unquote(function)(%Orientation{}) :: %Orientation{}
    def unquote(function)(orientation = %Orientation{}) do
      %{
        orientation
        | conclusion: %Conclusion{code: unquote(function) |> Atom.to_string() |> String.upcase()}
      }
    end
  end)
end
