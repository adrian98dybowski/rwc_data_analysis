TABS <<- list('RWC' = tabPanel("Participants", 
                                        
                                        div(class = 'filter-box', 
                                            
                                            
                                            # Filtr edycji
                                            
                                            div(class = "filter_divs",                                                                    
                                                selectInput(inputId = "edition",
                                                            label = "RWC Edition",
                                                            multiple = FALSE,
                                                            choices =rev(EDITION),
                                                            selected = "2019")
                                            )#,
                                            
                                            # # Odświeżanie danych
                                            # div(title = 'Generate report', 
                                            #     actionBttn(inputId = "go", label = NULL, style = "material-circle", 
                                            #                color = "danger", icon = icon("search"))
                                            # )
                                            
                                            ),
                         
                                        htmlOutput("map")
                                        
)
) 
