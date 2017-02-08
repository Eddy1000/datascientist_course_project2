#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

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

#Aggregate
total.emissions <- aggregate(Emissions ~ year, NEI, sum)

#Create the Plot
png('plot1.png')
barplot(height=total.emissions$Emissions, names.arg=total.emissions$year,ylab=expression('total PM'[2]*' emission'),xlab="years", main=expression('Total PM2 emissions'))
dev.off()
