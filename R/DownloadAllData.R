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
allViewsData <- subset(allViewsData, Views > 10)

#######################################
# VISUALIZATION

fte_theme <- function() {
  
  # Generate the colors for the chart procedurally with RColorBrewer
  palette <- brewer.pal("Greys", n=9)
  color.background = palette[2]
  color.grid.major = palette[3]
  color.axis.text = palette[6]
  color.axis.title = palette[7]
  color.title = palette[9]
  
  # Begin construction of chart
  theme_bw(base_size=9) +
    
    # Set the entire chart region to a light gray color
    theme(panel.background=element_rect(fill=color.background, color=color.background)) +
    theme(plot.background=element_rect(fill=color.background, color=color.background)) +
    theme(panel.border=element_rect(color=color.background)) +
    
    # Format the grid
    theme(panel.grid.major=element_line(color=color.grid.major,size=.25)) +
    theme(panel.grid.minor=element_blank()) +
    theme(axis.ticks=element_blank()) +
    
    # Format the legend, but hide by default
    theme(legend.position="none") +
    theme(legend.background = element_rect(fill=color.background)) +
    theme(legend.text = element_text(size=7,color=color.axis.title)) +
    
    # Set title and axis labels, and format these and tick marks
    theme(plot.title=element_text(color=color.title, size=20, vjust=1.25)) +
    theme(axis.text.x=element_text(size=12,color=color.axis.text)) +
    theme(axis.text.y=element_text(size=12,color=color.axis.text)) +
    theme(axis.title.x=element_text(size=15,color=color.axis.title, vjust=0)) +
    theme(axis.title.y=element_text(size=15,color=color.axis.title, vjust=1.25)) +
    
    # Plot margins
    theme(plot.margin = unit(c(0.35, 0.2, 0.3, 0.35), "cm"))
}

#Dynamic Title
startMonthLabel <- month(ymd(fromDate), label = TRUE, abbr = FALSE)
currentMonthLabel <- month(ymd(currentDate), label = TRUE, abbr = FALSE)

graphTitle <- paste0("Daily Wikipedia (EN) pageviews of ","'",keyword,"'"," from ",startMonthLabel," ",startYear," to ",currentMonthLabel," ",currentYear)

#Graph it

ggplot(data = allViewsData, aes(x= Date, y= Views)) +
  geom_point(alpha=0.1, color="#f46f25", size=2) +
  scale_y_log10(labels=comma, breaks=10^(0:6)) +
  geom_hline(yintercept=1, size=0.4, color="black") +
  geom_smooth(alpha=0.25, color="black", fill="black", method="auto") +
  fte_theme() +
 labs(title=graphTitle, x="Date", y="# of Pageviews")

## END OF SCRIPT