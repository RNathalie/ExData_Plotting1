#Downloading and unzipping file
urlfile <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(urlfile, destfile = "data_household_power_consumption.zip", mode = "wd")
unz("data_household_power_consumption.zip", "household_power_consumption.txt")

#reading file, getting the needed columns
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?") [, c(1,2,3)]

#subsetting data for the defind period 
data$Date = as.Date(data$Date, format = "%d/%m/%Y")
s_data <- subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02", na.rm=T)
s_data$D_T<- paste(as.character(s_data$Date), s_data$Time, sep = " ")
s_data$D_T <- as.POSIXct(as.character(s_data$D_T), format="%Y-%m-%d %H:%M:%S")


#plotting into file
png(filename = "Plot2.png", width = 480, height = 480)
plot(s_data$D_T, s_data$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(s_data$D_T, s_data$Global_active_power, type = "l")
dev.off()