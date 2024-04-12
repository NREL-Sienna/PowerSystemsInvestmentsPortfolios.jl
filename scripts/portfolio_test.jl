using Pkg
Pkg.activate("")
Pkg.instantiate()
using Revise
using PowerSystems
import InfrastructureSystems
using PowerSystemsInvestmentsPortfolios
const IS = InfrastructureSystems
const PSY = PowerSystems
const PSIP = PowerSystemsInvestmentsPortfolios

data = PSY._create_system_data_from_kwargs()

bus = ACBus(nothing)
discount_rate = 0.07
investment_schedule = Dict()
port_metadata = PSIP.PortfolioMetadata("portfolio_test", nothing, nothing)

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
)

PSIP.add_technology!(p, t)
IS.serialize(t)
IS.serialize(p)

get_technologies(x -> (!get_available(x)), SupplyTechnology{ThermalStandard}, p)

get_technologies(SupplyTechnology{ThermalStandard}, p)
PSIP.remove_technology!(SupplyTechnology{ThermalStandard}, p, "thermal_tech")

get_available(t)
