library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    titlePanel("Is Chuck Norris evil?"),
    sidebarLayout(position="left",
        sidebarPanel(
            h4("Simulate a Chuck Norris simpose, and measure if it's positive or negative."),
            h4("Define how many can live enough to give an opinion"),
            # slider to select how many request
            sliderInput(inputId="slider", label="Opinions returned",
                        min=10, max=50, value=20),
            # submit button to generate request
            actionButton("action", "Go!")
        ),
        mainPanel(
            mainPanel(
                tabsetPanel(
                    tabPanel("Jokes", textOutput("jokes")), 
                    tabPanel("Stats", textOutput("stats"))
                )
            )
        )
        
    )
))
