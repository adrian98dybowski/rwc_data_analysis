shinyServer(function(session, input, output) {
  
  USER_ENV <- pryr::where("session")
  
# MAP AND EDITION TABLE

observeEvent(input$edition, {
output$map <- prepare_map(data = copy(rwc), edition = input$edition)
output$edition_table <- edition_table(data = copy(rwc), edition = input$edition)
})

# TABLE

output$table <- history_table(data = copy(rwc))

# COMPARISON

observeEvent(list(input$country1, input$country2, input$country3, input$country4), {
output$comparison <- prepare_comparison(data = copy(rwc),
                                        country1 = input$country1,
                                        country2 = input$country2,
                                        country3 = input$country3,
                                        country4 = input$country4)
})

})
