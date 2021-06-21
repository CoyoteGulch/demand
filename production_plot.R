# Copyright: City of Thornton Water Resources
# Author: John Orr
# Plot dfinal data
# This program plots the production data from dfinal.csv. Each daily data point
# is represented by year as a different color. Maximum values for each day are
# shown by a line, as is minimum, and the mean and the median acre-feet per capita per day.
# 
library(ggplot2)
library(scales)
#
# Open dfinal.csv
#
dfinal <- read.csv("dfinal.csv", header = TRUE, sep = ",", 
                   stringsAsFactors = FALSE, check.names = FALSE)
#
# Transform the Month_Day column so that ggplot can treat it as a date
# sequence for plotting
#
dfinal$Month_Day <- as.Date(paste("2021-", dfinal$Month_Day, sep = ""))
#
# Used during testing
# View(dfinal)
#
# create the plot
p <- ggplot(dfinal) + 
  geom_point(aes(x = Month_Day, y = `2010`, color = "2010")) +
  geom_point(aes(x = Month_Day, y = `2011`, color = "2011")) +
  geom_point(aes(x = Month_Day, y = `2012`, color = "2012")) +
  geom_point(aes(x = Month_Day, y = `2013`, color = "2013")) +
  geom_point(aes(x = Month_Day, y = `2014`, color = "2014")) +
  geom_point(aes(x = Month_Day, y = `2015`, color = "2015")) + 
  geom_point(aes(x = Month_Day, y = `2016`, color = "2016")) +
  geom_point(aes(x = Month_Day, y = `2017`, color = "2017")) +
  geom_point(aes(x = Month_Day, y = `2018`, color = "2018")) +
  geom_point(aes(x = Month_Day, y = `2019`, color = "2019")) +
  geom_point(aes(x = Month_Day, y = `2020`, color = "2020")) +
  geom_line(aes(x = Month_Day, y = Mean, color="mean")) +
  geom_line(aes(x = Month_Day, y = Median, color="median")) +
  geom_line(aes(x = Month_Day, y = Maximum, color = "maximum")) +
  geom_line(aes(x = Month_Day, y = Minimum, color = "minimum")) +
  scale_color_discrete(name = "Year") +
  scale_y_continuous(breaks = seq(20, 150, by=10), limits=c(20,150)) +
  scale_x_date(breaks = "1 month", minor_breaks = "1 day", labels=date_format("%b")) +
  labs(x = "Month", y = "Production in acre-feet", title = "Treatment Plant Production 2010 - 2020")
#
# Display the plot
#
print(p)
#
# End of production_plot.R