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
allViewsData <- allViewsData[order(allViewsData$Date),]

#Clean the data
allViewsData <- subset(allViewsData, !is.na(Date))

#Graph it
ggplot(data=allViewsData, aes(x=Date, y=Views)) + geom_line()

## END OF SCRIPT