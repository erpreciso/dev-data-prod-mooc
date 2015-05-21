library(shiny)

create.jokes.list <- function(number.of.jokes) {
    cn.url <- paste("http://api.icndb.com/jokes/random/", number.of.jokes, sep="")
    t <- fromJSON(getURL(cn.url))
    lapply(1:number.of.jokes, function(i) as.character(t$value[[i]]$joke))
}
measure.sentiment.level <- function(jokes.list) {
    print(jokes.list[1])
}

shinyServer(function(input, output) {
    n <- 20
    jokes <- list()
    jokes.input <- reactive({
        n  <- round(input$slider/1, digits=0)
        jokes <- create.jokes.list(n)
    })
    output$jokes <- renderText({
        jokes.input()
        unlist(jokes)
        })
    output$stats <- renderUI({
        jokes.input()
        measure.sentiment.level(jokes)
    })
})
