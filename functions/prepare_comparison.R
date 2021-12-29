
prepare_comparison <- function(data, country1, country2, country3, country4) {
  
  # rwc0 <- data
  # rwc1 <- rwc0[country == country1]
  # rwc1[, position := NULL]
  # rwc2 <- rwc0[country == country2]
  # rwc2[, position := NULL]
  # rwc3 <- rwc0[country == country3]
  # rwc3[, position := NULL]
  # rwc4 <- rwc0[country == country4]
  # rwc4[, position := NULL]
  # 
  # rwc_all <- merge(rwc1, rwc2, by = 'year', all = TRUE)
  # names(table)[2] <- 'champion'
  # table <- merge(table, rwc2, by = 'country', all = TRUE)
  # names(table)[3] <- 'runner_up'
  # table <- merge(table, rwc3, by = 'country', all = TRUE)
  # names(table)[4] <- 'third_place'
  
  data_comaprison <- reactive ({
  rwc0 <- data
  rwc0 <- rwc0[country %in% c(country1, country2, country3, country4)]
  })
  
  renderPlotly({
  ggplot(data_comaprison()) +
    geom_point(mapping = aes(x = year, y = -rank, colour = country, group = country), size=2)+
    geom_line(mapping = aes(x = year, y = -rank, colour = country, group = country), size=1)+
    xlab("RWC Edition")+
    ylab("Achievement")+
    scale_x_continuous(breaks = EDITION)+ 
    scale_y_continuous(breaks = -1:-6, labels = POSITION)+ 
    theme_minimal()
  })  
}
