# This file contains functions that read Dataset "Hosehold Power Consumption" 
# and make graph plot4.png
library(graphics)
#Filepaths

filepath_dataset="./Datasets/Electric power consumption/household_power_consumption.txt"

#hpc -  Household Power Consumption
hpc = read.table(file =  filepath_dataset, header = TRUE, sep = ";", colClasses = c("character", "character", "character","character","character","character","character","character","character"))

#hpc_short - Short version of Dataset (only for two days: 01.02.2007 and 02.02.2007)
hpc_short<-subset(hpc, strptime(Date,"%d/%m/%Y")=="2007-02-01"|strptime(Date,"%d/%m/%Y")=="2007-02-02")

#This function makes new column with Date and Time together
hpc_short$datetime<-paste(hpc_short$Date, hpc_short$Time)

#This function changes format and class of new column to Date/Time
hpc_short$datetime<-strptime(hpc_short$datetime, "%d/%m/%Y %H:%M:%S")

#This function changes format and class of column to numeric
class(hpc_short$Global_active_power)<-"numeric"
class(hpc_short$Global_reactive_power)<-"numeric"

class(hpc_short$Voltage)<-"numeric"
class(hpc_short$Global_intensity)<-"numeric"

class(hpc_short$Sub_metering_1)<-"numeric"
class(hpc_short$Sub_metering_2)<-"numeric"
class(hpc_short$Sub_metering_3)<-"numeric"

#We have to plot 4 graphs instead of 1 
par(mfcol=c(2,2))


#The graph of Global active power in two days
with(hpc_short,plot(datetime, Global_active_power, ylab = "Global Active Power", xlab = "", type = "l"))


#The function plots SUB METERING 1 during two days
with(hpc_short,plot(datetime, Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "l"))

#The function adds SUB METERING 2 and 3
with(hpc_short,lines(datetime,Sub_metering_2, col="red"))
with(hpc_short,lines(datetime,Sub_metering_3, col="blue"))

#The function adds LEGEND metering 2 and 3
legend("topright", bty = "n", xjust = 0, yjust = 0, y.intersp = 0.4, lwd=2, col = c("black","red","blue"), legend = c("Sub_metering_1     ","Sub_metering_2     ","Sub_metering_3     "))


#The graph of VOLTAGE during two days
with(hpc_short,plot(datetime, Voltage, type = "l"))

#Add graph of GLOBAL REACTIVE POWER during two days 
with(hpc_short,plot(datetime, Global_reactive_power, type = "l"))

#Open device to print png
dev.copy(png, file="plot4.png")
#Close device for png
dev.off()

