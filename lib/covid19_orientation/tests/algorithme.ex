defmodule Covid19Orientation.Tests.Algorithme do
  @moduledoc """
  Crée l'algorithme d'orientation du Covid-19.
  """

  alias Covid19Orientation.Tests.{Codes, Conditions}

  @type tree :: module
  @type trees() :: [struct] | []

  @spec call(tree) :: trees

  def call(module) do
    [
      struct(module, key: &Codes.fin1/0, operation: &Conditions.moins_de_15_ans/1),
      struct(module,
        operation: &Conditions.symptomes1/1,
        children: [
          struct(module,
            key: &Codes.fin5/0,
            operation: &(Conditions.facteurs_gravite_majeurs(&1) >= 1)
          ),
          struct(module,
            operation: &(Conditions.facteurs_pronostique(&1) >= 1),
            children: [
              struct(module,
                key: &Codes.fin4/0,
                operation: &(Conditions.facteurs_gravite_mineurs(&1) == 2)
              ),
              struct(module,
                key: &Codes.fin3/0,
                operation: &(Conditions.facteurs_gravite_mineurs(&1) == 1)
              ),
              struct(module,
                key: &Codes.fin3/0,
                operation: &(Conditions.facteurs_gravite(&1) == 0)
              )
            ]
          ),
          struct(module,
            operation: &(Conditions.facteurs_pronostique(&1) == 0),
            children: [
              struct(module,
                key: &Codes.fin3/0,
                operation: &(Conditions.facteurs_gravite_mineurs(&1) == 1)
              ),
              struct(module,
                operation: &(Conditions.facteurs_gravite(&1) == 0),
                children: [
                  struct(module, key: &Codes.fin3/0, operation: &Conditions.entre_50_et_69_ans(&1)),
                  struct(module, key: &Codes.fin2/0, operation: &Conditions.moins_de_50_ans(&1))
                ]
              )
            ]
          )
        ]
      ),
      struct(module,
        operation: &Conditions.symptomes2/1,
        children: [
          struct(module,
            key: &Codes.fin5/0,
            operation: &(Conditions.facteurs_gravite_majeurs(&1) >= 1)
          ),
          struct(module,
            operation: &(Conditions.facteurs_pronostique(&1) >= 1),
            children: [
              struct(module,
                key: &Codes.fin4/0,
                operation: &(Conditions.facteurs_gravite_mineurs(&1) == 2)
              ),
              struct(module,
                key: &Codes.fin6/0,
                operation: &(Conditions.facteurs_gravite_mineurs(&1) == 1)
              ),
              struct(module,
                key: &Codes.fin6/0,
                operation: &(Conditions.facteurs_gravite(&1) == 0)
              )
            ]
          ),
          struct(module,
            operation: &(Conditions.facteurs_pronostique(&1) == 0),
            children: [
              struct(module,
                operation: &(Conditions.facteurs_gravite_mineurs(&1) >= 1),
                children: [
                  struct(module,
                    key: &Codes.fin6/0,
                    operation: &(Conditions.facteurs_gravite_majeurs(&1) == 0)
                  )
                ]
              ),
              struct(module,
                key: &Codes.fin6/0,
                operation: &(Conditions.facteurs_gravite(&1) == 0)
              )
            ]
          )
        ]
      ),
      struct(module,
        operation: &Conditions.symptomes3/1,
        children: [
          struct(module,
            key: &Codes.fin8/0,
            operation: &(Conditions.facteurs_pronostique(&1) >= 1)
          ),
          struct(module, key: &Codes.fin8/0, operation: &(Conditions.facteurs_gravite(&1) >= 1)),
          struct(module, key: &Codes.fin7/0, operation: &(Conditions.facteurs_gravite(&1) == 0))
        ]
      ),
      struct(module, key: &Codes.fin9/0, operation: &(!!&1))
    ]
  end
end
