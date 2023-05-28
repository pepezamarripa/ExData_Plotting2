# Pepe Zamarrips
# Exploratory Data Analysis - Project 2
# May 28th, 2023

# Plot 2
library("data.table")

path <- getwd()
# Download the zip with the DBs
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

# Create the tables
SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

# Get the total emissions per year
NEI[, Emissions := lapply(.SD, as.numeric),.SDcols = c("Emissions")] 
totalNEI <- NEI[fips=='24510', lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

# Display Plot 2
png(filename='plot_2.png')
barplot(totalNEI[, Emissions], names = totalNEI[, year], xlab = "Years", ylab = "Emissions", main = "Emissions across the years", col="Tomato3")

dev.off()