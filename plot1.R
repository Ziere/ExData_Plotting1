source('makePlot.R')
#auxiliar methods to properly get the data
cleandt <- makeDt()
#first plot
par(mfrow=c(1,1))
png(filename="plot1.png",width = 480, height = 480)
hist(x = cleandt$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()