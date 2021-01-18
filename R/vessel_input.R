library(shiny)

# Variables ####
ships <- read.csv("./data/ships.csv")
ship_types <- unique(ships$ship_type)

# UI part ####
vessel_inputUI <- function(id) {
  ns <- NS(id)
  tagList(
    div(class = "ui horizontal divider", icon("ship"), "VESSEL SELECTION"),
    p("TYPE:"),
    dropdown_input(ns("selected_type"), ship_types),
    uiOutput(ns("select_ship_dropdown"))
  )
}

# SERVER part ####
vessel_inputServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      output$select_ship_dropdown <- renderUI({
        if (input$selected_type %in% ship_types){
          only_that_type <- filter(ships, ship_type == input$selected_type)
          ship_names <- unique(only_that_type$SHIPNAME)
          div(
            p("VESSEL:", style = "padding-top: 20px"),
            dropdown_input("selected_ship", ship_names),
              div(style = "padding-top: 20px", action_button("show", label = "Show", class ="ui green button"))
          )
         }
      })
    }
  )
}
