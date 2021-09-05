filelocation <- "D:/R Programming/Exploratory Data Analysis/Peer Graded Project/exdata_data_household_power_consumption.zip"

powerdata <- unzip(zipfile = filelocation, exdir = "D:/elecdata")

elecdata <- read.table(powerdata,header = T,sep = ";", na.strings = "?",colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
elecdata$Date <- as.Date(elecdata$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
elecdata <- subset(elecdata,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
elecdata<- elecdata[complete.cases(elecdata),]

## Combine Date and Time column
dateTime <- paste(elecdata$Date, elecdata$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
elecdata <- elecdata[ ,!(names(elecdata) %in% c("Date","Time"))]

## Add DateTime column
elecdata <- cbind(dateTime, elecdata)

## Format dateTime Column
elecdata$dateTime <- as.POSIXct(dateTime)

##Creating Third Plot
plot(elecdata$Sub_metering_1~elecdata$dateTime,type = 'l',ylab = "Energy Submetering", xlab = "")
points(elecdata$Sub_metering_2~elecdata$dateTime,type = 'l', col = 'red')
points(elecdata$Sub_metering_3~elecdata$dateTime,type = 'l', col = 'blue')
legend('topright',col = c('black','red','blue'),lwd = c(1,1,1),legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))

## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()