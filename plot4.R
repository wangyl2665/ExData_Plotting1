#============================================================================
# load package to R
library(readr)
library(tidyr)
library(dplyr)
library(lubridate)

#============================================================================
# loading the data
data <- read_delim("household_power_consumption.txt", 
                   ";", 
                   escape_double = FALSE, 
                   trim_ws = TRUE) %>% 
        filter(Date %in% c('1/2/2007', '2/2/2007')) %>% 
        mutate(Date = as.Date(Date, "%d/%m/%Y")) %>% 
        unite(Date, Time, col = 'DateTime', sep = ' ') %>% 
        mutate(DateTime = as_datetime(DateTime))

#============================================================================
# Making Plots
png("plot4.png", width = 480, height = 480)
par(mfcol = c(2, 2))
with(data, {plot(DateTime, Global_active_power, 
                 type = 'l', 
                 xlab = '', 
                 ylab = 'Global Active Power (kilowatts)')
        {plot(DateTime, Sub_metering_1, 
              type = 'l', 
              xlab = '', 
              ylab = 'Energy sub metering')
                lines(DateTime, Sub_metering_2,  col='red')
                lines(DateTime, Sub_metering_3,  col='blue')
                legend('topright', lty = 1, bty = 'n', 
                       col = c('black','blue', 'red'),  
                       legend = c('Sub_metering_1', 
                                  'Sub_metering_2', 
                                  'Sub_metering_3'))}
        plot(DateTime, Voltage, 
             type = 'l', 
             xlab = 'datetime', ylab = 'Voltage')
        plot(DateTime, Global_reactive_power, 
             type = 'l', 
             xlab = 'datetime', 
             ylab = 'Global_reactive_power')
})
dev.off()