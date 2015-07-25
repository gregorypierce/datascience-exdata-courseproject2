## set the project Directory
projectDirectory <- "/projects/datascience/exploraratorydata/courseproject2"
dataDirectory <- paste0( projectDirectory,"/data")
setwd( projectDirectory )

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS( paste0( dataDirectory, "/summarySCC_PM25.rds" ) )
SCC <- readRDS( paste0( dataDirectory, "/Source_Classification_Code.rds") )

## Aggregate the Emissions/year into totals
totals <- aggregate(Emissions ~ year, NEI, sum )

## Generate a barplot
barplot( totals$Emissions/10^6,
         names.arg = totals$year,
         xlab="Year",
         ylab="PM2.5 Emissions (10^6 Tons)",
         main="Total PM2.5 Emissions (all sources)")

dev.copy(png, 'plot1.png')
dev.off()