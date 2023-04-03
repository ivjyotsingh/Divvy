box::use(
  app/logic/data
)

box::use(
  shiny[NS,moduleServer],
  dplyr[group_by,summarise],
  echarts4r[group_by,e_chart,e_pie,e_tooltip,e_title,echarts4rOutput,renderEcharts4r]
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  
  echarts4rOutput(ns("rbmp"))
  
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    output$rbmp <- renderEcharts4r({
      
      data$fetch_riders_01() |>
        group_by(Month,Rider) |>
        summarise(Trips = sum(Trips),.groups = "drop") |>
        group_by(Month) |>
        e_chart(Rider,timeline = TRUE) |>
        e_pie(Trips)
      
    })
  })
}