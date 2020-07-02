# READ DATA
data <- read.table("household_power_consumption.txt",
                   header=TRUE, sep=";", 
                   na.strings = "?", 
                   colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# FORMAT DATE CORRECTLY
data$Date <- strptime(data$Date, "%d/%m/%Y", tz="")
data$Date <- as.Date(data$Date, "%Y-%m-%d")

# FILTER FOR ONLY 2007-02-01 & 2007-02-02
filteredData <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

# REMOVE INCOMPLETE ENTRIES
filteredData <- filteredData[complete.cases(filteredData),]

# COMBINE DATE AND TIME
dateTime <- paste(filteredData$Date, filteredData$Time)

# REMOVE DATE AND TIME FROM ORIGINAL DATE FRAME
filteredData$Date <- NULL
filteredData$Time <- NULL

# ADD NEW COMBINED DATE AND TIME COLUMN
filteredData <- cbind(dateTime,filteredData)

# FORMAT DATE/TIME CORRECTLY
filteredData$dateTime <- as.POSIXct(filteredData$dateTime)

# SETUP MULTIPLE PLOT CANVAS
par(mfrow=c(2,2))

# FIRST PLOT
plot(filteredData$Global_active_power~filteredData$dateTime,
     type="l",
     ylab="Global Active Power (kilowatts)",
     xlab="")

# SECOND PLOT
plot(filteredData$Voltage~filteredData$dateTime,
     type="l",
     ylab="Voltage",
     xlab="datetime")

# THIRD PLOT
# first set of data
plot(filteredData$Sub_metering_1~filteredData$dateTime,
     type="l",
     ylab="Energy sub metering",
     xlab="")
# add second set of data
lines(filteredData$Sub_metering_2~filteredData$dateTime,
      type="l",
      col="red")
# add third set of data
lines(filteredData$Sub_metering_3~filteredData$dateTime,
      type="l",
      col="blue")
# add legend
legend("topright",
       lty=1,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"))

# FOURTH PLOT
plot(filteredData$Global_reactive_power~filteredData$dateTime,
     type="l",
     ylab="Global_reactive_power",
     xlab="datetime")

# SAVE PNG TO FILE
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()
