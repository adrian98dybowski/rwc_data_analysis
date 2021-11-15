library(readxl)
library(pander)
library(shiny)
#library(shinyWidgets)
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

rwc_best <- rwc[rank > 1]

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
        choices = as.vector(sort(unique(rwc$country))),
        selected = " ",
        options = list(`max-options` = 1)
      ),
      pickerInput(
        "kurs2",
        "Waluta druga",
        multiple = TRUE,
        choices = as.vector(sort(c("THB", "USD", "AUD", "HKD",	"CAD",	"NZD",	"SGD", "HUF",	
                                   "CHF",	"UAH", "JPY",	"CZK",	"DKK", "ISK",	"NOK", "SEK", "HRK",	
                                   "RON",	"BGN", "TRY",	"LTL", "LVL", "ILS", "CLP",	"PHP", "MXN",	"ZAR", "BRL",
                                   "MYR",	"RUB", "IDR", "INR", "KRW",	"CNY", "GBP", "EUR", "XDR")),mode="list"),
        selected = " ",
        options = list(`max-options` = 1)
      ),
      
      actionButton("report","Generuj raport HTML")
      
    ),
    
    
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Start", verbatimTextOutput("start")),
                  tabPanel("Tabela roczna", DT::dataTableOutput("dataSample")),
                  tabPanel("Mapa walut",htmlOutput("view")),
                  tabPanel("Szeregi czasowe",plotlyOutput("szereg")),
                  tabPanel("Scatter plot",plotlyOutput("scatter")),
                  tabPanel("Histogram",plotlyOutput("histogram")),
                  tabPanel("Model regresji", uiOutput("math"), verbatimTextOutput("summary"),
                           verbatimTextOutput("raintest"), plotlyOutput("regresja"))
                  
      )
      
    )
    
    
  )
  
)

            
