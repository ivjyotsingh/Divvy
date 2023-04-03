box::use(
  app/logic/data
)

box::use(
  shiny[NS,moduleServer],
  dplyr[group_by,summarise],
  echarts4r[group_by,e_chart,e_line,e_tooltip,
            echarts4rOutput,renderEcharts4r]
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  
  echarts4rOutput(ns("ramy"))
  
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    output$ramy <- renderEcharts4r({
      
        data$fetch_riders_01() -> Riders
          
        Riders$Month <- factor(Riders$Month,
                               levels = c("Jan","Feb","Mar","Apr","May","Jun",
                                          "Jul","Aug","Sep","Oct","Nov","Dec"))  
      
        Riders |>
        dplyr::group_by(Year,Month) |>
        summarise(Trips = sum(Trips),.groups = "drop") |>
        echarts4r::group_by(Year) |>
        e_chart(Month) |>
        e_line(Trips) |>
        e_tooltip(trigger = "axis")
      
    })
  })
}