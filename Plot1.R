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
png("plot1.png", height = 480, width = 480, bg = "transparent")
# Creating the histogram with y-axis removed and new axis with required ticks
hist(newdat$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red", yaxt = 'n')
axis(2, at = c(0,200,400,600,800,1000,1200))
# Closing the PNG graphic device
dev.off()