source('makePlot.R')
#auxiliar methods to properly get the data
cleandt <- makeDt()
#fouth plot
png(filename="plot4.png",width = 480, height = 480)
par(mfrow=c(2,2))

plot(x = cleandt$DateTime, y = cleandt$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

plot(x = cleandt$DateTime, y = cleandt$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

plot(x = cleandt$DateTime, y = cleandt$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(x = cleandt$DateTime, y = cleandt$Sub_metering_2, col = "red")
lines(x = cleandt$DateTime, y = cleandt$Sub_metering_3, col = "blue")
legend("topright", inset=c(-0,-0), y.intersp = 0.75, lwd=2, cex = 1, xpd = TRUE, bty = "n",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       col=c("black","blue","red"))

plot(x = cleandt$DateTime, y = cleandt$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()