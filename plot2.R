#Read full data file, as RAM is sufficient on the local machine
all_data = read.table(file = 'household_power_consumption.txt',header = T,sep = ";")

#Convert Date column to be recognised as dates
all_data$Date = as.Date(all_data$Date,format = "%d/%m/%Y")

#Convert Global active power from factors to number
all_data$Global_active_power = as.numeric(levels(all_data$Global_active_power))[all_data$Global_active_power]

#Shortlist the two dates of 1st and 2nd Feb 2007
main_data = subset(all_data,all_data$Date >= '2007-02-01' & all_data$Date <= '2007-02-02')

#Introduce continuous time line in a variable which is a combination of Date and Time columns
main_data$DT = as.POSIXct(paste(main_data$Date, main_data$Time), format="%Y-%m-%d %H:%M:%S")

#Define the PNG file size to save in
png("plot2.png", width = 480, height = 480)

#Create line plot for Global active power
plot(x = main_data$DT,y = main_data$Global_active_power,ylab = "Global Active Power (kilowatts)",xlab = "",type = 'l')

#Off graphics device used for creating plot
dev.off()