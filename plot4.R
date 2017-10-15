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


#Quad 1 - copied code from plot 1
par(mfrow = c(2, 2))
with(data, plot(datetime, Global_active_power, type = "n", xlab = "", 
                ylab = "Global Active Power (kilowatts)"))
lines(data$datetime, data$Global_active_power)
#Quad 2 - tweaked code from plot 1
with(data, plot(datetime, Voltage, type = "n"))  
lines(data$datetime, data$Voltage)
#Quad 3 - copied code from plot 3
with(data, plot(datetime, Sub_metering_1, type = "n", xlab = "", 
                ylab = "Energy sub metering"))
lines(data$datetime, data$Sub_metering_1, col = "black")
lines(data$datetime, data$Sub_metering_2, col = "red")
lines(data$datetime, data$Sub_metering_3, col = "blue")
legend("topright", lwd = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       cex = 0.6, y.intersp = .3, bty = "n")
      #the legend looked horrible so i spent time on these 3 params
#Quad 4 - tweaked code from plot 1
with(data, plot(datetime, Global_reactive_power, type = "n")) 
lines(data$datetime, data$Global_reactive_power)

#saving png, closing
dev.copy(png, "plot4.png", height=480, width=480)
dev.off()