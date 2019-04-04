# This file contains functions that read Dataset "Hosehold Power Consumption" 
# and make graph plot1.png
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

#This function changes format and class of column  to numeric
class(hpc_short$Sub_metering_1)<-"numeric"
class(hpc_short$Sub_metering_2)<-"numeric"
class(hpc_short$Sub_metering_3)<-"numeric"
#hpc_short$Sub_metering_1<-as.numeric(hpc_short$Sub_metering_1)
#hpc_short$Sub_metering_2<-as.numeric(hpc_short$Sub_metering_2)
#hpc_short$Sub_metering_3<-as.numeric(hpc_short$Sub_metering_3)

#We have to plot only one graph
par(mfcol=c(1,1))

#The graph of Sub metering 1 in two days
with(hpc_short,plot(datetime,Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l",col="black"))

#The function adds SUB METERING 2 and 3
with(hpc_short,lines(datetime,Sub_metering_2, col="red"))
with(hpc_short,lines(datetime,Sub_metering_3, col="blue"))

legend("topright", lwd=2, col = c("black","red","blue"), legend = c("Sub_metering_1     ","Sub_metering_2     ","Sub_metering_3     "))

#Open device to print png
dev.copy(png, file="plot3.png")
#Close device for png
dev.off()


