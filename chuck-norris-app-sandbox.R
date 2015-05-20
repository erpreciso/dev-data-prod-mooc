
# install.packages("tm.lexicon.GeneralInquirer", repos="http://datacube.wu.ac.at", type="source")
require(tm)
require("tm.lexicon.GeneralInquirer")
require(RCurl)

positive.terms <- terms_in_General_Inquirer_categories("Positiv")
negative.terms <- terms_in_General_Inquirer_categories("Negativ")

t <- getURL("http://api.icndb.com/jokes/random/10")
q <- fromJSON(t)
tm_term_score(PlainTextDocument(q$value$joke), negative.terms)
