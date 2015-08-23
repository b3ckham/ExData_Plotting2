library(plyr)
library(ggplot2)

## Step 1: load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

baltimoreNEI <- NEI[NEI$fips=="24510",]
aggTotalsBC <- aggregate(Emissions ~ year + type, baltimoreNEI, sum)

## Step 2: prepare to plot to png
png("plot3.png")

ggp <- ggplot(aggTotalsBC, aes(year, Emissions, color = type))
ggp <- ggp + geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999 to 2008')
print(ggp)

dev.off() 