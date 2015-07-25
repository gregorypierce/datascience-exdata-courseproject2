library(ggplot2)

## set the project Directory
projectDirectory <- "/projects/datascience/exploraratorydata/courseproject2"
dataDirectory <- paste0( projectDirectory,"/data")
setwd( projectDirectory )

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS( paste0( dataDirectory, "/summarySCC_PM25.rds" ) )
SCC <- readRDS( paste0( dataDirectory, "/Source_Classification_Code.rds") )

## parse out a logical vector of the combustion & coal data
combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case = TRUE)
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE)

coalCombustion <- ( combustion & coal )
combustionSCC <- SCC[coalCombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

combustionPlot <- ggplot(combustionNEI,aes(factor(year),Emissions/10^5))+ 
  geom_bar(stat="identity",fill="grey",width=0.75)+
  theme_bw()+ 
  guides(fill=FALSE)+ 
  labs(x="Year",y=expression("TotalPM2.5 Emission(10^5Tons)"))+ 
  labs(title=expression("PM2.5 Coal Combustion Source Emissions Across US from 1999 - 2008"))

print( combustionPlot )
dev.copy(png, 'plot4.png')
dev.off()