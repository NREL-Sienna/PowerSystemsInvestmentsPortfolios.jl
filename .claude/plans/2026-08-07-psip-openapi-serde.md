# PSIP OpenAPI Serde Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make PowerSystemsInvestmentsPortfolios.jl consume the platform OpenAPI model packages and serialize through generated `from_openapi` / `to_openapi` converters shaped exactly like PowerSystems.jl's, with an id⇄UUID ledger on the Portfolio's `ext`.

**Architecture:** Three moves. (1) Delete PSIP's vendored `src/models/generated/open_api_models/` tree and depend on `PowerCoreOpenAPIModels` + `PowerInvestmentsOpenAPIModels` from the sibling `PowerOpenAPIModels` monorepo. (2) Replace the generator's `serialize_openapi_struct` / `deserialize_openapi_struct` emission with PSY's `from_openapi(::Type{X}, po, refs)` / `to_openapi(value::X, refs)` pair — same field-classification design, minus the `Val{:DEVICE_BASE}` / `Val{:NATURAL_UNITS}` axis, because PSIP has exactly one unit representation. (3) Add `OpenAPIRefs` (id⇄component registry for one conversion pass) and a `"_openapi_ledger"` entry in the Portfolio's `ext` holding id→UUID across passes, both ported from PSY.

**Tech Stack:** Julia 1.10+, InfrastructureSystems.jl (IS4 branch), PowerSystems.jl (psy6 branch), `PowerCoreOpenAPIModels` / `PowerInvestmentsOpenAPIModels` (path deps), OpenAPI.jl 0.2, Mustache.jl, Unitful.jl, ReTest.

---

## Global Constraints

Every task's requirements implicitly include this section.

- **NEVER run `git commit`, `git push`, `git add`, or any `gh` write command.** The deliverable is the working tree. This overrides the writing-plans skill's "Commit" step, which does not appear in any task below.
- **A merge is in progress and its resolution is STAGED in the git index.** `git diff --cached HEAD` is the merge; `git diff` is this plan's work. Do not stage, unstage, reset, stash, or checkout anything. If the index is ever found empty, restore it from `/private/tmp/claude-501/-Users-jdlara-cache-psy6-PowerSystemsInvestmentsPortfolios-jl/308379bc-a57e-4d09-89c7-d3f776a160d4/scratchpad/MERGE_RESOLUTION.patch` and say so.
- **No shims.** psy6 is a planned breaking release. No compat aliases (`const APIServer = …` is forbidden), no defensive deserialization, no changelog entries. Fix callers.
- **No version or compat bumps** in any `Project.toml` beyond the two new `[deps]`/`[compat]`/`[sources]` entries Task 1 adds.
- **Never hand-edit `src/models/generated/*.jl`.** Edit the descriptor or `src/utils/generate_structs.jl` and regenerate.
- **Julia style** (from `~/.claude/user-preferences.md`): no `isa`/`<:` runtime checks — dispatch; no ternaries — `if`/`else`; `iszero(x)` not `x == 0`; explicit `function … end` with explicit `return` for any non-trivial body; no `Union{Nothing,T}` absence sentinels in new code; terse comments documenting only a non-obvious WHY.
- **Never extend a silent-failure pattern.** An unclassifiable field, an unmapped enum, an unresolved id: `error()` or `throw(DataFormatError(...))` naming the type, the field, and what was expected. Never skip, never guess, never return `nothing` to mean "absent" where absence is a bug.
- **The DB parser is out of scope.** Do not restructure `src/db_parser.jl`. Only make the mechanical edits Task 6 names.
- **Failing tests may be commented out** with a `# TODO(openapi-serde):` marker and a one-line reason. Prefer fixing; comment out only when the failure is genuinely out of scope (PSCB, DB parser).
- **PowerSystemCaseBuilder is broken in this environment.** `build_portfolio()` (`test/portfolio_5bus.jl`) cannot run: registry PSCB 2.4.0 calls `PSY.set_units_base_system!`, removed in psy6. Every testset that calls it will error before reaching any assertion. This is pre-existing and not yours to fix. All new tests MUST construct components inline, never via `build_portfolio()`.
- **Formatter** must be run before any task is reported done:
  `julia --project=scripts/formatter -e 'include("scripts/formatter/formatter_code.jl")'`
- **Compile check** after every file edit: `julia --project=. -e 'using PowerSystemsInvestmentsPortfolios'`

### The PSB-free verification command

This is the only test command that produces signal. Use it as the gate for every task.

```bash
cd /Users/jdlara/cache/psy6/PowerSystemsInvestmentsPortfolios.jl/test && julia --project=. -e '
using PowerSystemsInvestmentsPortfolios
include("PowerSystemsInvestmentsPortfoliosTests.jl")
using ReTest
retest(PowerSystemsInvestmentsPortfoliosTests, r"<PATTERN>")
'
```

Baseline before any work in this plan: **539 pass, 0 fail** for
`r"Technology Constructors|Technology and region getters|Test time mapping|conversions|getters/setters|natural_unit|display_units_arg|conversion_unit matches"`.
That number must never regress. New testsets add to it.

---

## Reference material

Read these before starting. They are the source of the design; this plan does not restate them in full.

| What | Where |
|---|---|
| PSY's generator + OpenAPI template | `/Users/jdlara/cache/psy6/PowerSystems.jl/src/generate_structs.jl` — template at 109–149, `OPENAPI_SKIP_FIELDS` at 180, `openapi_classify_field` at 542, `compute_openapi_converter!` at 710, `compute_openapi_export_converter!` at 876 |
| PSY's refs registry | `/Users/jdlara/cache/psy6/PowerSystems.jl/src/openapi/refs.jl` (143 lines) |
| PSY's ledger | `/Users/jdlara/cache/psy6/PowerSystems.jl/src/openapi/ledger.jl` (60 lines) |
| PSY's cost/curve converters | `/Users/jdlara/cache/psy6/PowerSystems.jl/src/openapi/cost_conversion.jl` (200) and `export_cost_conversion.jl` (224) |
| PSY's generated-converter helpers | `/Users/jdlara/cache/psy6/PowerSystems.jl/src/openapi/export_generated_types.jl` (71 lines) |
| Platform OpenAPI models | `/Users/jdlara/cache/psy6/PowerOpenAPIModels/PowerInvestmentsOpenAPIModels.jl/` and `PowerCoreOpenAPIModels.jl/` |
| Prior research (already gathered) | `<scratchpad>/psy_serde_report.md` (PSY side) and `<scratchpad>/psip_inventory.md` (PSIP side) — scratchpad is `/private/tmp/claude-501/-Users-jdlara-cache-psy6-PowerSystemsInvestmentsPortfolios-jl/308379bc-a57e-4d09-89c7-d3f776a160d4/scratchpad` |

### Design decisions already made — do not relitigate

1. **No unit-system dispatch.** PSY emits four methods per type (`from_openapi`/`to_openapi` × `Val{:DEVICE_BASE}`/`Val{:NATURAL_UNITS}`) because a PSY document can state values in either of two per-unit bases. PSIP's units are absolute Unitful quantities with exactly one representation, so PSIP emits **two** methods per type and **no `Val` argument at all**. Fields with `needs_conversion` export as `get_x(value, NU)`, which is identity (`_resolve_nu(NU, base_unit) = base_unit`, so `convert_units` converts base→base). Fields without it export as `get_x(value)`. Import passes `po.x` straight to the constructor, which stores natural units.
2. **Parametric types are generated, not hand-written.** PSY's generator hard-rejects `parametric` and hand-writes those converters. PSIP cannot: 8 of its 23 types are parametric and they are the bulk of the domain. `power_systems_type::String` is the carrier. `from_openapi` resolves `T = getproperty(PowerSystems, Symbol(po.power_systems_type))`; `to_openapi` dispatches `where {T <: Bound}` and emits `power_systems_type = string(nameof(T))`. This deletes the current two-carrier redundancy (`__metadata__.parameters[1]` and the `power_systems_type` field drift independently today).
3. **Abstract type parameters are legal.** `AggregateTransportTechnology{PSY.ACBranch}` is in active use (`test/test_serialization.jl:103`, `src/db_parser.jl:588,640,1468`). `getproperty(PowerSystems, :ACBranch)` resolves it. Do not add a concreteness check.
4. **PSIP components own their document id.** Every one of the 23 has an `id::Int64` field, and it is already the identifier the OpenAPI models key on. So `_build_export_refs` registers `refs[get_id(c)] = c` rather than running a counter. Duplicate ids across types are a data bug and `OpenAPIRefs.setindex!` errors on them.
5. **Vector references are new.** PSY only has scalar references. PSIP has `region::Vector{RegionTopology}` (×5) and `requirements::Vector{Requirement}` (×7). The generator emits `resolve_refs` / `component_ids` for these.
6. **Reference types are a declared set, not derived.** PSY decides "reference" by testing whether the bare type name is one of the descriptor's `struct_name`s. That fails in PSIP because `RegionTopology` and `Requirement` are *abstract* supertypes and never appear as component names. Declare `OPENAPI_REFERENCE_TYPES = Set(["RegionTopology", "Requirement", "Zone", "Node"])` in the generator and raise on anything unclassified.
7. **Scope stops short of a `PortfolioDocument`.** The existing JSON envelope (`IS.serialize(portfolio)` → `data.components` array, `to_json`, `Portfolio(path)`) stays. Only the per-component payload changes, from the `ENCODED_FIELDS`/`serialize_custom_types` machinery to the generated converters. Time series, supplemental-attribute associations, and `InvestmentScheduleResults` keep their current paths. A `PortfolioDocument` container and a `case/` directory bundle are PR3/PR4 of `.claude/plans/2026-08-06-psip-serde-strategy-port.md` and are **not** in this plan.

---

## File Structure

| File | Status | Responsibility |
|---|---|---|
| `Project.toml` | modify | Two new deps + `[sources]` path entries + `[compat]` |
| `src/PowerSystemsInvestmentsPortfolios.jl` | modify | Swap `include(APIServer.jl)` + `using .APIServer` for `import PowerCoreOpenAPIModels`/`PowerInvestmentsOpenAPIModels` and the `PC`/`PI` aliases; add the `src/openapi/*` includes in the right order; export `from_openapi`/`to_openapi` |
| `src/models/generated/open_api_models/` | **delete** | 56 vendored files, all superseded |
| `src/openapi/refs.jl` | create | `OpenAPIRefs`, `resolve_ref(s)`, `component_id(s)`, the empty `from_openapi`/`to_openapi` generics. **Must be included before `models/generated/includes.jl`** |
| `src/openapi/converters.jl` | create | Hand-written value converters both directions: curves, operational costs, financial data, and the compound (`MinMax`/`UpDown`/`InOut`) PO constructors the generated code calls |
| `src/openapi/ledger.jl` | create | `store_ledger!` / `load_ledger` / `has_ledger` on `Portfolio` ext. Must come **after** `portfolio.jl` |
| `src/openapi/document.jl` | create | `DOCUMENT_PLAN` (the type ordering both directions share) and `component_type_for` lookup |
| `src/utils/generate_structs.jl` | modify | Field classification + the template's converter section |
| `src/models/generated/*.jl` | regenerate | 23 files, each gaining a `from_openapi`/`to_openapi` pair |
| `src/serialization.jl` | modify | Drive the generated converters; delete `ENCODED_FIELDS`, `serialize_custom_types`, `deserialize_custom_types`, `build_model_struct` |
| `test/test_openapi_refs.jl` | create | `OpenAPIRefs` semantics |
| `test/test_openapi_converters.jl` | create | Per-type `from_openapi`/`to_openapi` round trips, built inline (no PSCB) |
| `test/test_openapi_parity.jl` | create | Descriptor ⇄ platform-PO field parity guard |

---

## Task 1: Depend on the platform OpenAPI packages

**Files:**
- Modify: `Project.toml`
- Modify: `src/PowerSystemsInvestmentsPortfolios.jl:41` (imports), `:161-163` (enum re-exports), `:166-167` (the `APIServer` include)
- Delete: `src/models/generated/open_api_models/` (whole tree, 56 files)
- Modify: `src/utils/generate_structs.jl` — the `SERIALIZATION_TEMPLATE` portion of `STRUCT_TEMPLATE`, `APIServer.` → `PI.`
- Regenerate: `src/models/generated/*.jl`
- Test: `test/test_openapi_parity.jl` (create)

**Interfaces:**
- Produces: the module-level aliases `const PC = PowerCoreOpenAPIModels` and `const PI = PowerInvestmentsOpenAPIModels`. Every later task refers to PO types as `PI.SupplyTechnology`, `PC.MinMax`, etc. Investments re-exports every public Core name, so `PI.MinMax` also resolves; **use `PC.` for Core types and `PI.` for Investments types** so the origin is readable.

The vendored tree and the platform tree were verified field-identical for all 24 Investments types and 28 of 29 Core types. Two known differences, both platform-ahead:
- `AverageRateCurveFunctionData` exists only in the vendored tree and is **stale** — it admits `PIECEWISE_LINEAR`/`QUADRATIC` and rejects `PIECEWISE_STEP`, the inverse of what `SiennaSchemas/Core/common.json` says. Do not port it. `AverageRateCurve.function_data` is `IncrementalCurveFunctionData` on the platform side.
- `FuelCurve` gains an optional `startup_fuel_offtake`, so its positional arity goes 5 → 6. Grep for positional `FuelCurve(` calls.

- [ ] **Step 1: Write the failing parity test**

Create `test/test_openapi_parity.jl`. This is the guard that the descriptor and the platform models agree — it is the thing that would otherwise fail silently for months.

```julia
# Descriptor <-> platform OpenAPI model field parity. The descriptor drives PSIP's
# Julia structs and the platform package drives the wire format; a field present in
# one and absent from the other is a silent data-loss bug, so it fails here instead.
@testset "descriptor and PowerInvestmentsOpenAPIModels agree on fields" begin
    descriptor = JSON3.read(
        joinpath(BASE_DIR, "src", "descriptors", "SiennaInvestSchema.json"),
    )
    skipped = Set(["ext", "internal"])
    for component in descriptor["components"]
        name = String(component["name"])
        po_type = getproperty(PSIP.PI, Symbol(name))
        po_fields = Set(String(f) for f in fieldnames(po_type))
        descriptor_fields = Set(
            String(p["name"]) for p in component["properties"] if
            !(String(p["name"]) in skipped)
        )
        missing_on_po = setdiff(descriptor_fields, po_fields)
        @test isempty(missing_on_po)
        if !isempty(missing_on_po)
            @error "descriptor fields absent from the OpenAPI model" name missing_on_po
        end
    end
end
```

Note this asserts one direction only: every descriptor field must exist on the PO type. The reverse is allowed — `PI.ColocatedSupplyStorageTechnology` has a `requirements` field the descriptor does not, and `to_openapi` simply leaves it at its default.

- [ ] **Step 2: Run it to verify it fails**

Run the PSB-free command with `r"descriptor and PowerInvestments"`.
Expected: FAIL — `UndefVarError: PI not defined in PowerSystemsInvestmentsPortfolios`.

- [ ] **Step 3: Add the dependencies**

In `Project.toml`, under `[deps]` (keep alphabetical):

```toml
PowerCoreOpenAPIModels = "b7b40286-e793-417d-a9a0-b1583e4da1cb"
PowerInvestmentsOpenAPIModels = "33cb4396-f4d9-4f59-8585-787ebb56cb1b"
```

Under `[sources]`, mirroring PowerSystems.jl's own `Project.toml` verbatim in style — including the reason comment, because a path source is not releasable:

```toml
# Sibling-checkout paths, not a git rev: the generated models are not yet released.
# Switch to a tagged rev before merge.
PowerCoreOpenAPIModels = {path = "../../PowerOpenAPIModels/PowerCoreOpenAPIModels.jl"}
PowerInvestmentsOpenAPIModels = {path = "../../PowerOpenAPIModels/PowerInvestmentsOpenAPIModels.jl"}
```

Both packages need an explicit source: `PowerInvestmentsOpenAPIModels`'s own `Project.toml` supplies no source for `PowerCoreOpenAPIModels`, so the consumer must.

Under `[compat]`:

```toml
PowerCoreOpenAPIModels = "0.1"
PowerInvestmentsOpenAPIModels = "0.1"
```

Add the same three blocks to `test/Project.toml`. The path there is `"../../PowerOpenAPIModels/..."` as well — `test/Project.toml`'s sources resolve relative to the repo root, matching the existing `InfrastructureSystems`/`PowerSystems` entries' style.

Then: `julia --project=. -e 'using Pkg; Pkg.instantiate()'` and `julia --project=test -e 'using Pkg; Pkg.instantiate()'`.

- [ ] **Step 4: Swap the module wiring**

In `src/PowerSystemsInvestmentsPortfolios.jl`, replace the `import OpenAPI` line's neighbourhood so the imports read:

```julia
import OpenAPI
import PowerCoreOpenAPIModels
import PowerInvestmentsOpenAPIModels
const PC = PowerCoreOpenAPIModels
const PI = PowerInvestmentsOpenAPIModels
```

Delete lines 166–167:

```julia
#submodule for OpenAPI structs
include("models/generated/open_api_models/src/APIServer.jl")
using .APIServer
```

`ThermalFuels`, `PrimeMovers`, and `StorageTech` are already imported from PowerSystems at line 30 and re-exported at 161–163 — those are the real PSY enums and are unaffected. Core's same-named `const X = String` aliases are unexported and must not be reached; if any code resolves one of them, qualify it `PC.ThermalFuels` and fix the caller.

- [ ] **Step 5: Delete the vendored tree and repoint the generator**

```bash
rm -rf src/models/generated/open_api_models
```

In `src/utils/generate_structs.jl`, the `STRUCT_TEMPLATE`'s serialization section currently emits `APIServer.{{struct_name}}`. Change both occurrences to `PI.{{struct_name}}`. Leave everything else in the template alone — Task 4 replaces this whole section.

Regenerate:

```bash
julia --project=. -e '
using PowerSystemsInvestmentsPortfolios
PowerSystemsInvestmentsPortfolios.StructGeneration.generate_structs(
    "src/descriptors/SiennaInvestSchema.json", "src/models/generated")
'
```

- [ ] **Step 6: Fix the fallout**

```bash
grep -rn "APIServer\|AverageRateCurveFunctionData" src/ test/ docs/
```

Every hit must be resolved, not silenced:
- `APIServer.X` → `PI.X` for Investments types, `PC.X` for Core types.
- `AverageRateCurveFunctionData` → `IncrementalCurveFunctionData`. If a call site was constructing an `AverageRateCurve` with `PIECEWISE_LINEAR` or `QUADRATIC` function data, it was emitting schema-invalid output; fix the data, do not preserve the behaviour.

Then check `FuelCurve` positional calls: `grep -rn "FuelCurve(" src/ test/ | grep -v "FuelCurve(;"`.

- [ ] **Step 7: Verify**

```bash
julia --project=. -e 'using PowerSystemsInvestmentsPortfolios'
julia --project=scripts/formatter -e 'include("scripts/formatter/formatter_code.jl")'
```
Then the PSB-free command with the baseline pattern **plus** `|descriptor and PowerInvestments`.
Expected: 539 baseline tests still pass, plus 23 new parity assertions pass.

If a parity assertion fails, that is a real schema finding. Record it in the task report with the exact type and field list; **do not** paper over it by editing the descriptor to match, or by loosening the test.

---

## Task 2: The refs registry

**Files:**
- Create: `src/openapi/refs.jl`
- Modify: `src/PowerSystemsInvestmentsPortfolios.jl` — add `include("openapi/refs.jl")` **before** `include("models/generated/includes.jl")`, and export `from_openapi` / `to_openapi`
- Test: `test/test_openapi_refs.jl` (create)

**Interfaces:**
- Produces, all consumed by Tasks 3–6 and by the generated code:
  - `struct OpenAPIRefs` with `by_id::Dict{Int, Any}` and `id_by_component::IdDict{Any, Int}`
  - `OpenAPIRefs()` — zero-arg constructor
  - `Base.setindex!(refs::OpenAPIRefs, component, id::Integer)` — errors on duplicate id
  - `Base.getindex(refs::OpenAPIRefs, id::Integer)` — errors on unregistered id
  - `has_ref(refs::OpenAPIRefs, id::Integer)::Bool`
  - `resolve_ref(refs::OpenAPIRefs, id::Integer)` and `resolve_ref(::OpenAPIRefs, ::Nothing) = nothing`
  - `resolve_refs(refs::OpenAPIRefs, ids)::Vector` and `resolve_refs(::OpenAPIRefs, ::Nothing) = []`
  - `component_id(refs::OpenAPIRefs, component)::Int` — errors when unregistered
  - `component_ids(refs::OpenAPIRefs, components)::Vector{Int}`
  - `has_component_id(refs::OpenAPIRefs, component)::Bool`
  - `function from_openapi end` and `function to_openapi end` — the generics the generated methods extend

PSY's `OpenAPIRefs` also carries `unit_system::String` and `base_power::Float64`. PSIP has neither: one unit representation, no system base. Omit both fields.

- [ ] **Step 1: Write the failing test**

Create `test/test_openapi_refs.jl`:

```julia
@testset "OpenAPIRefs registration and resolution" begin
    refs = PSIP.OpenAPIRefs()
    zone = Zone(name="z1", id=1)
    node = Node(name="n1", id=2)

    refs[1] = zone
    refs[2] = node

    @test refs[1] === zone
    @test PSIP.component_id(refs, node) == 2
    @test PSIP.has_ref(refs, 1)
    @test !PSIP.has_ref(refs, 99)
    @test PSIP.has_component_id(refs, zone)

    # `nothing` in, `nothing` out: an omitted optional reference is an absent
    # relationship, not a malformed one.
    @test isnothing(PSIP.resolve_ref(refs, nothing))
    @test PSIP.resolve_ref(refs, 2) === node
    @test PSIP.resolve_refs(refs, [1, 2]) == [zone, node]
    @test isempty(PSIP.resolve_refs(refs, nothing))
    @test PSIP.component_ids(refs, [node, zone]) == [2, 1]
end

@testset "OpenAPIRefs errors loudly on malformed input" begin
    refs = PSIP.OpenAPIRefs()
    zone = Zone(name="z1", id=1)
    refs[1] = zone

    @test_throws ErrorException refs[1] = Zone(name="other", id=1)
    @test_throws ErrorException refs[7]
    @test_throws ErrorException PSIP.resolve_ref(refs, 7)
    @test_throws ErrorException PSIP.component_id(refs, Node(name="n", id=3))
end
```

- [ ] **Step 2: Run it to verify it fails**

PSB-free command with `r"OpenAPIRefs"`. Expected: FAIL, `UndefVarError: OpenAPIRefs`.

- [ ] **Step 3: Write `src/openapi/refs.jl`**

Port `/Users/jdlara/cache/psy6/PowerSystems.jl/src/openapi/refs.jl` structurally — same docstrings' intent, same error wording pattern, minus `unit_system`/`base_power`, plus the two vector methods.

```julia
# Ported from PowerSystems.jl's src/openapi/refs.jl. PSY's version also carries the
# document's unit system and base power; PSIP has one unit representation and no
# system base, so both fields are absent.

function from_openapi end
function to_openapi end

"""
$(TYPEDEF)
$(TYPEDFIELDS)

Bidirectional id<->component resolution context for one OpenAPI conversion pass.

Populated in dependency order as components are converted (regions before the
technologies that reference them, etc.) An id or a component that has not been
registered yet is malformed input, not an absence to tolerate: [`Base.getindex`](@ref)
and [`component_id`](@ref) error loudly naming what was missing rather than returning
`nothing`. Use [`has_ref`](@ref) / [`has_component_id`](@ref) first when absence is
itself a valid outcome to branch on.
"""
struct OpenAPIRefs
    "Id → component, populated by `setindex!` as each component is converted."
    by_id::Dict{Int, Any}
    "Component → id, the reverse of `by_id`, keyed by object identity."
    id_by_component::IdDict{Any, Int}
end

OpenAPIRefs() = OpenAPIRefs(Dict{Int, Any}(), IdDict{Any, Int}())

function Base.setindex!(refs::OpenAPIRefs, component, id::Integer)
    key = Int(id)
    if haskey(refs.by_id, key)
        error(
            "OpenAPIRefs: duplicate id $key — already registered as " *
            "$(summary(refs.by_id[key])), cannot register $(summary(component))",
        )
    end
    refs.by_id[key] = component
    refs.id_by_component[component] = key
    return component
end

function Base.getindex(refs::OpenAPIRefs, id::Integer)
    key = Int(id)
    if !haskey(refs.by_id, key)
        error(
            "OpenAPIRefs: unresolved id $key — no component registered under it; " *
            "expected every referenced component to be converted earlier, in " *
            "dependency order",
        )
    end
    return refs.by_id[key]
end

has_ref(refs::OpenAPIRefs, id::Integer) = haskey(refs.by_id, Int(id))

"""
Resolve an **optional** component reference from a document.

`nothing` in means `nothing` out: a schema-optional reference the document omits is an
absent relationship, not a malformed one. A reference that *is* stated still goes
through [`Base.getindex`](@ref) and so still errors when it names an unregistered id.
"""
resolve_ref(::OpenAPIRefs, ::Nothing) = nothing
resolve_ref(refs::OpenAPIRefs, id::Integer) = refs[id]

"""Resolve a list of component references. An omitted list is an empty one."""
resolve_refs(::OpenAPIRefs, ::Nothing) = []
resolve_refs(refs::OpenAPIRefs, ids) = [refs[id] for id in ids]

function component_id(refs::OpenAPIRefs, component)
    if !haskey(refs.id_by_component, component)
        error(
            "OpenAPIRefs: component $(summary(component)) has no registered id — it " *
            "was never passed through setindex!",
        )
    end
    return refs.id_by_component[component]
end

component_ids(refs::OpenAPIRefs, components) =
    Int[component_id(refs, c) for c in components]

has_component_id(refs::OpenAPIRefs, component) =
    haskey(refs.id_by_component, component)
```

- [ ] **Step 4: Wire it into the module**

In `src/PowerSystemsInvestmentsPortfolios.jl`, add **before** `include("models/generated/includes.jl")` (currently line 176):

```julia
include("openapi/refs.jl")
```

The generated converter methods extend the `from_openapi`/`to_openapi` generics defined there, so this ordering is load-bearing — the same constraint PSY documents.

Add to the export list:

```julia
export from_openapi
export to_openapi
```

- [ ] **Step 5: Run the test to verify it passes**

PSB-free command with `r"OpenAPIRefs"`. Expected: PASS, 18 assertions.

- [ ] **Step 6: Verify no regression**

Compile check, formatter, then the baseline pattern plus `|OpenAPIRefs|descriptor and PowerInvestments`.
Expected: 539 + 23 + 18, no failures.

---

## Task 3: Hand-written value converters

**Files:**
- Create: `src/openapi/converters.jl`
- Modify: `src/PowerSystemsInvestmentsPortfolios.jl` — `include("openapi/converters.jl")` immediately after `openapi/refs.jl`
- Test: `test/test_openapi_converters.jl` (create — this file grows again in Task 4)

**Interfaces:**
- Produces, all called by generated code in Task 4:
  - `convert_value_curve(po)` → `IS.ValueCurve` subtype; `convert_value_curve_to_openapi(curve)` → `PC.ValueCurve`
  - `convert_cost(po)` → `PSY.OperationalCost` subtype; `convert_cost_to_openapi(cost)` → the matching PC cost model
  - `convert_financial_data(po)` → `TechnologyFinancialData`; `convert_financial_data_to_openapi(fd)` → `PC.TechnologyFinancialData`
  - `_minmax_po(nt)` → `PC.MinMax`; `_updown_po(nt)` → `PC.UpDown`; `_inout_po(nt)` → `PC.InOut`
  - `_minmax_po_optional`, `_updown_po_optional`, `_inout_po_optional` — `nothing` in, `nothing` out
  - `_value_curve_optional(po)` / `_value_curve_po_optional(curve)` — the nullable curve pair (`StorageTechnology.capital_costs_charge` is `Union{Nothing, PSY.ValueCurve}`)

**Consumes:** `PC.*` model types from Task 1.

Mirror `/Users/jdlara/cache/psy6/PowerSystems.jl/src/openapi/cost_conversion.jl` and `export_cost_conversion.jl` — same recursive shape, one method per PO variant, dispatch not `isa`, loud `error()` on an unmapped variant. PSIP's set is smaller: it needs `ValueCurve` (the `InputOutputCurve`/`IncrementalCurve`/`AverageRateCurve` oneOf and the four `FunctionData` leaves) and the operational costs actually used in the descriptor — `ThermalGenerationCost`, `StorageCost`, `RenewableGenerationCost`, and `ProductionVariableCostCurve` for `ColocatedSupplyStorageTechnology.operation_costs_inverter`.

PSY's converters take no unit argument and neither do these. Values are already in natural units on both sides.

- [ ] **Step 1: Write the failing round-trip tests**

Append to `test/test_openapi_converters.jl`:

```julia
@testset "value curve conversion round trip" begin
    for curve in (
        LinearCurve(3.0),
        LinearCurve(2.0, 5.0),
        PSY.QuadraticCurve(1.0, 2.0, 3.0),
        PSY.PiecewisePointCurve([(1.0, 10.0), (2.0, 25.0)]),
    )
        po = PSIP.convert_value_curve_to_openapi(curve)
        @test PSIP.convert_value_curve(po) == curve
    end
end

@testset "operational cost conversion round trip" begin
    for cost in (
        PSY.ThermalGenerationCost(nothing),
        PSY.StorageCost(nothing),
        PSY.RenewableGenerationCost(nothing),
    )
        po = PSIP.convert_cost_to_openapi(cost)
        @test PSIP.convert_cost(po) == cost
    end
end

@testset "financial data conversion round trip" begin
    fd = TechnologyFinancialData(
        capital_recovery_period=20,
        technology_base_year=2024,
        debt_fraction=0.6,
        debt_rate=0.05,
        return_on_equity=0.1,
        tax_rate=0.21,
    )
    po = PSIP.convert_financial_data_to_openapi(fd)
    round_tripped = PSIP.convert_financial_data(po)
    @test get_capital_recovery_period(round_tripped) == 20
    @test get_technology_base_year(round_tripped) == 2024
    @test get_debt_fraction(round_tripped) == 0.6
    @test get_debt_rate(round_tripped) == 0.05
    @test get_return_on_equity(round_tripped) == 0.1
    @test get_tax_rate(round_tripped) == 0.21
end

@testset "compound PO constructors" begin
    @test PSIP._minmax_po((min=1.0, max=2.0)).min == 1.0
    @test PSIP._minmax_po((min=1.0, max=2.0)).max == 2.0
    @test PSIP._updown_po((up=3.0, down=4.0)).up == 3.0
    @test PSIP._inout_po((in=0.9, out=0.8)).out == 0.8
    @test isnothing(PSIP._minmax_po_optional(nothing))
    @test PSIP._minmax_po_optional((min=0.0, max=1.0)).max == 1.0
end

@testset "unmapped converter input errors loudly" begin
    @test_throws ErrorException PSIP.convert_cost("not a cost model")
    @test_throws ErrorException PSIP.convert_value_curve(42)
end
```

- [ ] **Step 2: Run to verify it fails**

PSB-free command with `r"conversion round trip|compound PO constructors|unmapped converter"`.
Expected: FAIL, `UndefVarError: convert_value_curve_to_openapi`.

- [ ] **Step 3: Read the PSY originals**

Read both files end to end before writing anything:
`/Users/jdlara/cache/psy6/PowerSystems.jl/src/openapi/cost_conversion.jl`
`/Users/jdlara/cache/psy6/PowerSystems.jl/src/openapi/export_cost_conversion.jl`

Match their structure: same function naming, same recursive descent, same one-method-per-variant dispatch, same terminal `error()` naming the unmapped type. Diverge only where PSIP's type set differs.

- [ ] **Step 4: Write `src/openapi/converters.jl`**

Structure, in this order:

```julia
# Hand-written OpenAPI value converters, mirroring PowerSystems.jl's
# src/openapi/cost_conversion.jl and export_cost_conversion.jl. PSIP carries no
# per-unit basis, so unlike PSY's these take no unit argument on either side.

# ── compound PO constructors, called by generated to_openapi ──────────────────
_minmax_po(v) = PC.MinMax(; min=v.min, max=v.max)
_minmax_po_optional(::Nothing) = nothing
_minmax_po_optional(v) = _minmax_po(v)
# ... _updown_po, _inout_po and their _optional pairs

# ── function data ────────────────────────────────────────────────────────────
# one method per PC.*FunctionData leaf, both directions, terminal error()

# ── value curves ─────────────────────────────────────────────────────────────
# convert_value_curve / convert_value_curve_to_openapi over the oneOf variants

# ── operational costs ────────────────────────────────────────────────────────
# convert_cost / convert_cost_to_openapi over Thermal/Storage/Renewable/ProductionVariable

# ── financial data ───────────────────────────────────────────────────────────
# convert_financial_data / convert_financial_data_to_openapi
```

Terminal fallbacks must name the type and the direction, e.g.:

```julia
function convert_cost(po)
    return error(
        "no OpenAPI operational-cost converter for $(nameof(typeof(po))) — every " *
        "cost in the document must be converted, not skipped",
    )
end
```

Do **not** write `isa`/`<:` branches. One typed method per variant.

- [ ] **Step 5: Wire it in and run the tests**

`include("openapi/converters.jl")` right after `openapi/refs.jl` in the module file.
Compile check, then the PSB-free command with the Step-2 pattern. Expected: PASS.

- [ ] **Step 6: Verify no regression**

Formatter, then baseline + `|OpenAPIRefs|descriptor and PowerInvestments|conversion round trip|compound PO constructors|unmapped converter`.

---

## Task 4: Generate `from_openapi` / `to_openapi`

This is the task the whole plan exists for. It is also the only one that changes 23 generated files at once, so its gate matters most.

**Files:**
- Modify: `src/utils/generate_structs.jl` — replace the `SERIALIZATION_TEMPLATE` section of `STRUCT_TEMPLATE` and add the classification machinery
- Regenerate: `src/models/generated/*.jl` (23 files)
- Test: `test/test_openapi_converters.jl` (extend)

**Interfaces:**
- Consumes: everything Tasks 2 and 3 produce.
- Produces, on every generated type — this is the surface Task 6 drives:
  - non-parametric: `from_openapi(::Type{X}, po, refs::OpenAPIRefs)` and `to_openapi(value::X, refs::OpenAPIRefs)`
  - parametric: `from_openapi(::Type{X}, po, refs::OpenAPIRefs)` returning `X{T}` with `T` resolved from `po.power_systems_type`, and `to_openapi(value::X{T}, refs::OpenAPIRefs) where {T <: Bound}`
  - per-enum module-level tables `const <ENUM>_FROM_STRING` / `const <ENUM>_TO_STRING`, deduplicated across the whole generation run

- [ ] **Step 1: Write the failing converter round-trip tests**

Extend `test/test_openapi_converters.jl`. Cover one type per classification family. Build everything inline — `build_portfolio()` is unavailable.

```julia
# Shared fixture: the reference targets every technology round trip needs.
function _refs_fixture()
    refs = PSIP.OpenAPIRefs()
    zone = Zone(name="zone_a", id=1)
    node = Node(name="node_a", id=2)
    req = CarbonTax(name="tax", id=3, available=true)
    refs[1] = zone
    refs[2] = node
    refs[3] = req
    return refs, zone, node, req
end

@testset "Zone and Node round trip through OpenAPI" begin
    refs, zone, node, _ = _refs_fixture()

    po_zone = PSIP.to_openapi(zone, refs)
    @test po_zone.id == 1
    @test po_zone.name == "zone_a"
    @test PSIP.get_name(PSIP.from_openapi(Zone, po_zone, refs)) == "zone_a"

    # bus_type is an ACBusTypes enum: it crosses the wire as a string.
    po_node = PSIP.to_openapi(node, refs)
    @test po_node.bus_type == string(ACBusTypes.PQ)
    @test PSIP.get_bus_type(PSIP.from_openapi(Node, po_node, refs)) == ACBusTypes.PQ
end

@testset "SupplyTechnology round trip through OpenAPI" begin
    refs, zone, _, req = _refs_fixture()
    tech = SupplyTechnology{ThermalStandard}(;
        name="cheap_thermal",
        id=10,
        power_systems_type="ThermalStandard",
        region=[zone],
        requirements=[req],
        prime_mover_type=PrimeMovers.CT,
        fuel=[ThermalFuels.NATURAL_GAS],
        co2=Dict(ThermalFuels.NATURAL_GAS => 0.05),
        cofire_level_limits=Dict(ThermalFuels.NATURAL_GAS => (min=0.0, max=1.0)),
        capacity_limits=(min=0.0, max=500.0),
        ramp_limits=(up=1.0, down=1.0),
        time_limits=(up=60.0, down=60.0),
        unit_size=100.0,
        capital_costs=LinearCurve(1000.0),
        financial_data=TechnologyFinancialData(
            capital_recovery_period=20, technology_base_year=2024,
            debt_fraction=0.6, debt_rate=0.05, return_on_equity=0.1, tax_rate=0.21,
        ),
    )
    refs[10] = tech

    po = PSIP.to_openapi(tech, refs)
    # references leave as ids, not objects
    @test po.region == [1]
    @test po.requirements == [3]
    # the type parameter is carried by power_systems_type, and by nothing else
    @test po.power_systems_type == "ThermalStandard"
    # enums, enum vectors and enum-keyed dicts all cross as strings
    @test po.prime_mover_type == string(PrimeMovers.CT)
    @test po.fuel == [string(ThermalFuels.NATURAL_GAS)]
    @test collect(keys(po.co2)) == [string(ThermalFuels.NATURAL_GAS)]
    # compounds become PC models
    @test po.capacity_limits.max == 500.0
    @test po.ramp_limits.up == 1.0
    # scalars are unscaled: PSIP stores natural units and the document states them
    @test po.unit_size == 100.0

    back = PSIP.from_openapi(SupplyTechnology, po, refs)
    @test PSIP.get_parameter_type(back) === ThermalStandard
    @test PSIP.get_name(back) == "cheap_thermal"
    @test PSIP.get_region(back) == [zone]
    @test PSIP.get_requirements(back) == [req]
    @test PSIP.get_prime_mover_type(back) == PrimeMovers.CT
    @test PSIP.get_fuel(back) == [ThermalFuels.NATURAL_GAS]
    @test PSIP.get_co2(back, NU) == Dict(ThermalFuels.NATURAL_GAS => 0.05)
    @test PSIP.get_capacity_limits(back, NU) == (min=0.0, max=500.0)
    @test PSIP.get_unit_size(back, NU) == 100.0
end

@testset "abstract type parameters survive the round trip" begin
    refs, zone, _, _ = _refs_fixture()
    tech = AggregateTransportTechnology{ACBranch}(;
        name="test_branch",
        id=40,
        available=true,
        power_systems_type="ACBranch",
        start_region=zone,
        end_region=zone,
        financial_data=TechnologyFinancialData(
            capital_recovery_period=20, technology_base_year=2024,
            debt_fraction=0.6, debt_rate=0.05, return_on_equity=0.1, tax_rate=0.21,
        ),
    )
    refs[40] = tech

    po = PSIP.to_openapi(tech, refs)
    @test po.start_region == 1
    @test po.power_systems_type == "ACBranch"
    @test PSIP.get_parameter_type(
        PSIP.from_openapi(AggregateTransportTechnology, po, refs),
    ) === ACBranch
end

@testset "supplemental attribute round trip through OpenAPI" begin
    refs = PSIP.OpenAPIRefs()
    attr = ExistingDevices(id=54, existing_devices=["gen_a", "gen_b"])
    refs[54] = attr
    po = PSIP.to_openapi(attr, refs)
    @test po.id == 54
    @test po.existing_devices == ["gen_a", "gen_b"]
    @test PSIP.get_existing_devices(PSIP.from_openapi(ExistingDevices, po, refs)) ==
          ["gen_a", "gen_b"]
end

@testset "an unregistered reference errors rather than serializing garbage" begin
    refs = PSIP.OpenAPIRefs()
    orphan = Zone(name="orphan", id=77)
    tech = DemandRequirement{PowerLoad}(;
        name="demand", id=78, power_systems_type="PowerLoad",
        value_of_lost_load=1e5, region=[orphan],
    )
    refs[78] = tech
    @test_throws ErrorException PSIP.to_openapi(tech, refs)
end
```

- [ ] **Step 2: Run to verify it fails**

PSB-free command with `r"round trip through OpenAPI|abstract type parameters survive|unregistered reference errors"`.
Expected: FAIL — `to_openapi` has no method for `Zone`.

- [ ] **Step 3: Add the classification tables to the generator**

In `src/utils/generate_structs.jl`, inside `module StructGeneration`, above `generate_invest_structs`. These are declared sets: a field that matches nothing raises.

```julia
# ── OpenAPI converter generation ──────────────────────────────────────────────
# Ported from PowerSystems.jl's src/generate_structs.jl. Two differences, both
# structural rather than stylistic:
#
#  * No unit-system axis. PSY emits four methods per type because a PSY document can
#    state values in either of two per-unit bases. PSIP has one representation, so it
#    emits two and takes no `Val`.
#  * Parametric types are generated, not rejected. PSY hand-writes those; PSIP cannot,
#    since 8 of its 23 types are parametric. `power_systems_type` carries the parameter.

const OPENAPI_SKIP_FIELDS = Set(["ext", "internal"])

const OPENAPI_SCALAR_TYPES = Set([
    "Float64", "Int", "Int64", "String", "Bool",
    "Vector{String}", "Dict{String, Int64}", "Dict{String, Float64}",
])

const OPENAPI_COMPOUND_MEMBERS = Dict(
    "MinMax" => ("min", "max"),
    "UpDown" => ("up", "down"),
    "InOut" => ("in", "out"),
)

const OPENAPI_COMPOUND_CTORS = Dict(
    "MinMax" => (required="_minmax_po", optional="_minmax_po_optional"),
    "UpDown" => (required="_updown_po", optional="_updown_po_optional"),
    "InOut" => (required="_inout_po", optional="_inout_po_optional"),
)

# PSY derives this from the descriptor's own struct names. That fails here: PSIP's
# reference fields are typed with the ABSTRACT supertypes `RegionTopology` and
# `Requirement`, which are never component names, so the set is declared instead.
const OPENAPI_REFERENCE_TYPES = Set(["RegionTopology", "Requirement", "Zone", "Node"])

const OPENAPI_ENUM_TYPES =
    Set(["PrimeMovers", "ThermalFuels", "StorageTech", "ACBusTypes", "PSY.LoadConformity"])

const OPENAPI_CURVE_TYPES = Set([
    "PSY.ValueCurve",
    "Union{IS.LinearCurve, IS.PiecewiseIncrementalCurve}",
])

const OPENAPI_COST_TYPES = Set(["PSY.OperationalCost"])

const OPENAPI_NESTED_TYPES = Set(["TechnologyFinancialData"])
```

- [ ] **Step 4: Add the classifier**

```julia
"""Split `Union{Nothing, X}` into `(X, true)`; any other type string is `(type, false)`."""
function openapi_strip_nullable(data_type::AbstractString)
    m = match(r"^Union\{Nothing,\s*(.+)\}$", data_type)
    if isnothing(m)
        return (data_type, false)
    end
    return (String(m.captures[1]), true)
end

openapi_enum_table_name(bare) = uppercase(replace(bare, "." => "_")) * "_FROM_STRING"
openapi_enum_table_name_export(bare) = uppercase(replace(bare, "." => "_")) * "_TO_STRING"

"""
Classify one field's role in an OpenAPI converter, returning `(kind, bare, nullable)`
with `kind` one of `:skip`, `:scalar`, `:compound`, `:reference`, `:reference_vector`,
`:enum`, `:enum_vector`, `:enum_dict`, `:enum_compound_dict`, `:curve`, `:cost`,
`:nested`.

Raises `DataFormatError` rather than guessing: a field whose Julia type matches none of
the declared tables is a descriptor change the generator has not been taught about, and
emitting a silently-wrong converter for it would corrupt data at run time.
"""
function openapi_classify_field(struct_name, field)
    name = field["name"]
    if name in OPENAPI_SKIP_FIELDS
        return (:skip, field["type"], false)
    end
    bare, nullable = openapi_strip_nullable(field["type"])
    bare in OPENAPI_SCALAR_TYPES && return (:scalar, bare, nullable)
    haskey(OPENAPI_COMPOUND_MEMBERS, bare) && return (:compound, bare, nullable)
    bare in OPENAPI_REFERENCE_TYPES && return (:reference, bare, nullable)
    bare in OPENAPI_ENUM_TYPES && return (:enum, bare, nullable)
    bare in OPENAPI_CURVE_TYPES && return (:curve, bare, nullable)
    bare in OPENAPI_COST_TYPES && return (:cost, bare, nullable)
    bare in OPENAPI_NESTED_TYPES && return (:nested, bare, nullable)

    inner = match(r"^Vector\{(.+)\}$", bare)
    if !isnothing(inner)
        element = String(inner.captures[1])
        element in OPENAPI_REFERENCE_TYPES && return (:reference_vector, element, nullable)
        element in OPENAPI_ENUM_TYPES && return (:enum_vector, element, nullable)
    end

    dict = match(r"^Dict\{(.+?),\s*(.+)\}$", bare)
    if !isnothing(dict)
        key = String(dict.captures[1])
        value = String(dict.captures[2])
        if key in OPENAPI_ENUM_TYPES
            haskey(OPENAPI_COMPOUND_MEMBERS, value) &&
                return (:enum_compound_dict, (key, value), nullable)
            value in OPENAPI_SCALAR_TYPES && return (:enum_dict, key, nullable)
        end
    end

    throw(
        DataFormatError(
            "$struct_name field=$name type=$(field["type"]) has no determinable " *
            "OpenAPI converter kind (not a scalar, compound, reference, enum, curve, " *
            "cost, or nested struct declared in the generator's tables)",
        ),
    )
end
```

- [ ] **Step 5: Add the two direction drivers**

`compute_openapi_converter!(item)` (import) and `compute_openapi_export_converter!(item)` (export) both walk `item["properties"]` once, share `openapi_classify_field`, and push `Dict("name" => …, "expr" => …)` into a single kwargs vector each. Full expression table — this is the specification, implement it exactly:

| kind | `from_openapi` expr | `to_openapi` expr |
|---|---|---|
| `:skip` | *(omitted)* | *(omitted)* |
| `:scalar` | `po.<n>` | `get_<n>(value, NU)` if `needs_conversion`, else `get_<n>(value)` |
| `:compound` | `(min = po.<n>.min, max = po.<n>.max)` | `_minmax_po(get_<n>(value, NU))` — `_optional` variant and member names per `OPENAPI_COMPOUND_MEMBERS`/`OPENAPI_COMPOUND_CTORS`; drop the `NU` argument when `needs_conversion` is false |
| `:reference` | `resolve_ref(refs, po.<n>)` | `component_id(refs, get_<n>(value))`, or `_component_id_optional(refs, …)` when nullable |
| `:reference_vector` | `resolve_refs(refs, po.<n>)` | `component_ids(refs, get_<n>(value))` |
| `:enum` | `<E>_FROM_STRING[po.<n>]` | `<E>_TO_STRING[get_<n>(value)]` |
| `:enum_vector` | `[<E>_FROM_STRING[v] for v in po.<n>]` | `[<E>_TO_STRING[v] for v in get_<n>(value)]` |
| `:enum_dict` | `Dict(<E>_FROM_STRING[k] => v for (k, v) in po.<n>)` | `Dict(<E>_TO_STRING[k] => v for (k, v) in get_<n>(value, NU))` |
| `:enum_compound_dict` | `Dict(<E>_FROM_STRING[k] => (min = v.min, max = v.max) for (k, v) in po.<n>)` | `Dict(<E>_TO_STRING[k] => _minmax_po(v) for (k, v) in get_<n>(value))` |
| `:curve` | `convert_value_curve(po.<n>)`, or `_value_curve_optional(po.<n>)` when nullable | `convert_value_curve_to_openapi(get_<n>(value, NU))`, `_value_curve_po_optional(…)` when nullable |
| `:cost` | `convert_cost(po.<n>)` | `convert_cost_to_openapi(get_<n>(value, NU))` |
| `:nested` | `convert_financial_data(po.<n>)` | `convert_financial_data_to_openapi(get_<n>(value))` |

Nullable-scalar wrap, when needed, mirrors PSY's:
`"(if isnothing(po.$name); nothing; else; $body; end)"`.

Three rules that are easy to miss:

1. **`id` is a real descriptor field in PSIP.** PSY prepends `id = component_id(refs, value)` because `id` is not in its descriptor. Here `id` is an ordinary `:scalar` field on all 23 types and needs no special case. Emit it like any other scalar; `to_openapi` writes `get_id(value)`, and `_build_export_refs` registers under exactly that value, so they agree by construction.
2. **`power_systems_type` on a parametric type is generated, not read.** Special-case it in the export driver: emit `string(nameof(T))` rather than `get_power_systems_type(value)`. That makes the type parameter the single carrier and eliminates the drift the old `__metadata__.parameters` path allowed. In the import driver it is still `po.power_systems_type` — it is what resolves `T` — so emit it as a normal scalar there too.
3. **Enum tables are deduplicated across the whole run.** Thread a `Set{String}` through both drivers, exactly as PSY threads `defined_enum_tables`. Two files each emitting `const THERMALFUELS_FROM_STRING` is a duplicate-`const` error at include time, not at generation time.

Enum table emission handles the qualified `PSY.LoadConformity`: the const name is `PSY_LOADCONFORMITY_FROM_STRING` and the `instances(...)` argument stays `PSY.LoadConformity`.

- [ ] **Step 6: Replace the template's converter section**

In `STRUCT_TEMPLATE`, delete the `serialize_openapi_struct` / `deserialize_openapi_struct` block entirely and put this in its place:

```
{{#openapi_enum_tables}}
const {{const_name}} = Dict{String, {{{enum_type}}}}(string(m) => m for m in instances({{{enum_type}}}))
{{/openapi_enum_tables}}
{{#openapi_export_enum_tables}}
const {{const_name}} = Dict{ {{{enum_type}}}, String}(m => string(m) for m in instances({{{enum_type}}}))
{{/openapi_export_enum_tables}}

{{#has_parametric}}
function from_openapi(::Type{ {{struct_name}} }, po, refs::OpenAPIRefs)
    parameter = getproperty(PowerSystems, Symbol(po.power_systems_type))
    return {{struct_name}}{parameter}(;
        {{#openapi_kwargs}}
        {{name}} = {{{expr}}},
        {{/openapi_kwargs}}
    )
end

function to_openapi(value::{{struct_name}}{T}, refs::OpenAPIRefs) where {T <: {{parametric}}}
    return PI.{{struct_name}}(;
        {{#openapi_export_kwargs}}
        {{name}} = {{{expr}}},
        {{/openapi_export_kwargs}}
    )
end
{{/has_parametric}}

{{^has_parametric}}
function from_openapi(::Type{ {{struct_name}} }, po, refs::OpenAPIRefs)
    return {{struct_name}}(;
        {{#openapi_kwargs}}
        {{name}} = {{{expr}}},
        {{/openapi_kwargs}}
    )
end

function to_openapi(value::{{struct_name}}, refs::OpenAPIRefs)
    return PI.{{struct_name}}(;
        {{#openapi_export_kwargs}}
        {{name}} = {{{expr}}},
        {{/openapi_export_kwargs}}
    )
end
{{/has_parametric}}
```

Call both drivers from `generate_invest_structs`'s per-item loop, before the `MU.render` call, threading the two shared enum-table sets created outside the loop.

- [ ] **Step 7: Regenerate and inspect**

```bash
julia --project=. -e '
using PowerSystemsInvestmentsPortfolios
PowerSystemsInvestmentsPortfolios.StructGeneration.generate_structs(
    "src/descriptors/SiennaInvestSchema.json", "src/models/generated")
'
julia --project=scripts/formatter -e 'include("scripts/formatter/formatter_code.jl")'
```

Then **read** `src/models/generated/SupplyTechnology.jl` and `src/models/generated/Zone.jl` end to end. The generated code is the deliverable; skimming it is not enough. Confirm: the `where {T <: PSY.Generator}` clause is present on the parametric export, references emit `component_ids`, `power_systems_type` emits `string(nameof(T))`, and no `Val` appears anywhere.

- [ ] **Step 8: Run the tests**

Compile check, then the PSB-free command with the Step-2 pattern. Expected: PASS.

Common failure and its cause: `MethodError: no method matching get_x(::T, ::NaturalUnit)` means the field is marked `needs_conversion` in the descriptor but the generated accessor is the plain one, or vice versa — the export driver's `NU`-argument decision must read the same `needs_conversion` key the accessor generation reads.

- [ ] **Step 9: Verify no regression**

Baseline pattern + everything added so far. Expected: 539 baseline plus all new testsets, no failures.

---

## Task 5: The id⇄UUID ledger

**Files:**
- Create: `src/openapi/ledger.jl`
- Create: `src/openapi/document.jl`
- Modify: `src/PowerSystemsInvestmentsPortfolios.jl` — include both **after** `include("portfolio.jl")`
- Test: `test/test_openapi_converters.jl` (extend)

**Interfaces:**
- Produces:
  - `const OPENAPI_LEDGER_KEY = "_openapi_ledger"`
  - `store_ledger!(portfolio::Portfolio, refs::OpenAPIRefs)::Nothing`
  - `has_ledger(portfolio::Portfolio)::Bool`
  - `load_ledger(portfolio::Portfolio)::Dict{String, Any}` — errors when absent
  - `const DOCUMENT_PLAN::Vector{Tuple{DataType, String}}` — `(PSIP type, document key)` in dependency order
  - `_build_export_refs(portfolio::Portfolio)::OpenAPIRefs`

`ext` on a `Portfolio` is reached through `internal`: `get_ext(val::Portfolio) = IS.get_ext(val.internal)` (`src/portfolio.jl:218`). It round-trips today because `IS.serialize(portfolio)` serializes `internal` wholesale — `test/common.jl:14-15,27-28` already proves it.

- [ ] **Step 1: Write the failing test**

```julia
@testset "OpenAPI ledger round trips ids to UUIDs through Portfolio ext" begin
    portfolio = Portfolio(100.0)
    zone = Zone(name="zone_a", id=1)
    PSIP.add_region!(portfolio, zone)

    @test !PSIP.has_ledger(portfolio)
    @test_throws ErrorException PSIP.load_ledger(portfolio)

    refs = PSIP._build_export_refs(portfolio)
    @test PSIP.component_id(refs, zone) == 1

    PSIP.store_ledger!(portfolio, refs)
    @test PSIP.has_ledger(portfolio)
    ledger = PSIP.load_ledger(portfolio)
    @test ledger["id_to_uuid"]["1"] == string(IS.get_uuid(zone))
end

@testset "duplicate component ids are rejected when building export refs" begin
    portfolio = Portfolio(100.0)
    PSIP.add_region!(portfolio, Zone(name="zone_a", id=1))
    PSIP.add_region!(portfolio, Node(name="node_a", id=1))
    @test_throws ErrorException PSIP._build_export_refs(portfolio)
end
```

Check the `Portfolio(100.0)` constructor signature against `src/portfolio.jl` first and use whichever no-argument-ish constructor exists; adjust the fixture rather than adding a constructor.

- [ ] **Step 2: Run to verify it fails**

PSB-free command with `r"OpenAPI ledger|duplicate component ids"`. Expected: FAIL.

- [ ] **Step 3: Write `src/openapi/document.jl`**

```julia
# The type ordering both conversion directions share. References resolve by id, and
# `OpenAPIRefs` errors on an unregistered one, so a type must appear after everything
# it points at: regions have no references, requirements have none, technologies point
# at both, supplemental attributes reference nothing.
const DOCUMENT_PLAN = [
    (Zone, "Zone"),
    (Node, "Node"),
    (CarbonCaps, "CarbonCaps"),
    (CarbonTax, "CarbonTax"),
    (CapacityReserveMargin, "CapacityReserveMargin"),
    (EnergyShareRequirements, "EnergyShareRequirements"),
    (HourlyMatching, "HourlyMatching"),
    (MinimumCapacityRequirements, "MinimumCapacityRequirements"),
    (MaximumCapacityRequirements, "MaximumCapacityRequirements"),
    (SupplyTechnology, "SupplyTechnology"),
    (StorageTechnology, "StorageTechnology"),
    (ColocatedSupplyStorageTechnology, "ColocatedSupplyStorageTechnology"),
    (DemandRequirement, "DemandRequirement"),
    (DemandSideTechnology, "DemandSideTechnology"),
    (AggregateTransportTechnology, "AggregateTransportTechnology"),
    (NodalACTransportTechnology, "NodalACTransportTechnology"),
    (NodalHVDCTransportTechnology, "NodalHVDCTransportTechnology"),
]

const SUPPLEMENTAL_ATTRIBUTE_PLAN = [
    (RetirementPotential, "RetirementPotential"),
    (AggregateRetirementPotential, "AggregateRetirementPotential"),
    (RetrofitPotential, "RetrofitPotential"),
    (AggregateRetrofitPotential, "AggregateRetrofitPotential"),
    (ExistingDevices, "ExistingDevices"),
    (TopologyMapping, "TopologyMapping"),
]
```

- [ ] **Step 4: Write `src/openapi/ledger.jl`**

Port `/Users/jdlara/cache/psy6/PowerSystems.jl/src/openapi/ledger.jl`, keeping its framing comment — the ledger is a deliberate temporary bridge pending a UUID→id migration in IS, and it must be deleted rather than migrated forward when that lands. PSIP's version drops `unit_system` (there is only one) and needs no `_has_own_uuid` predicate (every PSIP component in the plan has an `internal`).

`_build_export_refs` differs from PSY's meaningfully and the comment must say why:

```julia
# PSY runs a counter here because its components have no id of their own. Every PSIP
# component carries `id::Int64` as a domain field and that id IS the document id, so
# ids are read, not assigned. A collision across types is a data bug, and
# `OpenAPIRefs.setindex!` raises on it rather than silently overwriting.
function _build_export_refs(portfolio::Portfolio)
    refs = OpenAPIRefs()
    for (psip_type, _key) in DOCUMENT_PLAN
        for component in IS.get_components(psip_type, portfolio.data)
            refs[get_id(component)] = component
        end
    end
    for (attribute_type, _key) in SUPPLEMENTAL_ATTRIBUTE_PLAN
        for attribute in IS.get_supplemental_attributes(attribute_type, portfolio.data)
            refs[get_id(attribute)] = attribute
        end
    end
    return refs
end
```

- [ ] **Step 5: Wire in and run**

Add both includes after `include("portfolio.jl")` and before `include("serialization.jl")` in the module file. The ledger needs `Portfolio`; `DOCUMENT_PLAN` needs the generated types.

Compile check, then the PSB-free command with the Step-2 pattern. Expected: PASS.

- [ ] **Step 6: Verify no regression**

Formatter, full PSB-free suite.

---

## Task 6: Rewire serialization

**Files:**
- Modify: `src/serialization.jl` — delete lines 20–51 (`ENCODED_FIELDS`), 157–184 (`IS.serialize(technology)`), 569–605 (`build_model_struct`), 607–636 (dead `IS.deserialize`), 639–681 (`serialize_custom_types`), 682–792 (`deserialize_custom_types`); rewrite 459–494 (`deserialize_attributes`) and 496–567 (`deserialize_components!`)
- Modify: `src/PowerSystemsInvestmentsPortfolios.jl` — drop any export of the deleted names
- Test: `test/test_serialization.jl`

**Interfaces:**
- Consumes: `to_openapi` / `from_openapi` (Task 4), `OpenAPIRefs` (Task 2), `store_ledger!` / `_build_export_refs` / `DOCUMENT_PLAN` (Task 5).
- Produces: unchanged public API. `to_json(portfolio, path)` and `Portfolio(path)` keep their signatures and the on-disk envelope keeps its shape — only each component's payload changes.

The envelope stays as it is. What changes is the payload: today each component is a PO struct built field-by-field through `ENCODED_FIELDS` and `serialize_custom_types`; after this task it is `to_openapi(component, refs)` and nothing else. `__metadata__` keeps `type` and `module` for dispatch on the way back in, and **loses `parameters` / `construct_with_parameters`** — the type parameter now travels in `power_systems_type`, which is the whole point of Task 4's decision 2.

Serialize path:
1. `refs = _build_export_refs(portfolio)`
2. per component in `DOCUMENT_PLAN` order: `po = to_openapi(component, refs)`, then `OpenAPI.to_json(po)` into the components array with a `__metadata__` block carrying `type` and `module`
3. `store_ledger!(portfolio, refs)` before writing, so the file records the mapping

Deserialize path:
1. `refs = OpenAPIRefs()`
2. per `DOCUMENT_PLAN` entry, in order: for each raw component of that type, `po = IS.deserialize_struct(PI.<Type>, raw)`, `component = from_openapi(<Type>, po, refs)`, add it to the portfolio, then `refs[Int(po.id)] = component`
3. supplemental attributes after components, so their owners resolve
4. `store_ledger!(portfolio, refs)` at the end

Register **after** conversion, exactly as PSY does — a component cannot reference itself, and registering first would mask a dependency-order bug in `DOCUMENT_PLAN`.

- [ ] **Step 1: Note which existing tests cannot run**

`test/test_serialization.jl`'s seven testsets all call `build_portfolio()` and therefore all error on PSCB before reaching an assertion. They cannot gate this task. Do not comment them out — they are the right tests and will pass once PSCB is fixed. Add a single marker comment at the top of the file:

```julia
# TODO(openapi-serde): every testset here needs build_portfolio(), which cannot run
# until PowerSystemCaseBuilder is psy6-compatible. Verified instead by
# test_openapi_converters.jl, which builds components inline.
```

- [ ] **Step 2: Write the failing PSCB-free round-trip test**

Append to `test/test_openapi_converters.jl` — this is what actually gates the task:

```julia
@testset "portfolio round trips through the OpenAPI serialization path" begin
    portfolio = Portfolio(100.0)
    zone = Zone(name="zone_a", id=1)
    req = CarbonTax(name="tax", id=3, available=true)
    PSIP.add_region!(portfolio, zone)
    PSIP.add_requirement!(portfolio, req)
    tech = SupplyTechnology{ThermalStandard}(;
        name="cheap_thermal",
        id=10,
        power_systems_type="ThermalStandard",
        region=[zone],
        requirements=[req],
        capacity_limits=(min=0.0, max=500.0),
        financial_data=TechnologyFinancialData(
            capital_recovery_period=20, technology_base_year=2024,
            debt_fraction=0.6, debt_rate=0.05, return_on_equity=0.1, tax_rate=0.21,
        ),
    )
    PSIP.add_technology!(portfolio, tech)

    path = joinpath(mktempdir(), "portfolio.json")
    PSIP.to_json(portfolio, path; force=true)
    portfolio2 = Portfolio(path)

    tech2 = PSIP.get_technology(
        SupplyTechnology{ThermalStandard}, portfolio2, "cheap_thermal",
    )
    @test !isnothing(tech2)
    @test PSIP.get_parameter_type(tech2) === ThermalStandard
    @test PSIP.get_capacity_limits(tech2, NU) == (min=0.0, max=500.0)
    # references resolve to the deserialized objects, not to copies
    zone2 = PSIP.get_region(Zone, portfolio2, "zone_a")
    @test PSIP.get_region(tech2) == [zone2]
    req2 = PSIP.get_requirement(CarbonTax, portfolio2, "tax")
    @test PSIP.has_requirement(tech2, req2)
    # the ledger records what the document said
    @test PSIP.has_ledger(portfolio2)
    @test PSIP.load_ledger(portfolio2)["id_to_uuid"]["10"] ==
          string(IS.get_uuid(tech2))
end
```

- [ ] **Step 3: Run to verify it fails**

PSB-free command with `r"portfolio round trips through the OpenAPI"`.

- [ ] **Step 4: Rewrite the serialize side**

Replace `IS.serialize(technology::T) where {T <: _CONTAINS_SHOULD_ENCODE}` with a path driven by `to_openapi`. Delete `_CONTAINS_SHOULD_ENCODE`, `ENCODED_FIELDS`, and `serialize_custom_types` outright — the classification they hand-maintained now lives in the generator, and keeping both would let them drift.

Note the asymmetry being fixed: `Requirement` was excluded from `_CONTAINS_SHOULD_ENCODE` (so it serialized through stock IS) but *deserialized* through the OpenAPI path. After this task all four families — technologies, regions, requirements, supplemental attributes — take the same route in both directions.

- [ ] **Step 5: Rewrite the deserialize side**

Rewrite `deserialize_components!` and `deserialize_attributes` per the flow above. Delete `build_model_struct`, the dead `IS.deserialize(::Type{T}, data, component_cache)` (it calls the undefined `deserialize_uuid_handling`), and `deserialize_custom_types`.

Also fix, since they sit directly in the rewritten path:
- `aggregation` is hard-coded to `PSY.ACBus` on deserialize (`src/serialization.jl:257`), discarding the serialized value. Read the serialized value.
- `add_serialization_metadata!` must stop writing `PARAMETERS_KEY`; delete the `PARAMETERS_KEY` and `CONSTRUCT_WITH_PARAMETERS_KEY` consts with it.

Leave `InvestmentScheduleResults` serde alone. It has its own `technology`/`parameter` string pair and is not part of the component document.

- [ ] **Step 6: Mechanical `db_parser.jl` edit**

Only this, nothing more: if any call site sets `power_systems_type` to a value that disagrees with the type parameter it is constructing, make them agree. `grep -n "power_systems_type=" src/db_parser.jl` — all 11 sites currently derive both from the same symbol, so this is expected to be a no-op. Confirm and report.

- [ ] **Step 7: Run the tests**

Compile check, then the PSB-free command with the Step-3 pattern. Expected: PASS.

- [ ] **Step 8: Verify no regression**

Formatter, then the full accumulated pattern. Expected: 539 baseline plus every testset added by Tasks 1–6.

---

## Task 7: Sweep and report

**Files:** whatever the sweep turns up.

- [ ] **Step 1: Hunt the leftovers**

```bash
grep -rn "APIServer\|serialize_openapi_struct\|deserialize_openapi_struct\|ENCODED_FIELDS\|_CONTAINS_SHOULD_ENCODE\|build_model_struct\|PARAMETERS_KEY\|CONSTRUCT_WITH_PARAMETERS_KEY" src/ test/ docs/
```

Every hit is either a deletion this plan missed or a caller that needs updating. Resolve each; none may remain.

- [ ] **Step 2: Update the repo guide**

`.claude/CLAUDE.md`'s "Auto-generated structs" section describes two generated layers, the second being the vendored `open_api_models/` tree. That tree is gone. Rewrite the section to describe the one remaining generated layer and the two platform packages it now targets, and note that generated files carry `from_openapi`/`to_openapi`.

- [ ] **Step 3: Update the design doc**

In `.claude/plans/2026-08-06-psip-serde-strategy-port.md`, mark PR 1 and PR 2 done with a one-line pointer to this plan. Do not rewrite the rest — PRs 3–6 remain proposals.

Note explicitly in that doc that §1b.1's "`id` is transport-only, a Sienna component must not gain an `id` field" is now **contradicted by the shipped code**: psy6's #115 added `id` to the six supplemental-attribute types and this plan builds on it, treating each component's own `id` as the document id. Whoever picks up PR 3 needs to know that decision was made.

- [ ] **Step 4: Full verification**

```bash
julia --project=. -e 'using PowerSystemsInvestmentsPortfolios'
julia --project=scripts/formatter -e 'include("scripts/formatter/formatter_code.jl")'
```
Full PSB-free pattern, then the whole suite (`julia --project=test test/runtests.jl`) purely to confirm every remaining failure is a PSCB `set_units_base_system!` error and nothing else.

- [ ] **Step 5: Write the handoff**

Append a "Session outcome" section to this plan file recording: which tasks completed, the final PSB-free pass count against the 539 baseline, every test commented out with its reason, every parity finding from Task 1 Step 7, and the exact state of the git index (the merge must still be staged, this work must still be unstaged). State plainly that nothing was committed.

---

## Self-review notes

Checked against the three requirements in the request:

1. *Use PowerOpenAPIModels and delete PSIP's OpenAPI-model autogeneration* — Task 1. The vendored tree is deleted, not deprecated; both platform packages become path deps mirroring PowerSystems.jl.
2. *Emit `from_openapi`/`to_openapi` exactly as PSY does, natural units only* — Tasks 2, 3, 4. Same `OpenAPIRefs`, same field classification, same template structure, same loud-failure discipline. Minus the unit-system `Val` axis, which halves the emitted method count. Plus parametric support and vector references, which PSY does not need and PSIP cannot do without.
3. *ext-based id⇄UUID mapping like PSY's* — Task 5. `"_openapi_ledger"` on the Portfolio's `ext`, same three-function API, same framing as a temporary bridge.

Two things the request did not ask for and this plan therefore does not do: a `PortfolioDocument` container and a `case/` directory bundle. Both are PR 3 and PR 4 of the existing strategy doc, and either would change the on-disk format — a much larger blast radius than swapping the payload encoder. Flagging so the omission is a decision rather than an oversight.

One risk worth stating up front: **PSCB cannot run, so `test_serialization.jl` — the only pre-existing test of the code Task 6 rewrites — cannot gate it.** The mitigation is Task 6 Step 2, a PSCB-free round trip built inline that exercises the same path. It is narrower than the seven existing testsets. Treat the serialization rewrite as verified-but-not-proven until PSCB is fixed and `test_serialization.jl` runs green.

---

## Session outcome (2026-08-07)

**Nothing was committed, staged, or pushed.** All of this work is unstaged in the working
tree. See "Git state" below.

### Tasks

All seven completed, each through its own scoped review, then one whole-branch review and
two fix waves.

| Task | Outcome |
|---|---|
| 1 — depend on the platform OpenAPI packages | clean first pass |
| 2 — `OpenAPIRefs` registry | clean first pass |
| 3 — hand-written value converters | clean first pass |
| 4 — generate `from_openapi`/`to_openapi` | clean, 3 minors deferred |
| 5 — `DOCUMENT_PLAN` + id⇄UUID ledger | clean first pass |
| 6 — rewire `src/serialization.jl` | 1 Critical + 2 Important, fixed in one round |
| 7 — sweep + 7 carried findings | clean |

### Tests

**1083 pass / 0 fail / 0 error**, up from a 539 starting baseline. 58 top-level testsets
run; 32 are excluded because they call `build_portfolio()` and PowerSystemCaseBuilder is not
psy6-compatible in this environment (`UndefVarError: set_units_base_system!`). That is
pre-existing and was not touched.

Reproduce with:

```bash
cd test && julia --project=. -e '
using PowerSystemsInvestmentsPortfolios
include("PowerSystemsInvestmentsPortfoliosTests.jl")
using ReTest
retest(PowerSystemsInvestmentsPortfoliosTests, Regex(read("<path-to>/include_pattern.txt", String)))'
```

ReTest aborts the entire run on the first uncaught testset exception, so the runnable set has
to be expressed as a positive filter rather than by exclusion.

### No test was commented out or weakened

`test/test_serialization.jl` carries a `# TODO(openapi-serde):` marker at the top recording
that its seven testsets need `build_portfolio()`. All seven remain intact and will run once
PowerSystemCaseBuilder is fixed. Four lines inside "serialization edge cases" changed
meaning deliberately — see the behaviour changes below. Nothing else in the suite was
skipped, `@test_broken`'d, or loosened; the fix-wave re-review audited all five touched
fixture files and confirmed every edit corrected a fixture that was wrong before.

### Schema parity

`test/test_openapi_parity.jl` now asserts, for all 23 components: every descriptor field
exists on the platform OpenAPI model, and its type matches the model's declared property
type. 197 field-type assertions. Task 1's name-only version found zero mismatches; the
type comparison added in the final fix wave found **five**, all real and all fixed —
`ColocatedSupplyStorageTechnology.operation_costs_inverter`, `operation_costs_solar`,
`operation_costs_wind`, `operation_costs_energy`, `operation_costs_power`, and
`StorageTechnology.operation_costs`.

### Behaviour changes callers must know about

1. **Component ids must now be unique across every component type in a portfolio**, not
   just within a type. The OpenAPI document keys references by one integer id space, so
   `region = [1]` has to name Zone#1 unambiguously. `OpenAPIRefs` errors on a cross-type
   collision at save time. One test fixture already violated this.
2. **`to_json` on a bare component now raises.** Reference resolution needs the export
   registry, which exists only during a portfolio walk. The error names
   `to_json(portfolio, filename)` as the supported entry point, and the docstring says so.
3. **Four cost fields narrowed from the abstract `PSY.OperationalCost` to concrete types**
   (`RenewableGenerationCost`, `StorageCost`, `IS.ProductionVariableCostCurve`). Breaking
   for any caller passing a different cost family. **`PowerSystemsInvestments.jl` was not
   audited** — flag this in the PR description.
4. **`__metadata__` no longer carries `parameters` / `construct_with_parameters`.** The type
   parameter travels in `power_systems_type`, which is now the single carrier. Portfolios
   serialized before this change will not deserialize.

### Known defects left open, deliberately

- **`SupplyTechnology.operation_costs` is wider than its transport type.** The descriptor
  keeps `PSY.OperationalCost` (7 subtypes) against a PO `GenericOperationCost` `oneOf`
  spanning 3. Passing `PSY.StorageCost` fails loudly in `to_openapi`, so it is not the
  silent-corruption class the other five were. Whoever fixes it must also tighten the
  corresponding entry in the parity guard's allowance table, or the guard will keep
  blessing the pairing.
- **Supplemental-attribute associations do not survive a round trip.** The attributes
  themselves do; the attachment does not, because the OpenAPI payload carries no `internal`
  and both objects get fresh UUIDs. Pre-existing, not a regression. The ledger now preserves
  the document's map under `source_id_to_uuid`, which is the raw material a remapping fix
  needs. `test/test_openapi_converters.jl` asserts the loss explicitly so it cannot regress
  silently in either direction.
- **`IS.from_json(io, ::Type{Portfolio})` calls `from_dict` with the wrong arity**
  (`src/serialization.jl`). Pre-existing, untested, untouched.
- **`DBParser` is out of scope** per instruction. One import fix was applied
  (`get_time_series_values`) because it broke a testset; nothing else.
- **Decision 4's id-uniqueness invariant is enforced only at save time**, in
  `_build_export_refs`. A check in `add_technology!` / `add_requirement!` /
  `add_supplemental_attribute!` would surface a collision when it is introduced rather than
  when the portfolio is written.

### Merge fallout fixed outside the plan

The staged merge combined two changes git could not see conflicting: psy6's PR #116 added
`src/validation.jl` written against pre-units accessors, while this branch made every
`needs_conversion` accessor units-aware. 20 call sites in `src/validation.jl` and 12 in
`test/test_validation.jl` gained `IS.NU`. Four `power_systems_type=` literals naming
non-existent PowerSystems types were also corrected.

### Git state

- **Index:** the merge resolution from the earlier task, untouched all session —
  `git diff --cached --stat HEAD` reads `88 files changed, 1405 insertions(+), 884 deletions(-)`.
- **Working tree:** everything in this plan, unstaged.
- Review the merge with `git diff --cached HEAD` and this work with `git diff`.
- **Nothing was committed.**
