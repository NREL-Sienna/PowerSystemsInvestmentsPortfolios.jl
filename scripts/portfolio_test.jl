using Pkg
Pkg.activate("")
Pkg.instantiate()
using Revise
using PowerSystems
using InfrastructureSystems
using PowerSystemsInvestmentsPortfolios
const IS = InfrastructureSystems
const PSY = PowerSystems
const PSIP = PowerSystemsInvestmentsPortfolios

p = Portfolio(0.07)

t = SupplyTechnology{ThermalStandard}(
    "thermal_tech",
    true,
    ThermalStandard,
    PSY.ThermalFuels.COAL,
    PSY.PrimeMovers.ST,
    0.98, # cap factor
    nothing,
    nothing,
    IS.SupplementalAttributesContainer(),
    IS.TimeSeriesContainer(),
    IS.InfrastructureSystemsInternal(),
)

PSIP.add_technology!(p, t)
PSIP.remove_technology!(SupplyTechnology{ThermalStandard}, p, "thermal_tech")
