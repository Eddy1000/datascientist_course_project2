
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

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

#aggregate
be <- NEI[NEI$fips=="24510",]
bey <- aggregate(Emissions ~ year, be, sum)

#Create the plot
png('plot2.png')
barplot(height=bey$Emissions,
        names.arg=bey$year,
        xlab="years", ylab=expression('total PM2'),
        main=expression('Total PM2 emissions in Baltimore and Maryland'))
dev.off()
