library(RCurl)
rawData <- getURL("http://stats.grok.se/json/en/201410/Friday")
library(RJSONIO)
parsedData <- fromJSON(rawData)