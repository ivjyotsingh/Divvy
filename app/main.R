box::use(
  shiny[navbarPage,moduleServer,NS],
  bslib[bs_theme],
  thematic[thematic_shiny]
)

box::use(
  app/view/Riders/rTab,
  
)


#' @export
ui <- function(id) {
  thematic::thematic_shiny()
  ns <- NS(id)
  navbarPage(
    "Divvy",
    theme = bs_theme(bootswatch = "zephyr"),
    rTab$ui(ns("rtab"))
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    rTab$server("rtab")
  })
}