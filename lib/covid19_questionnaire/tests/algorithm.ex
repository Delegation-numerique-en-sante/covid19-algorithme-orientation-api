defmodule Covid19Questionnaire.Tests.Algorithm do
  @moduledoc """
  Crée l'algorithme d'orientation du COVID19.
  """

  import Covid19Questionnaire.Tests.{Codes, Conditions}

  @type tree :: module
  @type trees() :: [struct] | []

  @spec call(tree) :: trees

  def call(module) do
    [
      struct(module, key: &orientation_moins_de_15_ans/0, operation: &age_less_15/1),
      struct(module, key: &orientation_SAMU/0, operation: &(gravity_factors_major(&1) >= 1)),
      struct(module,
        operation: &symptoms1/1,
        children: [
          struct(module,
            key: &orientation_consultation_surveillance_3/0,
            operation: &(risk_factors(&1) == 0)
          ),
          struct(module,
            operation: &(risk_factors(&1) >= 1),
            children: [
              struct(module,
                key: &orientation_consultation_surveillance_3/0,
                operation: &(gravity_factors_minor(&1) < 2)
              ),
              struct(module,
                key: &orientation_consultation_surveillance_2/0,
                operation: &(gravity_factors_minor(&1) >= 2)
              )
            ]
          )
        ]
      ),
      struct(module,
        operation: &symptoms2/1,
        children: [
          struct(module,
            operation: &(risk_factors(&1) == 0),
            children: [
              struct(module,
                operation: &(gravity_factors_minor(&1) == 0),
                children: [
                  struct(module,
                    key: &orientation_domicile_surveillance_1/0,
                    operation: &age_less_50/1
                  ),
                  struct(module,
                    key: &orientation_consultation_surveillance_1/0,
                    operation: &age_more_50/1
                  )
                ]
              ),
              struct(module,
                key: &orientation_consultation_surveillance_1/0,
                operation: &(gravity_factors_minor(&1) >= 1)
              )
            ]
          ),
          struct(module,
            operation: &(risk_factors(&1) >= 1),
            children: [
              struct(module,
                key: &orientation_consultation_surveillance_1/0,
                operation: &(gravity_factors_minor(&1) < 2)
              ),
              struct(module,
                key: &orientation_consultation_surveillance_2/0,
                operation: &(gravity_factors_minor(&1) >= 2)
              )
            ]
          )
        ]
      ),
      struct(module,
        operation: &symptoms3/1,
        children: [
          struct(module,
            key: &orientation_domicile_surveillance_1/0,
            operation: &(risk_factors(&1) == 0)
          ),
          struct(module,
            key: &orientation_consultation_surveillance_4/0,
            operation: &(risk_factors(&1) >= 1)
          )
        ]
      ),
      struct(module, key: &orientation_surveillance/0, operation: &symptoms4/1)
    ]
  end
end
