require(shiny)
# install.packages("tm.lexicon.GeneralInquirer", repos="http://datacube.wu.ac.at", type="source")
require(tm)
require("tm.lexicon.GeneralInquirer")
require(RCurl)
require(ggplot2)
require(reshape)

# TODO
# split jokes in HTML paragraphs
# refine graph output
# reread instructions

positive.terms <- terms_in_General_Inquirer_categories("Positiv")
negative.terms <- terms_in_General_Inquirer_categories("Negativ")

create.jokes.list <- function(number.of.jokes) {
    cn.url <- paste("http://api.icndb.com/jokes/random/", number.of.jokes, sep="")
    t <- fromJSON(getURL(cn.url))
    lapply(1:number.of.jokes, function(i) as.character(t$value[[i]]$joke))
}
measure.sentiment.level <- function(jokes.list) {
    positive.score <- 0
    negative.score <- 0
    for (joke in jokes.list) {
        positive.score <- positive.score + tm_term_score(
            PlainTextDocument(joke), positive.terms)
        negative.score <- negative.score + tm_term_score(
            PlainTextDocument(joke), negative.terms)
    }
    return(c(positive.score, negative.score))
}

shinyServer(function(input, output) {
    n <- 20
    jokes <- list()
    jokes.input <- reactive({
        n  <<- round(input$slider/1, digits=0)
        jokes <<- create.jokes.list(n)
    })
    output$jokes <- renderText({
        jokes.input()
        unlist(jokes)
        })
    output$plot <- renderPlot({
        jokes.input()
        scores <- measure.sentiment.level(jokes)
        df <- data.frame(
            direction.of.mood=c("Positive","Negative"),
            score=scores)
        p <- ggplot(df, aes(direction.of.mood, score))
        p <- p + geom_bar(stat="identity", fill=c("green","red"))
        print(p)
        
    })
})
