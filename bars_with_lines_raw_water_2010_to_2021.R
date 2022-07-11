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
dfrwfinal <- read.csv("dfrwfinal.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE, check.names = FALSE)
dfrwfinaltibble <- tibble(dfrwfinal)
#
# Replace zeros in row 60 with na since February 29th does only occurs in leap years
dfrwfinaltibble[60, 2:13] <- na_if(dfrwfinaltibble[60, 2:13], 0)
#
# Calculate the means for each row and create a new column called 12_year_mean, cbind with the month_day column in dfrwfinal,
# change the column names to something more meaningful
dfrwfinaltibblemean <- dfrwfinaltibble[, 2:13]
dfrwfinaltibblemean <- tibble(rowMeans(dfrwfinaltibblemean, na.rm = TRUE))
dfrwfinaltibblemean <- cbind(dfrwfinal[, 1], dfrwfinaltibblemean[1:366,])
colnames(dfrwfinaltibblemean) <- c("month_day", "12_year_mean")
#
# Used during testing
View(dfrwfinaltibblemean)
#
# Tidy dfrwfinaltibble
dfrwfinaltibble <- dfrwfinaltibble %>% pivot_longer(c(y_2010, y_2011, y_2012, y_2013, y_2014, y_2015, y_2016, y_2017, y_2018, y_2019, y_2020, y_2021), names_to = "year", values_to = "acre_feet")
#
# Change the month_day column adding the year so that ggplot can treat it as a date
dfrwfinaltibble$month_day <- paste(str_sub(dfrwfinaltibble$year, 3, 6), "-", dfrwfinaltibble$month_day, sep = "")
dfrwfinaltibble$month_day <- as.Date(dfrwfinaltibble$month_day)
#
# Remove the year column
dfrwfinaltibble <- subset(dfrwfinaltibble, select = -year)
#
# Used during testing
View(dfrwfinaltibble)


#


#
# Plot the data
coeff <- 325851.4
#
p_rw_2010_2_2021 <- ggplot(dfrwfinaltibble, aes(x = month_day)) +
    geom_col(aes(y = acre_feet), color = "darkblue", fill = "white") +
    scale_x_date(breaks = "1 year", minor_breaks = "1 month", labels = date_format("%Y")) +
    scale_y_continuous(
       name = "Acre Feet",
       sec.axis = sec_axis(~.*coeff / 1000000, name = "MGD")
    ) +
    labs(x = "Year", y = "acre-feet", title = "Treatment Plant Draw on Raw Water 2010 - 2021")
#
print(p_rw_2010_2_2021)
#
# Save the plot to a .pdf
ggsave(filename = "p_rw_2010_2_2021.pdf", plot = p_rw_2010_2_2021, units = "in", width = 44, height = 34)
# # # Compute the mean for each day over all the years
# #
# dfinal$Mean = apply(dfinal[2:12], 1, mean)
# #
# # Compute the median for each day over all the years
# #
# dfinal$Median = apply(dfinal[2:12], 1, median)
# 
# # Determine the maximum by day over all of the days
# dfinal$Maximum <- apply(dfinal[2:12], 1, max)
# #
# # Determine the minimum value by day over all of the days
# dfinal$Minimum <- apply(dfinal[2:12], 1, min)
# 
