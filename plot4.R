# This script recreates Plot 4 of the Course Project 1 of the Exploratory Data 
# Analysis Coursera course, based on the Individual household electric power 
# consumption Data Set, found in the UC Irvine Machine Learning Repository.

# Loading libraries

library(tidyverse)
library(lubridate)

# Setting file names and URLs

file <- "exdata-data-household_power_consumption.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Checking if .zip exists

if (!file.exists(file)) {
        download.file(fileURL, destfile = "./exdata-data-household_power_consumption.zip", method="curl")
}  

# Checking if file exists

if (!file.exists("household_power_consumption.txt")) { 
        unzip(file) 
}

# Reading household_power_consumption.txt and addressing "?" as NA

household_power_consumption <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?"), stringsAsFactors = FALSE)

# Reclassing date and time using lubridate

household_power_consumption$DateTime <- paste(household_power_consumption$Date, household_power_consumption$Time)
household_power_consumption$DateTime <- dmy_hms(household_power_consumption$DateTime)

# Filtering only dates 2007-02-01 and 2007-02-02

household_power_consumption <- filter(household_power_consumption, date(DateTime) == "2007-02-01" | date(DateTime) == "2007-02-02")

# Setting par() mfcol argument to 2 by 2 plots and opening png device "plot4.png"

png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2, 2))

# Creating first plot with appropriate y-axis label

with(household_power_consumption, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

# Creating second plot with appropriate y-axis label, line colors, and legend

with(household_power_consumption, plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(household_power_consumption, points(DateTime, Sub_metering_2, type = "l", col = "red"))
with(household_power_consumption, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, bty = "n")

# Creating third plot with appropriate x- and y- axis labels

with(household_power_consumption, plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

# Creating fourth plot with appropriate x- and y- axis labels

with(household_power_consumption, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

dev.off()