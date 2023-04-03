box::use(
  app/logic/data
)

box::use(
  shiny[NS,moduleServer],
  dplyr[group_by,summarise],
  echarts4r[group_by,e_chart,e_pie,e_tooltip,
            echarts4rOutput,renderEcharts4r,e_timeline_opts]
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  
  echarts4rOutput(ns("rbwp"))
  
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    output$rbwp <- renderEcharts4r({
      
      data$fetch_riders_01() -> Riders
      
      Riders$DayOfWeek <- factor(Riders$DayOfWeek,
                                 levels = c("Sun","Mon","Tue","Wed","Thu","Fri","Sat"))
      
        Riders |>
        dplyr::group_by(DayOfWeek,Rider) |>
        summarise(Trips = sum(Trips),.groups = "drop") |>
        echarts4r::group_by(DayOfWeek) |>
        e_chart(Rider,timeline = TRUE) |>
        e_pie(Trips) |>
        e_tooltip(trigger = "item") |>
        e_timeline_opts(autoPlay = TRUE)
      
      
      
    })
  })
}