library(readxl)
library(pander)
library(shiny)
library(data.table)
library(googleVis)
library(tidyverse)
library(ggplot2)
library(plotly)
library(scales)
library(reshape2)
library(shinythemes)
library(lmtest)
library(markdown)
library(rmarkdown)
library(knitr)
library(xtable)

rwc <- read_excel("rwc_history.xlsx")
setDT(rwc)
rwc[, rank := ifelse(position == "Pool stage", 1, 
                     ifelse(position == "Quater-finals", 2, 
                            ifelse(position == "Fourth place", 3, 
                                   ifelse(position == "Third place", 4,
                                          ifelse(position == "Runner-up", 5,6)))))]

#rwc_best <- rwc[rank > 1]

#ggplot(rwc_best, aes(x=year, y = rank, colour = country, label = country))+
 # geom_point(size = 1)+
  #geom_text(aes(label=country,hjust=0.5,vjust=-2))+
  #scale_y_continuous(name="Position in RWC", labels = c("Quater-finals", "Fourth place", "Third place", "Runner-up", "Champion")) +
  #scale_x_continuous(name="RWC edition", breaks = c(1987, 1991, 1995, 1999, 2003, 2007, 2011, 2015, 2019)) +
  #ggtitle("Knockout stage in Rugby World Cup")


### UI #############################################################################

ui <- fluidPage(
  
  theme=shinytheme("cerulean"),
  
  titlePanel("RUGBY WORLD CUP"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      checkboxGroupInput(inputId = "selectYear",
                         label = "RWC Edition",
                         choices = rev(seq(1987, 2019, 4)),
                         selected = "2019"),
      actionButton("getDataFromServer", "Upload data"),
      
      selectInput(
        "country",
        "Choose country",
        multiple = TRUE,
        choices = as.vector(sort(unique(rwc$country)), mode="list"),
        selected = " "
      ),
    ),
    

    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Start", verbatimTextOutput("start")),
                  tabPanel("Tabela roczna", DT::dataTableOutput("edition")),
                  tabPanel("Mapa walut",htmlOutput("view")),
                  tabPanel("Szeregi czasowe",plotlyOutput("szereg"))
                  #tabPanel("Scatter plot",plotlyOutput("scatter")),
                  #tabPanel("Histogram",plotlyOutput("histogram")),
                  #tabPanel("Model regresji", uiOutput("math"), verbatimTextOutput("summary"),
                           #verbatimTextOutput("raintest"), plotlyOutput("regresja"))
                  
      )
      
    )
    

  )
  
)

### SERVER ########################################################################

server <- function(input, output) {
  
  outCountry <- reactiveValues(
    selectCountryVar = " "
  )
  
  observeEvent(input$country,{
    outCountry$selectCountryVar <-input$country
  })
  
  outVar <- reactiveValues(
    selectYearVar = "2019"
  )
  
  observeEvent(input$selectYear,{
    outVar$selectYearVar <- input$selectYear
  })
  
  data <- reactive({rwc})
  
  #START#
  output$start <- renderText({
    "                      Witaj w aplikacji KURSY WALUT
    
    
              1. Zaimportuj dane
              2. Wybierz w okienkach po jednej dowolnej walucie
              3. Przejdz do wybranej zakladki
    
           UWAGA! 
           Waluta LTL dostepna tylko dla roku 2013, 
           natomiast waluta LVL dla lat 2013-2014
           (potem zamienione na euro)."
  })
  
  #TABELA ROCZNA#
  output$edition <- DT::renderDataTable({
    DT::datatable(  
      data(), 
      rownames = FALSE,
      options = list(
        scrollX = TRUE,
        pageLength = 10,
        lengthMenu = seq(from=10,by=10,to=100)
      )
    )
  })
  
  
  #SZEREG CZASOWY#  
  output$szereg <- renderPlotly({
    ggplot(rwc_best, aes(x=year, y = rank, colour = input$country, group = input$country))+
      geom_point(size = 1)+
      #geom_text(aes(label=input$country,hjust=0.5,vjust=-2))+
      scale_y_continuous(name="Position in RWC", labels = c("Quater-finals", "Fourth place", "Third place", "Runner-up", "Champion")) +
      scale_x_continuous(name="RWC edition", breaks = c(1987, 1991, 1995, 1999, 2003, 2007, 2011, 2015, 2019)) +
      ggtitle("Knockout stage in Rugby World Cup")
  })
  
  
}


shinyApp(ui = ui, server = server)
