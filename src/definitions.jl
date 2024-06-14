#From https://www.eia.gov/survey/form/eia_923/instructions.pdf
IS.@scoped_enum(
    PrimeMovers,
    BA = 1,  # Energy Storage, Battery
    BT = 2,  # Turbines Used in a Binary Cycle (including those used for geothermal applications)
    CA = 3,  # Combined-Cycle – Steam Part
    CC = 4,  # Combined-Cycle - Aggregated Plant *augmentation of EIA
    CE = 5,  # Energy Storage, Compressed Air
    CP = 6,  # Energy Storage, Concentrated Solar Power
    CS = 7,  # Combined-Cycle Single-Shaft Combustion turbine and steam turbine share a single generator
    CT = 8,  # Combined-Cycle Combustion Turbine Part
    ES = 9,  # Energy Storage, Other (Specify on Schedule 9, Comments)
    FC = 10,  # Fuel Cell
    FW = 11,  # Energy Storage, Flywheel
    GT = 12,  # Combustion (Gas) Turbine (including jet engine design)
    HA = 13,  # Hydrokinetic, Axial Flow Turbine
    HB = 14,  # Hydrokinetic, Wave Buoy
    HK = 15,  # Hydrokinetic, Other
    HY = 16,  # Hydraulic Turbine (including turbines associated with delivery of water by pipeline)
    IC = 17,  # Internal Combustion (diesel, piston, reciprocating) Engine
    PS = 18,  # Energy Storage, Reversible Hydraulic Turbine (Pumped Storage)
    OT = 19,  # Other – Specify on SCHEDULE 9.
    ST = 20,  # Steam Turbine (including nuclear, geothermal and solar steam; does not include combined-cycle turbine)
    PVe = 21,  # Photovoltaic *renaming from EIA PV to PVe to avoid conflict with BusType.PV
    WT = 22,  # Wind Turbine, Onshore
    WS = 23,  # Wind Turbine, Offshore
)


#AER Aggregated Fuel Code From https://www.eia.gov/survey/form/eia_923/instructions.pdf
IS.@scoped_enum(
    ThermalFuels,
    COAL = 1,  # COL    # Anthracite Coal and Bituminous Coal
    WASTE_COAL = 2,  # WOC    # Waste/Other Coal (includes anthracite culm, gob, fine coal, lignite waste, waste coal)
    DISTILLATE_FUEL_OIL = 3,  # DFO # Distillate Fuel Oil (Diesel, No. 1, No. 2, and No. 4
    WASTE_OIL = 4,  # WOO    # Waste Oil Kerosene and JetFuel Butane, Propane,
    PETROLEUM_COKE = 5,  # PC  # Petroleum Coke
    RESIDUAL_FUEL_OIL = 6,     # RFO # Residual Fuel Oil (No. 5, No. 6 Fuel Oils, and Bunker Oil)
    NATURAL_GAS = 7,  # NG    # Natural Gas
    OTHER_GAS = 8,  # OOG    # Other Gas and blast furnace gas
    NUCLEAR = 9,  # NUC # Nuclear Fission (Uranium, Plutonium, Thorium)
    AG_BIPRODUCT = 10,  # ORW    # Agricultural Crop Byproducts/Straw/Energy Crops
    MUNICIPAL_WASTE = 11,  # MLG    # Municipal Solid Waste – Biogenic component
    WOOD_WASTE = 12,  # WWW     # Wood Waste Liquids excluding Black Liquor (BLQ) (Includes red liquor, sludge wood, spent sulfite liquor, and other wood-based liquids)
    GEOTHERMAL = 13,  # GEO     # Geothermal
    OTHER = 14,  # OTH     # Other
)

IS.@scoped_enum(
    StorageTech,
    PTES = 1, # Pumped thermal energy storage
    LIB = 2, # LiON Battery
    LAB = 3, # Lead Acid Battery
    FLWB = 4, # Redox Flow Battery
    SIB = 5, # Sodium Ion Battery
    ZIB = 6, # Zinc Ion Battery,
    HGS = 7, # Hydrogen Gas Storage,
    LAES = 8, # Liquid Air Storage
    OTHER_CHEM = 9, # Chemmical Storage
    OTHER_MECH = 10, # Mechanical Storage
    OTHER_THERM = 11, # Thermal Storage
)
