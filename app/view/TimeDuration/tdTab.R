box::use(
  app/logic/data
)

box::use(
  app/view/Controls/YearSelect
)

box::use(
  app/view/TimeDuration/TimeYearBar,
  app/view/TimeDuration/TimeWdayBar
)

box::use(
  shiny[NS,tabPanel,fluidRow,column,moduleServer],
  bslib[card,card_header,card_body_fill],
  echarts4r[echarts4rOutput,renderEcharts4r,e_charts,e_bar],
  dplyr[filter]
)


#' @export
ui <- function(id) {
  ns <- NS(id)
  
  tabPanel("Trip Duration",
           fluidRow(
             column(3,
                    card(
                      height = 350,
                      card_header("Info and Control"),
                      card_body_fill(YearSelect$yearSelect(ns("year_select")))
                    )),
             column(9,
                    card(height = 350,
                         card_header("Month"),
                         card_body_fill(echarts4rOutput(ns("tym")))
                        )
             )
           ),
           fluidRow(
             column(4,
                    card(
                      height = 350,
                      card_header("Year"),
                      card_body_fill(TimeYearBar$ui(ns("tyb")))
                      )
                    ),
             column(8,
                    card(
                      height = 350,
                      card_header("Weekday"),
                      card_body_fill(TimeWdayBar$ui(ns("twb")))
                     )
                  )
               )
           )
           
}


#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    
    TimeYearBar$server("tyb")
    TimeWdayBar$server("twb")
    
    output$tym <- renderEcharts4r({
      
      data$fetch_time_month() |>
      filter(Year == input$year_select) |>
      echarts4r::group_by(Rider) |>
      e_charts(Month) |>
      e_bar(TripDuration)
      
    })
    
  })
}

