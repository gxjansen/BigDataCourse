### Download JSON Data from the URLs defined in WikiMultipleMonths.R

## R SCRIPT:

#Create datafile
allViewsData <- NULL

#Starting the loop for the download
for (theURL in allURLs) {
  cat("Downloading data from", theURL, "\n")
  
  rawData <- getURL(theURL)
  parsedData <- fromJSON(rawData)
  viewsData <- data.frame(
    Date = names(parsedData$daily_views),
    Views = parsedData$daily_views,
    row.names = NULL
  )
  #storing the downloaded data
  allViewsData <- rbind(allViewsData, viewsData)
}

#Assigning dates to the first column
allViewsData$Date <- as.Date(allViewsData$Date)

#Sort on date
allViewsData <- allViewsData[order(allViewsData$Date), ]

##Clean the data
#Remove unavailable dates
allViewsData <- subset(allViewsData, !is.na(Date))
#Remove dates where there are 0 views (probably a data collection error)
allViewsData <- subset(allViewsData, Views != 0)

#Graph it
ggplot(data = allViewsData, aes(x = Date, y = Views)) + geom_line()

## END OF SCRIPT