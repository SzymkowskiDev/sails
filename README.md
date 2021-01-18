# Longest Sail
 Shiny app that finds the observation when a ship sailed the longest distance between two consecutive observations from the AIS system

## 🔗 Link
* [Longest Sail (This shiny app)](https://szymkowskidev.shinyapps.io/sail/)

![Image of the map](https://github.com/SzymkowskiDev/sails/blob/main/demo.gif?raw=true)

## 🚧 Warning / How to run
Supply CSV data file to directory data/ to run the application, name the file "ships". Due to GitHub's limit on the file size, I wasn't able to upload the dataset.

## 📦 Packages
- library(shiny)           # Web development framework
- library(shiny.semantic)  # Used to style the app with Fomantic-UI's classes
- library(leaflet)         # Interactive map
- library(dplyr)           # Used for data manipulation
- library(stringr)         # Used to manipulated date and time columns
- library(geosphere)       # Used to calculated distance between two coordinates (distVincentyEllipsoid())
- library(leaflet.extras)  # Additions to the map: pulsating marker, full screen and ruler
- library(waiter)          # Loading screen
- library(reactlog)        # Visualising the reactive graph; reactlog::reactlog_enable(); shiny::reactlogShow()
- library(testthat)        # Unit tests, snapshot tests and reactivity tests
- library(magrittr)        # Pipe operator

## 📧 Contact
[![](https://img.shields.io/twitter/url?label=/SzymkowskiDev&style=social&url=https%3A%2F%2Ftwitter.com%2FSzymkowskiDev)](https://twitter.com/SzymkowskiDev) [![](https://img.shields.io/twitter/url?label=/kamil-szymkowski/&logo=linkedin&logoColor=%230077B5&style=social&url=https%3A%2F%2Fwww.linkedin.com%2Fin%2Fkamil-szymkowski%2F)](https://www.linkedin.com/in/kamil-szymkowski/) [![](https://img.shields.io/twitter/url?label=@szymkowskidev&logo=medium&logoColor=%23292929&style=social&url=https%3A%2F%2Fmedium.com%2F%40szymkowskidev)](https://medium.com/@szymkowskidev) [![](https://img.shields.io/twitter/url?label=/SzymkowskiDev&logo=github&logoColor=%23292929&style=social&url=https%3A%2F%2Fgithub.com%2FSzymkowskiDev)](https://github.com/SzymkowskiDev)






