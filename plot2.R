source('makePlot.R')
#auxiliar methods to properly get the data
cleandt <- makeDt()
#second plot
png(filename="plot2.png",width = 480, height = 480)
par(mfrow=c(1,1))
plot(x = cleandt$DateTime, y = as.numeric(as.character(cleandt$Global_active_power)), type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()