TABS <<- tabPanel("Participants", 
                                        
                                  div(class = 'filter-box', 
                                            
                                      # Filter on editions
                                            
                                        div(class = "filter_divs",                                                                    
                                            selectInput(inputId = "edition",
                                                        label = "RWC Edition",
                                                        multiple = FALSE,
                                                        choices =rev(EDITION),
                                                        selected = "2019")
                                            )),
                         
                                    htmlOutput("map")
                                        )
