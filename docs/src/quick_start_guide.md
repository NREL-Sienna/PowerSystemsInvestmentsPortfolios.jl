# Quick Start Guide

PowerSystemsInvestmentsPortfolios.jl is structured to enable modeling and analysis of power system investment decisions across multiple technologies, regions, and time horizons.

## Installation

```julia
using Pkg
Pkg.add("PowerSystemsInvestmentsPortfolios")
```

## Basic Usage

```julia
using PowerSystemsInvestmentsPortfolios

# Create an empty portfolio
portfolio = Portfolio()

# Add zones
zone = Zone(; name="Zone_1", id=1)
add_region!(portfolio, zone)
```
