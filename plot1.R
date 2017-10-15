#obligatory library call
library(data.table)

#full data read. I like that fread() gives me progress updates.
data <- fread("household_power_consumption.txt", na.strings = "?")
#reformat date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
#subset
data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

#plot
hist(data$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

#saving png, closing
dev.copy(png, "plot1.png", height=480, width=480)
dev.off()