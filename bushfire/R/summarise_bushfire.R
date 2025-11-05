#' Summarise Bushfire Data
#'
#' @description
#' Aggregates the monthly bushfire dataset to provide a yearly summary
#' of fire intensity and extent for southeast Australia (1997–2018).
#' The function calculates the mean Fire Weather Index (FWI) and total
#' burned area (km²) for each year.
#'
#' @param data A data frame containing the variables \code{year},
#'   \code{fwi}, and \code{burned_area_km2}, such as [bushfire].
#'
#' @return A tibble with one row per year containing:
#' \describe{
#'   \item{year}{Calendar year (1997–2018)}
#'   \item{mean_fwi}{Average Fire Weather Index across all months in that year}
#'   \item{total_burned_km2}{Sum of burned area across all months in that year}
#' }
#'
#' @details
#' This function simplifies the monthly bushfire dataset into an
#' annual summary for quick trend analysis or use in visualisations.
#'
#' @export
#' @importFrom dplyr group_by summarise
#' @importFrom tibble tibble
#'
#' @examples
#' data(bushfire)
#'
#' # Create a yearly summary
#' yearly_summary <- summarise_bushfire(bushfire)
#' head(yearly_summary)
#'

summarise_bushfire <- function(data) {
  if (!all(c("year", "fwi", "burned_area_km2") %in% names(data))) {
    stop("Input data must contain 'year', 'fwi', and 'burned_area_km2' columns.")
  }

  data |>
    dplyr::group_by(year) |>
    dplyr::summarise(
      mean_fwi = mean(fwi, na.rm = TRUE),
      total_burned_km2 = sum(burned_area_km2, na.rm = TRUE),
      .groups = "drop"
    )
}
