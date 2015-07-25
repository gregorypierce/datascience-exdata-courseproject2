library(ggplot2)

## set the project Directory
projectDirectory <- "/projects/datascience/exploraratorydata/courseproject2"
dataDirectory <- paste0( projectDirectory,"/data")
setwd( projectDirectory )

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS( paste0( dataDirectory, "/summarySCC_PM25.rds" ) )
SCC <- readRDS( paste0( dataDirectory, "/Source_Classification_Code.rds") )

## Parse out a logical vector of the vehicle data
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

## Extract the data specifically for baltimore
baltimoreNEI <- vehiclesNEI[vehiclesNEI$fips==24510,]

baltimoreNEIPlot <- ggplot(baltimoreNEI, aes(factor(year), Emissions)) +
  geom_bar( stat = "identity", fill="grey") +
  theme_bw() +
  guides(fill=FALSE) +
  labs( x="Year", y=expression("Total PM2.5 Emissions (Tons)")) +
  labs( title=expression("PM2.5 Motor Vehicle Source Emissions from 1999 - 2008 (Baltimore)"))

print( baltimoreNEIPlot )
dev.copy(png, 'plot5.png')
dev.off()