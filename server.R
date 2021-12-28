shinyServer(function(session, input, output) {
  
  USER_ENV <- pryr::where("session")
  
# MAP #

 data_map <- reactive({
   map <- rwc
   map[, rank := NULL]
   map <- map[, country := ifelse(country %in% 
                                    c("England", "Wales", "Scotland"), 
                                  "United Kingdom", country)]
  
  map <- map[map$year %in% input$edition]
})

output$map <- renderGvis({
  
  gvisGeoChart(data_map(), locationvar= "country",
               options=list(
                 width=1075, height=550))
  
})
})