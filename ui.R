library(shiny)
library(DT)

shinyUI(fluidPage(
  titlePanel("PokeDex"),
  sidebarLayout(
    sidebarPanel(
      h3("Filters"),
      sliderInput("hp", "HP", 0, 255, value=c(0, 255)),
      sliderInput("attack", "Attack", 0, 255, value=c(0, 255)),
      sliderInput("defense", "Defense", 0, 255, value=c(0, 255)),
      sliderInput("special_attack", "Special Attack", 0, 255, value=c(0, 255)),
      sliderInput("special_defense", "Special Defense", 0, 255, value=c(0, 255)),
      sliderInput("speed", "Speed", 0, 255, value=c(0, 255)),
    ),
    mainPanel(
      h3("Pokemon"),
       a("Documentation", href="https://github.com/bagofbolts/pokedex"),
      DT::dataTableOutput("table")
    )
  )
))