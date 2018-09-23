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
xrange <- range(min(data$Global_active_power), max(data$Global_active_power))
breaks <- 2* (max(data$Global_active_power) - min(data$Global_active_power))

png("plot1.png", width = 480, height = 480)
hist(data$Global_active_power, 
     main="Global Active Power", 
     xlab="Global Active Power(kilowatts)", 
     col="red",
     xlim=xrange,
     breaks=breaks)
dev.off()
