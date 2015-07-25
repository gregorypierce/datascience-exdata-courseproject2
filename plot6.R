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
baltimoreNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]
baltimoreNEI$cityName <- "Baltimore"

laNEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
laNEI$cityName <-"Los Angeles"

## combine this data into one dataframe
compNEI <- rbind( baltimoreNEI, laNEI )


 
compPlot <- ggplot(compNEI, aes(factor(year), Emissions, fill=cityName)) +
  geom_bar(aes(fill=year), stat = "identity") +
  facet_grid(scales="free", space="free", .~cityName) +
  guides(fill=FALSE) +
  theme_bw() +
  
  labs( x="Year", y=expression("Total PM2.5 Emissions (Tons)")) +
  labs( title=expression("PM2.5 Motor Vehicle Source Emissions (Baltimore vs LA)"))

print( compPlot )
dev.copy(png, 'plot6.png')
dev.off()