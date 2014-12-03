#This function return the data from a
#txt file with the data values between the dates 
#2007-02-01 to 2007-02-02

makeCsv <- function(txtFile = "household_power_consumption.txt",
                    localPath = getwd(),
                    outputFile = "dataCleaned.csv",
                    fileOUT = FALSE)
{
    #set for the local work directory (need to be change in each computer)
    setwd(localPath)
    
    #force the english language in my case the weekdays was in Spanish instead of English
    Sys.setlocale("LC_TIME", "English")
    
    #download the data of process existing files
    if (!file.exists(txtFile))
    {    
        
        if (!file.exists("exdata-data-household_power_consumption.zip"))
        {
            download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                            destfile = "exdata-data-household_power_consumption.zip")
            unzip("exdata-data-household_power_consumption.zip")
            txtFile = "household_power_consumption.txt"
        }
        else
        {
            unzip("exdata-data-household_power_consumption.zip")
            txtFile = "household_power_consumption.txt"
        }
    }    
    #read the .txt data file using separator ";"
    dt <- read.csv(txtFile,sep = ";")
    
    #transform the field Date into a Date to filter for dates
    dt$Date = as.Date(dt$Date,format = "%d/%m/%Y")
    
    #bound for the date filter
    bounds <- NULL
    bounds$first <- as.Date(c("2007-02-01")) 
    bounds$second <- as.Date(c("2007-02-02"))
    
    #make a new one with only the date required for the graphs
    cleandt <- dt[(dt$Date >= bounds$first & dt$Date <= bounds$second),]
    
    #write a csv with this data
    if (fileOUT)
    {
        write.csv(cleandt,outputFile)
    }        
    cleandt
}

makeDt <- function(csvIn = "dataCleaned.csv"){
    #check for the clean csv, if is not in the
    #working directory create it using makeCsv()
    
    if (file.exists(csvIn))
    {
        cat("File",csvIn,"found and readed\n")
        cleandt <- read.csv("dataCleaned.csv")
    }
    else
    {
        cat(csvIn,"file not found calling makeCsv()\n")
        makeCsv(fileOUT = TRUE)
        cleandt <- read.csv("dataCleaned.csv")
    }

    #make a full date with the date and the time and transform it to Date format
    cleandt$DateTime <- paste(cleandt$Date,cleandt$Time)
    cleandt$DateTime <- strptime(cleandt$DateTime,format = "%Y-%m-%d %H:%M:%S")
    
    #remove duplicate information
    cleandt$Date <- NULL
    cleandt$Time <- NULL
    cleandt
}

#given a number between 1 and 4 return the plot of each part of the project
makePlot <- function(number)
{    
    if (number==1)
    {
        cleandt <- makeDt()
        #first plot
        par(mfrow=c(1,1))
        hist(x = cleandt$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
    }
    else if (number==2)
    {   
        cleandt <- makeDt()
        #second plot
        par(mfrow=c(1,1))
        plot(x = cleandt$DateTime, y = as.numeric(as.character(cleandt$Global_active_power)), type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
    }
    else if (number==3)
    {
        cleandt <- makeDt()
        #thrid plot
        par(mfrow=c(1,1))
        plot(x = cleandt$DateTime, y = cleandt$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
        lines(x = cleandt$DateTime, y = cleandt$Sub_metering_2, col = "red")
        lines(x = cleandt$DateTime, y = cleandt$Sub_metering_3, col = "blue")
        
        legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               lty=c(1,1,1), # gives the legend appropriate symbols (lines)
               lwd=c(2.5,2.5,2.5),col=c("black","blue","red")) # gives the legend lines the correct color and width
    }
    else if (number==4)
    {
        cleandt <- makeDt()
        #fouth plot
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
    }
    else
    {
        cat("\n Please select a number between 1 and 4")
    }
    
}