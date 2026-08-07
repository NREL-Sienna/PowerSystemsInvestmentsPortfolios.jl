# Port PSY's serde strategy to PSIP — PR proposal

**Date:** 2026-08-06 · **Status:** proposal, nothing implemented · **Branch:** `jd/code_generation`
· **Repos:** PSIP, SiennaSchemas, PowerOpenAPIModels

Companion authority: `psy6/.claude/plans/2026-08-05-openapi-serde-consolidation.md` (the PSY effort
this ports) and `psy6/.claude/plans/2026-08-06-codegen-fork-is-to-psy.md` (the codegen fork).

**No PRs have been opened.** This document is the draft to review before anything is pushed.

## 1. Where PSIP is today

PSIP is almost exactly where PSY was before the consolidation campaign began.

`src/serialization.jl` (**1005 lines**) is the same pre-OpenAPI path PSY is deleting, symbol for
symbol:

| PSIP | PSY equivalent being deleted |
|---|---|
| `METADATA_KEY`, `TYPE_KEY`, `MODULE_KEY`, `PARAMETERS_KEY`, `CONSTRUCT_WITH_PARAMETERS_KEY` | IS metadata-encoding scheme |
| `_CONTAINS_SHOULD_ENCODE`, `ENCODED_FIELDS` | `src/models/serialization.jl` UUID-encoding machinery |
| `IS.serialize(portfolio)` / `deserialize` / `deserialize_components!` | `IS.serialize(sys)` / `IS.deserialize(System,…)` / `deserialize_components!` |
| `add_serialization_metadata!`, `from_dict`, `build_model_struct` | the same helpers |
| `to_json`, `IS.from_json`, `_serialize_portfolio_metadata_to_file`, `_post_deserialize_handling` | `IS.to_json`, `IS.from_json`, `_serialize_system_metadata_to_file`, `_post_deserialize_handling` |

So the target state is the same: **the OpenAPI document becomes the only serialization format**, with
one owner per layer.

## 1a. Two generation pipelines — never conflate them

This distinction governs every PR below and is the easiest thing in the effort to get catastrophically
wrong, because the two pipelines produce types with **identical names**.

| | Pipeline A — OpenAPI transport | Pipeline B — Sienna structs |
|---|---|---|
| What it emits | plain data-transfer structs | real Sienna **components** |
| Carries | fields only | `InfrastructureSystemsInternal`, accessors/setters, constructors, supertypes, validation hooks — all the IS component-management technicalities |
| Generator | openapi-generator, in the `PowerOpenAPIModels` repo | **PSIP's own** `src/generate_structs.jl` |
| Source of truth | SiennaSchemas | today: PSIP's `src/descriptors/SiennaInvestSchema.json` |
| Lives in | `PowerInvestmentsOpenAPIModels` / `PowerCoreOpenAPIModels` (today: PSIP's vendored `src/models/generated/open_api_models/`) | `src/models/generated/*.jl` |

`PowerInvestmentsOpenAPIModels.Node` and `PSIP.Node` are different things and **both must exist**.
Matching type names do not make them redundant. Pipeline B is not being replaced by anything.

## 1b. Direction: Pipeline B should read SiennaSchemas too

**User direction, 2026-08-06.** PSIP was built after PSY, so it can do what PSY cannot cheaply do: have
its *Sienna struct* generation read **SiennaSchemas** directly, instead of maintaining
`src/descriptors/SiennaInvestSchema.json` as a schema parallel to it. PSY's equivalent
(`power_system_structs.json`) is entrenched and mirrored by SiennaSchemas with a parity checker to
catch drift; PSIP can skip that entire apparatus by having one source of truth from the start.

**This makes §2's drift structurally impossible rather than merely fixed.** Note the ordering
consequence: PR 2 adopts SiennaSchemas-generated *transport* models while Pipeline B still generates
from `SiennaInvestSchema.json`, so between PR 2 and this change PSIP has **two sources of truth for
one domain** — drift becomes a live risk instead of a historical one. That is acceptable as a
transient, and it is the argument for scheduling this soon after PR 2 rather than late.

### 1b.1 Measured gap — this is a schema-extension effort, not a swap

Checked 2026-08-06 against `Investments/Technologies/ColocatedSupplyStorageTechnology.json` and
PSIP's `SupplyTechnology` entry. Pipeline B's generator needs metadata SiennaSchemas does not carry.

| Per-type key PSIP's generator consumes | In `SiennaInvestSchema.json` | In `SiennaSchemas/Investments/` |
|---|---|---|
| `supertype` — the Sienna type hierarchy | yes | **absent** |
| `parametric` — type parameters | yes | **absent** |
| `docstring` | yes | **absent** |
| field `type` | **Julia** types (`String`, `Vector{RegionTopology}`) | JSON Schema types |
| field `default` | **Julia expressions** (`Vector()`) | JSON defaults |

Two further mismatches:

- **`id` is transport-only.** SiennaSchemas types carry `id` because the document keys components by
  it; a Sienna component must not gain an `id` field — it has `InfrastructureSystemsInternal` and a
  UUID. Pipeline B needs a skip-list, the mirror image of PSY's `OPENAPI_SKIP_FIELDS`.

  > **Superseded 2026-08-07 — this claim is contradicted by the shipped code.** psy6's #115 added an
  > `id` field to the six supplemental-attribute types, and every one of PSIP's 23 generated
  > components already declares `id::Int64`. `.claude/plans/2026-08-07-psip-openapi-serde.md` builds
  > on that: it treats each component's **own** `id` as the document id (Decision 4), so
  > `_build_export_refs` registers `refs[get_id(c)] = c` instead of running a counter, and `id` is
  > *not* on the skip list — `OPENAPI_SKIP_FIELDS` is `{"ext", "internal"}` only. Whoever picks up
  > PR 3 must design the `PortfolioDocument` id space around component-owned ids, and must know that
  > the "one shared id counter" idea below no longer has anything to count: duplicate ids across
  > types are now a data bug that `OpenAPIRefs.setindex!` rejects.
- Field counts differ (that same type has 31 fields in SiennaSchemas), so the switch needs a
  per-type field reconciliation, not just a metadata addition.

**Hard constraint (user, 2026-08-06): no schema extensions.** SiennaSchemas is not modified by this
effort — no `x-sienna-*` keys, no new properties, no per-type additions. That rules out the otherwise
idiomatic option of extending the schemas, and it keeps the whole change inside PSIP with no
cross-repo PR.

So the work splits cleanly in two:

1. **Derive everything derivable from the schema as it stands.** Field names, JSON types → Julia
   types via a mapping table, optionality from `required`, descriptions → field comments, defaults
   where expressible. This is the bulk of the per-field work and needs no metadata that isn't already
   in SiennaSchemas.
2. **Keep the genuinely Sienna-only metadata in PSIP.** `supertype`, `parametric`, `docstring`, and
   the transport-field skip-list (`id`) describe Julia/IS structure, not the data contract — they have
   no business in a language-neutral schema anyway, so PSIP is their correct home. Whether that is a
   slimmed PSIP descriptor keyed by type name, or declarations in the generator itself, is the design
   step's call.

The constraint is a clarifying one: SiennaSchemas owns **the data shape**, PSIP owns **the Julia
component structure**. The parallel-schema problem in §2 is solved by PSIP no longer restating field
definitions, not by moving Julia concerns into the schema.

**Scheduled 2026-08-06** (user direction). Design step runs now as read-only analysis — it does not
contend with PR 2. Implementation follows once PR 2 lands, since both touch
`src/generate_structs.jl`.

## 2. The finding that should shape the whole effort

**PSIP duplicates a platform pipeline that already exists.** PSIP vendors its own OpenAPI models at
`src/models/generated/open_api_models/src/APIServer.jl` — 56 generated `.jl` files — produced from its
own `src/descriptors/SiennaInvestSchema.json`, which is a schema parallel to SiennaSchemas rather than
part of it.

Meanwhile both halves of the platform path already exist:

- `SiennaSchemas/Investments/` — a full domain (`Attributes`, `Financials`, `Regions`,
  `Requirements`, `Technologies`), with `openapi-config-investments.json`
- `PowerOpenAPIModels/PowerInvestmentsOpenAPIModels.jl` — **24 generated models**

Measured overlap of PSIP's 56 vendored models:

| Group | Count | Platform home | Status |
|---|---|---|---|
| Investments domain types (`AggregateRetirementPotential` … `Zone`) | 24 | `PowerInvestmentsOpenAPIModels` | **exact name match — duplicated today** |
| Core cost/curve types (`CostCurve`, `FuelCurve`, `ValueCurve`, `*FunctionData`, `MinMax`, `UpDown`, `InOut`, `XYCoords`, `ThermalGenerationCost`, `StorageCost`, …) | ~30 | `PowerCoreOpenAPIModels` | duplicated; PSY already consumes these |
| `InvestmentScheduleResults`, `InvestmentScheduleResultsResultsInner` | 2 | none | **PSIP-only; needs a decision (§4 D2)** |

Porting the serde without addressing this would mean building the new path on a duplicated model
layer, which is the thing PSY's effort spent most of its time undoing.

## 3. Units — PSIP's are ABSOLUTE, not relative. Corrected 2026-08-06.

**This section previously said PSIP has no units engine. That was measured against `main` and is
wrong for the target branch.** All work lands on **`jp/unit_prototype`** (user, 2026-08-06), which is
**72 commits ahead of `main`** and is almost entirely a units campaign. Re-measured there:

| | `main` | **`jp/unit_prototype`** (the base that matters) |
|---|---|---|
| `needs_conversion` fields in descriptor | 0 | **67** |
| units engine | none | `src/units/{types,conversions,function_conversions}.jl` |
| generator location | `src/generate_structs.jl` (217 lines) | **`src/utils/generate_structs.jl` (327 lines)** |
| units-accessor emission | none | **already ported from IS/PSY** |

The generator on that branch already emits IS's units block — `{{#needs_conversion}}`,
`IS._strip_units`, `get_value(value, Val(:{{name}}), Val({{conversion_unit}}), units)`,
`display_units_arg`. So PSIP has unit-aware getters and setters today.

**The real distinction, which still matters as much as the original claim did:** PSIP's units are
**absolute Unitful quantities**, not relative per-unit bases. `src/units/types.jl` defines
`@dimension Money`, `@refunit USD`, `MMBtu`, `tonne`, and re-exports `MW`/`kV`/`Ω`/`S`; the
`conversion_unit` values are `:mw`, `:usd_per_mwh`, `:usd_per_mw`, `:yr`, `:hr`, `:mwh`, `:ohm`,
`:usd_per_t`, `:usd_per_mmbtu`, `:t`. Every one is an absolute physical or monetary unit. There is no
system base, no device base, no `base_power` anchoring, and no `pu`.

Consequences for the serde port — the conclusion survives, the reasoning does not:

- **Still no `Val{:DEVICE_BASE}` / `Val{:NATURAL_UNITS}` method pairs.** Not because PSIP lacks units,
  but because it has only **one** representation. PSY needs the pair because a document can state
  values in either of two per-unit bases; a PSIP quantity in MW is just in MW.
- **Still one `from_openapi` / `to_openapi` per type**, not two. PSY's `/simplify` pass flagged those
  pairs as ~500 lines of near-duplication existing solely because PSY has two bases. PSIP should not
  inherit that cost.
- **But the document does need a unit contract**: which absolute unit each field is stated in. That is
  what SiennaSchemas' `x-unit` annotations already carry, so the converter reads them rather than
  inventing a basis dichotomy.
- **`base_power` is irrelevant here.** The missing-`base_power` codegen rejection that forced 8
  hand-written converters in PSY (its §5.6) has no PSIP analogue.

**Defect found while re-measuring, worth fixing separately:** the generator's accessor docstring
template (`src/utils/generate_structs.jl:66`) was copied from IS verbatim and tells the reader to pass
`SU` or `DU` — relative-basis markers **PSIP does not have**. Every unit-bearing accessor in PSIP's
generated code therefore carries a docstring describing PSY's units model, not PSIP's.

## 4. Decisions needed before PR 1

| # | Decision | Recommendation |
|---|---|---|
| D1 | Converge PSIP onto `SiennaSchemas/Investments` + `PowerInvestmentsOpenAPIModels`, or keep the vendored `open_api_models/` tree? | **Converge.** The 24 domain names already match exactly, and the Core curve types are the same ones PSY consumes. Keeping both means every schema change lands twice. |
| D2 | Where does `InvestmentScheduleResults` live? | It is **results, not portfolio data** — a different lifecycle from components. Recommend keeping it PSIP-local (its own small vendored model or a hand-written struct) rather than pushing it into SiennaSchemas, unless another package needs to read schedules. |
| D3 | Does PSIP adopt the D10 two-association-table rule? | **Yes** — time series and supplemental attributes only. Whatever association tables the portfolio document needs must fold into `SupplementalAttributeAssociation` with its optional index/role, exactly as in PSY. |
| D4 | Does PSIP's generator become a submodule with no export, matching the PSY fork? | **Yes.** PSIP currently flat-includes and `export generate_structs` (`PSIP.jl:120,181`). PSY now uses `PowerSystems.StructGeneration` with no export. Aligning is cheap and it is the hygiene decision already taken. |

D1 is the gating decision; PRs 2 onward assume "converge".

## 5. Proposed PR sequence

Each PR is independently reviewable and leaves PSIP working. Ordered so no PR depends on a later one.

### PR 1 — generator hygiene + PSY-shaped converter emission — ✅ DONE
Implemented by `.claude/plans/2026-08-07-psip-openapi-serde.md` (Tasks 4–6).

`src/generate_structs.jl` → `module StructGeneration`, no export, qualified entry point
(`PSIP.StructGeneration.generate_structs`). Then upgrade its emission from the current
`serialize_openapi_struct` / `deserialize_openapi_struct` pair to PSY's `from_openapi` / `to_openapi`
shape with a refs registry — **single-method per type per §3, no unit Vals**.
*Gate:* generated output diffed deliberately; every emission change reviewed, since this one is
intentionally not byte-identical.

### PR 2 — adopt the platform model packages (D1) — ✅ DONE
Implemented by `.claude/plans/2026-08-07-psip-openapi-serde.md` (Task 1). Parity result: 23/23
components, zero descriptor fields missing from the platform models.

Depend on `PowerInvestmentsOpenAPIModels` + `PowerCoreOpenAPIModels`; delete the vendored
`open_api_models/` tree (56 files). Reconcile any field drift between `SiennaInvestSchema.json` and
`SiennaSchemas/Investments/` **before** deleting, and record each difference — drift found here is a
real schema finding, not noise to flatten.
*Gate:* `check_psy_parity.py`-equivalent for the Investments domain; PSIP suite green.

### PR 3 — `PortfolioDocument` container + two association tables (D3)
A `PortfolioDocument` mirroring `SystemDocument`: `components` bucketed by type name, a flat
`supplemental_attributes` array, `supplemental_attribute_associations`, `time_series_associations`,
and a single shared id counter. **One id space** — PSY's §3.2b defect (two counters both starting at
1, so id 1 meant two different things) is pre-empted by construction, not fixed later.
*Gate:* container fields drift-checked against the schema; round-trip on a real portfolio.

### PR 4 — `to_file` / `from_file` directory bundle
`case/{portfolio.json, time_series.h5}`, replacing `to_json` / `from_json`. PSIP already depends on
HDF5, so the sidecar half is in place. Carry the portfolio's `name`/`description` metadata explicitly
— PSY's §4.2 found the old path silently dropped exactly those.
*Gate:* bundle round-trip reproduces the portfolio including metadata.

### PR 5 — delete the old serde path
Remove `src/serialization.jl`'s metadata-encoding and UUID machinery, `to_json`/`from_json`, and
`_post_deserialize_handling`. **Prerequisite, learned the hard way in PSY (§8.6):** converter
coverage first. Any type reachable in a live `Portfolio` but absent from the document has *no*
serialization route once this lands. Enumerate coverage before deleting, not after.
*Gate:* `grep -r "to_json\|from_json"` over `src/` returns nothing; suite green.

### PR 6 — `db_parser.jl` alignment (optional, separate)
1683 lines of SQLite reading. Only in scope if the document becomes its interchange format too;
otherwise leave it alone and say so.

## 6. Lessons from PSY worth importing for free

These cost real debugging time in PSY. They are cheap to pre-empt in PSIP.

- **One id space, from the start** (§3.2b) — the container owns the counter; components and
  supplemental attributes both draw from it.
- **No silent `ext` drop** (§3.1) — an unmapped key errors naming key/id/type; an ignore-list entry is
  a *declared* skip with a reason. PSY lost 352 entries silently before this.
- **Forecasts must be in the document** (§8.5d) — PSY's export walked only `SingleTimeSeries`, so no
  forecast survived, and the cache silently returned `forecast_count == 0`. Walk the forecast types
  from day one.
- **Memoize shared supplemental attributes per id on import** (§8.5e) — otherwise one shared
  attribute becomes N independent copies.
- **Optional references** (§8.5b) — emit `resolve_ref(refs, po.x)`, never `refs[po.x]`; an omitted
  optional reference arrives as `nothing` and `refs[nothing]` is a `MethodError`.
- **Guard lossy caching** (§8.5f) — if anything caches a serialized portfolio, it must refuse when the
  object carries types the document cannot represent, or the cache silently truncates.

## 7. Out of scope

PSY-side work, SiennaGridDB's four-association-table collapse (§5.5 of the PSY plan), and the IS
codegen system-base fallback (§5.6). None of it blocks PSIP.
