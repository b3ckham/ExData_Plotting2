library(plyr)
library(ggplot2)

## Step 1: load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

aggTotals <- aggregate(Emissions ~ year, NEI, sum)

## Step 2: prepare to plot to png
png("plot1.png")

barplot(height=aggTotals$Emissions, names.arg=aggTotals$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions at various years')) 

dev.off() 