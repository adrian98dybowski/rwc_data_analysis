
edition_table <- function(data, edition){
  
  rwc0 <- data
  rwc0 <- rwc0[year == edition]
  rwc0[, c("rank", "year") := NULL]
  
  colnames(rwc0) <- c("Position", "Country")
  
  renderDT({datatable(rwc0,
                      escape = F,
                      class = 'cell-border stripe',
                      selection = 'none',
                      rownames = FALSE,
                      options = list(dom = 't', 
                                     title = 'Edition_stats', 
                                     pageLength = 20, 
                                     searchHighlight = TRUE, 
                                     scrollX = FALSE, 
                                     autoWidth = FALSE)
                      
  ) %>%
      formatStyle("Position", 
                  backgroundColor = styleEqual(
                    c("Champion", "Runner-up", "Third place"), 
                    c("gold", "silver", "brown")))
    
  }, server = FALSE
  )
  
}
