
#This script assumes that data file is in the working directory
#if not use setwd() to set working directory

#Read first 100 rows to initialize column classes
initial <- read.table('household_power_consumption.txt', nrows = 100, header = T, sep=';')
classes <- sapply(initial, class)

#Read all data using column classes defined above
consumptionData <- read.table('household_power_consumption.txt', header = T, sep=';',colClasses = classes,na.strings = "?")

# paste observation time to observation date
x <- paste(consumptionData$Date, consumptionData$Time)

#convert to date/time class
consumptionData$Date<-strptime(x, '%d/%m/%Y %H:%M:%S')

#take data only from the dates 2007-02-01 and 2007-02-02
subset <-consumptionData[consumptionData$Date>= strptime('2007-01-02 00:00:00' , '%Y-%d-%m %H:%M:%S') & consumptionData$Date<= strptime('2007-02-02 23:59:00', '%Y-%d-%m %H:%M:%S'),]

#remove NAs
subset<-subset[!is.na(subset$Date),]



#start png printing device
png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12)

#create time series line graph
plot(y=as.numeric(subset$Global_active_power),x=(subset$Date), ylab='Global Active Power (kilowatts)',xlab='', main='', type='l')

#shut down png printing device
dev.off() 
