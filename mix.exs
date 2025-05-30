defmodule App.MixProject do
  use Mix.Project

  def project do
    [
      app: :app,
      version: "1.7.0",
      elixir: "~> 1.17",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        c: :test,
        coveralls: :test,
        "coveralls.json": :test,
        "coveralls.html": :test,
        t: :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {App.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.7.17"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.6"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 4.0"},
      {:phoenix_html_helpers, "~> 1.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 1.0.0"},
      {:phoenix_view, "~> 2.0"},
      {:floki, ">= 0.30.0", only: :test},
      {:esbuild, "~> 0.4", runtime: Mix.env() == :dev},
      {:telemetry_metrics, "~> 1.0"},
      {:telemetry_poller, "~> 1.0"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},

      # Check/get Environment Variables: https://github.com/dwyl/envar
      {:envar, "~> 1.0.8"},
      # Auth with ONE Environment Variable™: github.com/dwyl/auth_plug
      {:auth_plug, "~> 1.5.0"},
      # Easily Encrypt Senstive Data: github.com/dwyl/fields
      {:fields, "~> 2.10.3"},
      # Useful functions: github.com/dwyl/useful
      {:useful, "~> 1.15.0", override: true},

      # JSON Parsing: https://hex.pm/packages/poison
      {:poison, "~> 6.0.0"},

      # Extract image data: https://github.com/elixir-image/image/
      {:image, "~> 0.37"},

      # Create docs on localhost by running "mix docs"
      {:ex_doc, "~> 0.38.1", only: :dev, runtime: false},
      # Track test coverage
      {:excoveralls, "~> 0.18.0", only: [:test, :dev]},
      # git pre-commit hook runs tests before allowing commits
      {:pre_commit, "~> 0.3.4"},
      # Credo static analysis: https://github.com/rrrene/credo
      {:credo, "~> 1.7.0", only: [:dev, :test], runtime: false},

      # Ref: github.com/dwyl/learn-tailwind
      {:tailwind, "~> 0.3.1", runtime: Mix.env() == :dev},

      # Elixir GitHub REST API lib: github.com/edgurgel/tentacat
      {:tentacat, "~> 2.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      seeds: ["run priv/repo/seeds.exs"],
      setup: ["deps.get", "ecto.reset", "tailwind.install"],
      "ecto.setup": [
        "ecto.create --quiet",
        "ecto.migrate --quiet",
        "run priv/repo/seeds.exs"
      ],
      "ecto.reset": ["ecto.drop --quiet", "ecto.setup"],
      "assets.deploy": [
        "tailwind default --minify",
        "esbuild default --minify",
        "phx.digest"
      ],
      test: ["ecto.reset", "test"],
      t: ["test --trace"],
      c: ["coveralls.html --trace"],
      s: ["phx.server"]
    ]
  end
end
