library(shiny)
library(rgdal)
library(raster)
library(RStoolbox)

shinyServer(function(input, output) {
  
  setwd("~/RScripts/Remote sensing/project")
  
  lsat <- brick("raster/cropped.tif")

  output$dataPlot <- renderPlot({
    if(input$select == 1) {
      # Unsupervised classification
      classification <- RStoolbox::unsuperClass(lsat, nClasses=input$categories, nSamples=input$samples)
      plot(classification$map)
      details.text <- paste("Unsupervised classification with", input$categories, "categories and", input$samples, "samples.")
      details.text2 <- ""
    }
    else {
      # Supervised classification
      file.name <- paste0("classes", input$categories)
      training.data <- readOGR("vector", file.name)
      classification <- superClass(lsat, trainData = training.data, responseCol = "class", trainPartition = 0.7, nSamples=input$samples)
      accuracy <- classification$validation$performance$overall["Accuracy"] 
      plot(classification$map)
      details.text <- paste("Supervised classification with", input$categories," categories and", input$samples, "samples.")
      details.text2 <- paste("Accuracy of ", accuracy)
    }
    output$details <- renderText(details.text)
    output$details2 <- renderText(details.text2)
  })
})