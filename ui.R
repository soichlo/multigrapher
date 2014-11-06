
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(ggplot2)
library(plot3D)
library(manipulate)
library(cubature)

shinyUI(pageWithSidebar(
  
  
  
  # Application title
  headerPanel("Multivariate Grapher"),
  
  # Sidebar
  sidebarPanel(
    #tags$head(
    #  tags$style("body {background-color: black; }")),
    
    wellPanel(radioButtons("inputType",strong("Input Type:"),list("Pre Set","Enter Own"),
                           selected="Pre Set") ),
    #Select output type
    wellPanel(radioButtons("outType", strong("Output Type:"), 
                           list("Standard Axes", "Box", "No Axes"), 
                           selected="Box"))
  ),
  
  # Output results of plots
  mainPanel(
    withMathJax(),  
    
    uiOutput("phi"),
    uiOutput("theta"),
    uiOutput("integrand"),
    uiOutput("lowerLim1"),
    uiOutput("upperLim1"),
    uiOutput("lowerLim2"),
    uiOutput("upperLim2"),
    
    plotOutput("object"),
    
    uiOutput("distribCalc"),
    uiOutput("percentile"),
    uiOutput("percentCalc"),
    uiOutput("probTypeSelect"),
    uiOutput("probCalc"),
    uiOutput("intCalc")
    
  )
)
)
