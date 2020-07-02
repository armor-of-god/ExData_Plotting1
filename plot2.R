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

# PLOT DATA
plot(filteredData$Global_active_power~filteredData$dateTime,
     type="l",
     ylab="Global Active Power (kilowatts)",
     xlab="")

# SAVE PNG TO FILE
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()
