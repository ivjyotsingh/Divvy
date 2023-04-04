box::use(
  shiny[selectInput]
)


#' @export
yearSelect <- function(yearArg){
  
  selectInput(inputId = yearArg,
              "Select a country",
              choices = c("2020","2021","2022"),
              selected = 1)
  
}
