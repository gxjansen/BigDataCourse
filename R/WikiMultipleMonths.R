### Select the correct URLs for a certain date range to download Pageviews data from
### This is used as input for DownloadAllData.R

## R Script

#### INPUT VARIABLES ###############################################
### Allows you to select the keyword and starting date
keyword <- "Friday"
fromDate <- "2007-12-01"  #YYYY-MM-DD - Day input here has no effect
####################################################################

#Figure our the "from" year and month
startYear <- year(fromDate)
startMonth <- month(fromDate)

# Figure out the current year and month
currentDate <- Sys.Date()
currentYear <- year(currentDate)
currentMonth <- month(currentDate)

#Creating Data storage
allURLs <- NULL

#Starting the data collection loop
for (year in (startYear:currentYear)) {
  for (month in (1:12)) {
    if ((year == startYear) && month < startMonth) {
      next
      
    }
    if ((year == currentYear) && month > currentMonth) {
      break
      
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