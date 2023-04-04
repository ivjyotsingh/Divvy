box::use(
  app/logic/data
)

box::use(
  shiny[NS,moduleServer,fluidRow,column],
  dplyr[group_by,summarise,filter],
  echarts4r[e_charts,e_pie,e_title,e_group,e_connect_group,
            echarts4rOutput,renderEcharts4r]
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  
  fluidRow(
    column(4,echarts4rOutput(ns("bbyp0"))),
    column(4,echarts4rOutput(ns("bbyp1"))),
    column(4,echarts4rOutput(ns("bbyp2")))
  )

}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    output$bbyp0 <- renderEcharts4r({
      
          data$fetch_bikes_01() |>
          filter(Year == 2020) |>
          dplyr::group_by(Bike) |>
          summarise(Trips = sum(Trips),.groups = "drop") |>
          e_charts(Bike) |>
          e_pie(Trips) |>
          e_title(input$year_select) |>
          e_group("grp") |>
          e_title("2020")
        
    })
    
    
    output$bbyp1 <- renderEcharts4r({
      
      data$fetch_bikes_01() |>
        filter(Year == 2021) |>
        dplyr::group_by(Bike) |>
        summarise(Trips = sum(Trips),.groups = "drop") |>
        e_charts(Bike) |>
        e_pie(Trips) |>
        e_title(input$year_select) |>
        e_group("grp") |>
        e_connect_group("grp") |>
        e_title("2021")
      
    })
    
    output$bbyp2 <- renderEcharts4r({
      
      data$fetch_bikes_01() |>
        filter(Year == 2022) |>
        dplyr::group_by(Bike) |>
        summarise(Trips = sum(Trips),.groups = "drop") |>
        e_charts(Bike) |>
        e_pie(Trips) |>
        e_title(input$year_select) |>
        e_group("grp") |>
        e_connect_group("grp") |>
        e_title("2022")
      
    })
        
  })
}