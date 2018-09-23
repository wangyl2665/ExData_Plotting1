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
png("plot2.png", width = 480, height = 480) 
plot(data$DateTime, 
     data$Global_active_power, 
     type = 'l', xlab = '', ylab = 'Global Active Power (kilowatts)')
dev.off()
