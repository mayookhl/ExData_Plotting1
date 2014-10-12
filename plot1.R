#Read full data file, as RAM is sufficient on the local machine
all_data = read.table(file = 'household_power_consumption.txt',header = T,sep = ";")

#Convert Date column to be recognised as dates
all_data$Date = as.Date(all_data$Date,format = "%d/%m/%Y")

#Convert Global active power from factors to number
all_data$Global_active_power = as.numeric(levels(all_data$Global_active_power))[all_data$Global_active_power]

#Shortlist the two dates of 1st and 2nd Feb 2007
main_data = subset(all_data,all_data$Date >= '2007-02-01' & all_data$Date <= '2007-02-02')

#Define the PNG file size to save in
png("plot1.png", width = 480, height = 480)

#Create histogram: with Main, X and Y labels and Red coloured bars
hist(main_data$Global_active_power,main = "Global Active Power",xlab = "Global Active Power (kilowatts)",ylab = "Frequency",col = "red",freq = T)
#Off graphics device used for creating plot
dev.off()