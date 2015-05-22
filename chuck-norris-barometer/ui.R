require(shiny)
require(RCurl)
require(RJSONIO)



shinyUI(fluidPage(
    titlePanel("Are people discussing Chuck Norris positively, or negatively?"),
    sidebarLayout(position="left",
        sidebarPanel(
            h4("Simulate a Chuck Norris simpose, and measure if the mood is positive or negative."),
            h4("Define how many can live enough to give an opinion"),
            # slider to select how many request
            sliderInput(inputId="slider", label="Opinions returned",
                        min=10, max=50, value=20),
            # submit button to generate request
            actionButton("action", "Go!"),
            h6("A special thanks to ",
               a("ICNb.com", href="http://www.icndb.com/"),
               ", the Internet Chuck Norris Database")
        ),
        mainPanel(
            fluidRow(
                column(5,
                    textOutput("jokes")
                ),
                column(5,
                    plotOutput("plot", width = "100%", height = "400")
                )
            )
        )
        
    )
))
