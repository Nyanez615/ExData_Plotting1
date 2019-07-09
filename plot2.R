# This script recreates Plot 2 of the Course Project 1 of the Exploratory Data 
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

# Creating plot with appropriate y-axis label and saving it into "plot2.png"

png(filename = "plot2.png", width = 480, height = 480)
with(household_power_consumption, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()