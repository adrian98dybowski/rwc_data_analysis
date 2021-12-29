TABS3 <<- tabPanel("Comparison", 
                  
                  div(class = 'filter-box', 
                      
                      # Filter on editions
                      
                      div(class = "filter_divs",                                                                    
                          pickerInput(inputId = "country1",
                                      label = "Country 1",
                                      multiple = TRUE,
                                      choices = as.vector(sort(COUNTRY), mode="list"),
                                      selected = "New Zealand",
                                      options = list(`max-options` = 1))
                      ),
                      
                      div(class = "filter_divs",                                                                    
                          pickerInput(inputId = "country2",
                                      label = "Country 2",
                                      multiple = TRUE,
                                      choices = as.vector(sort(COUNTRY), mode="list"),
                                      selected = " ",
                                      options = list(`max-options` = 1))
                      ),
                      
                      div(class = "filter_divs",                                                                    
                          pickerInput(inputId = "country3",
                                      label = "Country 3",
                                      multiple = TRUE,
                                      choices = as.vector(sort(COUNTRY), mode="list"),
                                      selected = " ",
                                      options = list(`max-options` = 1))
                      ),
                      
                      div(class = "filter_divs",                                                                    
                          pickerInput(inputId = "country4",
                                      label = "Country 4",
                                      multiple = TRUE,
                                      choices = as.vector(sort(COUNTRY), mode="list"),
                                      selected = " ",
                                      options = list(`max-options` = 1))
                      )
                      ),
                  
                  plotlyOutput("comparison")
)