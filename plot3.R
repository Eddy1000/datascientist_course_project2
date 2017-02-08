#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

#load needed libarary
library(ggplot2)

#Fetching the Data if needed
filename1 <- "summarySCC_PM25.rds"
filename2 <- "Source_Classification_Code.rds"

if (!file.exists(filename1) || !file.exists(filename2)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  zipfile <- "exdata_data_NEI_data.zip"
  download.file(fileURL, zipfile)
  unzip(zipfile)
} 

#Reading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

be <- NEI[NEI$fips=="24510",]

bea <- aggregate(Emissions ~ year + type,data=be,FUN=sum)

#create the plot
png("plot3.png", height=480, width=680)
ggplot(bea, aes(x=factor(year), y=Emissions, fill=type)) +
  geom_bar(stat="identity") +
  facet_grid(. ~ type) +
  xlab("year") +
  ylab("total PM2 emission") +
  ggtitle(expression("PM2 emissions in Baltimore City by source types"))
dev.off()
