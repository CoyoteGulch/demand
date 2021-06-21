# Script to download maximum and minimum temperature data from particular SNOTEL site of interest to Thornton's
# drought monitoring effort and display it to the "Drought Monitoring" SharePoint page. The code runs in the Drought Monitoring
# share and stores the files in that directory. User must manually upload the graphs to "Contents" in SharePoint, then the page
# will display the latest graph. Current plan is to update the graph monthly. The display consists of a line graph of tMax,
# tMin, and freezing (32F) data for a single water year for a single SNOTEL site. Winter low temperatures are the most
# important to snowpack accumulation and preservation.
#
# Set up the environment
library(data.table)
library(tidyverse)
library(ggplot2)
library(scales)
setwd("S:/ID/WR/Supply and Demand Planning/Drought Monitoring/")
#
# Set the variable tMax to the URL for the SNOTEL site and download the data as a dataframe. The URL has to 
# be copied from the address bar in the browser after you generate the data set using the NRCS report writer
# at this URL: https://wcc.sc.egov.usda.gov/reportGenerator
tMax <- c("https://wcc.sc.egov.usda.gov/reportGenerator/view_csv/customMultiTimeSeriesGroupByStationReport/daily/start_of_period/936:CO:SNTL%7Cid=%22%22%7Cname/CurrentWY,CurrentWYEnd/TMAX::value,TMIN::value?fitToScreen=false")


echo_lake <- fread(tMax, sep = ",", header = TRUE, col.names = c("day", "Max", "Min"), stringsAsFactors = FALSE, data.table = FALSE)
#
View(echo_lake)
# The date comes in as a character field convert it to a R date
echo_lake$day <- as.Date((as.character(echo_lake$day)))
#
# View during testing
View(echo_lake)
#
# Plot the data.
echo_lake_plot <- ggplot(echo_lake) +
        geom_line(aes(x = day, y = Min, color = "red")) +
        geom_line(aes(x = day, y = Max, color = "blue")) +
        geom_line(aes(x = day, y = 32, color = "green")) +
        scale_color_discrete(name = "Temps", labels = (c("Max", "32F", "Min"))) +
        scale_y_continuous(breaks = seq(-35, 100, by=10), limits=c(-35,100)) +
        scale_x_date(breaks = "1 month", minor_breaks = "1 day", labels=date_format("%b")) +
        labs(x = "Water Year 2021", y = "Temperture F", title = "Echo Lake")
#
# Show the plot in the Viewwer window in RStudio during testing.
print(echo_lake_plot)
#
# Save the plot to disk.
ggsave(filename = "water_year_tMax_echo_lake.png", plot = echo_lake_plot, width = 6, height = 4)
#
# After script runs you have to upload the file to SharePoint. Click the gear wheel in the upper right corner of any page
# in SharePoint, click site contents, click site contents, click images, click on the plus sign next to "new document."
# Use the file chooser to locate the line plot and leave the checkbox checked, click OK, click save.
#
# End of echo_lake_minimum_tempertures.R
