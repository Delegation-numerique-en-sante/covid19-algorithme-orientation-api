defmodule Covid19Questionnaire.Tests.Conditions do
  @moduledoc """
  Conditions du test d'orientation du COVID19.
  """

  @type respondent :: struct
  @type symptoms :: struct
  @type risk_factors :: struct
  @type questionnaire :: %{respondent: respondent, symptoms: symptoms, risk_factors: risk_factors}

  ## Age range

  @spec age_less_15(questionnaire) :: boolean
  def age_less_15(%{respondent: %{age_range: "inf_15"}}), do: true
  def age_less_15(%{respondent: %{age_range: _age_range}}), do: false

  @spec age_less_50(questionnaire) :: boolean
  def age_less_50(%{respondent: %{age_range: "from_15_to_49"}}), do: true
  def age_less_50(%{respondent: %{age_range: "inf_15"}}), do: true
  def age_less_50(%{respondent: %{age_range: _age_range}}), do: false

  @spec age_less_70(questionnaire) :: boolean
  def age_less_70(%{respondent: %{age_range: "from_50_to_69"}}), do: true
  def age_less_70(%{respondent: %{age_range: "from_15_to_49"}}), do: true
  def age_less_70(%{respondent: %{age_range: "inf_15"}}), do: true
  def age_less_70(%{respondent: %{age_range: _age_range}}), do: false

  @spec age_more_15(questionnaire) :: boolean
  def age_more_15(%{respondent: %{age_range: "from_15_to_49"}}), do: true
  def age_more_15(%{respondent: %{age_range: "from_50_to_69"}}), do: true
  def age_more_15(%{respondent: %{age_range: "sup_70"}}), do: true
  def age_more_15(%{respondent: %{age_range: _age_range}}), do: false

  @spec age_more_50(questionnaire) :: boolean
  def age_more_50(%{respondent: %{age_range: "from_50_to_69"}}), do: true
  def age_more_50(%{respondent: %{age_range: "sup_70"}}), do: true
  def age_more_50(%{respondent: %{age_range: _age_range}}), do: false

  @spec age_more_70(questionnaire) :: boolean
  def age_more_70(%{respondent: %{age_range: "sup_70"}}), do: true
  def age_more_70(%{respondent: %{age_range: _age_range}}), do: false

  ## BMI/IMC algo

  @spec bmi_less_30(questionnaire) :: boolean
  def bmi_less_30(%{respondent: %{weight: nil}}), do: false
  def bmi_less_30(%{respondent: %{height: nil}}), do: false
  def bmi_less_30(questionnaire), do: bmi(questionnaire) < 30

  @spec bmi_more_30(questionnaire) :: boolean
  def bmi_more_30(%{respondent: %{weight: nil}}), do: false
  def bmi_more_30(%{respondent: %{height: nil}}), do: false
  def bmi_more_30(questionnaire), do: bmi(questionnaire) >= 30

  @spec bmi(questionnaire) :: float
  def bmi(%{respondent: %{weight: nil}}), do: nil
  def bmi(%{respondent: %{height: nil}}), do: nil

  def bmi(%{respondent: %{weight: weight, height: height}}) do
    weight
    |> Kernel./(:math.pow(height / 100, 2))
    |> Float.round(1)
  end

  defdelegate imc(questionnaire), to: __MODULE__, as: :bmi
  defdelegate imc_algo(questionnaire), to: __MODULE__, as: :bmi
  defdelegate bmi_algo(questionnaire), to: __MODULE__, as: :bmi

  ## Fever algo

  @spec fever_algo(questionnaire) :: boolean
  def fever_algo(%{symptoms: %{fever: 0}}), do: false
  def fever_algo(%{symptoms: %{fever: 1, temperature_cat: "inf_35.5"}}), do: true
  def fever_algo(%{symptoms: %{fever: 1, temperature_cat: "sup_39"}}), do: true
  def fever_algo(%{symptoms: %{fever: 1, temperature_cat: "NSP"}}), do: true
  def fever_algo(%{symptoms: %{fever: 999}}), do: true
  def fever_algo(%{symptoms: %{fever: _, temperature_cat: _}}), do: false

  ## Heart disease algo

  @spec heart_disease_algo(questionnaire) :: boolean
  def heart_disease_algo(%{risk_factors: %{heart_disease: 999}}), do: true
  def heart_disease_algo(%{risk_factors: %{heart_disease: 1}}), do: true
  def heart_disease_algo(%{risk_factors: %{heart_disease: _}}), do: false

  ## Immunosuppressant disease algo

  @spec immunosuppressant_disease_algo(questionnaire) :: boolean
  def immunosuppressant_disease_algo(%{risk_factors: %{immunosuppressant_disease: 1}}), do: true
  def immunosuppressant_disease_algo(%{risk_factors: %{immunosuppressant_disease: _}}), do: false

  ## Immunosuppressant drug algo

  @spec immunosuppressant_drug_algo(questionnaire) :: boolean
  def immunosuppressant_drug_algo(%{risk_factors: %{immunosuppressant_drug: 1}}), do: true
  def immunosuppressant_drug_algo(%{risk_factors: %{immunosuppressant_drug: _}}), do: false

  ##  Pregnant algo

  @spec pregnant_algo(questionnaire) :: boolean
  def pregnant_algo(%{risk_factors: %{pregnant: 0}}), do: false
  def pregnant_algo(%{risk_factors: %{pregnant: 1}}), do: true
  def pregnant_algo(%{risk_factors: %{pregnant: _}}), do: false

  ## Symptoms

  @doc """
  Fièvre ET toux.
  """
  @spec symptoms1(questionnaire) :: boolean
  def symptoms1(questionnaire = %{symptoms: %{cough: true}}), do: fever_algo(questionnaire)
  def symptoms1(_questionnaire), do: false

  @doc """
  Fièvre OU (pas de fièvre et (diarrhée OU (toux ET douleurs) OU (toux ET anosmie)).
  """
  @spec symptoms2(questionnaire) :: boolean

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
    fever_algo(questionnaire) ||
      (!fever_algo(questionnaire) &&
         (diarrhea || (cough && sore_throat_aches) || (cough && agueusia_anosmia)))
  end

  @doc """
  Toux OU douleurs OU anosmie.
  """
  @spec symptoms3(questionnaire) :: boolean
  def symptoms3(%{symptoms: %{cough: true}}), do: true
  def symptoms3(%{symptoms: %{sore_throat_aches: true}}), do: true
  def symptoms3(%{symptoms: %{agueusia_anosmia: true}}), do: true
  def symptoms3(_questionnaire), do: false

  @doc """
  NI toux NI douleurs NI anosmie.
  """
  @spec symptoms4(questionnaire) :: boolean
  def symptoms4(questionnaire), do: !symptoms3(questionnaire)

  ## Gravity factors

  @doc """
  Facteurs de gravité mineurs + majeurs.
  """
  @spec gravity_factors(questionnaire) :: integer

  def gravity_factors(questionnaire) do
    gravity_factors_minor(questionnaire) + gravity_factors_major(questionnaire)
  end

  @doc """
  Facteur de gravité mineurs.

  - Fièvre < 35,5°C
  - Fièvre >= 39°C
  - A indiqué de la fièvre sans renseigner de la température
  - Fatigue : alitement > 50% du temps diurne
  """
  @spec gravity_factors_minor(questionnaire) :: integer

  def gravity_factors_minor(questionnaire = %{symptoms: symptoms}) do
    symptoms
    |> Map.take([:tiredness_details])
    |> Map.put(:fever_algo, fever_algo(questionnaire))
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

  ## Risk factors

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
    |> Map.take([:breathing_disease, :kidney_disease, :liver_disease, :diabetes, :cancer])
    |> Map.put(:age_more_70, age_more_70(questionnaire))
    |> Map.put(:bmi_more_30, bmi_more_30(questionnaire))
    |> Map.put(:pregnant_algo, pregnant_algo(questionnaire))
    |> Map.put(:heart_disease_algo, heart_disease_algo(questionnaire))
    |> Map.put(:immunosuppressant_disease_algo, immunosuppressant_disease_algo(questionnaire))
    |> Map.put(:immunosuppressant_drug_algo, immunosuppressant_drug_algo(questionnaire))
    |> Enum.reduce(0, &count/2)
  end

  defp count({_, element}, acc) do
    case element do
      true -> acc + 1
      _ -> acc
    end
  end
end
