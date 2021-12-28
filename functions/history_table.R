
history_table <- function(data){
  
  rwc0 <- data  
  rwc0 <- rwc0[, achievement := .N, .(country, position)]
  rwc0[, c("year", "rank") := NULL]
  rwc0 <- rwc0[!duplicated(rwc0)]
  
  rwc1 <- rwc0[position == 'Champion']
  rwc1[, position := NULL]
  rwc2 <- rwc0[position == 'Runner-up']
  rwc2[, position := NULL]
  rwc3 <- rwc0[position == 'Third place']
  rwc3[, position := NULL]
  rwc4 <- rwc0[position == 'Fourth place']
  rwc4[, position := NULL]
  rwc5 <- rwc0[position == 'Quater-finals']
  rwc5[, position := NULL]
  rwc6 <- rwc0[position == 'Pool stage']
  rwc6[, position := NULL]
  
  table <- data.frame(country = unique(rwc0$country))
  
  table <- merge(table, rwc1, by = 'country', all = TRUE)
  names(table)[2] <- 'champion'
  table <- merge(table, rwc2, by = 'country', all = TRUE)
  names(table)[3] <- 'runner_up'
  table <- merge(table, rwc3, by = 'country', all = TRUE)
  names(table)[4] <- 'third_place'
  table <- merge(table, rwc4, by = 'country', all = TRUE)
  names(table)[5] <- 'fourth_place'
  table <- merge(table, rwc5, by = 'country', all = TRUE)
  names(table)[6] <- 'quater_finals'
  table <- merge(table, rwc6, by = 'country', all = TRUE)
  names(table)[7] <- 'pool_stage'
  
  table[is.na(table)] = 0
  
  setorder(table, -champion, -runner_up, -third_place, -fourth_place, -quater_finals, -pool_stage)
  
  setDT(table)
  table[, summary := champion+runner_up+third_place+fourth_place+quater_finals+pool_stage]
  
  colnames(table) <- c("Country", "Championship", "Runner-up", "Third place",
                       "Fourth place", "Quater-final", "Pool stage", "Summary")
  
  renderDT({datatable(table,
                      escape = F,
                      class = 'cell-border stripe',
                      #extensions = c('Buttons', 'Scroller'),
                      selection = 'none',
                      #filter = 'top',
                      rownames = FALSE,
                      options = list(dom = 'Blfrtip', 
                      #buttons = list('colvis', list(extend = 'excel', filename = "RWC_history")), 
                      title = 'Historical_stats', 
                      pageLength = 100, 
                      searchHighlight = TRUE, 
                      scrollX = TRUE, 
                      lengthMenu = list(c(5, 10, 15, 20, -1), c('5', '10', '15', '20', 'All')), 
                      autoWidth = FALSE,
                      columnDefs = list(list(width = '200px')))
                      
  ) %>%
    formatStyle("Championship", backgroundColor = styleEqual(c(1, 2, 3), c("gold", "gold", "gold"))) %>% 
    formatStyle("Runner-up", backgroundColor = styleEqual(c(1, 2, 3), c("silver", "silver", "silver"))) %>% 
    formatStyle("Third place", backgroundColor = styleEqual(c(1, 2, 3), c("brown", "brown", "brown")))
      
  }, server = FALSE
  )

}
