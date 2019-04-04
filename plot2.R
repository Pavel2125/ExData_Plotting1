# This file contains functions that read Dataset "Hosehold Power Consumption" 
# and make graph plot1.png
library(graphics)
#Filepaths

filepath_dataset="./Datasets/Electric power consumption/household_power_consumption.txt"

#hpc -  Household Power Consumption
hpc = read.table(file =  filepath_dataset, header = TRUE, sep = ";", colClasses = c("Date"="character", "Time"="character", "Global_active_power"="character"))

#hpc_short - Short version of Dataset (only for two days: 01.02.2007 and 02.02.2007)
hpc_short<-subset(hpc, strptime(Date,"%d/%m/%Y")=="2007-02-01"|strptime(Date,"%d/%m/%Y")=="2007-02-02")

#This function makes new column with Date and Time together
hpc_short$datetime<-paste(hpc_short$Date, hpc_short$Time)

#This function changes format and class of new column to Date/Time
hpc_short$datetime<-strptime(hpc_short$datetime, "%d/%m/%Y %H:%M:%S")

#This function changes format and class of column to numeric
class(hpc_short$Global_active_power)<-"numeric"

#Add graph of GLOBAL ACTIVE POWER during two days 
with(hpc_short,plot(datetime, Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l"))

#Open device to print png
dev.copy(png, file="plot2.png")
#Close device for png
dev.off()


