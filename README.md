
# bushfire

<!-- badges: start -->

[![License:
MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
<!-- badges: end -->

## Overview

**bushfire** provides an interactive Shiny dashboard and helper
functions to explore bushfire trends and climate correlations in
southeastern Australia between 1997 and 2018.

It includes three clean datasets:

- **bushfire** — monthly Fire Weather Index (FWI) and burned area
  records
- **bushfire_summary** — yearly summaries of total burned area and mean
  FWI
- **pop_est** — simplified population reference data used in the
  dashboard.

The dashboard features two main sections: **Overview** and **Correlation
Analysis**, allowing users to explore long-term climate–fire
relationships, visualize annual FWI and burned area trends, and measure
correlations between fire intensity and weather indicators.

Features:

- 🔥 **Three curated datasets** combining Fire Weather Index (FWI) and
  burned area data
- 🌏 **Overview:** yearly summaries showing total burned area and mean
  fire intensity
- 📊 **Correlation Analysis:** explore relationships between FWI and
  burned area across years
- 📈 **Interactive Visuals:** time-series plots, correlation trends, and
  summary tables
- 🧰 **Helper functions:** summarise_bushfire() to create yearly
  summaries, correlate_bushfire() to compute FWI–burned area
  correlations
- 💾 **Data download** option built into the dashboard
- 🖥️ One-line app launcher: run_app()

## Installation

You can install the development version of bushfire from
[GitHub](https://github.com/) with:

``` r

install.packages("remotes")
remotes::install_github("ETC5523-2025/assignment-4-packages-and-shiny-apps-parthtendulkar10")
```

## Quick Start

``` r

library(bushfire)
```

## Explore the datasets

``` r

data(bushfire)
head(bushfire)
data(bushfire_summary)
head(bushfire_summary)
data(pop_est)
dplyr::glimpse(pop_est)
```

### Launch interactive dashboard

``` r

run_app()
```

## Dashboard Views

- **Overview** – Displays yearly summaries of total burned area and
  average Fire Weather Index (FWI)  
  from 1997–2018, alongside key metrics in value boxes.

- **Correlation Analysis** -

  - **Trend Plot:** visualizes yearly changes in burned area (bars) and
    mean FWI (line)  
  - **Correlation Plot:** shows how closely FWI aligns with burned area
    across years.

- **Download Section** – Allows users to export processed bushfire data
  for further analysis.

## Example Analysis

Compute the gap between traveller and worker outbreak probabilities for
a given scenario grid:

## Example Analysis

Compute the relationship between Fire Weather Index (FWI) and total
burned area across years:

    #> 
    #> Attaching package: 'dplyr'
    #> The following objects are masked from 'package:stats':
    #> 
    #>     filter, lag
    #> The following objects are masked from 'package:base':
    #> 
    #>     intersect, setdiff, setequal, union
    #> # A tibble: 6 × 4
    #>    year mean_fwi total_burned_km2 fwi_to_burn_ratio
    #>   <dbl>    <dbl>            <dbl>             <dbl>
    #> 1  2008     20.3             867.            0.0234
    #> 2  2010     16.2             763.            0.0213
    #> 3  2005     24.4            1570.            0.0156
    #> 4  2018     33.0            2584.            0.0128
    #> 5  2015     22.3            1809.            0.0123
    #> 6  2004     28.4            2449.            0.0116

## Available Datasets

- `bushfire` — Tibble with columns: `year`, `month`, `fwi`,
  `burned_area_km2`. Contains monthly Fire Weather Index (FWI) and
  burned area data from 1997–2018.
- `bushfire_summary` — Tibble with columns: `year`, `mean_fwi`,
  `total_burned_km2`. Summarized yearly averages and totals for trend
  and correlation analysis.
- `pop_est` — Small reference tibble with population-level observation
  counts used in correlation and distribution summaries.

## Functions

- `run_app()` — Launches the interactive bushfire dashboard.
- `summarise_bushfire()` — Produces yearly summaries of total burned
  area and average FWI from the combined monthly dataset.
- `correlate_bushfire()` — Calculates correlations between Fire Weather
  Index (FWI) and burned area across years.

## Documentation

- Package website:
  <https://etc5523-2025.github.io/assignment-4-packages-and-shiny-apps-parthtendulkar10/>
- Package repo:
  <https://github.com/ETC5523-2025/assignment-4-packages-and-shiny-apps-parthtendulkar10.git>
