library(shiny)

create.jokes.list <- function(number.of.jokes) {
    cn.url <- paste("http://api.icndb.com/jokes/random/", number.of.jokes, sep="")
    t <- fromJSON(getURL(cn.url))
    lapply(1:number.of.jokes, function(i) as.character(t$value[[i]]$joke))
}
shinyServer(function(input, output) {
    output$jokes <- renderText({
        n  <- round(input$slider/10, digits=0)
        unlist(create.jokes.list(n))
        })
})
