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

# PLOT DATA
hist(filteredData$Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     col="red")

# SAVE PNG TO FILE
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()