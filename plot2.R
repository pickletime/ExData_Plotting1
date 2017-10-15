#obligatory library call
library(data.table)

#full data read. I like that fread() gives me progress updates.
data <- fread("household_power_consumption.txt", na.strings = "?")
#reformat date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
#subset
data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")
#paste together date and time
datetime <- (paste(data$Date, data$Time))
#read date and time back in as appropriate format
data$datetime <- as.POSIXct(datetime)

#plot
with(data, plot(datetime, Global_active_power, type = "n", xlab = "", 
                ylab = "Global Active Power (kilowatts)"))
lines(data$datetime, data$Global_active_power)

#saving png, closing
dev.copy(png, "plot2.png", height=480, width=480)
dev.off()