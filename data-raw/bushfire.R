library(readr)
library(dplyr)
library(janitor)
library(lubridate)
library(usethis)

# Read Data
fwi_data <- read_csv("data-raw/fwi_data.csv")
burned_data <- read_csv("data-raw/burned_data.csv")

# clean both datasets
fwi_data <- fwi_data |> janitor::clean_names()
burned_data <- burned_data |> janitor::clean_names()

# Merge both datasets by Year and Month
bushfire <- fwi_data |>
  inner_join(burned_data, by = c("year", "month")) |>
  mutate(date = make_date(year, match(month, month.abb), 1))

# Save
usethis::use_data(bushfire, overwrite = TRUE)

# simple summary dataset
bushfire_summary <- bushfire |>
  group_by(year) |>
  summarise(
    mean_fwi = mean(fwi, na.rm = TRUE),
    total_burned_km2 = sum(burned_area_km2, na.rm = TRUE),
    .groups = "drop"
  )

usethis::use_data(bushfire_summary, overwrite = TRUE)

# Create a population estimate (number of records)
pop_est <- bushfire |> summarise(total_obs = n())
usethis::use_data(pop_est, overwrite = TRUE)
