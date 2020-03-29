defmodule Covid19Orientation.Tests.Algorithme do
  @moduledoc """
  Algorithme d'orientation du Covid-19.
  """

  alias Covid19Orientation.Tests.Test

  @type tree :: module
  @type trees() :: [struct] | []

  @spec call(tree) :: trees

  def call(module) do
    [
      struct(module, key: &Test.fin1/1, operation: &Test.moins_de_15_ans/1),
      struct(module,
        operation: &Test.symptomes1/1,
        children: [
          struct(module, key: &Test.fin5/1, operation: &(Test.facteurs_gravite_majeurs(&1) >= 1)),
          struct(module,
            operation: &(Test.facteurs_pronostique(&1) >= 1),
            children: [
              struct(module,
                key: &Test.fin4/1,
                operation: &(Test.facteurs_gravite_mineurs(&1) == 2)
              ),
              struct(module,
                key: &Test.fin3/1,
                operation: &(Test.facteurs_gravite_mineurs(&1) == 1)
              ),
              struct(module, key: &Test.fin3/1, operation: &(Test.facteurs_gravite(&1) == 0))
            ]
          ),
          struct(module,
            operation: &(Test.facteurs_pronostique(&1) == 0),
            children: [
              struct(module,
                key: &Test.fin3/1,
                operation: &(Test.facteurs_gravite_mineurs(&1) == 1)
              ),
              struct(module,
                operation: &(Test.facteurs_gravite(&1) == 0),
                children: [
                  struct(module, key: &Test.fin3/1, operation: &Test.entre_50_et_69_ans(&1)),
                  struct(module, key: &Test.fin2/1, operation: &Test.moins_de_50_ans(&1))
                ]
              )
            ]
          )
        ]
      ),
      struct(module,
        operation: &Test.symptomes2/1,
        children: [
          struct(module, key: &Test.fin5/1, operation: &(Test.facteurs_gravite_majeurs(&1) >= 1)),
          struct(module,
            operation: &(Test.facteurs_pronostique(&1) >= 1),
            children: [
              struct(module,
                key: &Test.fin4/1,
                operation: &(Test.facteurs_gravite_mineurs(&1) == 2)
              ),
              struct(module,
                key: &Test.fin6/1,
                operation: &(Test.facteurs_gravite_mineurs(&1) == 1)
              ),
              struct(module, key: &Test.fin6/1, operation: &(Test.facteurs_gravite(&1) == 0))
            ]
          ),
          struct(module,
            operation: &(Test.facteurs_pronostique(&1) == 0),
            children: [
              struct(module,
                operation: &(Test.facteurs_gravite_mineurs(&1) >= 1),
                children: [
                  struct(module,
                    key: &Test.fin6/1,
                    operation: &(Test.facteurs_gravite_majeurs(&1) == 0)
                  )
                ]
              ),
              struct(module, key: &Test.fin6/1, operation: &(Test.facteurs_gravite(&1) == 0))
            ]
          )
        ]
      ),
      struct(module,
        operation: &Test.symptomes3/1,
        children: [
          struct(module, key: &Test.fin8/1, operation: &(Test.facteurs_pronostique(&1) >= 1)),
          struct(module, key: &Test.fin8/1, operation: &(Test.facteurs_gravite(&1) >= 1)),
          struct(module, key: &Test.fin7/1, operation: &(Test.facteurs_gravite(&1) == 0))
        ]
      )
    ]
  end
end
