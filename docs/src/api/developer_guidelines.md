```@meta
CurrentModule = PowerSystemsInvestmentsPortfolios
```

# Developer Guidelines

## Auto-generated files

The files under `src/models/generated/` are auto-generated from JSON descriptors. **Never edit them directly.** To add or modify a type:

1. Edit the corresponding JSON descriptor in `src/models/descriptors/`.
2. Run the struct generator:
   ```julia
   julia --project src/utils/generate_structs.jl
   ```
3. Review the generated file and commit both the descriptor and generated file.

If a new type needs custom serialization (e.g., a field that cannot round-trip through JSON automatically), add it to `PSIP_ENCODE_FIELDS` in `src/serialization.jl`.

## Adding a new Technology type

1. **Define the descriptor** in `src/models/descriptors/` following the existing pattern (see `SupplyTechnology.json` as a reference).
2. **Regenerate** with `generate_structs.jl`.
3. **Register serialization** if the type has encoded fields — add to `PSIP_ENCODE_FIELDS`.
4. **Add tests** in `test/` covering construction, `add_technology!`, `get_technology`, and round-trip serialization (`to_json` → `Portfolio(path)`).
5. **Add a model library page** in `docs/src/model_library/` and wire it into `docs/make.jl`.

## Coding style

Follow the [Sienna development conventions](https://sienna-platform.github.io/Sienna/SiennaDocs/docs/build/index.html):

- Do not use `isa` for type checks — use multiple dispatch instead.
- Do not access component fields with `.` notation — always use `get_*` accessor functions.
- Do not use ternary expressions in public-facing code.
- Keep functions short and single-purpose; prefer explicit over clever.

## Running tests

```bash
julia --project=test test/runtests.jl
```

The test suite uses `test/test_data/portfolio_5bus.jl` as the primary test portfolio fixture. When adding a new type, add a corresponding construction test in that fixture.

## OpenAPI models

PSIP includes OpenAPI-generated models under `src/models/generated/open_api_models/` for database serialization. These are also auto-generated — do not edit them directly. See `src/models/generated/open_api_models/README.md` for regeneration instructions.
