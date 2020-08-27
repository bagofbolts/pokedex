library(jsonlite)
library(DT)
library(shiny)
library(dplyr)
library(stringr)

pokemon <- fromJSON("pokemon.json")
pokemon$name <- str_to_title(pokemon$name)
pokemon$type1 <- sapply(pokemon$type1, function(x) {sprintf("<img src=\"%sIC.gif\" />", str_to_title(x))})
pokemon$type2 <- sapply(pokemon$type2, function(x) {ifelse(!is.na(x), sprintf("<img src=\"%sIC.gif\" />", str_to_title(x)), "")})
pokemon$id <- sapply(pokemon$id, function(x) {sprintf("<a href=\"https://bulbapedia.bulbagarden.net/wiki/%s\" target=\"_blank\"><img src=\"%s.png\" /></a>",pokemon[pokemon$id == x,]$name, x)})
pokemon <- rename(pokemon, c("sprite"="id"))
pokemon <- pokemon[, c(1, 2, 9, 10, 3, 4, 5, 6, 7, 8)]

shinyServer(function(input, output){
  pkmn <- pokemon

  pkmn_data <- reactive({
    pkmn <- pkmn[input$hp[1] <= pkmn$hp & pkmn$hp <= input$hp[2],]
    pkmn <- pkmn[input$attack[1] <= pkmn$attack & pkmn$attack <= input$attack[2],]
    pkmn <- pkmn[input$defense[1] <= pkmn$defense & pkmn$defense <= input$defense[2],]
    pkmn <- pkmn[input$special_attack[1] <= pkmn$`special-attack` & pkmn$`special-attack` <= input$special_attack[2],]
    pkmn <- pkmn[input$special_defense[1] <= pkmn$`special-defense` & pkmn$`special-defense` <= input$special_defense[2],]
    pkmn <- pkmn[input$speed[1] <= pkmn$speed & pkmn$speed <= input$speed[2],]
    pkmn
  })
  
  output$table <- DT::renderDataTable({
    DT::datatable(pkmn_data(), escape = FALSE)
  })
})