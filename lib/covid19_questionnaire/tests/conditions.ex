defmodule Covid19Questionnaire.Tests.Conditions do
  @moduledoc """
  Conditions du test d'orientation du Covid-19.
  """

  @type symptomes :: struct
  @type pronostiques :: struct
  @type questionnaire :: %{
          :__struct__ => atom(),
          :symptomes => symptomes,
          :pronostiques => pronostiques,
          optional(atom()) => any()
        }

  @seuil_imc 30.0
  @seuil_fever 37.8
  @seuil_au_moins_39_de_temperature 39.0

  @spec symptomes1(questionnaire) :: boolean

  @doc """
  Fièvre ET toux.
  """
  def symptomes1(questionnaire = %{symptomes: %{cough: cough}}) do
    fever(questionnaire) && cough
  end

  @spec symptomes2(questionnaire) :: boolean

  @doc """
  Fièvre OU (pas de fièvre et (diarrhée OU (toux ET douleurs) OU (toux ET anosmie)).
  """
  def symptomes2(
        questionnaire = %{
          symptomes: %{
            cough: cough,
            sore_throat_aches: sore_throat_aches,
            agueusia_anosmia: agueusia_anosmia,
            diarrhea: diarrhea
          }
        }
      ) do
    fever(questionnaire) ||
      (!fever(questionnaire) &&
         (diarrhea || (cough && sore_throat_aches) || (cough && agueusia_anosmia)))
  end

  @doc """
  Toux OU douleurs OU anosmie.
  """
  @spec symptomes3(questionnaire) :: boolean

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
  @spec symptomes4(questionnaire) :: boolean

  def symptomes4(questionnaire), do: !symptomes3(questionnaire)

  ## Statistiques

  @spec age_less_15(questionnaire) :: boolean

  def age_less_15(%{patient: %{age_less_15: age_less_15}}), do: age_less_15

  @spec age_less_50(questionnaire) :: boolean

  def age_less_50(%{patient: %{age_less_50: age_less_50}}), do: age_less_50

  @spec age_more_50(questionnaire) :: boolean

  def age_more_50(questionnaire) do
    !age_less_50(questionnaire)
  end

  @spec au_moins_30_imc(questionnaire) :: boolean

  def au_moins_30_imc(%{patient: %{weight: nil}}), do: false

  def au_moins_30_imc(%{patient: %{height: nil}}), do: false

  def au_moins_30_imc(%{patient: %{weight: weight, height: height}}) do
    weight
    |> Kernel./(:math.pow(height / 100, 2))
    |> Kernel.>=(@seuil_imc)
  end

  @spec fever(questionnaire) :: boolean

  def fever(%{symptomes: %{temperature: nil}}), do: true

  def fever(%{symptomes: %{temperature: temperature}}) do
    temperature >= @seuil_fever
  end

  @spec au_moins_39_de_temperature(questionnaire) :: boolean

  def au_moins_39_de_temperature(%{symptomes: %{temperature: nil}}), do: false

  def au_moins_39_de_temperature(%{symptomes: %{temperature: temperature}}) do
    temperature >= @seuil_au_moins_39_de_temperature
  end

  @spec heart_disease(questionnaire) :: boolean

  def heart_disease(%{pronostiques: %{heart_disease: nil}}), do: true

  def heart_disease(%{pronostiques: %{heart_disease: heart_disease}}), do: heart_disease

  @doc """
  Facteurs de gravité mineurs + majeurs.
  """
  @spec facteurs_gravite(questionnaire) :: integer

  def facteurs_gravite(questionnaire) do
    facteurs_gravite_mineurs(questionnaire) + facteurs_gravite_majeurs(questionnaire)
  end

  @doc """
  Facteur de gravité mineurs.

  - Fièvre >= 39°C
  - Fatigue : alitement > 50% du temps diurne
  """
  @spec facteurs_gravite_mineurs(questionnaire) :: integer

  def facteurs_gravite_mineurs(questionnaire = %{symptomes: symptomes}) do
    symptomes
    |> Map.take([:tiredness])
    |> Map.put(:au_moins_39_de_temperature, au_moins_39_de_temperature(questionnaire))
    |> Enum.reduce(0, &count/2)
  end

  @doc """
  Facteur de gravité majeurs.

  - Gêne respiratoire
  - Difficultés importantes pour s’alimenter ou boire depuis plus de 24h
  """
  @spec facteurs_gravite_majeurs(questionnaire) :: integer

  def facteurs_gravite_majeurs(%{symptomes: symptomes}) do
    symptomes
    |> Map.take([:breathlessness, :feeding])
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
  @spec facteurs_pronostique(questionnaire) :: integer

  def facteurs_pronostique(
        questionnaire = %{patient: %{age_more_70: age_more_70}, pronostiques: pronostiques}
      ) do
    pronostiques
    |> Map.from_struct()
    |> Map.put(:age_more_70, age_more_70)
    |> Map.put(:au_moins_30_imc, au_moins_30_imc(questionnaire))
    |> Map.put(:heart_disease, heart_disease(questionnaire))
    |> Enum.reduce(0, &count/2)
  end

  defp count({_, element}, acc) do
    case element do
      true -> acc + 1
      _ -> acc
    end
  end
end
