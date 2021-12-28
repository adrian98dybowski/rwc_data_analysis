shinyServer(function(session, input, output) {
  
  USER_ENV <- pryr::where("session")
  
# MAP #

observeEvent(input$edition, {
output$map <- prepare_map(data = copy(rwc), edition = input$edition)
})

# TABLE

output$table <- history_table(data = copy(rwc))

})
