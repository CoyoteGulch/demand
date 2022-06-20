# Program to graph dfrwfinal with daily values in bars and lines for median, max, and min, and average
#
library(dplyr)
library(readxl)
library(magrittr)
library(tibble)
library(tidyr)
library(ggplot2)
library(scales)
library(patchwork)
library(tidyverse)
#
# Read the file dfrwfinal from disk and store it in a tibble named dfrwfinaltibble
dfrwfinaltibble <- read.csv("dfrwfinal.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE, check.names = FALSE)
dfrwfinaltibble <- tibble(dfrwfinaltibble)
#
# Tidy dfrwfinaltibble
dfrwfinaltibble <- dfrwfinaltibble %>% pivot_longer(c(y_2010, y_2011, y_2012, y_2013, y_2014, y_2015, y_2016, y_2017, y_2018, y_2019, y_2020, y_2021), names_to = "year", values_to = "acre_feet" )
#
# Change the month_day column adding the year so that ggplot can treat it as a date
dfrwfinaltibble <- subset(dfrwfinaltibble, select = -year)
dfrwfinaltibble$month_day <- as.Date(as.character(paste(dfrwfinaltibble$month_day, str_sub(dfrwfinaltibble$year, 3, 6))))

#dfrwfinaltibble$Month_Day <- as.Date(paste("2021-", dfinal21$Month_Day, sep = ""))

#dfrwfinaltibble$month_day <- as.Date(as.character(dfrwfinaltibble$month_day), "%y/%m/%d")
# Used during testing
View(dfrwfinaltibble)
#
# Plot the data
p <- ggplot() + geom_col(data = dfrwfinaltibble, aes(y = acre_feet, x = month_day), color = "darkblue", fill = "white") +
  coord_cartesian(ylim = c(20,155)) +
  scale_x_date(breaks = "1 month", minor_breaks = "1 day", labels=date_format("%b")) +
  labs(x = "Month", y = "acre-feet", title = "Treatment Plant Draw on Water Water 2010 - 2021")
print(p)
#