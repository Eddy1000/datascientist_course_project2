#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

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

# aggrigate
be <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
bea <- aggregate(Emissions ~ year, data=be, FUN=sum)

# plot
library(ggplot2)
png("plot5.png")
ggplot(bea, aes(x=factor(year), y=Emissions)) +
  geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression("total PM25 emissions")) +
  ggtitle("Emissions Baltimore")
dev.off()
