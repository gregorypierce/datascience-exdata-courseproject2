library(ggplot2)

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

## Create a ggplot for the Baltimore NEI dataframe
neiplot <- ggplot( baltimoreNEI, aes(factor(year), Emissions, fill=type)) + geom_bar(stat="identity") + theme_bw() + guides( fill=FALSE ) + facet_grid(.~type, scales="free", space="free") +
  labs(x="Year", y=expression("PM2.5 Emissions (Tons)")) + labs( title=expression("PM2.5 Emissions, Baltimore City 1999-2008 by Source Type"))

print(neiplot) 

dev.copy(png, 'plot3.png')
dev.off()