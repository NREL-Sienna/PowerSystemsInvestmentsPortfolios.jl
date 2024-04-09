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

data = PSY._create_system_data_from_kwargs()

bus = ACBus(nothing)
discount_rate = 0.07
investment_schedule = Dict()
port_metadata = PSIP.PortfolioMetadata("portfolio_test", nothing, nothing)

p = Portfolio(
    ACBus,
    discount_rate,
    data,
    investment_schedule,
    port_metadata,
    nothing,
    IS.TimeSeriesContainer(),
    IS.InfrastructureSystemsInternal(),
)

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
