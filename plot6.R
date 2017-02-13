#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

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

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))
MD.onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
CA.onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

# aggregate
MD.DF <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum)
colnames(MD.DF) <- c('year', 'Emissions')
MD.DF$City <- paste(rep('MD', 4))
CA.DF <- aggregate(CA.onroad[, 'Emissions'], by=list(CA.onroad$year), sum)
colnames(CA.DF) <- c('year', 'Emissions')
CA.DF$City <- paste(rep('CA', 4))
DF <- as.data.frame(rbind(MD.DF, CA.DF))


# make the plot
png('plot6.png')
ggplot(data=DF, aes(x=year, y=Emissions)) + guides(fill=F) + geom_bar(stat="identity") + 
  ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') + 
  ylab(expression('PM25')) + xlab('Year') + theme(legend.position='none') + facet_grid(. ~ City) + 
  geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))
dev.off()
