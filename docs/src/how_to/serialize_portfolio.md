```@meta
CurrentModule = PowerSystemsInvestmentsPortfolios
```

# Save and Load a Portfolio

PSIP uses InfrastructureSystems serialization to persist a `Portfolio` — including all components, time series, and metadata — to disk and restore it in a later session.

## Save

Pass a file path (without extension) to `to_json`. PSIP writes three files automatically:

```julia
using PowerSystemsInvestmentsPortfolios

to_json(portfolio, "data/my_portfolio")
```

The three output files are:

  - `data/my_portfolio.json` — component data and portfolio metadata
  - `data/my_portfolio_validation.json` — component validation rules
  - `data/my_portfolio_time_series.h5` — time series arrays (HDF5 format)

All three files are required to reload the portfolio; keep them together in the same directory.

## Load

Pass the path to the `.json` file (with or without the `.json` extension) to the `Portfolio` constructor:

```julia
portfolio = Portfolio("data/my_portfolio.json")
```

## Load with fresh UUIDs

When you need to load a portfolio and then modify it — for example, to merge it with another portfolio or use it as a template — load it with new UUIDs so that component identifiers do not collide:

```julia
portfolio = Portfolio("data/my_portfolio.json"; assign_new_uuids=true)
```

This replaces every component UUID with a freshly generated value while leaving all other data intact.

## What is stored

  - **Component data** — all technologies, requirements, regions, and their field values
  - **Time series** — stored in HDF5 format; large arrays are not embedded in JSON
  - **Metadata** — portfolio name, description, and user-defined key-value pairs
  - **Validation rules** — field-level constraints used when components are loaded back

## See also

  - [`to_json`](@ref)
  - [`Portfolio`](@ref)
