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
BCVehiclesNEI$city <- "Baltimore City"

LAVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips=="06037",]
LAVehiclesNEI$city <- "Los Angeles County"

allNEI <- rbind(BCVehiclesNEI, LAVehiclesNEI)

## Step 2: prepare to plot to png
png("plot6.png")

ggp <- ggplot(allNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Baltimore and LA PM"[2.5]*" Motor Vehicle Emissions from 1999-2008"))
print(ggp)

dev.off() 