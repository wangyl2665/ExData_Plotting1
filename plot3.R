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
png("plot3.png", width = 480, height = 480) 
with(data, plot(DateTime, Sub_metering_1, 
                type = 'l', 
                xlab = '', 
                ylab = 'Energy sub metering'))
with(data, lines(DateTime, Sub_metering_2,  col='red'))
with(data, lines(DateTime, Sub_metering_3,  col='blue'))
legend("topright", lty = 1, col = c('black','blue', 'red'), 
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
dev.off()


