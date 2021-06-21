# Copyright: City of Thornton Water Resources
# Author: John Orr
# Plot dfinal data
# This program plots the production data from dfinal.csv. Each daily data point
# is represented by year as a different color. Maximum values for each day are
# shown by a line, as is minimum, and the mean and the median acre-feet per capita per day.
# 
library(ggplot2)
library(scales)
library(patchwork)
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
# create the first plot
p_a <- ggplot(dfinal) + 
  geom_point(aes(x = Month_Day, y = `2010`, color = "2010")) + 
  geom_line(aes(x = Month_Day, y = Mean, color="mean")) +
  geom_line(aes(x = Month_Day, y = Median, color="median")) +
  geom_line(aes(x = Month_Day, y = Maximum, color = "maximum")) +
  geom_line(aes(x = Month_Day, y = Minimum, color = "minimum")) +
  scale_color_discrete(name = "Year") +
  scale_y_continuous(breaks = seq(20, 150, by=10), limits=c(20,150)) +
  scale_x_date(breaks = "1 month", minor_breaks = "1 day", labels=date_format("%b")) +
  labs(x = "Month", y = "acre-feet", title = "Treatment Plant Production")
#
# create the second plot
p_b <- ggplot(dfinal) +
  geom_point(aes(x = Month_Day, y = `2011`, color = "2011")) +
  geom_line(aes(x = Month_Day, y = Mean, color="mean")) +
  geom_line(aes(x = Month_Day, y = Median, color="median")) +
  geom_line(aes(x = Month_Day, y = Maximum, color = "maximum")) +
  geom_line(aes(x = Month_Day, y = Minimum, color = "minimum")) +
  scale_color_discrete(name = "Year") +
  scale_y_continuous(breaks = seq(20, 150, by=10), limits=c(20,150)) +
  scale_x_date(breaks = "1 month", minor_breaks = "1 day", labels=date_format("%b"))  +
  labs(x = "Month", y = "acre-feet")
# 
p_c <- ggplot(dfinal) +
  geom_point(aes(x = Month_Day, y = `2012`, color = "2012")) +
  geom_line(aes(x = Month_Day, y = Mean, color="mean")) +
  geom_line(aes(x = Month_Day, y = Median, color="median")) +
  geom_line(aes(x = Month_Day, y = Maximum, color = "maximum")) +
  geom_line(aes(x = Month_Day, y = Minimum, color = "minimum")) +
  scale_color_discrete(name = "Year") +
  scale_y_continuous(breaks = seq(20, 150, by=10), limits=c(20,150))  +
  scale_x_date(breaks = "1 month", minor_breaks = "1 day", labels=date_format("%b")) +
  labs(x = "Month", y = "acre-feet")
# 
p_d <- ggplot(dfinal) +
  geom_point(aes(x = Month_Day, y = `2013`, color = "2013")) +
  geom_line(aes(x = Month_Day, y = Mean, color="mean")) +
  geom_line(aes(x = Month_Day, y = Median, color="median")) +
  geom_line(aes(x = Month_Day, y = Maximum, color = "maximum")) +
  geom_line(aes(x = Month_Day, y = Minimum, color = "minimum")) +
  scale_color_discrete(name = "Year") +
  scale_y_continuous(breaks = seq(20, 150, by=10), limits=c(20,150)) +
  scale_x_date(breaks = "1 month", minor_breaks = "1 day", labels=date_format("%b")) +
  labs(x = "Month", y = "acre-feet")
# 
p_e <- ggplot(dfinal) +
  geom_point(aes(x = Month_Day, y = `2014`, color = "2014")) +
  geom_line(aes(x = Month_Day, y = Mean, color="mean")) +
  geom_line(aes(x = Month_Day, y = Median, color="median")) +
  geom_line(aes(x = Month_Day, y = Maximum, color = "maximum")) +
  geom_line(aes(x = Month_Day, y = Minimum, color = "minimum")) +
  scale_color_discrete(name = "Year") +
  scale_y_continuous(breaks = seq(20, 150, by=10), limits=c(20,150)) +
  scale_x_date(breaks = "1 month", minor_breaks = "1 day", labels=date_format("%b")) +
  labs(x = "Month", y = "acre-feet")
# 
p_g <- ggplot(dfinal) +
  geom_point(aes(x = Month_Day, y = `2015`, color = "2015")) +
  geom_line(aes(x = Month_Day, y = Mean, color="mean")) +
  geom_line(aes(x = Month_Day, y = Median, color="median")) +
  geom_line(aes(x = Month_Day, y = Maximum, color = "maximum")) +
  geom_line(aes(x = Month_Day, y = Minimum, color = "minimum")) +
  scale_color_discrete(name = "Year") +
  scale_y_continuous(breaks = seq(20, 150, by=10), limits=c(20,150)) +
  scale_x_date(breaks = "1 month", minor_breaks = "1 day", labels=date_format("%b")) +
  labs(x = "Month", y = "acre-feet")
# 
p_h <- ggplot(dfinal) +
  geom_point(aes(x = Month_Day, y = `2016`, color = "2016")) +
  geom_line(aes(x = Month_Day, y = Mean, color="mean")) +
  geom_line(aes(x = Month_Day, y = Median, color="median")) +
  geom_line(aes(x = Month_Day, y = Maximum, color = "maximum")) +
  geom_line(aes(x = Month_Day, y = Minimum, color = "minimum")) +
  scale_color_discrete(name = "Year") +
  scale_y_continuous(breaks = seq(20, 150, by=10), limits=c(20,150)) +
  scale_x_date(breaks = "1 month", minor_breaks = "1 day", labels=date_format("%b")) +
  labs(x = "Month", y = "acre-feet")
# 
p_i <- ggplot(dfinal) +
  geom_point(aes(x = Month_Day, y = `2017`, color = "2017")) +
  geom_line(aes(x = Month_Day, y = Mean, color="mean")) +
  geom_line(aes(x = Month_Day, y = Median, color="median")) +
  geom_line(aes(x = Month_Day, y = Maximum, color = "maximum")) +
  geom_line(aes(x = Month_Day, y = Minimum, color = "minimum")) +
  scale_color_discrete(name = "Year") +
  scale_y_continuous(breaks = seq(20, 150, by=10), limits=c(20,150)) +
  scale_x_date(breaks = "1 month", minor_breaks = "1 day", labels=date_format("%b")) +
  labs(x = "Month", y = "acre-feet")
# 
p_j <- ggplot(dfinal) +
  geom_point(aes(x = Month_Day, y = `2018`, color = "2018")) +
  geom_line(aes(x = Month_Day, y = Mean, color="mean")) +
  geom_line(aes(x = Month_Day, y = Median, color="median")) +
  geom_line(aes(x = Month_Day, y = Maximum, color = "maximum")) +
  geom_line(aes(x = Month_Day, y = Minimum, color = "minimum")) +
  scale_color_discrete(name = "Year") +
  scale_y_continuous(breaks = seq(20, 150, by=10), limits=c(20,150)) +
  scale_x_date(breaks = "1 month", minor_breaks = "1 day", labels=date_format("%b")) +
  labs(x = "Month", y = "acre-feet")
# 
p_k <- ggplot(dfinal) +
  geom_point(aes(x = Month_Day, y = `2019`, color = "2019")) +
  geom_line(aes(x = Month_Day, y = Mean, color="mean")) +
  geom_line(aes(x = Month_Day, y = Median, color="median")) +
  geom_line(aes(x = Month_Day, y = Maximum, color = "maximum")) +
  geom_line(aes(x = Month_Day, y = Minimum, color = "minimum")) +
  scale_color_discrete(name = "Year") +
  scale_y_continuous(breaks = seq(20, 150, by=10), limits=c(20,150)) +
  scale_x_date(breaks = "1 month", minor_breaks = "1 day", labels=date_format("%b")) +
  labs(x = "Month", y = "acre-feet")
#   
p_l <- ggplot(dfinal) +
  geom_point(aes(x = Month_Day, y = `2020`, color = "2020")) +
  geom_line(aes(x = Month_Day, y = Mean, color="mean")) +
  geom_line(aes(x = Month_Day, y = Median, color="median")) +
  geom_line(aes(x = Month_Day, y = Maximum, color = "maximum")) +
  geom_line(aes(x = Month_Day, y = Minimum, color = "minimum")) +
  scale_color_discrete(name = "Year") +
  scale_y_continuous(breaks = seq(20, 150, by=10), limits=c(20,150)) +
  scale_x_date(breaks = "1 month", minor_breaks = "1 day", labels=date_format("%b")) +
  labs(x = "Month", y = "acre-feet")
#
# Patchwork graphic in chronological order
# p_f <- p_a / p_b / p_c / p_d / p_e / p_g / p_h / p_i / p_j / p_k / p_l 
# Patchwork graphic in reverse chronological order
p_f <- p_l / p_k / p_j / p_i / p_h / p_g / p_e / p_d / p_c / p_b / p_a
#
# Save the plot to disk
ggsave(filename = "p_f.pdf", plot = p_f, units = "in", width = 44, height = 34)
#
# Display the plot
#
print(p_f)
#
# End of production_patchwork.R