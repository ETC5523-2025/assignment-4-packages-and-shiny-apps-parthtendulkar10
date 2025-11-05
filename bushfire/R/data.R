#' Bushfire Monthly Dataset
#'
#' @description
#' Monthly bushfire data for southeast Australia (1997–2018),
#' combining the Fire Weather Index (FWI) and burned area (in km²).
#' Data are derived from ERA5 reanalysis and MODIS burned-area datasets
#' provided by KNMI Climate Explorer.
#'
#' @format A data frame with one row per year-month observation:
#' \describe{
#'   \item{year}{Calendar year (1997–2018)}
#'   \item{month}{Month name (Jan–Dec)}
#'   \item{fwi}{Monthly mean Fire Weather Index (unitless)}
#'   \item{burned_area_km2}{Total burned area in square kilometres}
#'   \item{date}{Date column representing the first day of the month}
#' }
#'
#' @details
#' The Fire Weather Index (FWI) measures potential fire intensity based on
#' temperature, humidity, wind speed, and precipitation. Burned area values
#' are derived from MODIS satellite observations.
#'
#' The merged dataset aligns both sources by year and month to allow
#' exploration of relationships between climatic fire danger and actual
#' fire extent during the Australian bushfire seasons.
#'
#' @source
#' Derived from KNMI Climate Explorer ERA5 FWI and MODIS burned-area datasets:
#' \url{https://climexp.knmi.nl/bushfires_timeseries.cgi}
#'
#' @seealso [bushfire_summary], [pop_est]
#'
#' @examples
#' data(bushfire)
#'
#' # View available years
#' range(bushfire$year)
#'
#' # Plot relationship between FWI and burned area
#' \dontrun{
#' bushfire |>
#'   ggplot2::ggplot(aes(fwi, burned_area_km2, color = factor(year))) +
#'   ggplot2::geom_point() +
#'   ggplot2::theme_minimal()
#' }
"bushfire"


#' Bushfire Yearly Summary
#'
#' @description
#' Annual summary of bushfire conditions for southeast Australia,
#' including average Fire Weather Index and total burned area for each year.
#'
#' @format A data frame with one row per year:
#' \describe{
#'   \item{year}{Calendar year (1997–2018)}
#'   \item{mean_fwi}{Mean Fire Weather Index across all months of that year}
#'   \item{total_burned_km2}{Total burned area across all months of that year}
#' }
#'
#' @details
#' Summarised from the \code{bushfire} dataset to provide a quick
#' year-level overview of fire intensity and extent.
#'
#' @source
#' Derived from the monthly bushfire dataset prepared from ERA5 and MODIS data.
#'
#' @seealso [bushfire], [pop_est]
#'
#' @examples
#' data(bushfire_summary)
#'
#' # Quick trend plot
#' \dontrun{
#' bushfire_summary |>
#'   ggplot2::ggplot(aes(year, total_burned_km2)) +
#'   ggplot2::geom_line(color = "firebrick") +
#'   ggplot2::theme_minimal()
#' }
"bushfire_summary"


#' Bushfire Observation Count
#'
#' @description
#' A single-row dataset reporting the total number of monthly observations
#' in the bushfire dataset (1997–2018).
#'
#' @format A data frame with one variable:
#' \describe{
#'   \item{total_obs}{Total number of monthly observations (n = 264)}
#' }
#'
#' @details
#' Represents the full count of valid year–month pairs available
#' in the merged Fire Weather Index and burned-area records.
#'
#' @source Derived from the combined bushfire dataset.
#'
#' @seealso [bushfire], [bushfire_summary]
#'
#' @examples
#' data(pop_est)
#' pop_est
"pop_est"
