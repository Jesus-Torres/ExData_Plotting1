#
# Plot No. 1 (Global Active Power Histogram)
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

#Plotting Chart No. 1

png(file = "plot1.png")
with(fddt,{	hist(Global_active_power, main = "Global Active Power",
			xlab = "Global Active Power (Kilowatts)", col = "red")})
dev.off()
