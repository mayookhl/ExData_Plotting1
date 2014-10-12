#Read full data file, as RAM is sufficient on the local machine
all_data = read.table(file = 'household_power_consumption.txt',header = T,sep = ";")

#Convert Date column to be recognised as dates
all_data$Date = as.Date(all_data$Date,format = "%d/%m/%Y")

#Shortlist the two dates of 1st and 2nd Feb 2007
main_data = subset(all_data,all_data$Date >= '2007-02-01' & all_data$Date <= '2007-02-02')

#Introduce continuous time line in a variable which is a combination of Date and Time columns
main_data$DT = as.POSIXct(paste(main_data$Date, main_data$Time), format="%Y-%m-%d %H:%M:%S")

#Convert Global active power from factors to number
main_data$Global_active_power = as.numeric(levels(main_data$Global_active_power))[main_data$Global_active_power]
main_data$Global_reactive_power = as.numeric(levels(main_data$Global_reactive_power))[main_data$Global_reactive_power]
main_data$Sub_metering_1 = as.numeric(levels(main_data$Sub_metering_1))[main_data$Sub_metering_1]
main_data$Sub_metering_2 = as.numeric(levels(main_data$Sub_metering_2))[main_data$Sub_metering_2]
main_data$Voltage = as.numeric(levels(main_data$Voltage))[main_data$Voltage]

#Define the PNG file size to save in
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

#Plot from part no 2
plot(x = main_data$DT, y = main_data$Global_active_power,ylab = "Global Active Power",xlab = "",type = 'l')

#Plot for Voltage
plot(x = main_data$DT, y = main_data$Voltage, ylab = "Voltage", xlab = "datetime", type = 'l')

#Plot from part no 3
plot(x = main_data$DT,y = main_data$Sub_metering_1,ylab = "Energy sub metering",xlab = "",type = 'l')
lines(x = main_data$DT,y = main_data$Sub_metering_2,type = 'l',col = "red")
lines(x = main_data$DT,y = main_data$Sub_metering_3,type = 'l',col = "blue")
#Create Leged
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = 1,col = c("black","red","blue"),bty = "n",cex = 0.8)

#Plot for Global reactive power
plot(x = main_data$DT, y = main_data$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = 'l')

#Off graphics device used for creating plot
dev.off()