# Libraries
library(shiny)           # Web development framework
library(shiny.semantic)  # Used to style the app with Fomantic-UI's classes
library(leaflet)         # Interactive map
library(dplyr)           # Used for data manipulation
library(stringr)         # Used to manipulated date and time columns
library(geosphere)       # Used to calculated distance between two coordinates (distVincentyEllipsoid())
library(leaflet.extras)  # Additions to the map: pulsating marker, full screen and ruler
library(waiter)          # Loading screen
library(reactlog)        # Visualising the reactive graph; reactlog::reactlog_enable(); shiny::reactlogShow()
library(testthat)        # Unit tests, snapshot tests and reactivity tests
library(magrittr)        # Pipe operator

# Modules/R files ####
source("./R/vessel_input.R")
source("./R/data_manipulation.R")

# UI ####
ui <- semanticPage(
  title = "Longest sail",
  style = "background-color: #1B1C1D",
  # Loading screen ####
  use_garcon(),
  use_waiter(),
  waiter_show_on_load(
    tags$img(
      src="appsilon.jpg",
      width = "100%",
      height = "700",
      id = "appsilonScreen"
    )
  ),
  grid(
    # Grid configuration ####
    grid_template(
      default = list(
        areas = rbind(c("header", "header", "header"), c("menu", "main", "main"), c("menu", "main", "main")),
        rows_height = c("80px", "auto", "100px"),
        cols_width = c("400px", "2fr", "1fr")
      )
    ),
    container_style = "border: 1px solid #000000",
    area_styles = list(
      header = "background: #1D1C1B",
      menu = "border-right: 1px solid #000000",
      main = "border-right: 1px solid #000000"
    ),
    # Header ####
    header = segment(style = "background-color: #1D1C1B",
      h2(class = "ui header", icon("crosshairs", style = "color: #9A9A9A"), style = "color: #9A9A9A",
         div(class = "content", "LONGEST SAIL",
             div(class = "sub header", "Powered by the AIS tracking system", style = "color: #9A9A9A")
         )
      )
     ),
    # Sidepanel ####
    menu = segment(style = "background-color: #9A9A9A",
      vessel_inputUI("inputModule")
     ),
    # Main panel ####
    main = segment(
      class = "ui raised segment", style = "background-color: #1D1C1B",
      leafletOutput("map", height = "570px"),
      uiOutput("note")
    )
  )
)

# SERVER ####
server <- function(input, output, session) {

  # Loading screen on start ####
  g <- Garcon$new("appsilonScreen", bg_color = "#FFFFFF", filter = "a, hue-rotate")
  for(i in 1:10){
    Sys.sleep(runif(1))
    g$set(i * 10)
  }
  waiter_hide()

  # Rendering dropdown inputs and an action button ####
  vessel_inputServer("inputModule")

  # Data manipulation ####
  coords <- reactiveValues(x1 = 18.98187, y1 = 54.76132, x2 = 18.98187, y2 = 54.76132, distance = 0, name = "")
  observeEvent(input$show, {
    latest_sail <- findVessel(ships, input$selected_ship)
    coords$x1 <- latest_sail$lon_two
    coords$y1 <- latest_sail$lat_two
    coords$x2 <- latest_sail$LON
    coords$y2 <- latest_sail$LAT
    coords$distance <- round(latest_sail$dist, digits = 2)
    coords$name <- latest_sail$SHIPNAME
  })

  # Map ####
  output$map <- renderLeaflet({
    leaflet() %>%
      setView(coords$x1, coords$y1, zoom = 10) %>%
      addProviderTiles("CartoDB.DarkMatterNoLabels") %>%
      addFullscreenControl() %>%
      addMeasure(
        position = "bottomleft",
        primaryLengthUnit = "meters",
        primaryAreaUnit = "sqmeters",
        activeColor = "#3D535D",
        completedColor = "#7D4479") %>%
      addPulseMarkers(
        lng = c(coords$x1, coords$x2), lat = c(coords$y1, coords$y2),
        label = c("Start", "End"),
        icon = makePulseIcon(heartbeat = 0.5))
  })

  # Note ####
  output$note <- renderUI({
    div(class = "ui raised segment", style = "background-color: #000000",
        p(paste("The ship ",coords$name, " has travelled the distance of ", coords$distance), paste(" meters."), style = "color: #FFFFFF")
    )
  })

}

shinyApp(ui = ui, server = server)
