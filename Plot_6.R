# Pepe Zamarrips
# Exploratory Data Analysis - Project 2
# May 28th, 2023

# Plot 5
library("data.table")
library("ggplot2")

path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

# Create the tables
SCC <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))

# Create a subset of NEI that contains data from vehicles
sub_vehicle <- grepl("vehicle", SCC[, SCC.Level.Two], ignore.case=TRUE)
vehiclesSCC <- SCC[sub_vehicle, SCC]
vehiclesNEI <- NEI[NEI[, SCC] %in% vehiclesSCC,]

# Subset NEI data by Baltimore using fips
vehiclesBaltimoreNEI <- vehiclesNEI[fips == "24510",]

# Add city name
vehiclesBaltimoreNEI[, city := c("Baltimore City")]

# Subset NEI data by LAX using fips
vehiclesLAXEI <- vehiclesNEI[fips == "06037",]

# Add city name
vehiclesLAXEI[, city := c("Los Angeles")]

# Merge Baltimore and LAX tables into one table
mergeNEI <- rbind(vehiclesBaltimoreNEI,vehiclesLAXEI)

# Display Plot 6
png("plot_6.png")

ggplot(mergeNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

dev.off()