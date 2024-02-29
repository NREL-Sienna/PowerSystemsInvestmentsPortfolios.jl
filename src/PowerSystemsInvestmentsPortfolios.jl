module PowerSystemsInvestmentsPortfolios

import InfrastructureSystems
import PowerSystems

export Portfolio
export SupplyTechnology
export TransportTechnology
export DemandTechnology

const PSY = PowerSystems
const IS = InfrastructureSystems

include("technologies.jl")
include("demand.jl")
include("supply.jl")
include("transport.jl")
include("storage.jl")
include("portfolio.jl")

using DocStringExtensions

@template (FUNCTIONS, METHODS) = """
                                 $(TYPEDSIGNATURES)
                                 $(DOCSTRING)
                                 """

end
