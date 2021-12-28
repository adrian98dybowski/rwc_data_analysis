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
library(shinyjs)
library(pryr)
library(shinyWidgets)


rwc <<- read_excel("rwc_history.xlsx")
setDT(rwc)
rwc[, rank := ifelse(position == "Pool stage", 6, 
                     ifelse(position == "Quater-finals", 5, 
                            ifelse(position == "Fourth place", 4, 
                                   ifelse(position == "Third place", 3,
                                          ifelse(position == "Runner-up", 2, 1)))))]

EDITION <<- unique(rwc$year) 
COUNTRY <<- unique(rwc$country)
POSITION <<- unique(rwc$position)
