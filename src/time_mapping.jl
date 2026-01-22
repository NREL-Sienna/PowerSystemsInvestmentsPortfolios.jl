"""
Stores time stamps for invesment periods and mappings to associated operational and feasibility periods.

# Arguments

  - `time_stamps::Vector{NTuple{2,Dates.Date}}`: Vector of investment period time stamps as tuples of start and end dates.
  - `map_to_operational_slices::Dict{Int,Vector{Int}}`: Mapping from investment period index to associated operational period slice indexes.
  - `map_to_feasibility_slices::Dict{Int,Vector{Int}}`: Mapping from investment period index to associated feasibility period slice indexes.
"""
struct InvestmentIntervals
    time_stamps::Vector{NTuple{2, Dates.Date}}
    map_to_operational_slices::Dict{Int, Vector{Int}}
    map_to_feasibility_slices::Dict{Int, Vector{Int}}
end

"""
Initialize an empty InvestmentIntervals struct.
"""
function InvestmentIntervals(::Nothing)
    return InvestmentIntervals(
        Vector{NTuple{2, Dates.Date}}(),
        Dict{Int, Vector{Int}}(),
        Dict{Int, Vector{Int}}(),
    )
end

"""
Stores time stamps for operational periods and necessary grouping and mapping data to represent operational and feasibility periods in each investment period.

# Arguments

  - `time_stamps::Vector{Dates.DateTime}`: Vector of all operational and feasibility period time stamps.
  - `consecutive_slices::Vector{Vector{Int}}`: Vector of vectors, where each inner vector contains the indexes of time stamps that make up a consecutive operational or feasibility period slice.
  - `inverse_invest_mapping::Vector{Int}`: Vector mapping each operational or feasibility slices index stored in `time_stamps` to its corresponding investment period.
  - `feasibility_indexes::Vector{Int}`: Vector of indexes identifying which slices are feasibility periods.
  - `operational_indexes::Vector{Int}`: Vector of indexes identifying which slices are operational periods.
"""
struct OperationalPeriods
    time_stamps::Vector{Dates.DateTime}
    consecutive_slices::Vector{Vector{Int}}
    inverse_invest_mapping::Vector{Int}
    feasibility_indexes::Vector{Int}
    operational_indexes::Vector{Int}
end

"""
Initialize an empty OperationalPeriods struct.
"""
function OperationalPeriods(::Nothing)
    return OperationalPeriods(
        Vector{Dates.DateTime}(),
        Vector{Vector{Int}}(),
        Vector{Int}(),
        Vector{Int}(),
        Vector{Int}(),
    )
end

"""
Stores investment and operational time periods. See `InvestmentIntervals` and `OperationalPeriods` for details.

# Arguments

  - `investment::InvestmentIntervals`: Investment periods data.
  - `operation::OperationalPeriods`: Operational periods data.
"""
struct TimeMapping
    investment::InvestmentIntervals
    operation::OperationalPeriods
end

"""
Builds a `TimeMapping` struct based on provided investment intervals, operational periods, and feasibility periods.

# Arguments

  - `investment_intervals::Vector{NTuple{2, Dates.Date}}`: Vector of investment period time stamps as tuples of start and end dates.
  - `operational_periods::Vector{Vector{Dates.DateTime}}`: Vector of vectors, where each inner vector contains the time stamps for a set of consecutive operational timepoints.
  - `feasibility_periods::Vector{Vector{Dates.DateTime}}`: Vector of vectors, where each inner vector contains the time stamps for a set of consecturive feasiibility timepoints.
"""
function TimeMapping(
    investment_intervals::Vector{NTuple{2, Dates.Date}},
    operational_periods::Vector{Vector{Dates.DateTime}},
    feasibility_periods::Vector{Vector{Dates.DateTime}},
)
    # TODO:
    # Validation of the dates to avoid overlaps
    # Validation of the dates to avoid gaps in the operational periods

    op_index_last_slice = length(operational_periods)
    all_operation_slices = [operational_periods; feasibility_periods]
    total_count = sum(length(x) for x in all_operation_slices)
    total_slice_count = length(operational_periods) + length(feasibility_periods)
    time_stamps = Vector{Dates.DateTime}(undef, total_count)
    consecutive_slices = Vector{Vector{Int}}(undef, total_slice_count)
    inverse_invest_mapping = Vector{Int}(undef, total_slice_count)
    map_to_operational_slices =
        Dict{Int, Vector{Int}}(i => Vector{Int}() for i in 1:length(investment_intervals))
    map_to_feasibility_slices =
        Dict{Int, Vector{Int}}(i => Vector{Int}() for i in 1:length(investment_intervals))

    ix = 1
    slice_running_count = 0
    for (sx, slice) in enumerate(all_operation_slices)
        slice_length = length(slice)
        slice_found_in_interval = false
        for (ivx, investment_interval) in enumerate(investment_intervals)
            if first(slice) >= investment_interval[1] &&
               last(slice) <= investment_interval[2]
                if sx <= op_index_last_slice
                    push!(map_to_operational_slices[ivx], sx)
                else
                    push!(map_to_feasibility_slices[ivx], sx)
                end
                inverse_invest_mapping[sx] = ivx
                slice_found_in_interval = true
                break
            end
        end
        if !slice_found_in_interval
            error(
                "Operational slice starting at $(first(slice)) could not be mapped to any investment interval. " *
                "Ensure all operational periods fall within defined investment intervals.",
            )
        end
        slice_length = length(slice)
        slice_indices = range(slice_running_count + 1, length=slice_length)
        consecutive_slices[sx] = collect(slice_indices)
        slice_running_count = last(slice_indices)
        for time_stamp in slice
            time_stamps[ix] = time_stamp
            ix += 1
        end
    end

    op_periods = OperationalPeriods(
        time_stamps,
        consecutive_slices,
        inverse_invest_mapping,
        collect(range(start=op_index_last_slice + 1, stop=total_slice_count)),
        collect(range(1, op_index_last_slice)),
    )

    inv_periods = InvestmentIntervals(
        investment_intervals,
        map_to_operational_slices,
        map_to_feasibility_slices,
    )

    TimeMapping(inv_periods, op_periods)
end

"""
Get a vector of vectors of consecutive operational indices.
"""
get_consecutive_slices(tm::TimeMapping) = tm.operation.consecutive_slices

"""
Get a vector of indices for all operational timepoints.
"""
get_operational_indexes(tm::TimeMapping) = tm.operation.operational_indexes

"""
Get a vector of indices for all feasibility timepoints.
"""
get_feasibility_indexes(tm::TimeMapping) = tm.operation.feasibility_indexes

"""
Get a vector of all timepoint indices (operational and feasibility).
"""
get_all_indexes(tm::TimeMapping) =
    [tm.operation.operational_indexes; tm.operation.feasibility_indexes]

"""
Get a vector of all time stamps (operational and feasibility).
"""
get_time_stamps(tm::TimeMapping) = tm.operation.time_stamps

"""
Get a vector of tuples that contain the start and end dates for each investment period.
"""
get_investment_time_stamps(tm::TimeMapping) = tm.investment.time_stamps

"""
Get a vector mapping each operational or feasibility slices time stamp stored in `time_stamps` to its corresponding investment period.
"""
get_inverse_invest_mapping(tm::TimeMapping) = tm.operation.inverse_invest_mapping

"""
Get the first date of the first investment period.
"""
get_base_date(tm::TimeMapping) = first(tm.investment.time_stamps)[1]

"""
Get the total number of operation and feasibility timestamps
"""
get_total_period_count(tm::TimeMapping) = length(tm.operation.time_stamps)

"""
Get the total number of operation timestamps
"""
function get_total_operation_period_count(tm::TimeMapping)
    consecutive_slices = get_consecutive_slices(tm)
    operational_indexes = get_operational_indexes(tm)
    return last(consecutive_slices[last(operational_indexes)])
end

"""
Get the total number of feasibility timestamps
"""
function get_total_feasibility_period_count(tm::TimeMapping)
    consecutive_slices = get_consecutive_slices(tm)
    return last(last(consecutive_slices))
end

"""
Get the number of investment periods
"""
get_total_investment_period_count(tm::TimeMapping) = length(tm.investment.time_stamps)

"""
Get a range of all time step indices (operational and feasibility).
"""
get_time_steps(tm::TimeMapping) = 1:get_total_period_count(tm)

"""
Get a range of all operational time step indices.
"""
get_operational_time_steps(tm::TimeMapping) = 1:get_total_operation_period_count(tm)

"""
Get a range of all feasibility time step indices.
"""
get_feasibility_time_steps(tm::TimeMapping) =
    (get_total_operation_period_count(tm) + 1):get_total_feasibility_period_count(tm)

"""
Get a range of all investment time step indices.
"""
get_investment_time_steps(tm::TimeMapping) = 1:get_total_investment_period_count(tm)

"""
Check if there are any feasibility periods defined.
"""
is_feasibility_empty(tm::TimeMapping) = isempty(tm.operation.feasibility_indexes)

"""
Get a vector mapping each investment period to its corresponding operational slices.
"""
get_investment_map_to_operational_slices(tm::TimeMapping) =
    tm.investment.map_to_operational_slices

"""
Initialize an empty TimeMapping struct.
"""
function TimeMapping(::Nothing)
    return TimeMapping(InvestmentIntervals(nothing), OperationalPeriods(nothing))
end
