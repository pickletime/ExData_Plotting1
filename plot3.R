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


with(data, plot(datetime, Sub_metering_1, type = "n", xlab = "", 
                ylab = "Energy to sub metering"))
lines(data$datetime, data$Sub_metering_1, col = "black")
lines(data$datetime, data$Sub_metering_2, col = "red")
lines(data$datetime, data$Sub_metering_3, col = "blue")
legend("topright", lwd = c(1, 1, 1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       border = "black")

#saving png, closing
dev.copy(png, "plot3.png", height=480, width=480)
dev.off()