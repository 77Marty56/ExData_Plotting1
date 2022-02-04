### Assignment 1 - Exploratory Data Analysis Coursera 
##### PLOT 2 #####

### Load libraries
library(lubridate)
library(dplyr)

### Change working directory
#setwd("/Users/Elena/Desktop/EDA/Week1/Assignment1/Data")

### Download the dataset
filename <- "data1.zip"
# Check if archive already exists
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename)
}
# Check if folder exists
if (!file.exists("household_power_consumption.txt")){
  unzip(filename)
}

### Load the data into R
household <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                        stringsAsFactors = FALSE, na.strings = "?", nrows=2075259, 
                        check.names = FALSE, comment.char = "")
# Turn Date and Time variable into Date object
dateTime <- as_datetime(paste(household$Date, household$Time), 
                        format = "%d/%m/%Y %H:%M:%S")

household$dateTime <- dateTime
household <- household %>% select(-c("Date", "Time"))


### Making the plot
# Create folder to store plot in
if (!file.exists("plots")){
  dir.create("plots")
}

# Subset the data to include only Feb 2007 day 1 and 2
data <- household %>% filter(year(dateTime) == 2007 & month(dateTime) == 2 &
                               (mday(dateTime) == 1 | mday(dateTime) == 2))

# Make the plot
png("./plots/plot2.png", width = 480, height = 480, units = "px")

plot(data$dateTime, data$Global_active_power, col = "black", type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()