box::use(
  shiny[selectInput]
)

#' @export
riderSelect <- function(riderArg){
  
  selectInput(inputId = riderArg,
              "Select Rider",
              choices = c("Member","Casual"),
              selected = 1)
  
}
