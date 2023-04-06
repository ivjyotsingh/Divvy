box::use(
  app/logic/data
)

box::use(
  shiny[NS,moduleServer],
  dplyr[group_by,summarise,filter],
  echarts4r[group_by,e_charts,e_bar,e_tooltip,
            echarts4rOutput,renderEcharts4r]
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  
  echarts4rOutput(ns("tyb"))
  
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    output$tyb <- renderEcharts4r({
      
        data$fetch_time_year() |>
        dplyr::group_by(Year,Rider) |>
        summarise(TripDuration = mean(TripDuration),.groups = "drop") |>
        filter(Year != 2023) |>
        echarts4r::group_by(Rider) |>
        e_charts(Year) |>
        e_bar(TripDuration) |>
        e_tooltip()
    
    })
  })
}