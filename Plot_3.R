# Pepe Zamarrips
# Exploratory Data Analysis - Project 2
# May 28th, 2023

# Plot 3
library("data.table")
library("ggplot2")

path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

# Create the tables
SCC <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))


# Subset NEI data by Baltimore using fips, a five-digit number (represented as a string) indicating the U.S. county
baltimoreNEI <- NEI[fips=="24510",]

#Display Plot 3
png("plot_3.png")

ggplot(baltimoreNEI,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill="none")+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

dev.off()
