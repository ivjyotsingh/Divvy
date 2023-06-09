box::use(
  shiny[navbarPage,moduleServer,NS],
  bslib[bs_theme],
  thematic[thematic_shiny]
)

box::use(
  app/view/Riders/rTab,
  app/view/Bikes/bTab,
  app/view/TimeOfDay/todTab,
  app/view/TimeDuration/tdTab
)

#' @export
ui <- function(id) {
  thematic::thematic_shiny()
  ns <- NS(id)
  navbarPage(
    "Divvy",
    theme = bs_theme(bootswatch = "zephyr"),
    rTab$ui(ns("rtab")),
    bTab$ui(ns("btab")),
    todTab$ui(ns("todtab")),
    tdTab$ui(ns("tdtab"))
  )
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    rTab$server("rtab")
    bTab$server("btab")
    todTab$server("todtab")
    tdTab$server("tdtab")
  })
}