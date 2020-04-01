defmodule Covid19Orientation.Tests.Conditions do
  @moduledoc """
  Conditions du test d’orientation du Covid-19.
  """

  @type symptomes :: struct
  @type pronostiques :: struct
  @type orientation :: %{
          :__struct__ => atom(),
          :symptomes => symptomes,
          :pronostiques => pronostiques,
          optional(atom()) => any()
        }

  @seuil_moins_de_15_ans 15
  @seuil_moins_de_50_ans 50
  @seuil_moins_de_70_ans 70
  @seuil_imc 30.0
  @seuil_fievre 37.8
  @seuil_au_moins_39_de_temperature 39.0

  @spec symptomes1(orientation) :: boolean

  @doc """
  Fièvre ET toux.
  """
  def symptomes1(orientation = %{symptomes: %{cough: cough}}) do
    fievre(orientation) && cough
  end

  @spec symptomes2(orientation) :: boolean

  @doc """
  Fièvre OU (pas de fièvre et (diarrhée OU (toux ET douleurs) OU (toux ET anosmie)).
  """
  def symptomes2(
        orientation = %{
          symptomes: %{
            cough: cough,
            sore_throat_aches: sore_throat_aches,
            agueusia_anosmia: agueusia_anosmia,
            diarrhee: diarrhee
          }
        }
      ) do
    fievre(orientation) ||
      (!fievre(orientation) &&
         (diarrhee || (cough && sore_throat_aches) || (cough && agueusia_anosmia)))
  end

  @doc """
  Toux OU douleurs OU anosmie.
  """
  @spec symptomes3(orientation) :: boolean

  def symptomes3(%{
        symptomes: %{
          cough: cough,
          sore_throat_aches: sore_throat_aches,
          agueusia_anosmia: agueusia_anosmia
        }
      }) do
    cough || sore_throat_aches || agueusia_anosmia
  end

  @doc """
  NI toux NI douleurs NI anosmie.
  """
  @spec symptomes4(orientation) :: boolean

  def symptomes4(orientation), do: !symptomes3(orientation)

  ## Statistiques

  @spec moins_de_15_ans(orientation) :: boolean

  def moins_de_15_ans(%{pronostiques: %{age: nil}}), do: false

  def moins_de_15_ans(%{pronostiques: %{age: age}}) do
    age < @seuil_moins_de_15_ans
  end

  @spec moins_de_50_ans(orientation) :: boolean

  def moins_de_50_ans(%{pronostiques: %{age: nil}}), do: false

  def moins_de_50_ans(%{pronostiques: %{age: age}}) do
    age < @seuil_moins_de_50_ans
  end

  @spec au_moins_50_ans(orientation) :: boolean

  def au_moins_50_ans(%{pronostiques: %{age: nil}}), do: false

  def au_moins_50_ans(%{pronostiques: %{age: age}}) do
    age >= @seuil_moins_de_50_ans
  end

  @spec entre_50_et_69_ans(orientation) :: boolean

  def entre_50_et_69_ans(%{pronostiques: %{age: nil}}), do: false

  def entre_50_et_69_ans(%{pronostiques: %{age: age}}) do
    age >= @seuil_moins_de_50_ans && age < @seuil_moins_de_70_ans
  end

  @spec moins_de_70_ans(orientation) :: boolean

  def moins_de_70_ans(%{pronostiques: %{age: nil}}), do: false

  def moins_de_70_ans(%{pronostiques: %{age: age}}) do
    age < @seuil_moins_de_70_ans
  end

  @spec au_moins_70_ans(orientation) :: boolean

  def au_moins_70_ans(%{pronostiques: %{age: nil}}), do: false

  def au_moins_70_ans(%{pronostiques: %{age: age}}) do
    age >= @seuil_moins_de_70_ans
  end

  @spec au_moins_30_imc(orientation) :: boolean

  def au_moins_30_imc(%{pronostiques: %{poids: nil}}), do: false

  def au_moins_30_imc(%{pronostiques: %{taille: nil}}), do: false

  def au_moins_30_imc(%{pronostiques: %{poids: poids, taille: taille}}) do
    poids
    |> Kernel./(:math.pow(taille, 2))
    |> Kernel.>=(@seuil_imc)
  end

  @spec fievre(orientation) :: boolean

  def fievre(%{symptomes: %{temperature: nil}}), do: true

  def fievre(%{symptomes: %{temperature: temperature}}) do
    temperature >= @seuil_fievre
  end

  @spec au_moins_39_de_temperature(orientation) :: boolean

  def au_moins_39_de_temperature(%{symptomes: %{temperature: nil}}), do: false

  def au_moins_39_de_temperature(%{symptomes: %{temperature: temperature}}) do
    temperature >= @seuil_au_moins_39_de_temperature
  end

  @spec heart_disease(orientation) :: boolean

  def heart_disease(%{pronostiques: %{heart_disease: nil}}), do: true

  def heart_disease(%{pronostiques: %{heart_disease: heart_disease}}), do: heart_disease

  @doc """
  Facteurs de gravité mineurs + majeurs.
  """
  @spec facteurs_gravite(orientation) :: integer

  def facteurs_gravite(orientation) do
    facteurs_gravite_mineurs(orientation) + facteurs_gravite_majeurs(orientation)
  end

  @doc """
  Facteur de gravité mineurs.

  - Fièvre >= 39°C
  - Fatigue : alitement > 50% du temps diurne
  """
  @spec facteurs_gravite_mineurs(orientation) :: integer

  def facteurs_gravite_mineurs(orientation = %{symptomes: symptomes}) do
    symptomes
    |> Map.take([:tiredness])
    |> Map.put(:au_moins_39_de_temperature, au_moins_39_de_temperature(orientation))
    |> Enum.reduce(0, &count/2)
  end

  @doc """
  Facteur de gravité majeurs.

  - Gêne respiratoire
  - Difficultés importantes pour s’alimenter ou boire depuis plus de 24h
  """
  @spec facteurs_gravite_majeurs(orientation) :: integer

  def facteurs_gravite_majeurs(%{symptomes: symptomes}) do
    symptomes
    |> Map.take([:essoufle, :diffs_alim_boire])
    |> Enum.reduce(0, &count/2)
  end

  @doc """
  Facteurs pronostique défavorable lié au terrain.

  - Si son âge est supérieur ou égal à 70 ans
  - Si son indice de masse corporelle est supérieur à 30 kg/m²
  - Si OUI ou Ne sait pas à la question sur l’hypertension / heart_disease
  - Si OUI pour diabétique
  - Si OUI pour a ou a eu un cancer
  - Si OUI pour maladie respiratoire ou suivi pneumologique
  - Si OUI pour insuffisance rénale
  - Si OUI pour maladie chronique du foie
  - Si OUI pour enceinte
  - Si OUI pour maladie qui diminue les défenses immunitaires
  - Si OUI pour traitement immunosuppresseur
  """
  @spec facteurs_pronostique(orientation) :: integer

  def facteurs_pronostique(orientation = %{pronostiques: pronostiques}) do
    pronostiques
    |> Map.from_struct()
    |> Map.put(:au_moins_70_ans, au_moins_70_ans(orientation))
    |> Map.put(:au_moins_30_imc, au_moins_30_imc(orientation))
    |> Map.put(:heart_disease, heart_disease(orientation))
    |> Enum.reduce(0, &count/2)
  end

  defp count({_, element}, acc) do
    case element do
      true -> acc + 1
      _ -> acc
    end
  end
end
