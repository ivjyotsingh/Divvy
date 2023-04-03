box::use(
  app/view/Riders/rByMonthPie,
  app/view/Riders/rByWeekdayPie,
  app/view/Riders/rAcrossMonthsYears
)

box::use(
  shiny[NS,moduleServer,tabPanel,fluidRow,column,p],
  bslib[card,card_header,card_body_fill,card_body]
)

#' @export
ui <- function(id) {
  ns <- NS(id)
  
  tabPanel("Riders",
           fluidRow(
                    column(3,
                    card(
                    height = 300,
                    card_header("Info"),
                    card_body(
                              p("For 2023, data is available only for the months of Jan and Feb.")
                              
                        )
                      )
                    ),
                    column(9,
                           card(
                           height = 300,
                           card_header("Total rides across months in different years"),
                           card_body_fill(rAcrossMonthsYears$ui(ns("ramy"))),
                           full_screen = TRUE
                           ),
           ),
           fluidRow(
             column(6,
                    card(
                      height = 350,
                      card_header("Rider composition across months"),
                      card_body_fill(rByMonthPie$ui(ns("rbmp"))),
                      full_screen = TRUE
                    )),
             column(6,
                    card(
                      height = 350,
                      card_header("Rider composition across weekdays"),
                      card_body_fill(rByWeekdayPie$ui(ns("rbwp"))),
                      full_screen = TRUE
                    ))
             
             
           )
  )
  
  )
  
}


#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    rByMonthPie$server("rbmp")
    rByWeekdayPie$server("rbwp")
    rAcrossMonthsYears$server("ramy")
  })
}
