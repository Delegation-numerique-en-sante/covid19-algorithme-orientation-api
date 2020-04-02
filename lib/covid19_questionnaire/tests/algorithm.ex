defmodule Covid19Questionnaire.Tests.Algorithm do
  @moduledoc """
  Crée l'algorithme d'orientation du Covid-19.
  """

  import Covid19Questionnaire.Tests.{Codes, Conditions}

  @type tree :: module
  @type trees() :: [struct] | []

  @spec call(tree) :: trees

  def call(module) do
    [
      struct(module, key: &fin1/0, operation: &age_less_15/1),
      struct(module, key: &fin5/0, operation: &(facteurs_gravite_majeurs(&1) >= 1)),
      struct(module,
        operation: &symptomes1/1,
        children: [
          struct(module, key: &fin6/0, operation: &(facteurs_pronostique(&1) == 0)),
          struct(module,
            operation: &(facteurs_pronostique(&1) >= 1),
            children: [
              struct(module, key: &fin6/0, operation: &(facteurs_gravite_mineurs(&1) < 2)),
              struct(module, key: &fin4/0, operation: &(facteurs_gravite_mineurs(&1) >= 2))
            ]
          )
        ]
      ),
      struct(module,
        operation: &symptomes2/1,
        children: [
          struct(module,
            operation: &(facteurs_pronostique(&1) == 0),
            children: [
              struct(module,
                operation: &(facteurs_gravite_mineurs(&1) == 0),
                children: [
                  struct(module, key: &fin2/0, operation: &age_less_50/1),
                  struct(module, key: &fin3/0, operation: &age_more_50/1)
                ]
              ),
              struct(module, key: &fin3/0, operation: &(facteurs_gravite_mineurs(&1) >= 1))
            ]
          ),
          struct(module,
            operation: &(facteurs_pronostique(&1) >= 1),
            children: [
              struct(module, key: &fin3/0, operation: &(facteurs_gravite_mineurs(&1) < 2)),
              struct(module, key: &fin4/0, operation: &(facteurs_gravite_mineurs(&1) >= 2))
            ]
          )
        ]
      ),
      struct(module,
        operation: &symptomes3/1,
        children: [
          struct(module, key: &fin2/0, operation: &(facteurs_pronostique(&1) == 0)),
          struct(module, key: &fin7/0, operation: &(facteurs_pronostique(&1) >= 1))
        ]
      ),
      struct(module, key: &fin9/0, operation: &symptomes4/1)
    ]
  end
end
