box::use(
  app/logic/data
)

box::use(
  app/view/Controls/RiderSelect
)

box::use(
  shiny[NS,tabPanel,fluidRow,column,moduleServer],
  bslib[card,card_header,card_body_fill],
  echarts4r[echarts4rOutput,renderEcharts4r,e_charts,e_bar],
  dplyr[group_by,summarise,filter]
)


#' @export
ui <- function(id) {
  ns <- NS(id)
  
  tabPanel("Time Of Day",
           fluidRow(
             column(3,
                    card(
                      height = 350,
                      card_header("Info and Control"),
                      card_body_fill(RiderSelect$riderSelect(ns("rider_select")))
                    )),
           ),
           fluidRow(
             column(12,
                    card(
                      height = 400,
                      card_header("Time of the day"),
                      card_body_fill(
                        echarts4rOutput(ns("rtod"))
                      )
                    )
                  )
               )
           
          )     
  
}


#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    output$rtod <- renderEcharts4r({
      
        data$fetch_time_01() |>
        dplyr::group_by(Hour,Rider) |>
        summarise(Trips = sum(Trips),.groups = "drop") |>
        filter(Rider == input$rider_select) |>
        e_charts(Hour) |>
        e_bar(Trips) 
      
    })
    
  })
}


