box::use(
  here[here],
  utils[read.csv]
)

#' @export
fetch_riders_01 <- function(){
  
  read.csv(here::here("data","riders_01.csv"))
  
}

#' @export
fetch_bikes_01 <- function(){
  
  bikes <- read.csv(here::here("data","bikes_01.csv"))
  
  bikes$Month <- factor(bikes$Month,levels = c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"))
  
  bikes
  
}