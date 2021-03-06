##
# This script is for the course: exploratory data analysis
# The script reads in data from household power consumption
#  and creates graphs of the data
#


#
# Check to see if the data already exists in the local directory, if not, download data
#

fileDir <- paste(getwd(),"/data/HPC",sep="")  #use this directory for data and plots

if(!file.exists(fileDir)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl,destfile = "HPC.zip")
  unzip("HPC.zip")
  file.rename("exdata-data-household_power_consumption",fileDir)
  file.remove("HPC.zip")}

#
# Read in data table and convert dates to R date format
#

hpc <- read.table(paste(fileDir,"/household_power_consumption.txt",sep=""),header=T,sep=";",na.strings = "?") #read data
hpc$Date <- as.Date(hpc$Date,format="%d/%m/%Y") #convert date from factor to POSIX date
hpc2 <- subset(hpc,Date=="2007-02-01" | Date=="2007-02-02") #select data from specific dates
hpc2$Date <- strptime(paste(hpc2$Date,hpc2$Time),format = "%Y-%m-%d %H:%M:%S") #convert times to POSIX


#
# Plot 1 - render plot to screen and to file
#

par(mfcol=c(1,1))
hist(hpc2$Global_active_power,col="red",xlab="Global Active Power (kilowats)",ylab = "Frequency",main = "Global Active Power")

png(filename = paste(fileDir,"/plot1.png",sep=""), width = 480, height = 480)
hist(hpc2$Global_active_power,col="red",bg="white",xlab="Global Active Power (kilowats)",ylab = "Frequency",main = "Global Active Power")
dev.off()

