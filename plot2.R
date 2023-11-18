#Download and unzip data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./exdata_data_household_power_consumption.zip", method="curl")
dateDownloaded<-date()
unzip("./exdata_data_household_power_consumption.zip")

#Reading data following the steps
## 1. read data from the household_power_consumption.txt
## 2. subset using data from the dates 2007-02-01 and 2007-02-02
## 3. generate a plot global active power vs. time

##Read data
powerconsumption <- read.table("./household_power_consumption.txt", na.strings = "?",stringsAsFactors = FALSE, header = TRUE, sep =";")

#date and time merge
FullTimeDate <- strptime(paste(powerconsumption$Date, powerconsumption$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
powerconsumption<-cbind(powerconsumption,FullTimeDate)
#day_names <- weekdays(powerconsumption$FullTimeDate)
#powerconsumption<-cbind(powerconsumption,day_names)

## Correct class of all columns
powerconsumption$Date <- as.Date(powerconsumption$Date, format="%d/%m/%Y")
powerconsumption$Time <- format(powerconsumption$Time, format="%H:%M:%S")
powerconsumption$Global_active_power <- as.numeric(powerconsumption$Global_active_power)
powerconsumption$Global_reactive_power <- as.numeric(powerconsumption$Global_reactive_power)
powerconsumption$Voltage <- as.numeric(powerconsumption$Voltage)
powerconsumption$Global_intensity <- as.numeric(powerconsumption$Global_intensity)
powerconsumption$Sub_metering_1 <- as.numeric(powerconsumption$Sub_metering_1)
powerconsumption$Sub_metering_2 <- as.numeric(powerconsumption$Sub_metering_2)
powerconsumption$Sub_metering_3 <- as.numeric(powerconsumption$Sub_metering_3)
  
## subset data from 2007-02-01 and 2007-02-02
subsetdata <- subset(powerconsumption, Date == "2007-02-01" | Date =="2007-02-02")
head(subsetdata)

#plot
png("plot2.png", width=480, height=480)
with(subsetdata, plot(FullTimeDate, Global_active_power, type="l", xlab="Day", ylab="Global Active Power (kilowatts)"))
dev.off() 