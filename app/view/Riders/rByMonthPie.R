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
  
  echarts4rOutput(ns("rbmp"))
  
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    output$rbmp <- renderEcharts4r({
      
        data$fetch_riders_01() -> Riders
      
        Riders$Month <- factor(Riders$Month,
                               levels = c("Jan","Feb","Mar","Apr","May","Jun",
                                          "Jul","Aug","Sep","Oct","Nov","Dec"))
        Riders |>
        group_by(Month,Rider) |>
        summarise(Trips = sum(Trips),.groups = "drop") |>
        group_by(Month) |>
        e_chart(Rider,timeline = TRUE) |>
        e_pie(Trips) |>
        e_tooltip(trigger = "item") |>
        e_timeline_opts(autoPlay = TRUE
        )
        
            
      
    })
  })
}