# production2021_patchwork.R
# Copyright: City of Thornton Water Resources
# Author: John Orr
# Plot dfinal21 data
# This program plots the production data from dfinal21.csv. Daily data points is shown as a point.
# Maximum values for each day are shown by a line, as is minimum, and the mean and the median.
#
library(ggplot2)
library(scales)
library(patchwork)
#
# Open dfinal21.csv
#
dfinal21 <- read.csv("dfinal21.csv", header = TRUE, sep = ",", 
                   stringsAsFactors = FALSE, check.names = FALSE)
#
# Transform the Month_Day column so that ggplot can treat it as a date
# sequence for plotting
#
dfinal21$Month_Day <- as.Date(paste("2021-", dfinal21$Month_Day, sep = ""))
#
# Build the plot
p_a <- ggplot(dfinal21) + 
  geom_point(aes(x = Month_Day, y = `2021`, color = "2021"), size = 2) +
  geom_line(aes(x = Month_Day, y = Mean, color="mean")) +
  geom_line(aes(x = Month_Day, y = Median, color="median")) +
  geom_line(aes(x = Month_Day, y = Maximum, color = "maximum")) +
  geom_line(aes(x = Month_Day, y = Minimum, color = "minimum")) +
  scale_color_discrete(name = "Year") +
  scale_y_continuous(breaks = seq(20, 150, by=10), limits=c(20,150)) +
  scale_x_date(breaks = "1 month", minor_breaks = "1 day", labels=date_format("%b")) +
  labs(x = "Month", y = "acre-feet", title = "Treatment Plant Production")
#
# Save the plot to disk
ggsave(filename = "p_f21.pdf", plot = p_a, units = "in", width = 44, height = 34)
#
# Display the plot
#
print(p_a)
# End of production2021_patchwork.R