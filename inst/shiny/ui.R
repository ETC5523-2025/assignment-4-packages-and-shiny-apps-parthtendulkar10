library(shiny)
library(shinydashboard)
library(plotly)
library(DT)

dashboardPage(
  skin = "black",

  dashboardHeader(
    title = tags$span("bushfireR", style = "font-weight:700;"),
    titleWidth = 260
  ),

  dashboardSidebar(
    width = 240,
    sidebarMenu(
      id = "tabs",
      menuItem("Overview", tabName = "overview", icon = icon("wave-square")),
      menuItem("Correlation", tabName = "correlation", icon = icon("chart-line"))
    )
  ),

  dashboardBody(
    tags$head(tags$style(HTML("
      body, .content-wrapper, .right-side { background: #0f1117; }
      .main-header .logo, .main-header .navbar { background: #0f1117 !important; border: none; }
      .main-header .navbar .sidebar-toggle { float: left; margin-left: 8px; }
      .content { color: #e5e7eb; }
      .box { background: #161a23; border: 1px solid #222737; border-radius: 12px; }
      .box-header { border-bottom: 1px solid #222737 !important; }
      .small-box { border-radius: 12px; background: #1a2030; border: 1px solid #222737; }
      .small-box .inner h3, .small-box .inner p { color: #eef2ff; }
      .skin-black .sidebar a { color: #cbd5e1; }
      .skin-black .sidebar-menu>li.active>a { background: #1a2030; border-left-color: #5aa1ff; }
      .skin-black .main-sidebar { background: #0f121a; border-right: 1px solid #1a1f2e; }
      table.dataTable thead th { background: #1a2030; color: #e5e7eb; }
      table.dataTable tbody td { color: #e5e7eb; }
      .btn { background: #1a2030; color: #e5e7eb; border: 1px solid #2a3144; border-radius:10px; }
      .btn:hover { background: #20283b; }
      .muted { color:#b8c2d6; font-size:13px; }
    "))),

    tabItems(

      # ---------- OVERVIEW ----------
      tabItem(
        tabName = "overview",

        fluidRow(
          valueBoxOutput("valueBoxRecords", width = 4),
          valueBoxOutput("valueBoxFWI",     width = 4),
          valueBoxOutput("valueBoxBurned",  width = 4)
        ),

        fluidRow(
          column(
            width = 8,
            box(width = 12, title = "Trends Over Time", status = "primary", solidHeader = TRUE,
                plotlyOutput("trendPlot", height = "460px"))
          ),
          column(
            width = 4,
            box(width = 12, title = "Filter", status = "primary", solidHeader = TRUE,
                sliderInput("trend_years", "Year Range", min = 1997, max = 2018,
                            value = c(1997, 2018), step = 1)),
            box(width = 12, title = "About Data", status = "info", solidHeader = TRUE,
                HTML("
                  <p>This tab summarises bushfire activity in southeastern Australia (1997–2018).</p>
                  <ul>
                    <li><b>FWI (Fire Weather Index):</b> combines wind, humidity, temperature, and rainfall to score fire danger. Higher = more conducive to fire spread.</li>
                    <li><b>Burned Area (km²):</b> total land area affected by bushfires each year.</li>
                    <li><b>Plot:</b> bars show burned area; the blue line shows mean FWI (scaled to align with the left axis).</li>
                  </ul>
                  <p class='muted'>Tip: adjust the year range to focus on specific periods and compare peaks/troughs.</p>
                "))
          )
        ),

        fluidRow(
          box(width = 12, title = "Yearly Summary Table", status = "info", solidHeader = TRUE,
              DTOutput("yearlyTable"))
        ),

        fluidRow(
          box(width = 12, title = "Download Data", status = "info", solidHeader = TRUE,
              div(style = "display:flex; gap:10px; flex-wrap:wrap;",
                  downloadButton("dl_bushfire", "Monthly CSV"),
                  downloadButton("dl_yearly", "Yearly Summary CSV"),
                  downloadButton("dl_pop", "Population CSV")))
        )
      ),

      # ---------- CORRELATION ----------
      tabItem(
        tabName = "correlation",

        fluidRow(valueBoxOutput("valueBoxCorr", width = 4)),

        fluidRow(
          column(
            width = 8,
            box(width = 12, title = "Yearly Correlation (FWI vs Burned Area)", status = "primary", solidHeader = TRUE,
                plotlyOutput("correlationPlot", height = "460px"))
          ),
          column(
            width = 4,
            box(width = 12, title = "Filter", status = "primary", solidHeader = TRUE,
                sliderInput("corr_years", "Year Range", min = 1997, max = 2018,
                            value = c(1997, 2018), step = 1)),
            box(width = 12, title = "About Data", status = "info", solidHeader = TRUE,
                HTML("
                  <p>This tab explores how closely FWI and burned area move together by year.</p>
                  <ul>
                    <li><b>Correlation (Pearson r):</b> +1 strong positive, 0 none, −1 strong negative.</li>
                    <li><b>Interpretation:</b> high positive values suggest years with higher FWI tended to have larger burned area.</li>
                    <li><b>Line & points:</b> correlation computed per year using all monthly observations available for that year.</li>
                  </ul>
                  <p class='muted'>Tip: narrow the year range to see if relationships strengthened or weakened across eras.</p>
                "))
          )
        ),

        fluidRow(
          box(width = 6, title = "Population Summary", status = "info", solidHeader = TRUE, DTOutput("popTable")),
          box(width = 6, title = "Download Correlation Data", status = "info", solidHeader = TRUE,
              downloadButton("dl_corr", "Yearly Correlation CSV"))
        )
      )
    )
  )
)
