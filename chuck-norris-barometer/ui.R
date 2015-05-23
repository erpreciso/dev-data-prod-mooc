require(shiny)
require(RCurl)
require(RJSONIO)



shinyUI(fluidPage(
    titlePanel("Chuck Norris Barometer"),
    fluidRow(h4("Is Chuck Norris seen as good or bad?",
                style="margin: 20px;")),
    sidebarLayout(position="left",
        sidebarPanel(
            h4("Choose a number of facts you'd like to analyze."),
            sliderInput(inputId="slider", label="Facts pool size",
                        min=10, max=50, value=10),
            # h5(em(strong("Fact"), ": satirical factoids about martial artist and actor Chuck Norris that have become an Internet phenomenon and as a result have become widespread in popular culture.")),
            # h6(em("From",a("Wikipedia", href="https://en.wikipedia.org/wiki/Chuck_Norris_facts"))),
            h6("A special thanks to ",
               a("ICNDb.com", href="http://www.icndb.com/"),
               ", the Internet Chuck Norris Database"),
            width=3
        ),
        mainPanel(
            tabsetPanel(type="tabs",
                        tabPanel("App", 
                                 fluidRow(
                                     column(8,
                                            h3("Facts Pool"),
                                            htmlOutput("jokes")
                                     ),
                                     column(4,
                                            plotOutput("plot")
                                     )
                                 )),
                        tabPanel("Documentation",
                                 includeMarkdown("app-documentation.md")
                                 )
            ),
            width=9
        )
        
    )
))
