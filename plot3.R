#
# Plot No. 3 (Sub metering Multi-line Chart)
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

#Plotting Chart No. 3

png(file = "plot3.png")
with(fddt,{	plot(	DateTime, Sub_metering_1, type = "n",
					main = "", xlab = "",
					ylab = "Energy sub metering")
			lines(	DateTime, Sub_metering_1)
			lines(	DateTime, Sub_metering_2, col = "red")
			lines(	DateTime, Sub_metering_3, col = "blue")
			legend(	"topright", 
					legend = c("Sub_metering 1","Sub_metering 2","Sub_metering 3"),
					col = c("black","red","blue"),lwd = 2)})

dev.off()
