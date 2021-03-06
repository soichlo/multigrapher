
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

require(shiny)
library(scales)
library(plot3D)
library(manipulate)
library(cubature)

if (!("shiny" %in% names(installed.packages()[,"Package"]))) {install.packages("shiny")}
suppressMessages(library(shiny, quietly = TRUE))

if (!("ggplot2" %in% names(installed.packages()[,"Package"]))) {install.packages("ggplot2")}
suppressMessages(library(ggplot2, quietly = TRUE))


shinyServer(function(input, output, session) {
  
  #Enter angles for graph display
  output$phi <- renderUI({
    numericInput("p", withMathJax('Enter the angle, phi, for viewing:'), 40, 
                 step=1, min=0, max=180)
  })
  output$theta <- renderUI({
    numericInput("t", withMathJax('Enter the angle, phi, for viewing:'), 90, 
                 step=1, min=0, max=360)
  })
  #Enter integrand to be evaluated
  output$integrand <- renderUI({
    textInput("integrand", withMathJax('Enter the integrand: e.g. paraboloid: x1^2+x2^2'), value="x1^2+x2^2")
  })
  #Enter limits for integration
  output$lowerLim1 <- renderUI({
    textInput("lowerLimit1", withMathJax('Enter the lower limit of integration on x1:'), value="0")
  })
  output$upperLim1 <- renderUI({
    textInput("upperLimit1", withMathJax('Enter the upper limit of integration on x1:'), value="1")
  })
  output$lowerLim2 <- renderUI({
    textInput("lowerLimit2", withMathJax('Enter the lower limit of integration on x2:'), value="0")
  })
  output$upperLim2 <- renderUI({
    textInput("upperLimit2", withMathJax('Enter the upper limit of integration on x2:'), value="1")
  })
  
  #Choose an object/enter your own after selecting Pre Set or Enter Own.
  output$object <- renderPlot({
    if(input$inputType == "Pre Set"){
      ### Weird Cube      
      M  <- mesh(seq(0, 20, length.out = 50), 
                 seq(0, 2*pi, length.out = 50))
      
      u  <- M$x ; v  <- M$y
      
      x  <- sin(u)
      y  <- sin(v)
      z  <- sin(u + v)
      
      surf3D(x, y, z, colvar = z, border = "black", phi = input$p, theta = input$t,
             colkey = FALSE)
    }
  })

  output$intCalc <- renderUI({
    #Allows for integrand to use x1 and x2 instead of x[1] and x[2]
    integrate <- function(x) {
      x1 = x[1]
      x2 = x[2]
      eval(parse(text=input$integrand))
    }
    #Compute integral of the inputted integrand over the inputted region
    adaptIntegrate(integrate, lowerLimit = c(input$lowerLimit1,input$lowerLimit2), upperLimit = c(input$upperLimit1, input$upperLimit2)) #eval(parse....) solved the problem of entering the inputted integrand into adaptIntegrate
  })
  
  #Close
})







