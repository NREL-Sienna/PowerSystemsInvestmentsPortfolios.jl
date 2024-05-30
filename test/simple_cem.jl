using HiGHS
using JuMP
using DataFrames

abstract type GenTech end
abstract type InvestmentModel end
abstract type OperationModel end
abstract type RegionalModel end
abstract type OptimizationModel end
#mutable struct ThermalGen <: GenTech end

# Structure used to define thermal generation assets
struct ThermalGen <: GenTech
    tech::String
    init_cap::Float32
    cap_max::Dict
    cap_min::Dict
    outage_derate::Float32
    capex::Dict
    fixed::Dict
    var::Dict
end


#Structure used to define renewable generation assets
struct RenewableGen <: GenTech
    tech::String
    init_cap::Float32
    cap_max::Dict
    cap_min::Dict
    outage_derate::Float32
    capex::Dict
    fixed::Dict
    var::Dict
    vcf::Dict
end

#struct to define basic capacity expansion model, broken down into operation and InvestmentModel
struct SimpleInvest <: InvestmentModel end
struct SimpleOp     <: OperationModel  end

#Defining Model types:
inv = SimpleInvest()
op = SimpleOp()

# Defining empty dictionaries for constraints, expressions, variables, etc. How is this done in Sienna?

# investment definitions
build = Dict()
capacity = Dict()
build_nonneg = Dict()
cap_bounds = Dict()
capital_costs = Dict()
fom_costs = Dict()

#operations definitions
dispatch_lb = Dict()
dispatch_ub = Dict()
dispatch_limit = Dict()
demand_matching = Dict()
vom_costs = Dict()

##################
# Investment variables
##################

function add_variables!(model, T::ThermalGen, U::SimpleInvest)
    print("Thermal investment variables called \n")
    for t in T_i

        # Build and capacity variables
        build[T.tech, t] =    JuMP.@variable(model)
        capacity[T.tech, t] = JuMP.@expression(model, (T.init_cap + sum( build[T.tech,t_p] for t_p in T_i if t_p <= t)))

        # Investment and FOM cost calculations
        capital_costs[T.tech, t] = JuMP.@expression(model, T.capex[t]*build[T.tech, t])
        fom_costs[T.tech, t] = JuMP.@expression(model, T.fixed[t]*capacity[T.tech, t])

    end

end

function add_variables!(model, T::RenewableGen, U::SimpleInvest)
    print("Renewable investment variables called\n")
    for t in T_i

        # Build and capacity variables
        build[T.tech, t] =    JuMP.@variable(model)
        capacity[T.tech, t] = JuMP.@expression(model, (T.init_cap + sum( build[T.tech,t_p] for t_p in T_i if t_p <= t)))

        # Investment and FOM cost calculations
        capital_costs[T.tech, t] = JuMP.@expression(model, T.capex[t]*build[T.tech, t])
        fom_costs[T.tech, t] = JuMP.@expression(model, T.fixed[t]*capacity[T.tech, t])

    end

end

############
# Operations variables
############

function add_variables!(model, T::ThermalGen, U::SimpleOp)
    print("Thermal operation variable called \n")
    for t in T_o

        #Dispatch Variable
        dispatch[T.tech, t]  =    JuMP.@variable(model)
        
        #VOM costs
        vom_costs[T.tech, t] =    JuMP.@expression(model, dispatch[T.tech, t]*T.var[T_io[t]])

    end

end

function add_variables!(model, T::RenewableGen, U::SimpleOp)
    print("Renewable operation variable called\n")
    for t in T_o

        # Dispatch Variable
        dispatch[T.tech, t] =    JuMP.@variable(model)

        #VOM costs
        vom_costs[T.tech, t] =    JuMP.@expression(model, dispatch[T.tech, t]*T.var[T_io[t]])

    end

end

############
# Investment constraints
############

function add_constraints!(model, T::RenewableGen, U::SimpleInvest)
    print("Renewable investment constraints called\n")
    for t in T_i

        # Build and capacity variable bounds
        build_nonneg[T.tech, t] = JuMP.@constraint(model, 0 <= build[T.tech, t])
        cap_bounds[T.tech, t] =   JuMP.@constraint(model, T.cap_min[t] <= capacity[T.tech, t] <= T.cap_max[t])

    end

end

function add_constraints!(model, T::ThermalGen, U::SimpleInvest)
    print("Thermal investment constraints called\n")
    for t in T_i

        # Build and capacity variable bounds
        build_nonneg[T.tech, t] = JuMP.@constraint(model, 0 <= build[T.tech, t])
        cap_bounds[T.tech, t] =   JuMP.@constraint(model, T.cap_min[t] <= capacity[T.tech, t] <= T.cap_max[t])

    end

end

###########
# Operations Constraints
###########

function add_constraints!(model, T::RenewableGen, U::SimpleOp)
    print("Renewable operations constraints called\n")
    for t in T_o

        # Dispatch Variable
        dispatch_lb[T.tech, t] =    JuMP.@constraint(model, 0 <= dispatch[T.tech, t])
        dispatch_ub[T.tech, t] =    JuMP.@constraint(model, dispatch[T.tech, t] <= T.vcf[t]*T.outage_derate*capacity[T.tech, T_io[t]])

    end

end

function add_constraints!(model, T::ThermalGen, U::SimpleOp)
    print("Thermal operatiosn constraints called\n")
    for t in T_o

        # Dispatch Variable
        dispatch_lb[T.tech, t] =    JuMP.@constraint(model, 0 <= dispatch[T.tech, t])
        dispatch_ub[T.tech, t] =    JuMP.@constraint(model, dispatch[T.tech, t] <= T.outage_derate*capacity[T.tech, T_io[t]])

    end

end

function add_constraints!(model, U::SimpleOp)
    print("system operations constraints called\n")
    for t in T_o

        demand_matching[t] = JuMP.@constraint(model, loads[t] <= sum(dispatch[g,t] for g in gens))

    end

end

#############
# Objective function
#############

function add_objective_function!(model)
    JuMP.@objective(model, Min, sum(capital_costs[g, t]+fom_costs[g, t] for g in gens for t in T_i)+sum(vom_costs[g, t] for g in gens for t in T_o))
end

##################
# Running the optimization model
##################

#defining toy data for writing model
T_i = [2024, 2026]
T_o = [1, 2, 3, 4]
T_io = Dict(1 => 2024, 2 => 2024, 3 => 2026, 4 => 2026)
loads = Dict(1 => 100, 2 => 150, 3 => 175, 4 => 80)

# regions = ['1', '2']
gens = ["Coal", "NGCC", "Wind", "PV"]
thermal_gen = ["Coal", "NGCC"]
renewable_gen = ["Wind", "PV"]
cap_max = Dict(2024 => Inf, 2026 => Inf)
cap_min = Dict(2024 => 0, 2026 => 0)
capex = Dict(2024 => 1e5, 2026 => 1e5)
fom = Dict(2024 => 100, 2026 => 100)
vom = Dict(2024 => 10, 2026 => 10)
vcf = Dict(1 => .5, 2 => .5, 3 => .5, 4 => .5)
    
coal = ThermalGen("Coal",   1, cap_max, cap_min, .9, capex, fom, vom)
ngcc = ThermalGen("NGCC",   1, cap_max, cap_min, .9, capex, fom, vom)

wind = RenewableGen("Wind", 1, cap_max, cap_min, .9, capex, fom, vom, vcf)
pv   = RenewableGen("PV",   1, cap_max, cap_min, .9, capex, fom, vom, vcf)

# initialize model
model = JuMP.Model(HiGHS.Optimizer)

# Calling investment variables
add_variables!(model, wind, inv)
add_variables!(model, pv, inv)
add_variables!(model, coal, inv)
add_variables!(model, ngcc, inv)

# Calling investment constraints
add_constraints!(model, wind, inv)
add_constraints!(model, pv, inv)
add_constraints!(model, coal, inv)
add_constraints!(model, ngcc, inv)

# Calling operation variable definitions
add_variables!(model, wind, op)
add_variables!(model, pv, op)
add_variables!(model, coal, op)
add_variables!(model, ngcc, op)

# Calling operation constraint definitions
add_constraints!(model, wind, op)
add_constraints!(model, pv, op)
add_constraints!(model, coal, op)
add_constraints!(model, ngcc, op)

# Calling demand matching constraints
add_constraints!(model, op)

# Calling objective function
add_objective_function!(model)