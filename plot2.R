library(plyr)
library(ggplot2)

## Step 1: load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimoreNEI <- NEI[NEI$fips=="24510",]
aggTotalsBC <- aggregate(Emissions ~ year, baltimoreNEI, sum)

## Step 2: prepare to plot to png
png("plot2.png")

barplot( aggTotalsBC$Emissions, names.arg=aggTotalsBC$year, xlab="Year", ylab="PM2.5 Emissions (Tons)", main="Total PM2.5 Emissions From all Baltimore City Sources" ) 

dev.off() 