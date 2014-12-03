source('makePlot.R')
#auxiliar methods to properly get the data
cleandt <- makeDt()
#thrid plot
png(filename="plot3.png",width = 480, height = 480)
par(mfrow=c(1,1))
plot(x = cleandt$DateTime, y = cleandt$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(x = cleandt$DateTime, y = cleandt$Sub_metering_2, col = "red")
lines(x = cleandt$DateTime, y = cleandt$Sub_metering_3, col = "blue")

legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       lwd=c(2.5,2.5,2.5),col=c("black","blue","red")) # gives the legend lines the correct color and width
dev.off()