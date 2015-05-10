#
# Plot No. 2 (Global Active Power Line Chart)
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

#Plotting Chart No. 2

png(file = "plot2.png")
with(fddt,{	plot(	DateTime, Global_active_power, type = "n", 
					main = "", xlab = "",
					ylab = "Global Active Power (Kilowatts)")
			lines(	DateTime, Global_active_power)})

dev.off()
