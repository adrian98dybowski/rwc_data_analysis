# Needed libraries

library(readxl)
library(pander)
library(shiny)
library(data.table)
library(DT)
library(googleVis)
library(tidyverse)
library(ggplot2)
library(plotly)
library(scales)
library(shinythemes)
library(xtable)
library(shinyjs)
library(pryr)
library(shinyWidgets)
library(shinydashboard) 
library(shinyBS) 


# Reading data

rwc <<- read_excel("rwc_history.xlsx")
setDT(rwc)
rwc[, rank := ifelse(position == "Pool stage", 6, 
                     ifelse(position == "Quater-finals", 5, 
                            ifelse(position == "Fourth place", 4, 
                                   ifelse(position == "Third place", 3,
                                          ifelse(position == "Runner-up", 2, 1)))))]
# Data to filters

EDITION <<- unique(rwc$year) 
COUNTRY <<- unique(rwc$country)
POSITION <<- unique(rwc$position)


# Functions to server

source("functions/prepare_map.R")
source("functions/history_table.R")
