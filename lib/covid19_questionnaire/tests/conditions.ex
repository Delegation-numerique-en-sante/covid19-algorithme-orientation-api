defmodule Covid19Questionnaire.Tests.Conditions do
  @moduledoc """
  Conditions du test d'orientation du COVID19.
  """

  @type symptoms :: struct
  @type risk_factors :: struct
  @type questionnaire :: %{
          :__struct__ => atom(),
          :symptoms => symptoms,
          :risk_factors => risk_factors,
          optional(atom()) => any()
        }

  @age_15_threshold "inf_15"
  @age_50_threshold ["from_15_to_49" | [@age_15_threshold]]
  @age_70_threshold ["from_50_to_69" | @age_50_threshold]
  @bmi_threshold 30.0
  @temperature_more_39 "sup_39"
  @fever_threshold ["37.7-38.9", "NSP" | [@temperature_more_39]]
  @pregnant 1

  @spec symptoms1(questionnaire) :: boolean

  @doc """
  Fièvre ET toux.
  """
  def symptoms1(questionnaire = %{symptoms: %{cough: cough}}) do
    fever(questionnaire) && cough
  end

  @spec symptoms2(questionnaire) :: boolean

  @doc """
  Fièvre OU (pas de fièvre et (diarrhée OU (toux ET douleurs) OU (toux ET anosmie)).
  """
  def symptoms2(
        questionnaire = %{
          symptoms: %{
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
  @spec symptoms3(questionnaire) :: boolean

  def symptoms3(%{
        symptoms: %{
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
  @spec symptoms4(questionnaire) :: boolean

  def symptoms4(questionnaire), do: !symptoms3(questionnaire)

  ## Statistiques

  @spec age_less_15(questionnaire) :: boolean

  def age_less_15(%{patient: %{age_range: nil}}), do: false

  def age_less_15(%{patient: %{age_range: age_range}}), do: age_range == @age_15_threshold

  @spec age_less_50(questionnaire) :: boolean

  def age_less_50(%{patient: %{age_range: nil}}), do: false

  def age_less_50(%{patient: %{age_range: age_range}}), do: age_range in @age_50_threshold

  @spec age_more_50(questionnaire) :: boolean

  def age_more_50(%{patient: %{age_range: nil}}), do: false

  def age_more_50(questionnaire), do: !age_less_50(questionnaire)

  @spec age_less_70(questionnaire) :: boolean

  def age_less_70(%{patient: %{age_range: nil}}), do: false

  def age_less_70(%{patient: %{age_range: age_range}}), do: age_range in @age_70_threshold

  @spec age_more_70(questionnaire) :: boolean

  def age_more_70(%{patient: %{age_range: nil}}), do: false

  def age_more_70(questionnaire), do: !age_less_70(questionnaire)

  @spec bmi_more_30(questionnaire) :: boolean

  def bmi_more_30(%{patient: %{weight: nil}}), do: false

  def bmi_more_30(%{patient: %{height: nil}}), do: false

  def bmi_more_30(questionnaire) do
    bmi(questionnaire) >= @bmi_threshold
  end

  @spec bmi(questionnaire) :: float

  def bmi(%{patient: %{weight: nil}}), do: nil

  def bmi(%{patient: %{height: nil}}), do: nil

  def bmi(%{patient: %{weight: weight, height: height}}) do
    weight
    |> Kernel./(:math.pow(height / 100, 2))
    |> Float.round(1)
  end

  @spec imc(questionnaire) :: float

  def imc(questionnaire), do: bmi(questionnaire)

  @spec fever(questionnaire) :: boolean

  def fever(%{symptoms: %{temperature_cat: nil}}), do: false

  def fever(%{symptoms: %{temperature_cat: temperature_cat}}) do
    temperature_cat in @fever_threshold
  end

  @spec temperature_more_39(questionnaire) :: boolean

  def temperature_more_39(%{symptoms: %{temperature_cat: nil}}), do: false

  def temperature_more_39(%{symptoms: %{temperature_cat: temperature}}) do
    temperature == @temperature_more_39
  end

  @spec pregnant(questionnaire) :: boolean

  def pregnant(%{risk_factors: %{pregnant: nil}}), do: false

  def pregnant(%{risk_factors: %{pregnant: pregnant}}) do
    pregnant == @pregnant
  end

  @doc """
  Facteurs de gravité mineurs + majeurs.
  """
  @spec gravity_factors(questionnaire) :: integer

  def gravity_factors(questionnaire) do
    gravity_factors_minor(questionnaire) + gravity_factors_major(questionnaire)
  end

  @doc """
  Facteur de gravité mineurs.

  - Fièvre >= 39°C
  - Fatigue : alitement > 50% du temps diurne
  """
  @spec gravity_factors_minor(questionnaire) :: integer

  def gravity_factors_minor(questionnaire = %{symptoms: symptoms}) do
    symptoms
    |> Map.take([:tiredness_details])
    |> Map.put(:temperature_more_39, temperature_more_39(questionnaire))
    |> Enum.reduce(0, &count/2)
  end

  @doc """
  Facteur de gravité majeurs.

  - Gêne respiratoire
  - Difficultés importantes pour s’alimenter ou boire depuis plus de 24h
  """
  @spec gravity_factors_major(questionnaire) :: integer

  def gravity_factors_major(%{symptoms: symptoms}) do
    symptoms
    |> Map.take([:breathlessness, :feeding_day])
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
  @spec risk_factors(questionnaire) :: integer

  def risk_factors(questionnaire = %{risk_factors: risk_factors}) do
    risk_factors
    |> Map.from_struct()
    |> Map.put(:age_more_70, age_more_70(questionnaire))
    |> Map.put(:bmi_more_30, bmi_more_30(questionnaire))
    |> Map.put(:pregnant, pregnant(questionnaire))
    |> Map.delete(:pregnant)
    |> Enum.reduce(0, &count/2)
  end

  defp count({_, element}, acc) do
    case element do
      true -> acc + 1
      _ -> acc
    end
  end
end
