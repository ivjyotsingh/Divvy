box::use(
  app/logic/data
)

box::use(
  app/view/Controls/YearSelect,
  app/view/Bikes/bByYearPie
)


box::use(
  shiny[NS,moduleServer,tabPanel,fluidRow,column,p,selectInput],
  bslib[card,card_header,card_body_fill],
  echarts4r[echarts4rOutput,renderEcharts4r,
            e_charts,e_title,e_bar,group_by],
  dplyr[filter,group_by,summarise]
  
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  
  tabPanel("Bikes",
           fluidRow(
             column(12,
                    card(
                      height = 450,
                      card_header("Bike usage across different years"),
                      card_body_fill(bByYearPie$ui(ns("bbyp"))),
                      full_screen = TRUE
                    )),
                ),
           fluidRow(
             column(4,
                    card(
                      height = 300,
                      card_header("Info and Control"),
                      card_body_fill(
                        p("3 different bikes are used - Docked,Electric and Classic. Use the control below to check
                          bike composition across different years."),
                        YearSelect$yearSelect(ns("year_select"))
                        )
                      )
                    ),
             column(8,
                    card(
                      height = 300,
                      card_header("Bike usage across months for a year"),
                      card_body_fill(echarts4rOutput(ns("bcbm"))),
                      full_screen = TRUE
                    ),
             )
           )
             
      )     
  
}


#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    
    bByYearPie$server("bbyp")
    
    
    output$bcbm <- renderEcharts4r({
      
        data$fetch_bikes_01() |>
        filter(Year == input$year_select) |>
        dplyr::group_by(Month,Bike) |>
        summarise(Trips = sum(Trips),.groups = "drop") |>
        echarts4r::group_by(Bike) |>
        e_charts(Month) |>
        e_bar(Trips)|>
        e_title(input$year_select) 
      
    })
    
   
  })
}
