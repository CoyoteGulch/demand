# Copyright: City of Thornton Water Resources
# Author: John Orr
# This program is used to extract treatment plant production data, by day, for 2021. The data becomes available
# daily over the year and is in two workbooks, Plant Production WY2021.xlsm and Plant Production WY2022.xlsm 
# located in the Accounting files on the S: share. Each month must be added to the program as the year passes.
# The source Excel files are generated from treatment plant each day and must be in the same directory as the
# program file.
# Program files and data: S:\ID\WR\Supply and Demand Planning\Demand Forecasting\demand
# 
#
# Load the necessary R libraries
#
library(readxl)
#
# Read the workbook and create a new dataframe with the values from Excel.
#
# Load the data for January into dataframe dfinal21
df21jan1 <- read_excel("Plant Production WY2021.xlsm", sheet = "January", range = "A5:A35", col_names = "Month_Day")
df21jan1$Month_Day <- as.Date(as.character((df21jan1$Month_Day)))
df21jan2 <- read_excel("Plant Production WY2021.xlsm", sheet = "January", range = "AD5:AD35", col_names = "2021")
dfinal21 <- cbind(df21jan1, df21jan2)
#
# Load the data for February into dataframe dfinal21
df21feb1 <- read_excel("Plant Production WY2021.xlsm", sheet = "February", range = "A5:A33", col_names = "Month_Day")
df21feb1$Month_Day <- as.Date(as.character((df21feb1$Month_Day)))
df21feb2 <- read_excel("Plant Production WY2021.xlsm", sheet = "February", range = "AD5:AD33", col_names = "2021")
df21feb <- cbind(df21feb1, df21feb2)
dfinal21 <- rbind(dfinal21, df21feb)
#
# Load the data for March into dataframe dfinal21
df21mar1 <- read_excel("Plant Production WY2021.xlsm", sheet = "March", range = "A5:A35", col_names = "Month_Day")
df21mar1$Month_Day <- as.Date(as.character((df21mar1$Month_Day)))
df21mar2 <- read_excel("Plant Production WY2021.xlsm", sheet = "March", range = "AD5:AD35", col_names = "2021")
df21mar <- cbind(df21mar1, df21mar2)
dfinal21 <- rbind(dfinal21, df21mar)
#
# Load the data for April into dataframe dfinal21
df21apr1 <- read_excel("Plant Production WY2021.xlsm", sheet = "April", range = "A5:A34", col_names = "Month_Day")
df21apr1$Month_Day <- as.Date(as.character((df21apr1$Month_Day)))
df21apr2 <- read_excel("Plant Production WY2021.xlsm", sheet = "April", range = "AD5:AD34", col_names = "2021")
df21apr <- cbind(df21apr1, df21apr2)
dfinal21 <- rbind(dfinal21, df21apr)
#
# Load the data for May into dataframe dfinal21
df21may1 <- read_excel("Plant Production WY2021.xlsm", sheet = "May", range = "A5:A35", col_names = "Month_Day")
df21may1$Month_Day <- as.Date(as.character((df21may1$Month_Day)))
df21may2 <- read_excel("Plant Production WY2021.xlsm", sheet = "May", range = "AD5:AD35", col_names = "2021")
df21may <- cbind(df21may1, df21may2)
dfinal21 <- rbind(dfinal21, df21may)
#
# Load the data for June into dataframe dfinal21
df21jun1 <- read_excel("Plant Production WY2021.xlsm", sheet = "June", range = "A5:A34", col_names = "Month_Day")
df21jun1$Month_Day <- as.Date(as.character((df21jun1$Month_Day)))
df21jun2 <- read_excel("Plant Production WY2021.xlsm", sheet = "June", range = "AD5:AD34", col_names = "2021")
df21jun <- cbind(df21jun1, df21jun2)
dfinal21 <- rbind(dfinal21, df21jun)
#
# Load the data for July into dataframe dfinal21
df21jul1 <- read_excel("Plant Production WY2021.xlsm", sheet = "July", range = "A5:A35", col_names = "Month_Day")
df21jul1$Month_Day <- as.Date(as.character((df21jul1$Month_Day)))
df21jul2 <- read_excel("Plant Production WY2021.xlsm", sheet = "July", range = "AD5:AD35", col_names = "2021")
df21jul <- cbind(df21jul1, df21jul2)
dfinal21 <- rbind(dfinal21, df21jul)
#
# Load the data for August into dataframe dfinal21
df21Aug1 <- read_excel("Plant Production WY2021.xlsm", sheet = "August", range = "A5:A35", col_names = "Month_Day")
df21Aug1$Month_Day <- as.Date(as.character((df21Aug1$Month_Day)))
df21Aug2 <- read_excel("Plant Production WY2021.xlsm", sheet = "August", range = "AD5:AD35", col_names = "2021")
df21Aug <- cbind(df21Aug1, df21Aug2)
dfinal21 <- rbind(dfinal21, df21Aug)
#
# Load the data for September into dataframe dfinal21
df21Sep1 <- read_excel("Plant Production WY2021.xlsm", sheet = "September", range = "A5:A34", col_names = "Month_Day")
df21Sep1$Month_Day <- as.Date(as.character((df21Sep1$Month_Day)))
df21Sep2 <- read_excel("Plant Production WY2021.xlsm", sheet = "September", range = "AD5:AD34", col_names = "2021")
df21Sep <- cbind(df21Sep1, df21Sep2)
dfinal21 <- rbind(dfinal21, df21Sep)
#
#
# Load the mean, median, maximum, and minimum for each day from dfinal.csv the production data for 2010-2020
#
dfinal <- read.csv("dfinal.csv", header = TRUE, sep = ",", 
                   stringsAsFactors = FALSE, check.names = FALSE)
#
# Determine the number of rows so far in the water year
dfinal21nrow <- nrow(dfinal21)
# 
dfinal21$Mean <- dfinal$Mean[1:dfinal21nrow]
dfinal21$Median <- dfinal$Median[1:dfinal21nrow]
dfinal21$Maximum <- dfinal$Maximum[1:dfinal21nrow]
dfinal21$Minimum <- dfinal$Minimum[1:dfinal21nrow]
#
# Replace the values in the Month_Day column with just the month and day. The dates from the Excel workbooks have
# incorrect years.
dfinal21[1] <- format(dfinal21[1], "%m-%d")
#
# Used during testing
View(dfinal21)
#
# Write the dataframe to a .csv file
write.csv(dfinal21,'dfinal21.csv', row.names = FALSE)
