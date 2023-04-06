box::use(
  here[here],
  utils[read.csv],
  dplyr[mutate]
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

#' @export
fetch_time_01 <- function(){
  
  read.csv(here::here("data","time_01.csv"))
  
}

#' @export
fetch_time_year <- function(){
  
  time_year <- read.csv(here::here("data","time_year.csv"))
  
  time_year |>
  mutate(Year = as.factor(Year)) |>
  mutate(Rider = as.factor(Rider)) -> time_year
  
  time_year
  
}

#' @export
fetch_time_wday <- function(){
  
  time_wday <- read.csv(here::here("data","time_wday.csv"))
  
  time_wday |>
    mutate(DayOfWeek = as.factor(DayOfWeek)) |>
    mutate(Rider = as.factor(Rider)) -> time_wday
  
  time_wday$DayOfWeek <- factor(time_wday$DayOfWeek,levels = c("Mon","Tue","Wed","Thu","Fri","Sat","Sun"))
  
  time_wday
  
}

#' @export
fetch_time_month <- function(){
  
  time_month <- read.csv(here::here("data","time_month.csv"))
  
  time_month |>
  mutate(Month = as.factor(Month)) |>
  mutate(Rider = as.factor(Rider)) -> time_month
  
  time_month$Month <- factor(time_month$Month,levels = c("Jan","Feb","Mar","Apr","May","Jun","Jul",
                                                         "Aug","Sep","Oct","Nov","Dec"))
  
  time_month
  
}

