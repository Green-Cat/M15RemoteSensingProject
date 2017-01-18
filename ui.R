library(shiny)

shinyUI(fluidPage(
  titlePanel("(Un)Supervised Classification"),
  sidebarLayout(
    sidebarPanel(
      selectInput("select", label = "Classification type", 
                  choices = list("Unsupervised" = 1, "Supervised" = 2), 
                  selected = 1),
      sliderInput("categories", "Number of categories", 2, 10, 2),
      sliderInput("samples", "Number of samples", 10, 200, 100)
    ),
    mainPanel(
      plotOutput("dataPlot"),
      h5(textOutput("details")),
      h5(textOutput("details2"))
    )
  )
))
