# Libraries
library(dplyr)           # Used for data manipulation
library(stringr)         # Used to manipulated date and time columns
library(geosphere)       # Used to calculated distance between two coordinates (distVincentyEllipsoid())
library(magrittr)        # Pipe operator

# Variables ####
ships <- read.csv("./data/ships.csv")

# Obtaining subset of the data for selected ship
subsetShip <- function(data, vessel){
  output <- filter(data, SHIPNAME == vessel) %>%
    mutate(time = str_sub(DATETIME,12,19)) %>%
    arrange(date, time)
  return(output)
}

# Adding variables representing start coordinates
addCoordinates <- function(data){
  lat_two <- data.frame(lat_two=c(NA,data$LAT))
  lon_two <- data.frame(lon_two=c(NA,data$LON))
  data[nrow(data)+1,] <- NA
  output <- cbind(data, lat_two, lon_two)
  return(output)
}

# Computing the shortest distance between two points according to the 'Vincenty (ellipsoid)' method.
computeDistance <- function(data){
  data <- data %>% rowwise() %>% mutate(dist = distVincentyEllipsoid(c(lon_two,lat_two), c(LON,LAT)))
  output <- data[which.max(data$dist),]
  return(output)
}

# Selecting the latest observation
selectLatest <- function(data){
  if (nrow(data) == 1){
    output <- data
  } else {
    data <- data[order(as.Date(data$date,format="%d/%m/%Y"), data$time, decreasing =TRUE ),, drop=FALSE]
    output <- data[1,]
  }
  return(output)
}

# Find the row when vessel travelled max distance
findVessel <- function(data, vessel){
  output <- subsetShip(data, vessel) %>%
    addCoordinates() %>%
    computeDistance() %>%
    selectLatest()
  return(output)
}
