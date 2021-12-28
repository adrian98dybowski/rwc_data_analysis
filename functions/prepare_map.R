
prepare_map <- function(data, edition) {
  
  data_map <- reactive({
    map <- data
    map[, rank := NULL]
    map <- map[, country := ifelse(country %in% 
                                     c("England", "Wales", "Scotland"), 
                                   "United Kingdom", country)]
    map <- map[, country1 := ifelse(country %in% 
                                      c("United Kingdom"), 
                                    "England, Wales, Scotland", country)]
    
    map <- map[map$year %in% edition]
  })
  
  renderGvis({
    
    gvisGeoChart(data_map(), locationvar= "country", hovervar="country1",
                 options=list(
                   width=1075, height=550))
    
  })
  
}