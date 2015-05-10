#
# Plot No. 4 (Multi-Chart Grid)
#
#Needed Library
library(dplyr)

#Reading data file
df <- read.table(	"household_power_consumption.txt",header = T, sep = ";", 
					na.strings = "?",stringsAsFactors = F)					
dt <- tbl_df(df)

#Filtering observation days 
fddt <- dt %>%
		filter(	as.Date(Date,"%d/%m/%Y") >= as.Date("01/02/2007","%d/%m/%Y") & 
                as.Date(Date,"%d/%m/%Y") <= as.Date("02/02/2007","%d/%m/%Y")) %>%
#Important: creating proper DateTime Type Field/Column 
		mutate(	DateTime = as.POSIXct(paste(Date,Time),format = "%d/%m/%Y %H:%M:%S")) %>%
		select(-Date, -Time)

#Removing no-needed data structs
rm(dt)
rm(df)

#Plotting Chart No. 4

png(file = "plot4.png")
par(mfrow = c(2, 2))

with(fddt, {

	#Plot No. 4-1
	plot(	DateTime, Global_active_power, type = "n", 
			main = "", xlab = "",ylab = "Global Active Power")
	lines(	DateTime, Global_active_power)

	#Plot No. 4-2
	plot(	DateTime, Voltage, type = "n", 
			main = "", xlab = "datetime",ylab = "Voltage")
	lines(	DateTime, Voltage)

	#Plot No. 4-3
	plot(	DateTime, Sub_metering_1, type = "n",
			main = "", xlab = "",
			ylab = "Energy sub metering")
	lines(	DateTime, Sub_metering_1)
	lines(	DateTime, Sub_metering_2,col ="red")
	lines(	DateTime, Sub_metering_3,col ="blue")
	legend(	"topright", legend = c("Sub_metering 1","Sub_metering 2","Sub_metering 3"),
			lwd = 2, bty = "n" , col = c("black","red","blue"))

	#Plot No. 4-4	
	plot(	DateTime, Global_reactive_power, type = "n",
			main = "", xlab = "datetime")
	lines(DateTime, Global_reactive_power)})

dev.off()
