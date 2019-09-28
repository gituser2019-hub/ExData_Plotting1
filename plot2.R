setwd("~/Data Science/Files/4")
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Downloading the file if not existing in wd
if (!file.exists('./exdata_data_household_power_consumption.zip')){
        download.file(url,destfile<-'exdata_data_household_power_consumption.zip', mode = 'wb')
        unzip('exdata_data_household_power_consumption.zip', exdir = getwd())}

## reading only the data from the two required dates: 2007/02/01 & 2007/02/02
## it is faster this way than loading the whole dataset and subset
data <- read.table(
        text = grep("^[1,2]/2/2007", readLines('household_power_consumption.txt'), value = TRUE), 
        col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                      "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
                      "Sub_metering_3"), sep = ";", header = TRUE
)

## adjusting the column classes
data$time_stamp<-paste(data$Date,data$Time,sep=" ")
data$time_stamp<-strptime(data$time_stamp,
                          format="%d/%m/%Y %H:%M:%S")
data$Date<-as.Date(data$Date,format = "%d/%m/%Y")

## generating plot 2
png("plot2.png",
    width = 480, height = 480, units = "px")
plot(y=data$Global_active_power,x=data$time_stamp,type='l',
     ylab='Global Active Power (kilowatts)',xlab='')
dev.off() 
