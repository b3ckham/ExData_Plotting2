library(plyr)
library(ggplot2)

## Step 1: load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Gather the subset of the NEI data which corresponds to vehicles 
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

BCVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips=="24510",]

## Step 2: prepare to plot to png
png("plot5.png")

ggp <- ggplot(BCVehiclesNEI,aes(factor(year),Emissions)) + 
  geom_bar(stat="identity",fill="grey",width=0.75) + 
  guides(fill=FALSE) + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (tons)")) +  
  labs(title=expression("Baltimore City PM"[2.5]*" Motor Vehicle Emissions from 1999-2008")) 
print(ggp)

dev.off() 