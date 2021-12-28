#source("ui.rwc/tabs.R") 

fluidPage(
  tags$head(
    includeCSS("www.rwc/style.css"), 
  ), 
  useShinyjs(), 
  navbarPage("RUGBY WORLD CUP", id = 'navbar'),
  source("ui.rwc/tabs.R") 
)