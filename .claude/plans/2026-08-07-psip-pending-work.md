# PSIP pending work — consolidated

**Written:** 2026-08-06, end of session · **Branch:** `jp/psy6_updates` · **Supersedes:**
`2026-08-06-psip-serde-strategy-port.md` and `2026-08-06-pipeline-b-siennaschemas-spec.md`
(deleted; their findings are folded in below, condensed).

## 0. Read this first: unresolved merge, discovered at session end

The working tree is mid-`git merge` (`git merge origin/psy6`, `MERGE_HEAD` present), started
outside this session. **Do not resolve by guessing** — several conflicts overlap the unit
corrections just committed (`1325465`).

Conflicted files:

| File | Markers | Note |
|---|---|---|
| `src/descriptors/SiennaInvestSchema.json` | 0 (needs `git add` once verified) | auto-merged, unstaged |
| `src/models/generated/{AggregateRetirementPotential,AggregateRetrofitPotential,ExistingDevices,RetirementPotential,RetrofitPotential,TopologyMapping}.jl` | 5–8 each | see below |
| `src/models/generated/open_api_models/src/models/model_{GenericOperationCost,SupplyTechnology}.jl` | 1 each | vendored OpenAPI models |
| `test/test_serialization.jl` | 1 | new "serialization edge cases" testset vs. HEAD content |

**Concrete finding:** the six `AggregateRetirementPotential`/…/`TopologyMapping` conflicts are
`origin/psy6` adding a real `id` field to every one of them, e.g.:

```julia
<<<<<<< HEAD
function TopologyMapping(; buses=Vector(), ext=Dict(), internal=InfrastructureSystemsInternal(), )
=======
function TopologyMapping(; internal=InfrastructureSystemsInternal(), buses=Vector(), id, ext=Dict(), )
>>>>>>> origin/psy6
```

This is **exactly** the blocker §2.5 of the old pipeline-b spec called out ("the six Attribute
types disagree on `id`... needs a decision") — `origin/psy6` appears to have already decided:
add `id`. Verify that's really the intent (check `origin/psy6`'s commit message/PR) before taking
that side; if confirmed, the six-type gap in §4 below is resolved for free.

`origin/psy6` also carries substantial unrelated work not seen this session: `src/validation.jl`
(new), `test/test_validation.jl` (new), a `ThermalRenewableGenerationCost` → `GenericOperationCost`
rename across the vendored `open_api_models/` tree, and `.claude/Sienna.md` deleted. Read the
actual `origin/psy6` diff before resolving — this is more than a small conflict.

**First action tomorrow:** resolve this merge (or abort it and re-approach deliberately) before
anything else in this document. Nothing below assumes it's resolved.

## 1. Where the branch stands otherwise

Pushed today (`09e4f99..4dde468`, before the merge above started):
- `1325465` — corrected 9 unit mismatches between the descriptor and SiennaSchemas.
- `4dde468` — `src/utils/generate_structs.jl` repackaged as a `StructGeneration` submodule
  (own imports, not exported; qualified entry point
  `PowerSystemsInvestmentsPortfolios.StructGeneration.generate_structs`). Verified byte-identical
  against the pre-wrap generator.

Committed externally during the session (not by this agent):
- `cb51577` — DBParser submodule move.
- `1db8fe2` — docs/CLAUDE.md updates.

**Known, not-yet-fixed bug in the DBParser submodule** (found while test-running, still true after
`cb51577`): `src/db_parser.jl:1771`, `deserialize_time_series_from_metadata!` calls
`get_time_series_values` unqualified inside the `DBParser` submodule without importing it —
`UndefVarError: get_time_series_values not defined in PowerSystemsInvestmentsPortfolios.DBParser`.
Fix: add it to `DBParser`'s explicit import list (it's exported by both `InfrastructureSystems`
and `PowerSystems`; pick one, don't rely on the ambient `using`).

**Pre-existing test blockers, confirmed unrelated to any work above** — do not spend time
attributing new failures to today's changes without ruling these out first:
- `Aqua.test_undefined_exports` flagged `database_to_portfolio` as an orphaned export after the
  DBParser move; current tree no longer exports it (fixed by `cb51577` or the merge — reverify
  after the merge above lands).
- `PowerSystemCaseBuilder` calls `set_units_base_system!`, removed from psy6 `PowerSystems`
  (`~/.julia/packages/PowerSystemCaseBuilder/8gBax/src/build_system.jl:98`). Blocks every test that
  calls `build_portfolio()`/`PowerSystemCaseBuilder.build_system` — most of the suite. Not PSIP's
  bug; needs a PSB-side fix, track separately.
- An apparent Unitful/`Mt` resolution difference in `test/test_units.jl` between two working-tree
  states that should have been equivalent (unexplained; noted, not root-caused). Re-check once the
  merge is resolved — the mystery may just have been the merge's parent tree already shifting under
  the two runs.

Left uncommitted, deliberately: none — docs/.claude were committed externally as `1db8fe2`.

## 2. Tomorrow's headline task: JSON3 → JSON 1.0 + adopt PowerOpenAPIModels serde for file I/O

Grounded findings, not yet a design:

- PSIP depends only on `JSON3` (`Project.toml`), used in `src/serialization.jl`,
  `src/PowerSystemsInvestmentsPortfolios.jl`, `src/db_parser.jl`, `src/utils/generate_structs.jl`.
  **No `JSON` (1.x) dependency exists today.**
- PSY's already-built OpenAPI serde path uses **`JSON` (1.x)**, not JSON3 —
  `PowerSystems/Project.toml:11` (`JSON = "682c06a0-..."`, compat `^1.5`), and
  `src/openapi/import_document.jl` reads via `JSON.parsefile`. `PowerCoreOpenAPIModels.jl` (the
  package PSIP would depend on) itself uses **both** `JSON3` and `JSON` together
  (`using OpenAPI, JSON3, HTTP, JSON, TimeZones`).
- PSY's file-format shape to mirror (`src/openapi/file_io.jl`): a directory bundle,
  `case/{system.json, time_series.h5}` — the OpenAPI document owns JSON, PSY/IS's HDF5 storage
  layer owns the sidecar, the document records only the sidecar's basename. `to_file`/`from_file`
  replace `to_json`/`from_json`. This is a direct model for PSIP's `Portfolio` (which already
  depends on HDF5).

This is **PR 2 + PR 4** of the old serde-strategy-port plan (§5 there), not a new idea — see §3
below for the full sequence. Concretely, before writing code:

1. Confirm whether PSIP should drop `JSON3` entirely or keep it alongside `JSON` the way
   `PowerCoreOpenAPIModels` does (check every current `JSON3` call site above for a real reason to
   keep it — e.g. does `generate_structs.jl`'s `JSON.parse` need JSON3-specific behavior?).
2. Decide **D1** (converge on `SiennaSchemas/Investments` + `PowerInvestmentsOpenAPIModels` /
   `PowerCoreOpenAPIModels`, deleting PSIP's vendored `src/models/generated/open_api_models/` — 56
   files) before writing the file-IO layer on top of a model tree that's about to be replaced.
   **Do this after the merge in §0 lands** — that merge already touches the vendored tree
   substantially (renames, new/deleted models); converging on the platform package first avoids
   reconciling two moving targets.
3. Reconcile field drift between `SiennaInvestSchema.json` and `SiennaSchemas/Investments/` before
   deleting the vendored tree (old plan's PR 2 gate) — record every difference found.
4. Design `PortfolioDocument` (mirrors `SystemDocument`): components bucketed by type name, flat
   `supplemental_attributes`, associations, **one shared id counter** (PSY's two-counter defect,
   §3.2b of the PSY plan, is a pre-empt-by-construction item here, not a fix-later one).
5. Only then: `to_file`/`from_file` as `case/{portfolio.json, time_series.h5}`, replacing
   `to_json`/`from_json`. Carry `name`/`description` metadata explicitly (PSY's port silently
   dropped exactly these once, per its own §4.2).
6. Delete the old `src/serialization.jl` metadata/UUID machinery last, and only after enumerating
   every type reachable in a live `Portfolio` that the new document format can serialize — PSY lost
   coverage silently doing this out of order.

**Decisions still needed before implementation** (D2, D3 from the old plan, still open):
- Where does `InvestmentScheduleResults` live — results, not portfolio data; recommend keeping it
  PSIP-local rather than pushing into SiennaSchemas.
- Does PSIP adopt PSY's two-association-table rule (time series + supplemental attributes only)?
  Recommend yes.

## 3. Longer-horizon: Pipeline B (`generate_structs.jl`) reading SiennaSchemas directly

Not blocking §2, scheduled after it since both touch the same file. Condensed from the deleted
spec — full field-by-field data is not reproduced here; regenerate it (a `python3` walk of both
JSON trees, described in the deleted doc's Appendix) if this section is picked up.

**Corrections already banked, don't re-derive:**
- `id` is **not** transport-only — 17 of PSIP's 23 generated types have a real, load-bearing
  `id::Int64` (foreign-key cross-references PSIP's `db_parser.jl` resolves 40+ times). Skip-list is
  just `ext`, `internal`.
- Type inventory is already aligned: all 23 PSIP types have an exact-name SiennaSchemas match, no
  additions/removals needed at the type level. All real work is field- and unit-level.

**Confirmed blockers needing a decision before switching the field source** (numbers below are
from SiennaSchemas as of 2026-08-06; re-verify if `origin/psy6` changed the schema too):
1. **`ColocatedSupplyStorageTechnology.operation_costs_inverter`** — PSIP types it
   `PSY.OperationalCost` (the full wrapper); SiennaSchemas `$ref`s `ProductionVariableCostCurve`
   (one level shallower). Compile-fails loudly if resolved wrong — lowest-risk blocker.
2. **Six Attribute types' missing `id`** — likely already resolved by the `origin/psy6` merge in
   §0; confirm, don't re-decide if so.
3. **9 unit mismatches** between PSIP's `conversion_unit` and SiennaSchemas' `x-unit` — same list
   already resolved and committed today for the *values* (`1325465`); this item is about switching
   Pipeline B's *field-sourcing* to read the annotation from SiennaSchemas going forward, so the
   two sources don't drift again. Highest-severity risk if sequenced wrong: switching field-sourcing
   before unit-sourcing is decided reintroduces silent 60×/10⁶× errors with no test signal.
4. **Nullable-vs-synthetic-default ambiguity** — e.g. `StorageTechnology.capital_costs_charge`
   (`Union{Nothing,T}`) vs. `capital_costs_discharge` (`T` with default) are byte-identical in
   SiennaSchemas. Genuinely unrecoverable from the schema; needs a per-field override table, not a
   derivation rule.
5. **`price_per_unit` and `operation_costs_power` basis disagreements** — already relabeled
   correctly in `1325465` (USD/t, USD/MWh); no live blocker, listed for completeness.

**Where Sienna-only metadata should live:** a slimmed `src/descriptors/psip_sienna_metadata.json`
keyed by type name (`supertype`, `parametric`, `docstring`, `field_overrides` for the ambiguous
cases only) — not embedded in the generator, not restating anything SiennaSchemas already states
plainly. Full shape and the six categories of schema-unrecoverable ambiguity (enum-keyed `Dict`s,
FK element type, nullable-default, numeric width, `$ref`-title→Julia-type naming, composite
defaults) are in the deleted spec's §4–5 — regenerate the table rather than trust a stale copy here
if this work resumes far in the future.

**Also noted, not yet acted on:**
- `SupplyTechnology.co2` (`Dict{ThermalFuels,Float64}`) has a SiennaSchemas `x-unit` (`t/MMBtu`)
  the generator's accessor template can't express (scalar-only `Val`-dispatch). Adding Dict-valued
  unit conversion is a real feature, not a mechanical port — don't fold it into a field-source
  swap.
- SiennaSchemas itself has two disagreeing `TechnologyFinancialData` definitions
  (`Core/common.json`'s bare 6-field version, actually `$ref`'d everywhere, vs. a standalone 7-field
  version with `id` + units that nothing references). SiennaSchemas-internal, report upstream,
  don't fix here.
- `SiennaSchemas/scripts/check_psip_parity.py` is broken against this branch's descriptor shape
  (`TypeError: list indices must be integers or slices, not str` — expects an OpenAPI-object
  `components`, PSIP's is an array). Cheap, independent fix; do it first, it becomes this whole
  section's verification gate.
- The generator's accessor docstring template still tells readers to pass `SU`/`DU` — relative-unit
  markers PSIP doesn't have (PSIP's units are absolute Unitful quantities). Cosmetic, one-line fix,
  unscheduled.

## 4. Style/process reminders that applied today, still apply

- No commits/pushes without explicit instruction; this document itself is intentionally left
  uncommitted (`.claude/` is excluded from the commit spree per today's instruction).
- No schema edits to SiennaSchemas as part of any of this (hard constraint, unchanged).
- Byte-identical-output gates don't apply once Pipeline B's *source of truth* changes (§3) — use a
  named-diff gate instead (every changed generated line must trace to an item in §3's blocker list).
