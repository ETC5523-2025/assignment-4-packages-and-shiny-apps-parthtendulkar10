library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(plotly)
library(DT)
library(scales)

function(input, output, session) {

  data("bushfire", package = "bushfire", envir = environment())
  data("bushfire_summary", package = "bushfire", envir = environment())
  data("pop_est", package = "bushfire", envir = environment())

  yearly_data <- bushfire_summary
  year_min <- min(yearly_data$year)
  year_max <- max(yearly_data$year)

  output$valueBoxRecords <- renderValueBox({
    valueBox(formatC(nrow(bushfire), format = "d", big.mark = ","),
             "Total Monthly Records", icon = icon("database"), color = "aqua")
  })

  output$valueBoxFWI <- renderValueBox({
    valueBox(round(mean(bushfire$fwi, na.rm = TRUE), 1),
             "Average Fire Weather Index", icon = icon("fire"), color = "yellow")
  })

  output$valueBoxBurned <- renderValueBox({
    total_area <- sum(bushfire$burned_area_km2, na.rm = TRUE)
    valueBox(paste0(comma(round(total_area)), " km²"),
             "Total Burned Area", icon = icon("mountain"), color = "red")
  })

  trend_data <- reactive({
    yearly_data %>% filter(year >= input$trend_years[1], year <= input$trend_years[2])
  })

  output$trendPlot <- renderPlotly({
    p <- ggplot(trend_data(), aes(x = year)) +
      geom_col(aes(y = total_burned_km2), fill = "#ff7a7a", alpha = 0.85) +
      geom_line(aes(y = mean_fwi * 1000), color = "#6aa6ff", linewidth = 1.2) +
      scale_y_continuous(name = "Total Burned Area (km²)",
                         sec.axis = sec_axis(~./1000, name = "Mean FWI")) +
      labs(title = "Bushfire Trends", x = "Year") +
      theme_minimal(base_size = 14) +
      theme(plot.title = element_text(face = "bold"))
    ggplotly(p, tooltip = c("x", "y"))
  })

  output$yearlyTable <- renderDT({
    datatable(yearly_data, options = list(pageLength = 10, dom = "tip"), rownames = FALSE)
  })

  corr_data <- reactive({
    bushfire %>%
      filter(year >= input$corr_years[1], year <= input$corr_years[2]) %>%
      group_by(year) %>%
      summarise(corr = cor(fwi, burned_area_km2, use = "complete.obs"), .groups = "drop")
  })

  output$valueBoxCorr <- renderValueBox({
    corr_value <- cor(bushfire$fwi, bushfire$burned_area_km2, use = "complete.obs")
    valueBox(round(corr_value, 2), "Overall Correlation (FWI vs Burned Area)",
             icon = icon("chart-line"), color = "teal")
  })

  output$correlationPlot <- renderPlotly({
    p <- ggplot(corr_data(), aes(x = year, y = corr)) +
      geom_line(color = "#22b07d", linewidth = 1.2) +
      geom_point(color = "#22b07d", size = 3) +
      scale_y_continuous(limits = c(-1, 1)) +
      labs(title = "Yearly Correlation", x = "Year", y = "Correlation") +
      theme_minimal(base_size = 14) +
      theme(plot.title = element_text(face = "bold"))
    ggplotly(p, tooltip = c("x", "y"))
  })

  output$popTable <- renderDT({
    datatable(pop_est, options = list(dom = "t", paging = FALSE), rownames = FALSE)
  })

  output$dl_yearly <- downloadHandler(
    filename = function() sprintf("bushfire_yearly_summary_%s.csv", Sys.Date()),
    content  = function(file) write.csv(yearly_data, file, row.names = FALSE)
  )

  output$dl_bushfire <- downloadHandler(
    filename = function() sprintf("bushfire_monthly_%s.csv", Sys.Date()),
    content  = function(file) write.csv(bushfire, file, row.names = FALSE)
  )

  output$dl_pop <- downloadHandler(
    filename = function() sprintf("bushfire_population_%s.csv", Sys.Date()),
    content  = function(file) write.csv(pop_est, file, row.names = FALSE)
  )

  output$dl_corr <- downloadHandler(
    filename = function() sprintf("bushfire_yearly_correlation_%s.csv", Sys.Date()),
    content  = function(file) write.csv(corr_data(), file, row.names = FALSE)
  )

  observe({
    updateSliderInput(session, "trend_years", min = year_min, max = year_max, value = c(year_min, year_max))
    updateSliderInput(session, "corr_years", min = year_min, max = year_max, value = c(year_min, year_max))
  })
}
