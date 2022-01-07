# Build_total_raw_water_demand.R
# This programs reads the Excel Accounting files, WGLXXXX and StanXXXX to get metered data into a Tidy format for plotting
# Email from Mary:
# The pumping numbers are located:
# WGL Sum Tab column D
# Tani Summary Tab columns K and P (note that the historian for TTP didn't record from 10-19-2021 into November)
# Stan2021(4-Party) Meter Tab R - This is total outflow including FHL Bubbler and inflows to Tani, not adjusted to the 48-Inch which we use in the accounting, but for your purposes it may be better to use the unadjusted with the following deducted to get TTP inflow. 
#       FHL Bubbler: Stan2021(decree) Meter Out Tab column F
#       Tani Summary Tab column G (no inflows 2021)
#
# Another consideration, but no metered number is the actual backwash from the plants to the backwash ponds (we only have the meter number from the backwash ponds to WGL. If you think it will be useful the backwash from the ponds to WGL is located WGL Sum Tab column E.
# End of email from Mary
# The relevant files are copied from the Accounting share S:\ID\WR\Accounting\ to the Supply and Demand Planning share S:\ID\WR\Supply and Demand Planning\Demand Forecasting\demand\ to avoid the possibility of corrupting the historical Accounting files.
#
# Data is extracted in table format and then tidied using pivot_long.
# Load the necessary R libraries
#
library(readxl)
#
# Read the workbook and create a new dataframe with the values from Excel.
#
# Load the data for January into dataframe dfrwfinal
dfrwjan1 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "A72:A102", col_names = "month_day")
dfrwjan1$month_day <- as.Date(as.character((dfrwjan1$month_day)))
dfrwjan2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2010")
dfrwfinal <- cbind(dfrwjan1, dfrwjan2)
dfrwjan2 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2011")
dfrwfinal <- cbind(dfrwfinal, dfrwjan2)
dfrwjan3 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2012")
dfrwfinal <- cbind(dfrwfinal, dfrwjan3)
dfrwjan4 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2013")
dfrwfinal <- cbind(dfrwfinal, dfrwjan4)
dfrwjan5 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2014")
dfrwfinal <- cbind(dfrwfinal, dfrwjan5)
dfrwjan6 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2015")
dfrwfinal <- cbind(dfrwfinal, dfrwjan6)
dfrwjan7 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2016")
dfrwfinal <- cbind(dfrwfinal, dfrwjan7)
dfrwjan8 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2017")
dfrwfinal <- cbind(dfrwfinal, dfrwjan8)
dfrwjan9 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2018")
dfrwfinal <- cbind(dfrwfinal, dfrwjan9)
dfrwjan10 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2019")
dfrwfinal <- cbind(dfrwfinal, dfrwjan10)
dfrwjan11 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2020")
dfrwfinal <- cbind(dfrwfinal, dfrwjan11)
dfrwjan12 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2021")
dfrwfinal <- cbind(dfrwfinal, dfrwjan12)
#
# Load the data for February into dataframe dfrwfinal
dfrwfeb1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A104:A132", col_names = "month_day")
dfrwfeb1$month_day <- as.Date(as.character((dfrwfeb1$month_day)))
dfrwfeb2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2010")
dfrwfeb <- cbind(dfrwfeb1, dfrwfeb2)
dfrwfeb2 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2011")
dfrwfeb <- cbind(dfrwfeb, dfrwfeb2)
dfrwfeb3 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2012")
dfrwfeb <- cbind(dfrwfeb, dfrwfeb3)
dfrwfeb4 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2013")
dfrwfeb <- cbind(dfrwfeb, dfrwfeb4)
dfrwfeb5 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2014")
dfrwfeb <- cbind(dfrwfeb, dfrwfeb5)
dfrwfeb6 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2015")
dfrwfeb <- cbind(dfrwfeb, dfrwfeb6)
dfrwfeb7 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2016")
dfrwfeb <- cbind(dfrwfeb, dfrwfeb7)
dfrwfeb8 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2017")
dfrwfeb <- cbind(dfrwfeb, dfrwfeb8)
dfrwfeb9 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2018")
dfrwfeb <- cbind(dfrwfeb, dfrwfeb9)
dfrwjan10 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2019")
dfrwfeb <- cbind(dfrwfeb, dfrwjan10)
dfrwjan11 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2020")
dfrwfeb <- cbind(dfrwfeb, dfrwjan11)
dfrwjan12 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2021")
dfrwfeb <- cbind(dfrwfeb, dfrwjan12)
#
dfrwfinal <- rbind(dfrwfinal, dfrwfeb)
# Compute the mean for each day over all the years
#
dfrwfinal$mean = apply(dfrwfinal[2:13], 1, mean, na.rm = TRUE)
#
# Compute the median for each day over all the years
#
dfrwfinal$median = apply(dfrwfinal[2:13], 1, median, na.rm = TRUE)
#
# Determine the maximum by day over all of the days
dfrwfinal$maximum <- apply(dfrwfinal[2:13], 1, max, na.rm = TRUE)
# 
# Determine the maximum by day over all of the days
dfrwfinal$minimum <- apply(dfrwfinal[2:13], 1, min, na.rm = TRUE)
#

View(dfrwfinal)
