## R Script

# What are we looking for?
keyword <- "Friday"

# Figure out the year and month
currentDate <- Sys.Date()
currentYear <- year(currentDate)
currentMonth <- month(currentDate)

#Creating Data file
allURLs <- NULL

#Starting the data collection loop
for (year in (2007:currentYear)) {
  for (month in (1:12)) {
    if ((year == currentYear) && month > currentMonth) {
      next
    }
    
    theURL <- "http://stats.grok.se/json/en/"
    theURL <- paste0(theURL, year)
    if (month < 10) {
      theURL <- paste0(theURL, "0")
    }
    theURL <- paste0(theURL, month)
    theURL <- paste0(theURL, "/", keyword)
    
    #Storing the URLs back in the data file
    allURLs <- c(allURLs, theURL)
  }
}

## END OF SCRIPT