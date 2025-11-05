#' Correlate Fire Weather Index and Burned Area
#'
#' @description
#' Computes the correlation between Fire Weather Index (FWI) and burned area
#' (in square kilometres) using the [bushfire] dataset. The correlation can be
#' calculated either overall or separately for each year.
#'
#' @param data A data frame containing the variables \code{year},
#'   \code{fwi}, and \code{burned_area_km2}, such as [bushfire].
#' @param by_year Logical; if \code{TRUE}, computes correlation separately
#'   for each year. Default is \code{FALSE}, which gives a single overall
#'   correlation value across all years.
#'
#' @return
#' A tibble with either:
#' \describe{
#'   \item{metric}{A label for the correlation type ("overall" or "by year")}
#'   \item{year}{Year (if \code{by_year = TRUE})}
#'   \item{correlation}{Pearson correlation coefficient between FWI and burned area}
#' }
#'
#' @details
#' This function helps assess how strongly fire weather intensity relates
#' to actual burned area over time, supporting exploratory analysis or
#' inclusion in the interactive Shiny app.
#'
#' @export
#' @importFrom dplyr group_by summarise
#' @importFrom tibble tibble
#'
#' @examples
#' data(bushfire)
#'
#' # Overall correlation
#' correlate_bushfire(bushfire)
#'
#' # Correlation by year
#' correlate_bushfire(bushfire, by_year = TRUE)
correlate_bushfire <- function(data, by_year = FALSE) {
  if (!all(c("year", "fwi", "burned_area_km2") %in% names(data))) {
    stop("Input data must contain 'year', 'fwi', and 'burned_area_km2' columns.")
  }

  if (by_year) {
    data |>
      dplyr::group_by(year) |>
      dplyr::summarise(
        correlation = cor(fwi, burned_area_km2, use = "complete.obs"),
        .groups = "drop"
      )
  } else {
    corr <- cor(data$fwi, data$burned_area_km2, use = "complete.obs")
    tibble::tibble(metric = "overall", correlation = corr)
  }
}
