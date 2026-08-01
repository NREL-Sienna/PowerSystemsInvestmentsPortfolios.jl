@testset "Storage technology insertion validation" begin
    portfolio = Portfolio()
    attached_region = Zone(; name="attached_region", id=1)
    add_region!(portfolio, attached_region)

    financial_data = TechnologyFinancialData(;
        capital_recovery_period=20,
        technology_base_year=2030,
        debt_fraction=0.4,
        debt_rate=0.05,
        return_on_equity=0.12,
        tax_rate=0.21,
    )
    storage_defaults = (;
        available=true,
        power_systems_type="EnergyReservoirStorage",
        storage_tech=StorageTech.LIB,
        financial_data,
    )

    valid_storage = StorageTechnology{PSY.EnergyReservoirStorage}(;
        storage_defaults...,
        name="valid_storage",
        id=1,
        region=RegionTopology[attached_region],
    )
    add_technology!(portfolio, valid_storage)
    @test get_technology(typeof(valid_storage), portfolio, "valid_storage") ===
          valid_storage

    invalid_duration = StorageTechnology{PSY.EnergyReservoirStorage}(;
        storage_defaults...,
        name="invalid_duration",
        id=2,
        region=RegionTopology[attached_region],
        duration_limits=(min=4.0, max=2.0),
    )
    @test_logs(
        (:error, r"Storage duration limits must be in ascending order"),
        min_level=Logging.Error,
        @test_throws(IS.InvalidValue, add_technology!(portfolio, invalid_duration)),
    )
    @test isnothing(
        get_technology(typeof(invalid_duration), portfolio, "invalid_duration"),
    )

    detached_region = Zone(; name="detached_region", id=2)
    invalid_region = StorageTechnology{PSY.EnergyReservoirStorage}(;
        storage_defaults...,
        name="invalid_region",
        id=3,
        region=RegionTopology[detached_region],
    )
    @test_logs(
        (:error, r"region that is not attached to the portfolio"),
        min_level=Logging.Error,
        @test_throws(IS.InvalidValue, add_technology!(portfolio, invalid_region)),
    )
    @test isnothing(
        get_technology(typeof(invalid_region), portfolio, "invalid_region"),
    )

    skipped_invalid = StorageTechnology{PSY.EnergyReservoirStorage}(;
        storage_defaults...,
        name="skipped_invalid",
        id=4,
        region=RegionTopology[attached_region],
        duration_limits=(min=4.0, max=2.0),
    )
    add_technology!(portfolio, skipped_invalid; skip_validation=true)
    @test get_technology(typeof(skipped_invalid), portfolio, "skipped_invalid") ===
          skipped_invalid
end
