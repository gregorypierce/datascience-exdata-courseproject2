## set the project Directory
projectDirectory <- "/projects/datascience/exploraratorydata/courseproject2"
dataDirectory <- paste0( projectDirectory,"/data")
setwd( projectDirectory )

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS( paste0( dataDirectory, "/summarySCC_PM25.rds" ) )
SCC <- readRDS( paste0( dataDirectory, "/Source_Classification_Code.rds") )

## Extract the data for Baltomore
baltimoreNEI <- NEI[NEI$fips=="24510",]
totals <- aggregate(Emissions ~ year, baltimoreNEI, sum )

## Generate a barplot
barplot( totals$Emissions,
         names.arg = totals$year,
         xlab="Year",
         ylab="PM2.5 Emissions (Tons)",
         main="Total PM2.5 Emissions (all Baltimore sources)")

dev.copy(png, 'plot2.png')
dev.off()