#' Launch the bushfire Interactive Dashboard
#'
#' @description
#' Launches an interactive Shiny dashboard for exploring bushfire data across
#' southeastern Australia. The dashboard provides visual summaries and insights
#' on fire intensity and burned area using Fire Weather Index (FWI) and
#' burned area datasets from 1997–2018.
#'
#' The dashboard includes two main tabs:
#' \itemize{
#'   \item \strong{Overview:} Annual patterns in fire weather and burned area
#'   \item \strong{Correlation:} Relationship between FWI and burned area
#' }
#'
#' @param ... Additional arguments passed to \code{\link[shiny]{runApp}}.
#'   Common options include:
#'   \itemize{
#'     \item \code{port}: Port number (e.g., \code{port = 3838})
#'     \item \code{launch.browser}: Whether to open in browser (default: \code{TRUE})
#'     \item \code{host}: Host IP address (default: \code{"127.0.0.1"})
#'   }
#'
#' @return Launches the Shiny application. No return value (called for side effects).
#'
#' @export
#'
#' @examples
#' \dontrun{
#'   # Launch the dashboard (opens in default browser)
#'   run_app()
#'
#'   # Launch on specific port
#'   run_app(port = 3838)
#'
#'   # Launch without opening browser automatically
#'   run_app(launch.browser = FALSE)
#' }
#'
#' @seealso
#' \code{\link{bushfire}}, \code{\link{bushfire_summary}}, \code{\link{pop_est}}
#'
#' @importFrom shiny runApp
run_app <- function(...) {
  # Check for required Shiny app packages
  required_pkgs <- c("shiny", "shinydashboard", "plotly", "DT", "ggplot2", "scales")
  missing_pkgs <- character(0)

  for (pkg in required_pkgs) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      missing_pkgs <- c(missing_pkgs, pkg)
    }
  }

  if (length(missing_pkgs) > 0) {
    stop(
      "The following packages are required to run the app but are not installed:\n  ",
      paste(missing_pkgs, collapse = ", "), "\n\n",
      "Install them with:\n  install.packages(c('",
      paste(missing_pkgs, collapse = "', '"), "'))",
      call. = FALSE
    )
  }


  if (dir.exists("inst/shiny")) {
    app_dir <- "inst/shiny"
  } else {
    app_dir <- system.file("shiny", package = "bushfire")
    if (app_dir == "") {
      stop("Could not find Shiny app directory. Make sure inst/shiny exists.", call. = FALSE)
    }
  }

  # Launch the app
  shiny::runApp(app_dir, display.mode = "normal", ...)
}
