# Assumes you setwd() to local location of git repo
data = read.delim("household_power_consumption.txt", sep=";", nrows=69516, header=TRUE, na.strings=c('?')) #Clip nrows for load sake

#Combine date and date time
data <- cbind(Date = with(data, paste(Date, Time)), data[3:9])

#Make them POSIX date-time objects
make_dates <- function(x) strptime(x,'%d/%m/%Y %H:%M:%S')
data <- cbind(sapply(data[1], make_dates), data[2:8])

#Subset the data to the specified dates of 2007-02-01 and 2007-02-02 (upper bound handled by nrows above)
subset_data = subset(data, Date >= strptime('2007-02-01', format='%Y-%m-%d'))

png(filename='plot4.png', width=480, height=480)
par(mfrow=c(2,2))

#Global_active_power histogram
with(subset_data, hist(Global_active_power, main='', col="red", axes='true', border='black', xlab='Global Active Power (kilowatts)',
     ylab='Frequency'))

#Voltage vs datetime
with(subset_data, plot(Date, Voltage, type='l', xlab='datetime', ylab='voltage'))

#Energy metering vs day of week
with(subset_data, plot(Date, Sub_metering_1, type='l', ylab='Energy sub metering', xlab=''),
     axis.Date(1, at = c(as.Date('2007-02-01'), as.Date('2007-02-02'), as.Date('2007-02-03')))
)

with(subset_data, lines(Date, Sub_metering_2, col='red'))
with(subset_data, lines(Date, Sub_metering_3, col='blue'))

#Global_reactive_power vs datetime
with(subset_data, plot(Date, Global_reactive_power, type='l', xlab='datetime', ylab='Global_reactive_power'))

dev.off()
