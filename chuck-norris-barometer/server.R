require(shiny)
require(tm)
require(RCurl)
require(ggplot2)
require(reshape)
require(qdap)

# TODO
# publish on shiny server
# rewrite instructions

create.jokes.list <- function(number.of.jokes) {
    cn.url <- paste("http://api.icndb.com/jokes/random/",
                    number.of.jokes,
                    "?escape=javascript",
                    sep="")
    t <- fromJSON(getURL(cn.url))
    lapply(1:number.of.jokes, FUN=function(i) t$value[[i]]$joke)
}

format.jokes.list <- function(jokes) {
    # function to format in html a single joke
    small.html.p <- function(indx, txt) {
        c <- "font-size: 11px; font-weight: 500; line-height: 1.1;"
        p(paste(indx, " - ", txt), style=c)
    }
    lapply(1:length(jokes), FUN=function(i) small.html.p(i, jokes[[i]]))
}

measure.sentiment.level <- function(jokes.list) {
    # return polarity obj
    df <- data.frame(joke=vector(mode="character"))
    for (joke in jokes.list) {
        df <- rbind(df, data.frame(joke=joke))
    }
    return(polarity(df$joke))
}

shinyServer(function(input, output) {
    n <- 10
    jokes <- list()
    formatted.jokes <- list()
    jokes.input <- reactive({
        n  <<- round(input$slider/1, digits=0)
        jokes <<- create.jokes.list(n)
        formatted.jokes <<- format.jokes.list(jokes)
    })
    output$jokes <- renderUI({
        jokes.input()
        return(formatted.jokes)
    })
    output$plot <- renderPlot({
        jokes.input()
        jokes.polarity <- measure.sentiment.level(jokes)
        j.p.df <- jokes.polarity$all
        p <- ggplot(j.p.df, aes(x=polarity)) + geom_density()
        p <- p + geom_vline(xintercept=0, colour="black", size=1)
        center.labels <- 0.3
        p <- p + geom_text(data=NULL, x=center.labels, y=0.5,
                           label = "Positive Mood", colour="green")
        p <- p + geom_text(data=NULL, x=-center.labels, y=0.5,
                           label = "Negative Mood", colour="red")
        p <- p + ggtitle("Fact Pool Polarity")
        print(p)
        
    })
})
