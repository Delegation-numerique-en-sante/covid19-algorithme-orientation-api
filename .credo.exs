%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["config/", "lib/", "test/"],
        excluded: []
      },
      checks: [
        {Credo.Check.Refactor.MapInto, false},
        {Credo.Check.Warning.LazyLogging, false}
      ]
    }
  ]
}
