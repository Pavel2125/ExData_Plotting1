# This file contains functions that read Dataset "Hosehold Power Consumption" 
# and make graph plot1.png
library(graphics)
#Filepaths

filepath_dataset="./Datasets/Electric power consumption/household_power_consumption.txt"

#hpc -  Household Power Consumption
hpc = read.table(file =  filepath_dataset, header = TRUE, sep = ";", colClasses = c("Date"="character", "Global_active_power"="character"))

#hpc_short - Short version of Dataset (only for two days: 01.02.2007 and 02.02.2007)
hpc_short<-subset(hpc, strptime(Date,"%d/%m/%Y")=="2007-02-01"|strptime(Date,"%d/%m/%Y")=="2007-02-02")

#This function changes format and class of column to numeric
class(hpc_short$Global_active_power)<-"numeric"

#The histogramm of Global active power in two days
#hist(as.numeric(hpc_short$Global_active_power), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
with(hpc_short, hist(Global_active_power,col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))

#Open device to print png
dev.copy(png, file="plot1.png")
#Close device for png
dev.off()


