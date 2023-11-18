#Download and unzip data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./exdata_data_household_power_consumption.zip", method="curl")
dateDownloaded<-date()
unzip("./exdata_data_household_power_consumption.zip")

#Reading data following the steps
## 1. read data from the household_power_consumption.txt
## 2. subset using data from the dates 2007-02-01 and 2007-02-02
## 3. generate 4 plots (GAP vs. time, Vol vs. time, submetering vs. time and GRP vs. time)

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
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(subsetdata, plot(FullTimeDate, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
with(subsetdata, plot(FullTimeDate, Voltage, type = "l", xlab="datetime", ylab="Voltage"))
with(subsetdata, plot(FullTimeDate, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
lines(subsetdata$FullTimeDate, subsetdata$Sub_metering_2,type="l", col= "red")
lines(subsetdata$FullTimeDate, subsetdata$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
with(subsetdata, plot(FullTimeDate, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
dev.off()
