# Reading the entire dataset into 'fulldat'
fulldat <- read.table("./../household_power_consumption.txt", header = TRUE, sep = ";")
# Selecting the rows with only the 2 dates for which data is required & Converting 7 variablesinto numeric
subdat <- subset(fulldat, subset = (fulldat$Date == '1/2/2007' | fulldat$Date == '2/2/2007'))
subdat[,3:9] <- apply(subdat[,3:9], 2, function(x) gsub("\\?", "NA", x))
subdat[,3:9] <- apply(subdat[,3:9], 2, function(x) as.numeric(x))
# Adding a new variable with Date and Time combined
library(dplyr)
newdat <- mutate(subdat, NewDateTime = paste(subdat$Date, subdat$Time, sep = " "))
newdat$NewDateTime <- strptime(newdat$NewDateTime, "%d/%m/%Y %H:%M:%S")
# newdat is the subset processed data used for plotting
# Initializing a PNG graphic device
png("plot3.png", height = 480, width = 480, bg = "transparent")
# Defining the range for multiple variables which defines the y-axis limit
p_range <- range(newdat$Sub_metering_1, newdat$Sub_metering_2, newdat$Sub_metering_3)
# Creating a Base plot with lines and adding other variables
plot(newdat$NewDateTime, newdat$Sub_metering_1, type = 'l', xlab = NA, ylim = p_range, ylab = "Energy sub metering")
lines(newdat$NewDateTime, newdat$Sub_metering_2, col = "red")
lines(newdat$NewDateTime, newdat$Sub_metering_3, col = "blue")
# Creating a legend where 'lty = 1' removes the legend box
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)
# Closing the PNG graphic device
dev.off()