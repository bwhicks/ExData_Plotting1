data = read.delim("household_power_consumption.txt", sep=";", nrows=69516, header=TRUE, na.strings=c('?')) #Clip nrows for load sake
make_dates <- function(x) strptime(x,'%d/%m/%Y')
data <- cbind(sapply(data[1], make_dates), data[2:9])

#Subset the data to the specified dates of 2007-02-01 and 2007-02-02 (upper bound handled by nrows above)
subset_data = subset(data, Date >= strptime('2007-02-01', format='%Y-%m-%d'))


#Open device, write histogram, default settings for compatibility
png(filename='plot1.png', width=480, height=480)
with(subset_data, hist(Global_active_power, main="Global Active Power", col="red", axes='true', border='black', xlab='Global Active Power (kilowatts)',
                       ylab='Frequency'))
dev.off()

