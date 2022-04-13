# Build_total_raw_water_demand.R
# This programs reads the Excel Accounting files, WGLXXXX, TANIwithWSPxxxx and StanXXXX to get metered data into a Tidy format for plotting
# 
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
# 
# The relevant files are copied from the Accounting share S:\ID\WR\Accounting\ to the Supply and Demand Planning share S:\ID\WR\Supply and Demand Planning\Demand Forecasting\demand\ to avoid the possibility of corrupting the historical Accounting files.
#
# Data is extracted in table format and then tidied using pivot_long.
# Load the necessary R libraries
#
library(dplyr)
library(readxl)
library(magrittr)
library(tibble)
#
# Read the workbooks and create a new dataframe with the values from Excel. Start with the West 
# Gravel Lakes, then South Tani, then Standley Lake.
#
# Load the data for January into dataframe dfrwwglfinal
dfrwwgljan1 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "A72:A102", col_names = "month_day")
dfrwwgljan1$month_day <- as.Date(as.character((dfrwwgljan1$month_day)))
dfrwwgljan2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2010")
dfrwwglfinal <- cbind(dfrwwgljan1, dfrwwgljan2)
dfrwwgljan3 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2011")
dfrwwglfinal <- cbind(dfrwwglfinal, dfrwwgljan3)
dfrwwgljan4 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2012")
dfrwwglfinal <- cbind(dfrwwglfinal, dfrwwgljan4)
dfrwwgljan5 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2013")
dfrwwglfinal <- cbind(dfrwwglfinal, dfrwwgljan5)
dfrwwgljan6 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2014")
dfrwwglfinal <- cbind(dfrwwglfinal, dfrwwgljan6)
dfrwwgljan7 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2015")
dfrwwglfinal <- cbind(dfrwwglfinal, dfrwwgljan7)
dfrwwgljan8 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2016")
dfrwwglfinal <- cbind(dfrwwglfinal, dfrwwgljan8)
dfrwwgljan9 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2017")
dfrwwglfinal <- cbind(dfrwwglfinal, dfrwwgljan9)
dfrwwgljan10 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2018")
dfrwwglfinal <- cbind(dfrwwglfinal, dfrwwgljan10)
dfrwwgljan11 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2019")
dfrwwglfinal <- cbind(dfrwwglfinal, dfrwwgljan11)
dfrwwgljan12 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2020")
dfrwwglfinal <- cbind(dfrwwglfinal, dfrwwgljan12)
dfrwwgljan13 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2021")
dfrwwglfinal <- cbind(dfrwwglfinal, dfrwwgljan13)
#
# Load the data for February into dataframe dfrwwglfinal
dfrwwglfeb1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A104:A132", col_names = "month_day")
dfrwwglfeb1$month_day <- as.Date(as.character((dfrwwglfeb1$month_day)))
dfrwwglfeb2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2010")
dfrwwglfeb <- cbind(dfrwwglfeb1, dfrwwglfeb2)
dfrwwglfeb3 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2011")
dfrwwglfeb <- cbind(dfrwwglfeb, dfrwwglfeb3)
dfrwwglfeb4 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2012")
dfrwwglfeb <- cbind(dfrwwglfeb, dfrwwglfeb4)
dfrwwglfeb5 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2013")
dfrwwglfeb <- cbind(dfrwwglfeb, dfrwwglfeb5)
dfrwwglfeb6 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2014")
dfrwwglfeb <- cbind(dfrwwglfeb, dfrwwglfeb6)
dfrwwglfeb7 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2015")
dfrwwglfeb <- cbind(dfrwwglfeb, dfrwwglfeb7)
dfrwwglfeb8 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2016")
dfrwwglfeb <- cbind(dfrwwglfeb, dfrwwglfeb8)
dfrwwglfeb9 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2017")
dfrwwglfeb <- cbind(dfrwwglfeb, dfrwwglfeb9)
dfrwwglfeb10 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2018")
dfrwwglfeb <- cbind(dfrwwglfeb, dfrwwglfeb10)
dfrwwglfeb11 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2019")
dfrwwglfeb <- cbind(dfrwwglfeb, dfrwwglfeb11)
dfrwwglfeb12 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2020")
dfrwwglfeb <- cbind(dfrwwglfeb, dfrwwglfeb12)
dfrwwglfeb13 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2021")
dfrwwglfeb <- cbind(dfrwwglfeb, dfrwwglfeb13)
#
dfrwwglfinal <- rbind(dfrwwglfinal, dfrwwglfeb)
#
# Load the data for March into dataframe dfrwwglfinal
dfrwwglmar1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A134:A164", col_names = "month_day")
dfrwwglmar1$month_day <- as.Date(as.character((dfrwwglmar1$month_day)))
dfrwwglmar2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2010")
dfrwwglmar <- cbind(dfrwwglmar1, dfrwwglmar2)
dfrwwglmar3 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2011")
dfrwwglmar <- cbind(dfrwwglmar, dfrwwglmar3)
dfrwwglmar4 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2012")
dfrwwglmar <- cbind(dfrwwglmar, dfrwwglmar4)
dfrwwglmar5 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2013")
dfrwwglmar <- cbind(dfrwwglmar, dfrwwglmar5)
dfrwwglmar6 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2014")
dfrwwglmar <- cbind(dfrwwglmar, dfrwwglmar6)
dfrwwglmar7 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2015")
dfrwwglmar <- cbind(dfrwwglmar, dfrwwglmar7)
dfrwwglmar8 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2016")
dfrwwglmar <- cbind(dfrwwglmar, dfrwwglmar8)
dfrwwglmar9 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2017")
dfrwwglmar <- cbind(dfrwwglmar, dfrwwglmar9)
dfrwwglmar10 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2018")
dfrwwglmar <- cbind(dfrwwglmar, dfrwwglmar10)
dfrwwglmar11 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2019")
dfrwwglmar <- cbind(dfrwwglmar, dfrwwglmar11)
dfrwwglmar12 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2020")
dfrwwglmar <- cbind(dfrwwglmar, dfrwwglmar12)
dfrwwglmar13 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2021")
dfrwwglmar <- cbind(dfrwwglmar, dfrwwglmar13)
#
dfrwwglfinal <- rbind(dfrwwglfinal, dfrwwglmar)
#
# Load the data for April into dataframe dfrwwglfinal
dfrwwglapr1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A166:A195", col_names = "month_day")
dfrwwglapr1$month_day <- as.Date(as.character((dfrwwglapr1$month_day)))
dfrwwglapr2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2010")
dfrwwglapr <- cbind(dfrwwglapr1, dfrwwglapr2)
dfrwwglapr3 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2011")
dfrwwglapr <- cbind(dfrwwglapr, dfrwwglapr3)
dfrwwglapr4 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2012")
dfrwwglapr <- cbind(dfrwwglapr, dfrwwglapr4)
dfrwwglapr5 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2013")
dfrwwglapr <- cbind(dfrwwglapr, dfrwwglapr5)
dfrwwglapr6 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2014")
dfrwwglapr <- cbind(dfrwwglapr, dfrwwglapr6)
dfrwwglapr7 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2015")
dfrwwglapr <- cbind(dfrwwglapr, dfrwwglapr7)
dfrwwglapr8 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2016")
dfrwwglapr <- cbind(dfrwwglapr, dfrwwglapr8)
dfrwwglapr9 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2017")
dfrwwglapr <- cbind(dfrwwglapr, dfrwwglapr9)
dfrwwglapr10 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2018")
dfrwwglapr <- cbind(dfrwwglapr, dfrwwglapr10)
dfrwwglapr11 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2019")
dfrwwglapr <- cbind(dfrwwglapr, dfrwwglapr11)
dfrwwglapr12 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2020")
dfrwwglapr <- cbind(dfrwwglapr, dfrwwglapr12)
dfrwwglapr13 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2021")
dfrwwglapr <- cbind(dfrwwglapr, dfrwwglapr13)
#
dfrwwglfinal <- rbind(dfrwwglfinal, dfrwwglapr)
#
# Load the data for May into dataframe dfrwwglfinal
dfrwwglmay1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A197:A227", col_names = "month_day")
dfrwwglmay1$month_day <- as.Date(as.character((dfrwwglmay1$month_day)))
dfrwwglmay2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2010")
dfrwwglmay <- cbind(dfrwwglmay1, dfrwwglmay2)
dfrwwglmay3 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2011")
dfrwwglmay <- cbind(dfrwwglmay, dfrwwglmay3)
dfrwwglmay4 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2012")
dfrwwglmay <- cbind(dfrwwglmay, dfrwwglmay4)
dfrwwglmay5 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2013")
dfrwwglmay <- cbind(dfrwwglmay, dfrwwglmay5)
dfrwwglmay6 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2014")
dfrwwglmay <- cbind(dfrwwglmay, dfrwwglmay6)
dfrwwglmay7 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2015")
dfrwwglmay <- cbind(dfrwwglmay, dfrwwglmay7)
dfrwwglmay8 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2016")
dfrwwglmay <- cbind(dfrwwglmay, dfrwwglmay8)
dfrwwglmay9 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2017")
dfrwwglmay <- cbind(dfrwwglmay, dfrwwglmay9)
dfrwwglmay10 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2018")
dfrwwglmay <- cbind(dfrwwglmay, dfrwwglmay10)
dfrwwglmay11 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2019")
dfrwwglmay <- cbind(dfrwwglmay, dfrwwglmay11)
dfrwwglmay12 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2020")
dfrwwglmay <- cbind(dfrwwglmay, dfrwwglmay12)
dfrwwglmay13 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2021")
dfrwwglmay <- cbind(dfrwwglmay, dfrwwglmay13)
#
dfrwwglfinal <- rbind(dfrwwglfinal, dfrwwglmay)
#
# Load the data for June into dataframe dfrwwglfinal
dfrwwgljun1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A229:A258", col_names = "month_day")
dfrwwgljun1$month_day <- as.Date(as.character((dfrwwgljun1$month_day)))
dfrwwgljun2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2010")
dfrwwgljun <- cbind(dfrwwgljun1, dfrwwgljun2)
dfrwwgljun3 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2011")
dfrwwgljun <- cbind(dfrwwgljun, dfrwwgljun3)
dfrwwgljun4 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2012")
dfrwwgljun <- cbind(dfrwwgljun, dfrwwgljun4)
dfrwwgljun5 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2013")
dfrwwgljun <- cbind(dfrwwgljun, dfrwwgljun5)
dfrwwgljun6 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2014")
dfrwwgljun <- cbind(dfrwwgljun, dfrwwgljun6)
dfrwwgljun7 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2015")
dfrwwgljun <- cbind(dfrwwgljun, dfrwwgljun7)
dfrwwgljun8 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2016")
dfrwwgljun <- cbind(dfrwwgljun, dfrwwgljun8)
dfrwwgljun9 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2017")
dfrwwgljun <- cbind(dfrwwgljun, dfrwwgljun9)
dfrwwgljun10 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2018")
dfrwwgljun <- cbind(dfrwwgljun, dfrwwgljun10)
dfrwwgljun11 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2019")
dfrwwgljun <- cbind(dfrwwgljun, dfrwwgljun11)
dfrwwgljun12 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2020")
dfrwwgljun <- cbind(dfrwwgljun, dfrwwgljun12)
dfrwwgljun13 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2021")
dfrwwgljun <- cbind(dfrwwgljun, dfrwwgljun13)
#
dfrwwglfinal <- rbind(dfrwwglfinal, dfrwwgljun)
#
# Load the data for July into dataframe dfrwwglfinal
dfrwwgljul1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A260:A290", col_names = "month_day")
dfrwwgljul1$month_day <- as.Date(as.character((dfrwwgljul1$month_day)))
dfrwwgljul2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2010")
dfrwwgljul <- cbind(dfrwwgljul1, dfrwwgljul2)
dfrwwgljul3 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2011")
dfrwwgljul <- cbind(dfrwwgljul, dfrwwgljul3)
dfrwwgljul4 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2012")
dfrwwgljul <- cbind(dfrwwgljul, dfrwwgljul4)
dfrwwgljul5 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2013")
dfrwwgljul <- cbind(dfrwwgljul, dfrwwgljul5)
dfrwwgljul6 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2014")
dfrwwgljul <- cbind(dfrwwgljul, dfrwwgljul6)
dfrwwgljul7 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2015")
dfrwwgljul <- cbind(dfrwwgljul, dfrwwgljul7)
dfrwwgljul8 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2016")
dfrwwgljul <- cbind(dfrwwgljul, dfrwwgljul8)
dfrwwgljul9 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2017")
dfrwwgljul <- cbind(dfrwwgljul, dfrwwgljul9)
dfrwwgljul10 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2018")
dfrwwgljul <- cbind(dfrwwgljul, dfrwwgljul10)
dfrwwgljul11 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2019")
dfrwwgljul <- cbind(dfrwwgljul, dfrwwgljul11)
dfrwwgljul12 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2020")
dfrwwgljul <- cbind(dfrwwgljul, dfrwwgljul12)
dfrwwgljul13 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2021")
dfrwwgljul <- cbind(dfrwwgljul, dfrwwgljul13)
#
dfrwwglfinal <- rbind(dfrwwglfinal, dfrwwgljul)
#
# Load the data for August into dataframe dfrwwglfinal
dfrwwglaug1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A292:A322", col_names = "month_day")
dfrwwglaug1$month_day <- as.Date(as.character((dfrwwglaug1$month_day)))
dfrwwglaug2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2010")
dfrwwglaug <- cbind(dfrwwglaug1, dfrwwglaug2)
dfrwwglaug3 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2011")
dfrwwglaug <- cbind(dfrwwglaug, dfrwwglaug3)
dfrwwglaug4 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2012")
dfrwwglaug <- cbind(dfrwwglaug, dfrwwglaug4)
dfrwwglaug5 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2013")
dfrwwglaug <- cbind(dfrwwglaug, dfrwwglaug5)
dfrwwglaug6 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2014")
dfrwwglaug <- cbind(dfrwwglaug, dfrwwglaug6)
dfrwwglaug7 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2015")
dfrwwglaug <- cbind(dfrwwglaug, dfrwwglaug7)
dfrwwglaug8 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2016")
dfrwwglaug <- cbind(dfrwwglaug, dfrwwglaug8)
dfrwwglaug9 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2017")
dfrwwglaug <- cbind(dfrwwglaug, dfrwwglaug9)
dfrwwglaug10 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2018")
dfrwwglaug <- cbind(dfrwwglaug, dfrwwglaug10)
dfrwwglaug11 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2019")
dfrwwglaug <- cbind(dfrwwglaug, dfrwwglaug11)
dfrwwglaug12 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2020")
dfrwwglaug <- cbind(dfrwwglaug, dfrwwglaug12)
dfrwwglaug13 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2021")
dfrwwglaug <- cbind(dfrwwglaug, dfrwwglaug13)
#
dfrwwglfinal <- rbind(dfrwwglfinal, dfrwwglaug)
#
# Load the data for September into dataframe dfrwwglfinal
dfrwwglsep1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A324:A353", col_names = "month_day")
dfrwwglsep1$month_day <- as.Date(as.character((dfrwwglsep1$month_day)))
dfrwwglsep2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2010")
dfrwwglsep <- cbind(dfrwwglsep1, dfrwwglsep2)
dfrwwglsep3 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2011")
dfrwwglsep <- cbind(dfrwwglsep, dfrwwglsep3)
dfrwwglsep4 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2012")
dfrwwglsep <- cbind(dfrwwglsep, dfrwwglsep4)
dfrwwglsep5 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2013")
dfrwwglsep <- cbind(dfrwwglsep, dfrwwglsep5)
dfrwwglsep6 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2014")
dfrwwglsep <- cbind(dfrwwglsep, dfrwwglsep6)
dfrwwglsep7 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2015")
dfrwwglsep <- cbind(dfrwwglsep, dfrwwglsep7)
dfrwwglsep8 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2016")
dfrwwglsep <- cbind(dfrwwglsep, dfrwwglsep8)
dfrwwglsep9 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2017")
dfrwwglsep <- cbind(dfrwwglsep, dfrwwglsep9)
dfrwwglsep10 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2018")
dfrwwglsep <- cbind(dfrwwglsep, dfrwwglsep10)
dfrwwglsep11 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2019")
dfrwwglsep <- cbind(dfrwwglsep, dfrwwglsep11)
dfrwwglsep12 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2020")
dfrwwglsep <- cbind(dfrwwglsep, dfrwwglsep12)
dfrwwglsep13 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2021")
dfrwwglsep <- cbind(dfrwwglsep, dfrwwglsep13)
#
dfrwwglfinal <- rbind(dfrwwglfinal, dfrwwglsep)
#
# Load the data for October into dataframe dfrwwglfinal
# NOte: I copied the formats from the October range of cells A355:L385 into the WGL2011.xlsm workbook. read_excel would not return values from column D. This seemed to work as the read from WGL2011.xlsm now works.
dfrwwgloct1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A355:A385", col_names = "month_day")
dfrwwgloct1$month_day <- as.Date(as.character((dfrwwgloct1$month_day)))
dfrwwgloct2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2010")
dfrwwgloct <- cbind(dfrwwgloct1, dfrwwgloct2)
dfrwwgloct3 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2011")
dfrwwgloct <- cbind(dfrwwgloct, dfrwwgloct3)
dfrwwgloct4 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2012")
dfrwwgloct <- cbind(dfrwwgloct, dfrwwgloct4)
dfrwwgloct5 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2013")
dfrwwgloct <- cbind(dfrwwgloct, dfrwwgloct5)
dfrwwgloct6 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2014")
dfrwwgloct <- cbind(dfrwwgloct, dfrwwgloct6)
dfrwwgloct7 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2015")
dfrwwgloct <- cbind(dfrwwgloct, dfrwwgloct7)
dfrwwgloct8 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2016")
dfrwwgloct <- cbind(dfrwwgloct, dfrwwgloct8)
dfrwwgloct9 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2017")
dfrwwgloct <- cbind(dfrwwgloct, dfrwwgloct9)
dfrwwgloct10 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2018")
dfrwwgloct <- cbind(dfrwwgloct, dfrwwgloct10)
dfrwwgloct11 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2019")
dfrwwgloct <- cbind(dfrwwgloct, dfrwwgloct11)
dfrwwgloct12 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2020")
dfrwwgloct <- cbind(dfrwwgloct, dfrwwgloct12)
dfrwwgloct13 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2021")
dfrwwgloct <- cbind(dfrwwgloct, dfrwwgloct13)
#
dfrwwglfinal <- rbind(dfrwwglfinal, dfrwwgloct)
#
#
# Load the data for November into dataframe dfrwwglfinal. NOTE that the workbooks conform to the DWR water year and therefore run from November in one year through October the following year, so in order to get November and December for e.g. "2010" you need the WGL2011 workbook.
dfrwwglnov1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A9:A38", col_names = "month_day")
dfrwwglnov1$month_day <- as.Date(as.character((dfrwwglnov1$month_day)))
dfrwwglnov2 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2010")
dfrwwglnov <- cbind(dfrwwglnov1, dfrwwglnov2)
dfrwwglnov3 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2011")
dfrwwglnov <- cbind(dfrwwglnov, dfrwwglnov3)
dfrwwglnov4 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2012")
dfrwwglnov <- cbind(dfrwwglnov, dfrwwglnov4)
dfrwwglnov5 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2013")
dfrwwglnov <- cbind(dfrwwglnov, dfrwwglnov5)
dfrwwglnov6 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2014")
dfrwwglnov <- cbind(dfrwwglnov, dfrwwglnov6)
dfrwwglnov7 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2015")
dfrwwglnov <- cbind(dfrwwglnov, dfrwwglnov7)
dfrwwglnov8 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2016")
dfrwwglnov <- cbind(dfrwwglnov, dfrwwglnov8)
dfrwwglnov9 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2017")
dfrwwglnov <- cbind(dfrwwglnov, dfrwwglnov9)
dfrwwglnov10 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2018")
dfrwwglnov <- cbind(dfrwwglnov, dfrwwglnov10)
dfrwwglnov11 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2019")
dfrwwglnov <- cbind(dfrwwglnov, dfrwwglnov11)
dfrwwglnov12 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2020")
dfrwwglnov <- cbind(dfrwwglnov, dfrwwglnov12)
dfrwwglnov13 <- read_excel("WGL2022.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2021")
dfrwwglnov <- cbind(dfrwwglnov, dfrwwglnov13)
#
dfrwwglfinal <- rbind(dfrwwglfinal, dfrwwglnov)
#
# Load the data for December into dataframe dfrwwglfinal. NOTE that the workbooks conform to the DWR water year and therefore run from November in one year through October the following year, so in order to get November and December for e.g. "2010" you need the WGL2011 workbook.
dfrwwgldec1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A40:A70", col_names = "month_day")
dfrwwgldec1$month_day <- as.Date(as.character((dfrwwgldec1$month_day)))
dfrwwgldec2 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2010")
dfrwwgldec <- cbind(dfrwwgldec1, dfrwwgldec2)
dfrwwgldec3 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2011")
dfrwwgldec <- cbind(dfrwwgldec, dfrwwgldec3)
dfrwwgldec4 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2012")
dfrwwgldec <- cbind(dfrwwgldec, dfrwwgldec4)
dfrwwgldec5 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2013")
dfrwwgldec <- cbind(dfrwwgldec, dfrwwgldec5)
dfrwwgldec6 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2014")
dfrwwgldec <- cbind(dfrwwgldec, dfrwwgldec6)
dfrwwgldec7 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2015")
dfrwwgldec <- cbind(dfrwwgldec, dfrwwgldec7)
dfrwwgldec8 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2016")
dfrwwgldec <- cbind(dfrwwgldec, dfrwwgldec8)
dfrwwgldec9 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2017")
dfrwwgldec <- cbind(dfrwwgldec, dfrwwgldec9)
dfrwwgldec10 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2018")
dfrwwgldec <- cbind(dfrwwgldec, dfrwwgldec10)
dfrwwgldec11 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2019")
dfrwwgldec <- cbind(dfrwwgldec, dfrwwgldec11)
dfrwwgldec12 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2020")
dfrwwgldec <- cbind(dfrwwgldec, dfrwwgldec12)
dfrwwgldec13 <- read_excel("WGL2022.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2021")
dfrwwgldec <- cbind(dfrwwgldec, dfrwwgldec13)
#

dfrwwglfinal <- rbind(dfrwwglfinal, dfrwwgldec)
#

# The values from the workbooks are negative, change them to positive. They are inflows to the treatment plant and come in negative because they are outflows from the reservoir.
# 
# dfrwwglfinal[, 2:13] <- dfrwwglfinal[, 2:13] * -1
#
# Replace all NA values with 0
#
# dfrwwglfinal[, 2:13] <- lapply(dfrwwglfinal[, 2:13], function(x) replace(x, is.na(x), 0))
#
# Compute the mean for each day over all the years ignoring zeros
#
#dfrwwglfinal$mean = apply(dfrwwglfinal[, 2:13], 1, function(x) mean(x[x>0]))
#
# Computing the mean on February 29th with all zero values for WGL  returns NaN. Hoping that this will clear up when there are not treatment values = 0 with all workbooks.
# 
# Compute the median for each day over all the years ignoring zeros
#
#dfrwwglfinal$median = apply(dfrwwglfinal[, 2:13], 1, function(x) median(x[x>0]))
#
# Computing the median on February 29th with all zero values for WGL  returns NA. Hoping that this will clear up when there are not treatment values = 0 with all workbooks.
#
# Determine the maximum by day over all of the days ignoring zeros
#dfrwwglfinal$maximum <- apply(dfrwwglfinal[, 2:13], 1, function(x) max(x[x>=0]))
# 
# Determine the maximum by day over all of the days ignoring zeros
#dfrwwglfinal$minimum <- apply(dfrwwglfinal[, 2:13], 1, function(x) min(x[x>=0]))
#
# Used during testing
# View(dfrwwglfinal)
#
# Write the dataframe to a .csv file
# write.csv(dfrwwglfinal,'dfrwwglfinal.csv', row.names = FALSE)
#
# Read the workbooks and create a new dataframe with the values from Excel. I had to unlock the "Taniwith ESP2010.xlsm"
#  column H for read_excel to return values. Also I checked "Show a zero in cells that have zero value". Save the file for
#  changes to take effect. For some workbooks I had to enter zeroes in columns that had blank cells. The next lines of code build a dataframe named
#  dfrwtanifinal that is merged with dfrwwglfinal (the
# dataframe for West Gravel Lakes) and dfrwslfinal (the dataframe for Standley Lake)
#
# Load the data for January into dataframe dfrwtanifinal
dfrwtanijan1 <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "A72:A102", col_names = "month_day")
dfrwtanijan1$month_day <- as.Date(as.character((dfrwtanijan1$month_day)))
#
# Read in column H (to wes brown wtp), cbind with dfrwtanijan1
dfrwtanijan2a <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "H72:H102", col_names = "y_2010")
dfrwtanijan2a <- cbind(dfrwtanijan1, dfrwtanijan2a)
#
# Read in column I (to thorton wtp), cbind with dfrwtanijan1
dfrwtanijan2b <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "I72:I102", col_names = "y_2010")
dfrwtanijan2b <- cbind(dfrwtanijan1, dfrwtanijan2b)
#
# Add dfrwtanijan2a and dfrwtanijan2b together, this drops the month_day column
dfrwtanijan2 <- dfrwtanijan2a %>% select(-month_day) %>% add(dfrwtanijan2b %>% select(-month_day)) %>% mutate(type = dfrwtanijan2b$type)
#
# Create dfrwtanijan for subsequent extracts
dfrwtanijan <- cbind(dfrwtanijan1, dfrwtanijan2)
#
# Read the data for 2011 from column H and combine with dfrwtanijan1 for dates
dfrwtanijan3a <- read_excel("TANIwith ESP2011.xlsm", sheet = "Summary", range = "H72:H102", col_names = "y_2011")
dfrwtanijan3a <- cbind(dfrwtanijan1, dfrwtanijan3a)
#
# Read the data from column I and combine it with dfrwtanijan1
dfrwtanijan3b <- read_excel("TANIwith ESP2011.xlsm", sheet = "Summary", range = "I72:I102", col_names = "y_2011")
dfrwtanijan3b <- cbind(dfrwtanijan1, dfrwtanijan3b)
#
# Add dfrwtanijan3a and dfrwtanijan3b together. This drops the month_day column
dfrwtanijan3 <- dfrwtanijan3a %>% select(-month_day) %>% add(dfrwtanijan3b %>% select(-month_day)) %>% mutate(type = dfrwtanijan3b$type)
#
# Add dfrwtanijan3 to dfrfinal (2011 january values)
dfrwtanijan <- cbind(dfrwtanijan, dfrwtanijan3)
#
# Extract 2012 data. Pattern is same as 2011 except now extract column I (to wes brown) and column J (to thornton WTP)
dfrwtanijan4a <- read_excel("TANIwith ESP2012.xlsm", sheet = "Summary", range = "I72:I102", col_names = "y_2012")
dfrwtanijan4a <- cbind(dfrwtanijan1, dfrwtanijan4a) # need month_day to add to dfrwtanifinal
#
dfrwtanijan4b <- read_excel("TANIwith ESP2012.xlsm", sheet = "Summary", range = "J72:J102", col_names = "y_2012")
dfrwtanijan4b <- cbind(dfrwtanijan1, dfrwtanijan4b) # need month_day to add to dfrwtanifinal
#
dfrwtanijan4 <- dfrwtanijan4a %>% select(-month_day) %>% add(dfrwtanijan4b %>% select(-month_day)) %>% mutate(type = dfrwtanijan4b$type)
dfrwtanijan <- cbind(dfrwtanijan, dfrwtanijan4)
#
# Extract the 2013 data
dfrwtanijan5a <- read_excel("TANIwith ESP2013.xlsm", sheet = "Summary", range = "I72:I102", col_names = "y_2013")
dfrwtanijan5a <- cbind(dfrwtanijan1, dfrwtanijan5a) # need month_day to add to dfrwtanifinal
#
dfrwtanijan5b <- read_excel("TANIwith ESP2013.xlsm", sheet = "Summary", range = "J72:J102", col_names = "y_2013")
dfrwtanijan5b <- cbind(dfrwtanijan1, dfrwtanijan5b) # need month_day to add to dfrwtanifinal
#
dfrwtanijan5 <- dfrwtanijan5a %>% select(-month_day) %>% add(dfrwtanijan5b %>% select(-month_day)) %>% mutate(type = dfrwtanijan5b$type)
dfrwtanijan <- cbind(dfrwtanijan, dfrwtanijan5)
#
# Extract the 2014 data. The workbook only has column I for outflows so no need to for a and b
dfrwtanijan6 <- read_excel("TANIwith ESP2014.xlsm", sheet = "Summary", range = "I72:I102", col_names = "y_2014")
dfrwtanijan <- cbind(dfrwtanijan, dfrwtanijan6)
#
# Extract the 2015 data. The workbook only has column I for outflows so no need to for a and b
dfrwtanijan7 <- read_excel("TANIwith ESP2015.xlsm", sheet = "Summary", range = "I72:I102", col_names = "y_2015")
dfrwtanijan <- cbind(dfrwtanijan, dfrwtanijan7)
#
# Extract the 2016 data. The workbook only has column I for outflows so no need to for a and b
dfrwtanijan8 <- read_excel("TANIwith ESP2016.xlsm", sheet = "Summary", range = "I72:I102", col_names = "y_2016")
dfrwtanijan <- cbind(dfrwtanijan, dfrwtanijan8)
#
# Extract the 2017 data. The workbook only has column I for outflows so no need to for a and b
dfrwtanijan9 <- read_excel("TANIwith ESP2017.xlsm", sheet = "Summary", range = "I72:I102", col_names = "y_2017")
dfrwtanijan <- cbind(dfrwtanijan, dfrwtanijan9)
#
# Extract the 2018 data. The workbook only has column K for outflows so no need to for a and b
dfrwtanijan10 <- read_excel("TANIwithWSP2018.xlsm", sheet = "Summary", range = "K72:K102", col_names = "y_2018")
dfrwtanijan <- cbind(dfrwtanijan, dfrwtanijan10)
#
# Extract the 2019 data. The workbook only has column K for outflows so no need to for a and b
dfrwtanijan11 <- read_excel("TANIwithWSP2019.xlsm", sheet = "Summary", range = "K72:K102", col_names = "y_2019")
dfrwtanijan <- cbind(dfrwtanijan, dfrwtanijan11)
#
# Extract the 2020 data. The workbook only has column K for outflows so no need to for a and b
dfrwtanijan12 <- read_excel("TANIwithWSP2020.xlsm", sheet = "Summary", range = "K72:K102", col_names = "y_2020")
dfrwtanijan <- cbind(dfrwtanijan, dfrwtanijan12)
#
# Extract the 2021 data. The workbook only has column K for outflows so no need to for a and b
dfrwtanijan13 <- read_excel("TANIwithWSP2021.xlsm", sheet = "Summary", range = "K72:K102", col_names = "y_2021")
dfrwtanijan <- cbind(dfrwtanijan, dfrwtanijan13)
#
# create dfrwtanifinal
dfrwtanifinal <- dfrwtanijan
#
# Load the data for February into dataframe dfrwtanifinal. Early workbooks have two columns for outflows to treatment
# so it is necessary to process each column and combine them and then bind with dfrwtanifinal.
# .The first read from wgl2012.xlsm is necessary to get February 29th to handle leap years.
# First time through have to cbind cfrwtanifeb1 and dfrwtanifeb2 after that add to get the month_day column for
# for the dataframe dfrwtanifeb.
# Extract the 2010 data
dfrwtanifeb1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A104:A132", col_names = "month_day")
#
dfrwtanifeb2a <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "H104:H132", col_names = "y_2010")
dfrwtanifeb2a <- cbind(dfrwtanifeb1, dfrwtanifeb2a)
#
dfrwtanifeb2b <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "I104:I132", col_names = "y_2010")
dfrwtanifeb2b <- cbind(dfrwtanifeb1, dfrwtanifeb2b)
#
# Add dfrwtanifeb2a and dfrwtanifeb2b together, this drops the month_day column
dfrwtanifeb2 <- dfrwtanifeb2a %>% select(-month_day) %>% add(dfrwtanifeb2b %>% select(-month_day)) %>% mutate(type = dfrwtanifeb2b$type)
#
# Create dfrwtanifeb from dfrwtanifina1 and dfrwtanifeb2
dfrwtanifeb <- cbind(dfrwtanifeb1, dfrwtanifeb2)
#
# Load the data for 2011
dfrwtanifeb3a <- read_excel("TANIwith ESP2011.xlsm", sheet = "Summary", range = "H104:H132", col_names = "y_2011")
dfrwtanifeb3a <- cbind(dfrwtanifeb1, dfrwtanifeb3a)
#
dfrwtanifeb3b <- read_excel("TANIwith ESP2011.xlsm", sheet = "Summary", range = "I104:I132", col_names = "y_2011")
dfrwtanifeb3b <- cbind(dfrwtanifeb1, dfrwtanifeb3b)
#
dfrwtanifeb3 <- dfrwtanifeb3a %>% select(-month_day) %>% add(dfrwtanifeb3b %>% select(-month_day)) %>% mutate(type = dfrwtanifeb3b$type)
#
dfrwtanifeb <- cbind(dfrwtanifeb, dfrwtanifeb3)
#
# Load the data for 2012
dfrwtanifeb4a <- read_excel("TANIwith ESP2012.xlsm", sheet = "Summary", range = "I104:I132", col_names = "y_2012")
dfrwtanifeb4a <- cbind(dfrwtanifeb1, dfrwtanifeb4a)
#
dfrwtanifeb4b <- read_excel("TANIwith ESP2012.xlsm", sheet = "Summary", range = "J104:J132", col_names = "y_2012")
dfrwtanifeb4b <- cbind(dfrwtanifeb1, dfrwtanifeb4b)
#
dfrwtanifeb4 <- dfrwtanifeb4a %>% select(-month_day) %>% add(dfrwtanifeb4b %>% select(-month_day)) %>% mutate(type = dfrwtanifeb4b$type)
#
dfrwtanifeb <- cbind(dfrwtanifeb, dfrwtanifeb4)
#
# Load the data for 2013
dfrwtanifeb5a <- read_excel("TANIwith ESP2013.xlsm", sheet = "Summary", range = "I104:I132", col_names = "y_2013")
dfrwtanifeb5a <- cbind(dfrwtanifeb1, dfrwtanifeb5a)
#
dfrwtanifeb5b <- read_excel("TANIwith ESP2013.xlsm", sheet = "Summary", range = "J104:J132", col_names = "y_2013")
dfrwtanifeb5b <- cbind(dfrwtanifeb1, dfrwtanifeb5b)
#
dfrwtanifeb5 <- dfrwtanifeb5a %>% select(-month_day) %>% add(dfrwtanifeb5b %>% select(-month_day)) %>% mutate(type = dfrwtanifeb5b$type)
#
dfrwtanifeb <- cbind(dfrwtanifeb, dfrwtanifeb5)
#
# Load the data for 2014. The workbook only has one column, to wes brown, H
dfrwtanifeb6 <- read_excel("TANIwith ESP2014.xlsm", sheet = "Summary", range = "H104:H132", col_names = "y_2014")
dfrwtanifeb <- cbind(dfrwtanifeb, dfrwtanifeb6)
#
# Load the data for 2015 from column I.
dfrwtanifeb7 <- read_excel("TANIwith ESP2015.xlsm", sheet = "Summary", range = "I104:I132", col_names = "y_2015")
dfrwtanifeb <- cbind(dfrwtanifeb, dfrwtanifeb7)
#
# Load the data for 2016 from column I.
dfrwtanifeb8 <- read_excel("TANIwith ESP2016.xlsm", sheet = "Summary", range = "I104:I132", col_names = "y_2016")
dfrwtanifeb <- cbind(dfrwtanifeb, dfrwtanifeb8)
#
# Load the data for 2017 from column I.
dfrwtanifeb9 <- read_excel("TANIwith ESP2017.xlsm", sheet = "Summary", range = "I104:I132", col_names = "y_2017")
dfrwtanifeb <- cbind(dfrwtanifeb, dfrwtanifeb9)
#
# Load the data for 2018 from column K.
dfrwtanifeb10 <- read_excel("TANIwithWSP2018.xlsm", sheet = "Summary", range = "K104:K132", col_names = "y_2018")
dfrwtanifeb <- cbind(dfrwtanifeb, dfrwtanifeb10)
#
# Load the data for 2019 from column K.
dfrwtanifeb11 <- read_excel("TANIwithWSP2019.xlsm", sheet = "Summary", range = "K104:K132", col_names = "y_2019")
dfrwtanifeb <- cbind(dfrwtanifeb, dfrwtanifeb11)
#
# Load the data for 2020 from column K.
dfrwtanifeb12 <- read_excel("TANIwithWSP2020.xlsm", sheet = "Summary", range = "K104:K132", col_names = "y_2020")
dfrwtanifeb <- cbind(dfrwtanifeb, dfrwtanifeb12)
#
# Load the data for 2021 from columns K and P.
dfrwtanifeb12a <- read_excel("TANIwithWSP2021.xlsm", sheet = "Summary", range = "K104:K132", col_names = "y_2021")
dfrwtanifeb12a <- cbind(dfrwtanifeb1, dfrwtanifeb12a)
#
dfrwtanifeb12b <- read_excel("TANIwithWSP2021.xlsm", sheet = "Summary", range = "P104:P132", col_names = "y_2021")
dfrwtanifeb12b <- cbind(dfrwtanifeb1, dfrwtanifeb12b)
#
# Add dfrwtanifeb12a and dfrwtanifeb12b together, this drops the month_day column
dfrwtanifeb12 <- dfrwtanifeb12a %>% select(-month_day) %>% add(dfrwtanifeb12b %>% select(-month_day)) %>% mutate(type = dfrwtanifeb12b$type)
#
dfrwtanifeb <- cbind(dfrwtanifeb, dfrwtanifeb12)
#
# Join dfrwtanifinal and dfrwtanifeb with rbind
dfrwtanifinal <- rbind(dfrwtanifinal, dfrwtanifeb)













# Load the data for March and rbind it to dfrwtanifeb in dfrwtanifinal
dfrwtanimar1 <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "A134:A164", col_names = "month_day")
#
dfrwtanimar2a <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "H134:H164", col_names = "y_2010")
dfrwtanimar2a <- cbind(dfrwtanimar1, dfrwtanimar2a)
#
dfrwtanimar2b <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "I134:I164", col_names = "y_2010")
dfrwtanimar2b <- cbind(dfrwtanimar1, dfrwtanimar2b)
#
# Add dfrwtanimar2a and dfrwtanimar2b together, this drops the month_day column
dfrwtanimar2 <- dfrwtanimar2a %>% select(-month_day) %>% add(dfrwtanimar2b %>% select(-month_day)) %>% mutate(type = dfrwtanimar2b$type)
#
# Create dfrwtanimar from dfrwtanimar1 and dfrwtanimar2
dfrwtanimar <- cbind(dfrwtanimar1, dfrwtanimar2)
#












# Load the data for March into dataframe dfrwtanifinal
dfrwtanimar1 <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "A134:A164", col_names = "month_day")
dfrwtanimar1$month_day <- as.Date(as.character((dfrwtanimar1$month_day)))
dfrwtanimar2 <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "H134:H164", col_names = "y_2010")
dfrwtanimar <- cbind(dfrwtanimar1, dfrwtanimar2)
dfrwtanimar3 <- read_excel("TANIwith ESP2011.xlsm", sheet = "Summary", range = "H134:H164", col_names = "y_2011")
dfrwtanimar <- cbind(dfrwtanimar, dfrwtanimar3)
dfrwtanimar4 <- read_excel("TANIwith ESP2012.xlsm", sheet = "Summary", range = "I134:I164", col_names = "y_2012")
dfrwtanimar <- cbind(dfrwtanimar, dfrwtanimar4)
dfrwtanimar5 <- read_excel("TANIwith ESP2013.xlsm", sheet = "Summary", range = "I134:I164", col_names = "y_2013")
dfrwtanimar <- cbind(dfrwtanimar, dfrwtanimar5)
dfrwtanimar6 <- read_excel("TANIwith ESP2014.xlsm", sheet = "Summary", range = "I134:I164", col_names = "y_2014")
dfrwtanimar <- cbind(dfrwtanimar, dfrwtanimar6)
dfrwtanimar7 <- read_excel("TANIwith ESP2015.xlsm", sheet = "Summary", range = "I134:I164", col_names = "y_2015")
dfrwtanimar <- cbind(dfrwtanimar, dfrwtanimar7)
dfrwtanimar8 <- read_excel("TANIwith ESP2016.xlsm", sheet = "Summary", range = "I134:I164", col_names = "y_2016")
dfrwtanimar <- cbind(dfrwtanimar, dfrwtanimar8)
dfrwtanimar9 <- read_excel("TANIwith ESP2017.xlsm", sheet = "Summary", range = "I134:I164", col_names = "y_2017")
dfrwtanimar <- cbind(dfrwtanimar, dfrwtanimar9)
dfrwtanimar10 <- read_excel("TANIwithWSP2018.xlsm", sheet = "Summary", range = "K134:K164", col_names = "y_2018")
dfrwtanimar <- cbind(dfrwtanimar, dfrwtanimar10)
dfrwtanimar11 <- read_excel("TANIwithWSP2019.xlsm", sheet = "Summary", range = "K134:K164", col_names = "y_2019")
dfrwtanimar <- cbind(dfrwtanimar, dfrwtanimar11)
dfrwtanimar12 <- read_excel("TANIwithWSP2020.xlsm", sheet = "Summary", range = "K134:K164", col_names = "y_2020")
dfrwtanimar <- cbind(dfrwtanimar, dfrwtanimar12)
dfrwtanimar13 <- read_excel("TANIwithWSP2021.xlsm", sheet = "Summary", range = "K134:K164", col_names = "y_2021")
dfrwtanimar <- cbind(dfrwtanimar, dfrwtanimar13)
#
dfrwtanifinal <- rbind(dfrwtanifinal, dfrwtanimar)
#
# Load the data for April into dataframe dfrwtanifinal
dfrwtaniapr1 <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "A166:A195", col_names = "month_day")
dfrwtaniapr1$month_day <- as.Date(as.character((dfrwtaniapr1$month_day)))
dfrwtaniapr2 <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "H166:H195", col_names = "y_2010")
dfrwtaniapr <- cbind(dfrwtaniapr1, dfrwtaniapr2)
dfrwtaniapr3 <- read_excel("TANIwith ESP2011.xlsm", sheet = "Summary", range = "H166:H195", col_names = "y_2011")
dfrwtaniapr <- cbind(dfrwtaniapr, dfrwtaniapr3)
dfrwtaniapr4 <- read_excel("TANIwith ESP2012.xlsm", sheet = "Summary", range = "I166:I195", col_names = "y_2012")
dfrwtaniapr <- cbind(dfrwtaniapr, dfrwtaniapr4)
dfrwtaniapr5 <- read_excel("TANIwith ESP2013.xlsm", sheet = "Summary", range = "I166:I195", col_names = "y_2013")
dfrwtaniapr <- cbind(dfrwtaniapr, dfrwtaniapr5)
dfrwtaniapr6 <- read_excel("TANIwith ESP2014.xlsm", sheet = "Summary", range = "I166:I195", col_names = "y_2014")
dfrwtaniapr <- cbind(dfrwtaniapr, dfrwtaniapr6)
dfrwtaniapr7 <- read_excel("TANIwith ESP2015.xlsm", sheet = "Summary", range = "I166:I195", col_names = "y_2015")
dfrwtaniapr <- cbind(dfrwtaniapr, dfrwtaniapr7)
dfrwtaniapr8 <- read_excel("TANIwith ESP2016.xlsm", sheet = "Summary", range = "I166:I195", col_names = "y_2016")
dfrwtaniapr <- cbind(dfrwtaniapr, dfrwtaniapr8)
dfrwtaniapr9 <- read_excel("TANIwith ESP2017.xlsm", sheet = "Summary", range = "I166:I195", col_names = "y_2017")
dfrwtaniapr <- cbind(dfrwtaniapr, dfrwtaniapr9)
dfrwtaniapr10 <- read_excel("TANIwithWSP2018.xlsm", sheet = "Summary", range = "K166:K195", col_names = "y_2018")
dfrwtaniapr <- cbind(dfrwtaniapr, dfrwtaniapr10)
dfrwtaniapr11 <- read_excel("TANIwithWSP2019.xlsm", sheet = "Summary", range = "K166:K195", col_names = "y_2019")
dfrwtaniapr <- cbind(dfrwtaniapr, dfrwtaniapr11)
dfrwtaniapr12 <- read_excel("TANIwithWSP2020.xlsm", sheet = "Summary", range = "K166:K195", col_names = "y_2020")
dfrwtaniapr <- cbind(dfrwtaniapr, dfrwtaniapr12)
dfrwtaniapr13 <- read_excel("TANIwithWSP2021.xlsm", sheet = "Summary", range = "K166:K195", col_names = "y_2021")
dfrwtaniapr <- cbind(dfrwtaniapr, dfrwtaniapr13)
#
dfrwtanifinal <- rbind(dfrwtanifinal, dfrwtaniapr)
#
# Load the data for May into dataframe dfrwtanifinal
dfrwtanimay1 <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "A197:A227", col_names = "month_day")
dfrwtanimay1$month_day <- as.Date(as.character((dfrwtanimay1$month_day)))
dfrwtanimay2 <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "H197:H227", col_names = "y_2010")
dfrwtanimay <- cbind(dfrwtanimay1, dfrwtanimay2)
dfrwtanimay3 <- read_excel("TANIwith ESP2011.xlsm", sheet = "Summary", range = "H197:H227", col_names = "y_2011")
dfrwtanimay <- cbind(dfrwtanimay, dfrwtanimay3)
dfrwtanimay4 <- read_excel("TANIwith ESP2012.xlsm", sheet = "Summary", range = "I197:I227", col_names = "y_2012")
dfrwtanimay <- cbind(dfrwtanimay, dfrwtanimay4)
dfrwtanimay5 <- read_excel("TANIwith ESP2013.xlsm", sheet = "Summary", range = "I197:I227", col_names = "y_2013")
dfrwtanimay <- cbind(dfrwtanimay, dfrwtanimay5)
dfrwtanimay6 <- read_excel("TANIwith ESP2014.xlsm", sheet = "Summary", range = "I197:I227", col_names = "y_2014")
dfrwtanimay <- cbind(dfrwtanimay, dfrwtanimay6)
dfrwtanimay7 <- read_excel("TANIwith ESP2015.xlsm", sheet = "Summary", range = "I197:I227", col_names = "y_2015")
dfrwtanimay <- cbind(dfrwtanimay, dfrwtanimay7)
dfrwtanimay8 <- read_excel("TANIwith ESP2016.xlsm", sheet = "Summary", range = "I197:I227", col_names = "y_2016")
dfrwtanimay <- cbind(dfrwtanimay, dfrwtanimay8)
dfrwtanimay9 <- read_excel("TANIwith ESP2017.xlsm", sheet = "Summary", range = "I197:I227", col_names = "y_2017")
dfrwtanimay <- cbind(dfrwtanimay, dfrwtanimay9)
dfrwtanimay10 <- read_excel("TANIwithWSP2018.xlsm", sheet = "Summary", range = "K197:K227", col_names = "y_2018")
dfrwtanimay <- cbind(dfrwtanimay, dfrwtanimay10)
dfrwtanimay11 <- read_excel("TANIwithWSP2019.xlsm", sheet = "Summary", range = "K197:K227", col_names = "y_2019")
dfrwtanimay <- cbind(dfrwtanimay, dfrwtanimay11)
dfrwtanimay12 <- read_excel("TANIwithWSP2020.xlsm", sheet = "Summary", range = "K197:K227", col_names = "y_2020")
dfrwtanimay <- cbind(dfrwtanimay, dfrwtanimay12)
dfrwtanimay13 <- read_excel("TANIwithWSP2021.xlsm", sheet = "Summary", range = "K197:K227", col_names = "y_2021")
dfrwtanimay <- cbind(dfrwtanimay, dfrwtanimay13)
#
dfrwtanifinal <- rbind(dfrwtanifinal, dfrwtanimay)
#
# Load the data for June into dataframe dfrwtanifinal
dfrwtanijun1 <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "A229:A258", col_names = "month_day")
dfrwtanijun1$month_day <- as.Date(as.character((dfrwtanijun1$month_day)))
dfrwtanijun2 <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "H229:H258", col_names = "y_2010")
dfrwtanijun <- cbind(dfrwtanijun1, dfrwtanijun2)
dfrwtanijun3 <- read_excel("TANIwith ESP2011.xlsm", sheet = "Summary", range = "H229:H258", col_names = "y_2011")
dfrwtanijun <- cbind(dfrwtanijun, dfrwtanijun3)
dfrwtanijun4 <- read_excel("TANIwith ESP2012.xlsm", sheet = "Summary", range = "I229:I258", col_names = "y_2012")
dfrwtanijun <- cbind(dfrwtanijun, dfrwtanijun4)
dfrwtanijun5 <- read_excel("TANIwith ESP2013.xlsm", sheet = "Summary", range = "I229:I258", col_names = "y_2013")
dfrwtanijun <- cbind(dfrwtanijun, dfrwtanijun5)
dfrwtanijun6 <- read_excel("TANIwith ESP2014.xlsm", sheet = "Summary", range = "I229:I258", col_names = "y_2014")
dfrwtanijun <- cbind(dfrwtanijun, dfrwtanijun6)
dfrwtanijun7 <- read_excel("TANIwith ESP2015.xlsm", sheet = "Summary", range = "I229:I258", col_names = "y_2015")
dfrwtanijun <- cbind(dfrwtanijun, dfrwtanijun7)
dfrwtanijun8 <- read_excel("TANIwith ESP2016.xlsm", sheet = "Summary", range = "I229:I258", col_names = "y_2016")
dfrwtanijun <- cbind(dfrwtanijun, dfrwtanijun8)
dfrwtanijun9 <- read_excel("TANIwith ESP2017.xlsm", sheet = "Summary", range = "I229:I258", col_names = "y_2017")
dfrwtanijun <- cbind(dfrwtanijun, dfrwtanijun9)
dfrwtanijun10 <- read_excel("TANIwithWSP2018.xlsm", sheet = "Summary", range = "K229:K258", col_names = "y_2018")
dfrwtanijun <- cbind(dfrwtanijun, dfrwtanijun10)
dfrwtanijun11 <- read_excel("TANIwithWSP2019.xlsm", sheet = "Summary", range = "K229:K258", col_names = "y_2019")
dfrwtanijun <- cbind(dfrwtanijun, dfrwtanijun11)
dfrwtanijun12 <- read_excel("TANIwithWSP2020.xlsm", sheet = "Summary", range = "K229:K258", col_names = "y_2020")
dfrwtanijun <- cbind(dfrwtanijun, dfrwtanijun12)
dfrwtanijun13 <- read_excel("TANIwithWSP2021.xlsm", sheet = "Summary", range = "K229:K258", col_names = "y_2021")
dfrwtanijun <- cbind(dfrwtanijun, dfrwtanijun13)
#
dfrwtanifinal <- rbind(dfrwtanifinal, dfrwtanijun)
#
# Load the data for July into dataframe dfrwtanifinal
dfrwtanijul1 <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "A260:A290", col_names = "month_day")
dfrwtanijul1$month_day <- as.Date(as.character((dfrwtanijul1$month_day)))
dfrwtanijul2 <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "H260:H290", col_names = "y_2010")
dfrwtanijul <- cbind(dfrwtanijul1, dfrwtanijul2)
dfrwtanijul3 <- read_excel("TANIwith ESP2011.xlsm", sheet = "Summary", range = "H260:H290", col_names = "y_2011")
dfrwtanijul <- cbind(dfrwtanijul, dfrwtanijul3)
dfrwtanijul4 <- read_excel("TANIwith ESP2012.xlsm", sheet = "Summary", range = "I260:I290", col_names = "y_2012")
dfrwtanijul <- cbind(dfrwtanijul, dfrwtanijul4)
dfrwtanijul5 <- read_excel("TANIwith ESP2013.xlsm", sheet = "Summary", range = "I260:I290", col_names = "y_2013")
dfrwtanijul <- cbind(dfrwtanijul, dfrwtanijul5)
dfrwtanijul6 <- read_excel("TANIwith ESP2014.xlsm", sheet = "Summary", range = "I260:I290", col_names = "y_2014")
dfrwtanijul <- cbind(dfrwtanijul, dfrwtanijul6)
dfrwtanijul7 <- read_excel("TANIwith ESP2015.xlsm", sheet = "Summary", range = "I260:I290", col_names = "y_2015")
dfrwtanijul <- cbind(dfrwtanijul, dfrwtanijul7)
dfrwtanijul8 <- read_excel("TANIwith ESP2016.xlsm", sheet = "Summary", range = "I260:I290", col_names = "y_2016")
dfrwtanijul <- cbind(dfrwtanijul, dfrwtanijul8)
dfrwtanijul9 <- read_excel("TANIwith ESP2017.xlsm", sheet = "Summary", range = "I260:I290", col_names = "y_2017")
dfrwtanijul <- cbind(dfrwtanijul, dfrwtanijul9)
dfrwtanijul10 <- read_excel("TANIwithWSP2018.xlsm", sheet = "Summary", range = "K260:K290", col_names = "y_2018")
dfrwtanijul <- cbind(dfrwtanijul, dfrwtanijul10)
dfrwtanijul11 <- read_excel("TANIwithWSP2019.xlsm", sheet = "Summary", range = "K260:K290", col_names = "y_2019")
dfrwtanijul <- cbind(dfrwtanijul, dfrwtanijul11)
dfrwtanijul12 <- read_excel("TANIwithWSP2020.xlsm", sheet = "Summary", range = "K260:K290", col_names = "y_2020")
dfrwtanijul <- cbind(dfrwtanijul, dfrwtanijul12)
dfrwtanijul13 <- read_excel("TANIwithWSP2021.xlsm", sheet = "Summary", range = "K260:K290", col_names = "y_2021")
dfrwtanijul <- cbind(dfrwtanijul, dfrwtanijul13)
#
dfrwtanifinal <- rbind(dfrwtanifinal, dfrwtanijul)
#
# Load the data for August into dataframe dfrwtanifinal
dfrwtaniaug1 <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "A292:A322", col_names = "month_day")
dfrwtaniaug1$month_day <- as.Date(as.character((dfrwtaniaug1$month_day)))
dfrwtaniaug2 <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "H292:H322", col_names = "y_2010")
dfrwtaniaug <- cbind(dfrwtaniaug1, dfrwtaniaug2)
dfrwtaniaug3 <- read_excel("TANIwith ESP2011.xlsm", sheet = "Summary", range = "H292:H322", col_names = "y_2011")
dfrwtaniaug <- cbind(dfrwtaniaug, dfrwtaniaug3)
dfrwtaniaug4 <- read_excel("TANIwith ESP2012.xlsm", sheet = "Summary", range = "I292:I322", col_names = "y_2012")
dfrwtaniaug <- cbind(dfrwtaniaug, dfrwtaniaug4)
dfrwtaniaug5 <- read_excel("TANIwith ESP2013.xlsm", sheet = "Summary", range = "I292:I322", col_names = "y_2013")
dfrwtaniaug <- cbind(dfrwtaniaug, dfrwtaniaug5)
dfrwtaniaug6 <- read_excel("TANIwith ESP2014.xlsm", sheet = "Summary", range = "I292:I322", col_names = "y_2014")
dfrwtaniaug <- cbind(dfrwtaniaug, dfrwtaniaug6)
dfrwtaniaug7 <- read_excel("TANIwith ESP2015.xlsm", sheet = "Summary", range = "I292:I322", col_names = "y_2015")
dfrwtaniaug <- cbind(dfrwtaniaug, dfrwtaniaug7)
dfrwtaniaug8 <- read_excel("TANIwith ESP2016.xlsm", sheet = "Summary", range = "I292:I322", col_names = "y_2016")
dfrwtaniaug <- cbind(dfrwtaniaug, dfrwtaniaug8)
dfrwtaniaug9 <- read_excel("TANIwith ESP2017.xlsm", sheet = "Summary", range = "I292:I322", col_names = "y_2017")
dfrwtaniaug <- cbind(dfrwtaniaug, dfrwtaniaug9)
dfrwtaniaug10 <- read_excel("TANIwithWSP2018.xlsm", sheet = "Summary", range = "K292:K322", col_names = "y_2018")
dfrwtaniaug <- cbind(dfrwtaniaug, dfrwtaniaug10)
dfrwtaniaug11 <- read_excel("TANIwithWSP2019.xlsm", sheet = "Summary", range = "K292:K322", col_names = "y_2019")
dfrwtaniaug <- cbind(dfrwtaniaug, dfrwtaniaug11)
dfrwtaniaug12 <- read_excel("TANIwithWSP2020.xlsm", sheet = "Summary", range = "K292:K322", col_names = "y_2020")
dfrwtaniaug <- cbind(dfrwtaniaug, dfrwtaniaug12)
dfrwtaniaug13 <- read_excel("TANIwithWSP2021.xlsm", sheet = "Summary", range = "K292:K322", col_names = "y_2021")
dfrwtaniaug <- cbind(dfrwtaniaug, dfrwtaniaug13)
#
dfrwtanifinal <- rbind(dfrwtanifinal, dfrwtaniaug)
#
# Load the data for September into dataframe dfrwtanifinal
dfrwtanisep1 <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "A324:A353", col_names = "month_day")
dfrwtanisep1$month_day <- as.Date(as.character((dfrwtanisep1$month_day)))
dfrwtanisep2 <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "H324:H353", col_names = "y_2010")
dfrwtanisep <- cbind(dfrwtanisep1, dfrwtanisep2)
dfrwtanisep3 <- read_excel("TANIwith ESP2011.xlsm", sheet = "Summary", range = "H324:H353", col_names = "y_2011")
dfrwtanisep <- cbind(dfrwtanisep, dfrwtanisep3)
dfrwtanisep4 <- read_excel("TANIwith ESP2012.xlsm", sheet = "Summary", range = "I324:I353", col_names = "y_2012")
dfrwtanisep <- cbind(dfrwtanisep, dfrwtanisep4)
dfrwtanisep5 <- read_excel("TANIwith ESP2013.xlsm", sheet = "Summary", range = "I324:I353", col_names = "y_2013")
dfrwtanisep <- cbind(dfrwtanisep, dfrwtanisep5)
dfrwtanisep6 <- read_excel("TANIwith ESP2014.xlsm", sheet = "Summary", range = "I324:I353", col_names = "y_2014")
dfrwtanisep <- cbind(dfrwtanisep, dfrwtanisep6)
dfrwtanisep7 <- read_excel("TANIwith ESP2015.xlsm", sheet = "Summary", range = "I324:I353", col_names = "y_2015")
dfrwtanisep <- cbind(dfrwtanisep, dfrwtanisep7)
dfrwtanisep8 <- read_excel("TANIwith ESP2016.xlsm", sheet = "Summary", range = "I324:I353", col_names = "y_2016")
dfrwtanisep <- cbind(dfrwtanisep, dfrwtanisep8)
dfrwtanisep9 <- read_excel("TANIwith ESP2017.xlsm", sheet = "Summary", range = "I324:I353", col_names = "y_2017")
dfrwtanisep <- cbind(dfrwtanisep, dfrwtanisep9)
dfrwtanisep10 <- read_excel("TANIwithWSP2018.xlsm", sheet = "Summary", range = "K324:K353", col_names = "y_2018")
dfrwtanisep <- cbind(dfrwtanisep, dfrwtanisep10)
dfrwtanisep11 <- read_excel("TANIwithWSP2019.xlsm", sheet = "Summary", range = "K324:K353", col_names = "y_2019")
dfrwtanisep <- cbind(dfrwtanisep, dfrwtanisep11)
dfrwtanisep12 <- read_excel("TANIwithWSP2020.xlsm", sheet = "Summary", range = "K324:K353", col_names = "y_2020")
dfrwtanisep <- cbind(dfrwtanisep, dfrwtanisep12)
dfrwtanisep13 <- read_excel("TANIwithWSP2021.xlsm", sheet = "Summary", range = "K324:K353", col_names = "y_2021")
dfrwtanisep <- cbind(dfrwtanisep, dfrwtanisep13)
#
dfrwtanifinal <- rbind(dfrwtanifinal, dfrwtanisep)
#
# Load the data for October into dataframe dfrwtanifinal
dfrwtanioct1 <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "A355:A385", col_names = "month_day")
dfrwtanioct1$month_day <- as.Date(as.character((dfrwtanioct1$month_day)))
dfrwtanioct2 <- read_excel("TANIwith ESP2010.xlsm", sheet = "Summary", range = "H355:H385", col_names = "y_2010")
dfrwtanioct <- cbind(dfrwtanioct1, dfrwtanioct2)
dfrwtanioct3 <- read_excel("TANIwith ESP2011.xlsm", sheet = "Summary", range = "H355:H385", col_names = "y_2011")
dfrwtanioct <- cbind(dfrwtanioct, dfrwtanioct3)
dfrwtanioct4 <- read_excel("TANIwith ESP2012.xlsm", sheet = "Summary", range = "I355:I385", col_names = "y_2012")
dfrwtanioct <- cbind(dfrwtanioct, dfrwtanioct4)
dfrwtanioct5 <- read_excel("TANIwith ESP2013.xlsm", sheet = "Summary", range = "I355:I385", col_names = "y_2013")
dfrwtanioct <- cbind(dfrwtanioct, dfrwtanioct5)
dfrwtanioct6 <- read_excel("TANIwith ESP2014.xlsm", sheet = "Summary", range = "I355:I385", col_names = "y_2014")
dfrwtanioct <- cbind(dfrwtanioct, dfrwtanioct6)
dfrwtanioct7 <- read_excel("TANIwith ESP2015.xlsm", sheet = "Summary", range = "I355:I385", col_names = "y_2015")
dfrwtanioct <- cbind(dfrwtanioct, dfrwtanioct7)
dfrwtanioct8 <- read_excel("TANIwith ESP2016.xlsm", sheet = "Summary", range = "I355:I385", col_names = "y_2016")
dfrwtanioct <- cbind(dfrwtanioct, dfrwtanioct8)
dfrwtanioct9 <- read_excel("TANIwith ESP2017.xlsm", sheet = "Summary", range = "I355:I385", col_names = "y_2017")
dfrwtanioct <- cbind(dfrwtanioct, dfrwtanioct9)
dfrwtanioct10 <- read_excel("TANIwithWSP2018.xlsm", sheet = "Summary", range = "K355:K385", col_names = "y_2018")
dfrwtanioct <- cbind(dfrwtanioct, dfrwtanioct10)
dfrwtanioct11 <- read_excel("TANIwithWSP2019.xlsm", sheet = "Summary", range = "K355:K385", col_names = "y_2019")
dfrwtanioct <- cbind(dfrwtanioct, dfrwtanioct11)
dfrwtanioct12 <- read_excel("TANIwithWSP2020.xlsm", sheet = "Summary", range = "K355:K385", col_names = "y_2020")
dfrwtanioct <- cbind(dfrwtanioct, dfrwtanioct12)
dfrwtanioct13 <- read_excel("TANIwithWSP2021.xlsm", sheet = "Summary", range = "K355:K385", col_names = "y_2021")
dfrwtanioct <- cbind(dfrwtanioct, dfrwtanioct13)
#
dfrwtanifinal <- rbind(dfrwtanifinal, dfrwtanioct)
#
# Load the data for November into dataframe dfrwtanifinal
dfrwtaninov1 <- read_excel("TANIwith ESP2011.xlsm", sheet = "Summary", range = "A9:A38", col_names = "month_day")
dfrwtaninov1$month_day <- as.Date(as.character((dfrwtaninov1$month_day)))
dfrwtaninov2 <- read_excel("TANIwith ESP2011.xlsm", sheet = "Summary", range = "H9:H38", col_names = "y_2010")
dfrwtaninov <- cbind(dfrwtaninov1, dfrwtaninov2)
dfrwtaninov3 <- read_excel("TANIwith ESP2012.xlsm", sheet = "Summary", range = "I9:I38", col_names = "y_2011")
dfrwtaninov <- cbind(dfrwtaninov, dfrwtaninov3)
dfrwtaninov4 <- read_excel("TANIwith ESP2013.xlsm", sheet = "Summary", range = "I9:I38", col_names = "y_2012")
dfrwtaninov <- cbind(dfrwtaninov, dfrwtaninov4)
dfrwtaninov5 <- read_excel("TANIwith ESP2014.xlsm", sheet = "Summary", range = "I9:I38", col_names = "y_2013")
dfrwtaninov <- cbind(dfrwtaninov, dfrwtaninov5)
dfrwtaninov6 <- read_excel("TANIwith ESP2015.xlsm", sheet = "Summary", range = "I9:I38", col_names = "y_2014")
dfrwtaninov <- cbind(dfrwtaninov, dfrwtaninov6)
dfrwtaninov7 <- read_excel("TANIwith ESP2016.xlsm", sheet = "Summary", range = "I9:I38", col_names = "y_2015")
dfrwtaninov <- cbind(dfrwtaninov, dfrwtaninov7)
dfrwtaninov8 <- read_excel("TANIwith ESP2017.xlsm", sheet = "Summary", range = "I9:I38", col_names = "y_2016")
dfrwtaninov <- cbind(dfrwtaninov, dfrwtaninov8)
dfrwtaninov9 <- read_excel("TANIwithWSP2018.xlsm", sheet = "Summary", range = "K9:K38", col_names = "y_2017")
dfrwtaninov <- cbind(dfrwtaninov, dfrwtaninov9)
dfrwtaninov10 <- read_excel("TANIwithWSP2019.xlsm", sheet = "Summary", range = "K9:K38", col_names = "y_2018")
dfrwtaninov <- cbind(dfrwtaninov, dfrwtaninov10)
dfrwtaninov11 <- read_excel("TANIwithWSP2020.xlsm", sheet = "Summary", range = "K9:K38", col_names = "y_2019")
dfrwtaninov <- cbind(dfrwtaninov, dfrwtaninov11)
dfrwtaninov12 <- read_excel("TANIwithWSP2021.xlsm", sheet = "Summary", range = "K9:K38", col_names = "y_2020")
dfrwtaninov <- cbind(dfrwtaninov, dfrwtaninov12)
dfrwtaninov13 <- read_excel("TANIwithWSP2022.xlsm", sheet = "Summary", range = "K9:K38", col_names = "y_2021")
dfrwtaninov <- cbind(dfrwtaninov, dfrwtaninov13)
#
dfrwtanifinal <- rbind(dfrwtanifinal, dfrwtaninov)
#
# Load the data for December into dataframe dfrwtanifinal
dfrwtanidec1 <- read_excel("TANIwith ESP2011.xlsm", sheet = "Summary", range = "A40:A70", col_names = "month_day")
dfrwtanidec1$month_day <- as.Date(as.character((dfrwtanidec1$month_day)))
dfrwtanidec2 <- read_excel("TANIwith ESP2011.xlsm", sheet = "Summary", range = "H40:H70", col_names = "y_2010")
dfrwtanidec <- cbind(dfrwtanidec1, dfrwtanidec2)
dfrwtanidec3 <- read_excel("TANIwith ESP2012.xlsm", sheet = "Summary", range = "I40:I70", col_names = "y_2011")
dfrwtanidec <- cbind(dfrwtanidec, dfrwtanidec3)
dfrwtanidec4 <- read_excel("TANIwith ESP2013.xlsm", sheet = "Summary", range = "I40:I70", col_names = "y_2012")
dfrwtanidec <- cbind(dfrwtanidec, dfrwtanidec4)
dfrwtanidec5 <- read_excel("TANIwith ESP2014.xlsm", sheet = "Summary", range = "I40:I70", col_names = "y_2013")
dfrwtanidec <- cbind(dfrwtanidec, dfrwtanidec5)
dfrwtanidec6 <- read_excel("TANIwith ESP2015.xlsm", sheet = "Summary", range = "I40:I70", col_names = "y_2014")
dfrwtanidec <- cbind(dfrwtanidec, dfrwtanidec6)
dfrwtanidec7 <- read_excel("TANIwith ESP2016.xlsm", sheet = "Summary", range = "I40:I70", col_names = "y_2015")
dfrwtanidec <- cbind(dfrwtanidec, dfrwtanidec7)
dfrwtanidec8 <- read_excel("TANIwith ESP2017.xlsm", sheet = "Summary", range = "I40:I70", col_names = "y_2016")
dfrwtanidec <- cbind(dfrwtanidec, dfrwtanidec8)
dfrwtanidec9 <- read_excel("TANIwithWSP2018.xlsm", sheet = "Summary", range = "K40:K70", col_names = "y_2017")
dfrwtanidec <- cbind(dfrwtanidec, dfrwtanidec9)
dfrwtanidec10 <- read_excel("TANIwithWSP2019.xlsm", sheet = "Summary", range = "K40:K70", col_names = "y_2018")
dfrwtanidec <- cbind(dfrwtanidec, dfrwtanidec10)
dfrwtanidec11 <- read_excel("TANIwithWSP2020.xlsm", sheet = "Summary", range = "K40:K70", col_names = "y_2019")
dfrwtanidec <- cbind(dfrwtanidec, dfrwtanidec11)
dfrwtanidec12 <- read_excel("TANIwithWSP2021.xlsm", sheet = "Summary", range = "K40:K70", col_names = "y_2020")
dfrwtanidec <- cbind(dfrwtanidec, dfrwtanidec12)
dfrwtanidec13 <- read_excel("TANIwithWSP2022.xlsm", sheet = "Summary", range = "K40:K70", col_names = "y_2021")
dfrwtanidec <- cbind(dfrwtanidec, dfrwtanidec13)
#
dfrwtanifinal <- rbind(dfrwtanifinal, dfrwtanidec)
#
# The values from the workbooks are negative, change them to positive. They are inflows to the treatment plant and come in negative because they are outflows from the reservoir.
# 
dfrwtanifinal[, 2:13] <- dfrwtanifinal[, 2:13] * -1
#
# Replace all NA values with 0
#
dfrwtanifinal[, 2:13] <- lapply(dfrwtanifinal[, 2:13], function(x) replace(x, is.na(x), 0))
#
View(dfrwtanifinal)
#
# Add the West Gravel Lakes and Tani dataframes and store the result in dfrwfinal.
# (Code from: https://stackoverflow.com/questions/30516094/r-add-two-data-frames-with-same-dimensions)
# 
dfrwfinal <- dfrwwglfinal %>% select(-month_day) %>% add(dfrwtanifinal %>% select(-month_day)) %>% mutate(type = dfrwtanifinal$type)
#
#Add the month_day column to dfrwfinal (code here: https://www.marsja.se/how-to-add-a-column-to-dataframe-in-r-with-tibble-dplyr/ and
# here (https://www.marsja.se/how-to-add-a-column-to-dataframe-in-r-with-tibble-dplyr/)). order here (
# https://stackoverflow.com/questions/5620885/how-does-one-reorder-columns-in-a-data-frame)
#
dfrwfinal$month_day <- dfrwwglfinal$month_day
#
#Move the month_day column to the first column
#
dfrwfinal <- dfrwfinal %>% select(month_day, everything())
#
# Used during testing
View(dfrwfinal)
#
# Read the workbooks and create a new dataframe with the values from Excel. Workbook name = Stan2010(4-party).xlsm.
# The next lines of code build a dataframe named dfrwslfinal that is merged with dfrwwglfinal (the
# dataframe for West Gravel Lakes) and dfrwslfinal (the dataframe for Standley Lake) into dfrwfinal.
#
# Load the data for January into dataframe dfrwtanifinal
dfrwsljan1 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "A72:A102", col_names = "month_day")
dfrwsljan1$month_day <- as.Date(as.character((dfrwtanijan1$month_day)))
dfrwsljan2 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "R72:R102", col_names = "y_2010")
dfrwslfinal <- cbind(dfrwsljan1, dfrwsljan2)
dfrwsljan3 <- read_excel("Stan2011(decree).xlsm", sheet = "Summary", range = "R72:R102", col_names = "y_2011")
dfrwslfinal <- cbind(dfrwslfinal, dfrwsljan3)
dfrwsljan4 <- read_excel("Stan2012(decree).xlsm", sheet = "Summary", range = "R72:R102", col_names = "y_2012")
dfrwslfinal <- cbind(dfrwslfinal, dfrwsljan4)
dfrwsljan5 <- read_excel("Stan2013(decree).xlsm", sheet = "Summary", range = "R72:R102", col_names = "y_2013")
dfrwslfinal <- cbind(dfrwslfinal, dfrwsljan5)
dfrwsljan6 <- read_excel("Stan2014(decree).xlsm", sheet = "Summary", range = "R72:R102", col_names = "y_2014")
dfrwslfinal <- cbind(dfrwslfinal, dfrwsljan6)
dfrwsljan7 <- read_excel("Stan2015(decree).xlsm", sheet = "Summary", range = "R72:R102", col_names = "y_2015")
dfrwslfinal <- cbind(dfrwslfinal, dfrwsljan7)
dfrwsljan8 <- read_excel("Stan2016(decree).xlsm", sheet = "Summary", range = "R72:R102", col_names = "y_2016")
dfrwslfinal <- cbind(dfrwslfinal, dfrwsljan8)
dfrwsljan9 <- read_excel("Stan2017(decree).xlsm", sheet = "Summary", range = "R72:R102", col_names = "y_2017")
dfrwslfinal <- cbind(dfrwslfinal, dfrwsljan9)
dfrwsljan10 <- read_excel("Stan2018(decree).xlsm", sheet = "Summary", range = "R72:R102", col_names = "y_2018")
dfrwslfinal <- cbind(dfrwslfinal, dfrwsljan10)
dfrwsljan11 <- read_excel("Stan2019(decree).xlsm", sheet = "Summary", range = "R72:R102", col_names = "y_2019")
dfrwslfinal <- cbind(dfrwslfinal, dfrwsljan11)
dfrwsljan12 <- read_excel("Stan2020(decree).xlsm", sheet = "Summary", range = "R72:R102", col_names = "y_2020")
dfrwslfinal <- cbind(dfrwslfinal, dfrwsljan12)
dfrwsljan13 <- read_excel("Stan2021(decree).xlsm", sheet = "Summary", range = "R72:R102", col_names = "y_2021")
dfrwslfinal <- cbind(dfrwslfinal, dfrwsljan13)
#
# Load the data for February into dataframe dfrwslfinal
#
# To get February 29th in non-leap years read the data from WGL2012.xlsm, a leap year.
dfrwslfeb1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A104:A132", col_names = "month_day")
dfrwslfeb1$month_day <- as.Date(as.character((dfrwslfeb1$month_day)))
dfrwslfeb2 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "R104:R132", col_names = "y_2010")
dfrwslfeb <- cbind(dfrwslfeb1, dfrwslfeb2)
dfrwslfeb3 <- read_excel("Stan2011(decree).xlsm", sheet = "Summary", range = "R104:R132", col_names = "y_2011")
dfrwslfeb <- cbind(dfrwslfeb, dfrwslfeb3)
dfrwslfeb4 <- read_excel("Stan2012(decree).xlsm", sheet = "Summary", range = "R104:R132", col_names = "y_2012")
dfrwslfeb <- cbind(dfrwslfeb, dfrwslfeb4)
dfrwslfeb5 <- read_excel("Stan2013(decree).xlsm", sheet = "Summary", range = "R104:R132", col_names = "y_2013")
dfrwslfeb <- cbind(dfrwslfeb, dfrwslfeb5)
dfrwslfeb6 <- read_excel("Stan2014(decree).xlsm", sheet = "Summary", range = "R104:R132", col_names = "y_2014")
dfrwslfeb <- cbind(dfrwslfeb, dfrwslfeb6)
dfrwslfeb7 <- read_excel("Stan2015(decree).xlsm", sheet = "Summary", range = "R104:R132", col_names = "y_2015")
dfrwslfeb <- cbind(dfrwslfeb, dfrwslfeb7)
dfrwslfeb8 <- read_excel("Stan2016(decree).xlsm", sheet = "Summary", range = "R104:R132", col_names = "y_2016")
dfrwslfeb <- cbind(dfrwslfeb, dfrwslfeb8)
dfrwslfeb9 <- read_excel("Stan2017(decree).xlsm", sheet = "Summary", range = "R104:R132", col_names = "y_2017")
dfrwslfeb <- cbind(dfrwslfeb, dfrwslfeb9)
dfrwslfeb10 <- read_excel("Stan2018(decree).xlsm", sheet = "Summary", range = "R104:R132", col_names = "y_2018")
dfrwslfeb <- cbind(dfrwslfeb, dfrwslfeb10)
dfrwslfeb11 <- read_excel("Stan2019(decree).xlsm", sheet = "Summary", range = "R104:R132", col_names = "y_2019")
dfrwslfeb <- cbind(dfrwslfeb, dfrwslfeb11)
dfrwslfeb12 <- read_excel("Stan2020(decree).xlsm", sheet = "Summary", range = "R104:R132", col_names = "y_2020")
dfrwslfeb <- cbind(dfrwslfeb, dfrwslfeb12)
dfrwslfeb13 <- read_excel("Stan2021(decree).xlsm", sheet = "Summary", range = "R104:R132", col_names = "y_2021")
dfrwslfeb <- cbind(dfrwslfeb, dfrwslfeb13)
#
dfrwslfinal <- rbind(dfrwslfinal, dfrwslfeb)
# #
# # Load the data for March into dataframe dfrwslfinal
dfrwslmar1 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "A134:A164", col_names = "month_day")
dfrwslmar1$month_day <- as.Date(as.character((dfrwslmar1$month_day)))
dfrwslmar2 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "R134:R164", col_names = "y_2010")
dfrwslmar <- cbind(dfrwslmar1, dfrwslmar2)
dfrwslmar3 <- read_excel("Stan2011(decree).xlsm", sheet = "Summary", range = "R134:R164", col_names = "y_2011")
dfrwslmar <- cbind(dfrwslmar, dfrwslmar3)
dfrwslmar4 <- read_excel("Stan2012(decree).xlsm", sheet = "Summary", range = "R134:R164", col_names = "y_2012")
dfrwslmar <- cbind(dfrwslmar, dfrwslmar4)
dfrwslmar5 <- read_excel("Stan2013(decree).xlsm", sheet = "Summary", range = "R134:R164", col_names = "y_2013")
dfrwslmar <- cbind(dfrwslmar, dfrwslmar5)
dfrwslmar6 <- read_excel("Stan2014(decree).xlsm", sheet = "Summary", range = "R134:R164", col_names = "y_2014")
dfrwslmar <- cbind(dfrwslmar, dfrwslmar6)
dfrwslmar7 <- read_excel("Stan2015(decree).xlsm", sheet = "Summary", range = "R134:R164", col_names = "y_2015")
dfrwslmar <- cbind(dfrwslmar, dfrwslmar7)
dfrwslmar8 <- read_excel("Stan2016(decree).xlsm", sheet = "Summary", range = "R134:R164", col_names = "y_2016")
dfrwslmar <- cbind(dfrwslmar, dfrwslmar8)
dfrwslmar9 <- read_excel("Stan2017(decree).xlsm", sheet = "Summary", range = "R134:R164", col_names = "y_2017")
dfrwslmar <- cbind(dfrwslmar, dfrwslmar9)
dfrwslmar10 <- read_excel("Stan2018(decree).xlsm", sheet = "Summary", range = "R134:R164", col_names = "y_2018")
dfrwslmar <- cbind(dfrwslmar, dfrwslmar10)
dfrwslmar11 <- read_excel("Stan2019(decree).xlsm", sheet = "Summary", range = "R134:R164", col_names = "y_2019")
dfrwslmar <- cbind(dfrwslmar, dfrwslmar11)
dfrwslmar12 <- read_excel("Stan2020(decree).xlsm", sheet = "Summary", range = "R134:R164", col_names = "y_2020")
dfrwslmar <- cbind(dfrwslmar, dfrwslmar12)
dfrwslmar13 <- read_excel("Stan2021(decree).xlsm", sheet = "Summary", range = "R134:R164", col_names = "y_2021")
dfrwslmar <- cbind(dfrwslmar, dfrwslmar13)
#
dfrwslfinal <- rbind(dfrwslfinal, dfrwslmar)
#
# Load the data for April into dataframe dfrwslfinal
dfrwslapr1 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "A166:A195", col_names = "month_day")
dfrwslapr1$month_day <- as.Date(as.character((dfrwslapr1$month_day)))
dfrwslapr2 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "R166:R195", col_names = "y_2010")
dfrwslapr <- cbind(dfrwslapr1, dfrwslapr2)
dfrwslapr3 <- read_excel("Stan2011(decree).xlsm", sheet = "Summary", range = "R166:R195", col_names = "y_2011")
dfrwslapr <- cbind(dfrwslapr, dfrwslapr3)
dfrwslapr4 <- read_excel("Stan2012(decree).xlsm", sheet = "Summary", range = "R166:R195", col_names = "y_2012")
dfrwslapr <- cbind(dfrwslapr, dfrwslapr4)
dfrwslapr5 <- read_excel("Stan2013(decree).xlsm", sheet = "Summary", range = "R166:R195", col_names = "y_2013")
dfrwslapr <- cbind(dfrwslapr, dfrwslapr5)
dfrwslapr6 <- read_excel("Stan2014(decree).xlsm", sheet = "Summary", range = "R166:R195", col_names = "y_2014")
dfrwslapr <- cbind(dfrwslapr, dfrwslapr6)
dfrwslapr7 <- read_excel("Stan2015(decree).xlsm", sheet = "Summary", range = "R166:R195", col_names = "y_2015")
dfrwslapr <- cbind(dfrwslapr, dfrwslapr7)
dfrwslapr8 <- read_excel("Stan2016(decree).xlsm", sheet = "Summary", range = "R166:R195", col_names = "y_2016")
dfrwslapr <- cbind(dfrwslapr, dfrwslapr8)
dfrwslapr9 <- read_excel("Stan2017(decree).xlsm", sheet = "Summary", range = "R166:R195", col_names = "y_2017")
dfrwslapr <- cbind(dfrwslapr, dfrwslapr9)
dfrwslapr10 <- read_excel("Stan2018(decree).xlsm", sheet = "Summary", range = "R166:R195", col_names = "y_2018")
dfrwslapr <- cbind(dfrwslapr, dfrwslapr10)
dfrwslapr11 <- read_excel("Stan2019(decree).xlsm", sheet = "Summary", range = "R166:R195", col_names = "y_2019")
dfrwslapr <- cbind(dfrwslapr, dfrwslapr11)
dfrwslapr12 <- read_excel("Stan2020(decree).xlsm", sheet = "Summary", range = "R166:R195", col_names = "y_2020")
dfrwslapr <- cbind(dfrwslapr, dfrwslapr12)
dfrwslapr13 <- read_excel("Stan2021(decree).xlsm", sheet = "Summary", range = "R166:R195", col_names = "y_2021")
dfrwslapr <- cbind(dfrwslapr, dfrwslapr13)
#
dfrwslfinal <- rbind(dfrwslfinal, dfrwslapr)
#
# Load the data for May into dataframe dfrwslfinal
dfrwslmay1 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "A197:A227", col_names = "month_day")
dfrwslmay1$month_day <- as.Date(as.character((dfrwslmay1$month_day)))
dfrwslmay2 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "R197:R227", col_names = "y_2010")
dfrwslmay <- cbind(dfrwslmay1, dfrwslmay2)
dfrwslmay3 <- read_excel("Stan2011(decree).xlsm", sheet = "Summary", range = "R197:R227", col_names = "y_2011")
dfrwslmay <- cbind(dfrwslmay, dfrwslmay3)
dfrwslmay4 <- read_excel("Stan2012(decree).xlsm", sheet = "Summary", range = "R197:R227", col_names = "y_2012")
dfrwslmay <- cbind(dfrwslmay, dfrwslmay4)
dfrwslmay5 <- read_excel("Stan2013(decree).xlsm", sheet = "Summary", range = "R197:R227", col_names = "y_2013")
dfrwslmay <- cbind(dfrwslmay, dfrwslmay5)
dfrwslmay6 <- read_excel("Stan2014(decree).xlsm", sheet = "Summary", range = "R197:R227", col_names = "y_2014")
dfrwslmay <- cbind(dfrwslmay, dfrwslmay6)
dfrwslmay7 <- read_excel("Stan2015(decree).xlsm", sheet = "Summary", range = "R197:R227", col_names = "y_2015")
dfrwslmay <- cbind(dfrwslmay, dfrwslmay7)
dfrwslmay8 <- read_excel("Stan2016(decree).xlsm", sheet = "Summary", range = "R197:R227", col_names = "y_2016")
dfrwslmay <- cbind(dfrwslmay, dfrwslmay8)
dfrwslmay9 <- read_excel("Stan2017(decree).xlsm", sheet = "Summary", range = "R197:R227", col_names = "y_2017")
dfrwslmay <- cbind(dfrwslmay, dfrwslmay9)
dfrwslmay10 <- read_excel("Stan2018(decree).xlsm", sheet = "Summary", range = "R197:R227", col_names = "y_2018")
dfrwslmay <- cbind(dfrwslmay, dfrwslmay10)
dfrwslmay11 <- read_excel("Stan2019(decree).xlsm", sheet = "Summary", range = "R197:R227", col_names = "y_2019")
dfrwslmay <- cbind(dfrwslmay, dfrwslmay11)
dfrwslmay12 <- read_excel("Stan2020(decree).xlsm", sheet = "Summary", range = "R197:R227", col_names = "y_2020")
dfrwslmay <- cbind(dfrwslmay, dfrwslmay12)
dfrwslmay13 <- read_excel("Stan2021(decree).xlsm", sheet = "Summary", range = "R197:R227", col_names = "y_2021")
dfrwslmay <- cbind(dfrwslmay, dfrwslmay13)
#
dfrwslfinal <- rbind(dfrwslfinal, dfrwslmay)
#
# Load the data for June into dataframe dfrwslfinal
dfrwsljun1 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "A229:A258", col_names = "month_day")
dfrwsljun1$month_day <- as.Date(as.character((dfrwsljun1$month_day)))
dfrwsljun2 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2010")
dfrwsljun <- cbind(dfrwsljun1, dfrwsljun2)
dfrwsljun3 <- read_excel("Stan2011(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2011")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun3)
dfrwsljun4 <- read_excel("Stan2012(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2012")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun4)
dfrwsljun5 <- read_excel("Stan2013(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2013")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun5)
dfrwsljun6 <- read_excel("Stan2014(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2014")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun6)
dfrwsljun7 <- read_excel("Stan2015(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2015")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun7)
dfrwsljun8 <- read_excel("Stan2016(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2016")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun8)
dfrwsljun9 <- read_excel("Stan2017(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2017")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun9)
dfrwsljun10 <- read_excel("Stan2018(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2018")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun10)
dfrwsljun11 <- read_excel("Stan2019(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2019")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun11)
dfrwsljun12 <- read_excel("Stan2020(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2020")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun12)
dfrwsljun13 <- read_excel("Stan2021(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2021")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun13)
#
dfrwslfinal <- rbind(dfrwslfinal, dfrwsljun)
#
# Load the data for July into dataframe dfrwslfinal
dfrwsljul1 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "A260:A290", col_names = "month_day")
dfrwsljul1$month_day <- as.Date(as.character((dfrwsljul1$month_day)))
dfrwsljul2 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2010")
dfrwsljul <- cbind(dfrwsljul1, dfrwsljul2)
dfrwsljul3 <- read_excel("Stan2011(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2011")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul3)
dfrwsljul4 <- read_excel("Stan2012(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2012")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul4)
dfrwsljul5 <- read_excel("Stan2013(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2013")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul5)
dfrwsljul6 <- read_excel("Stan2014(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2014")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul6)
dfrwsljul7 <- read_excel("Stan2015(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2015")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul7)
dfrwsljul8 <- read_excel("Stan2016(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2016")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul8)
dfrwsljul9 <- read_excel("Stan2017(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2017")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul9)
dfrwsljul10 <- read_excel("Stan2018(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2018")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul10)
dfrwsljul11 <- read_excel("Stan2019(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2019")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul11)
dfrwsljul12 <- read_excel("Stan2020(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2020")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul12)
dfrwsljul13 <- read_excel("Stan2021(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2021")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul13)
#
dfrwslfinal <- rbind(dfrwslfinal, dfrwsljul)
#
# Load the data for August into dataframe dfrwslfinal
dfrwslaug1 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "A292:A322", col_names = "month_day")
dfrwslaug1$month_day <- as.Date(as.character((dfrwslaug1$month_day)))
dfrwslaug2 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2010")
dfrwslaug <- cbind(dfrwslaug1, dfrwslaug2)
dfrwslaug3 <- read_excel("Stan2011(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2011")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug3)
dfrwslaug4 <- read_excel("Stan2012(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2012")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug4)
dfrwslaug5 <- read_excel("Stan2013(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2013")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug5)
dfrwslaug6 <- read_excel("Stan2014(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2014")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug6)
dfrwslaug7 <- read_excel("Stan2015(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2015")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug7)
dfrwslaug8 <- read_excel("Stan2016(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2016")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug8)
dfrwslaug9 <- read_excel("Stan2017(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2017")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug9)
dfrwslaug10 <- read_excel("Stan2018(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2018")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug10)
dfrwslaug11 <- read_excel("Stan2019(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2019")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug11)
dfrwslaug12 <- read_excel("Stan2020(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2020")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug12)
dfrwslaug13 <- read_excel("Stan2021(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2021")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug13)
#
dfrwslfinal <- rbind(dfrwslfinal, dfrwslaug)
#
# Load the data for September into dataframe dfrwslfinal
dfrwslsep1 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "A324:A353", col_names = "month_day")
dfrwslsep1$month_day <- as.Date(as.character((dfrwslsep1$month_day)))
dfrwslsep2 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2010")
dfrwslsep <- cbind(dfrwslsep1, dfrwslsep2)
dfrwslsep3 <- read_excel("Stan2011(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2011")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep3)
dfrwslsep4 <- read_excel("Stan2012(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2012")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep4)
dfrwslsep5 <- read_excel("Stan2013(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2013")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep5)
dfrwslsep6 <- read_excel("Stan2014(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2014")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep6)
dfrwslsep7 <- read_excel("Stan2015(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2015")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep7)
dfrwslsep8 <- read_excel("Stan2016(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2016")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep8)
dfrwslsep9 <- read_excel("Stan2017(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2017")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep9)
dfrwslsep10 <- read_excel("Stan2018(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2018")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep10)
dfrwslsep11 <- read_excel("Stan2019(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2019")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep11)
dfrwslsep12 <- read_excel("Stan2020(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2020")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep12)
dfrwslsep13 <- read_excel("Stan2021(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2021")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep13)
#
dfrwslfinal <- rbind(dfrwslfinal, dfrwslsep)
#
# Load the data for October into dataframe dfrwslfinal
dfrwsloct1 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "A355:A385", col_names = "month_day")
dfrwsloct1$month_day <- as.Date(as.character((dfrwsloct1$month_day)))
dfrwsloct2 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2010")
dfrwsloct <- cbind(dfrwsloct1, dfrwsloct2)
dfrwsloct3 <- read_excel("Stan2011(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2011")
dfrwsloct <- cbind(dfrwsloct, dfrwsloct3)
dfrwsloct4 <- read_excel("Stan2012(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2012")
dfrwsloct <- cbind(dfrwsloct, dfrwsloct4)
dfrwsloct5 <- read_excel("Stan2013(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2013")
dfrwsloct <- cbind(dfrwsloct, dfrwsloct5)
dfrwsloct6 <- read_excel("Stan2014(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2014")
dfrwsloct <- cbind(dfrwsloct, dfrwsloct6)
dfrwsloct7 <- read_excel("Stan2015(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2015")
dfrwsloct <- cbind(dfrwsloct, dfrwsloct7)
dfrwsloct8 <- read_excel("Stan2016(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2016")
dfrwsloct <- cbind(dfrwsloct, dfrwsloct8)
dfrwsloct9 <- read_excel("Stan2017(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2017")
dfrwsloct <- cbind(dfrwsloct, dfrwsloct9)
dfrwsloct10 <- read_excel("Stan2018(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2018")
dfrwsloct <- cbind(dfrwsloct, dfrwsloct10)
dfrwsloct11 <- read_excel("Stan2019(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2019")
dfrwsloct <- cbind(dfrwsloct, dfrwsloct11)
dfrwsloct12 <- read_excel("Stan2020(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2020")
dfrwsloct <- cbind(dfrwsloct, dfrwsloct12)
dfrwsloct13 <- read_excel("Stan2021(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2021")
dfrwsloct <- cbind(dfrwsloct, dfrwsloct13)
#
dfrwslfinal <- rbind(dfrwslfinal, dfrwsloct)
#
# Load the data for November into dataframe dfrwslfinal. The Accounting is on a water year basin so to get 
# November and December the data is in the next water year. e.g. for calendar year 2010 November and
# December are in the water year 2011 workbook.
# 
dfrwslnov1 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "A9:A38", col_names = "month_day")
dfrwslnov1$month_day <- as.Date(as.character((dfrwslnov1$month_day)))
dfrwslnov2 <- read_excel("Stan2011(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2010")
dfrwslnov <- cbind(dfrwslnov1, dfrwslnov2)
dfrwslnov3 <- read_excel("Stan2012(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2011")
dfrwslnov <- cbind(dfrwslnov, dfrwslnov3)
dfrwslnov4 <- read_excel("Stan2013(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2012")
dfrwslnov <- cbind(dfrwslnov, dfrwslnov4)
dfrwslnov5 <- read_excel("Stan2014(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2013")
dfrwslnov <- cbind(dfrwslnov, dfrwslnov5)
dfrwslnov6 <- read_excel("Stan2015(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2014")
dfrwslnov <- cbind(dfrwslnov, dfrwslnov6)
dfrwslnov7 <- read_excel("Stan2016(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2015")
dfrwslnov <- cbind(dfrwslnov, dfrwslnov7)
dfrwslnov8 <- read_excel("Stan2017(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2016")
dfrwslnov <- cbind(dfrwslnov, dfrwslnov8)
dfrwslnov9 <- read_excel("Stan2018(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2017")
dfrwslnov <- cbind(dfrwslnov, dfrwslnov9)
dfrwslnov10 <- read_excel("Stan2019(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2018")
dfrwslnov <- cbind(dfrwslnov, dfrwslnov10)
dfrwslnov11 <- read_excel("Stan2020(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2019")
dfrwslnov <- cbind(dfrwslnov, dfrwslnov11)
dfrwslnov12 <- read_excel("Stan2021(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2020")
dfrwslnov <- cbind(dfrwslnov, dfrwslnov12)
dfrwslnov13 <- read_excel("Stan2022(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2021")
dfrwslnov <- cbind(dfrwslnov, dfrwslnov13)
#
dfrwslfinal <- rbind(dfrwslfinal, dfrwslnov)
#
# Load the data for December into dataframe dfrwslfinal. The Accounting is on a water year basin so to get 
# November and December the data is in the next water year. e.g. for calendar year 2010 November and
# December are in the water year 2011 workbook.
#  
dfrwsldec1 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "A40:A70", col_names = "month_day")
dfrwsldec1$month_day <- as.Date(as.character((dfrwsldec1$month_day)))
dfrwsldec2 <- read_excel("Stan2011(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2010")
dfrwsldec <- cbind(dfrwsldec1, dfrwsldec2)
dfrwsldec3 <- read_excel("Stan2012(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2011")
dfrwsldec <- cbind(dfrwsldec, dfrwsldec3)
dfrwsldec4 <- read_excel("Stan2013(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2012")
dfrwsldec <- cbind(dfrwsldec, dfrwsldec4)
dfrwsldec5 <- read_excel("Stan2014(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2013")
dfrwsldec <- cbind(dfrwsldec, dfrwsldec5)
dfrwsldec6 <- read_excel("Stan2015(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2014")
dfrwsldec <- cbind(dfrwsldec, dfrwsldec6)
dfrwsldec7 <- read_excel("Stan2016(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2015")
dfrwsldec <- cbind(dfrwsldec, dfrwsldec7)
dfrwsldec8 <- read_excel("Stan2017(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2016")
dfrwsldec <- cbind(dfrwsldec, dfrwsldec8)
dfrwsldec9 <- read_excel("Stan2018(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2017")
dfrwsldec <- cbind(dfrwsldec, dfrwsldec9)
dfrwsldec10 <- read_excel("Stan2019(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2018")
dfrwsldec <- cbind(dfrwsldec, dfrwsldec10)
dfrwsldec11 <- read_excel("Stan2020(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2019")
dfrwsldec <- cbind(dfrwsldec, dfrwsldec11)
dfrwsldec12 <- read_excel("Stan2021(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2020")
dfrwsldec <- cbind(dfrwsldec, dfrwsldec12)
dfrwsldec13 <- read_excel("Stan2022(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2021")
dfrwsldec <- cbind(dfrwsldec, dfrwsldec13)
#
dfrwslfinal <- rbind(dfrwslfinal, dfrwsldec)
#
# # The values from the workbooks are negative, change them to positive. They are inflows to the treatment plant and come in negative because they are outflows from the reservoir.
# 
dfrwslfinal[, 2:13] <- dfrwslfinal[, 2:13] * -1
#
# Replace all NA values with 0
#
dfrwslfinal[, 2:13] <- lapply(dfrwslfinal[, 2:13], function(x) replace(x, is.na(x), 0))
#
View(dfrwslfinal)
#
# Add dfrwslfinal and dfrwfinal to complete the data set. Values are added because dfrwfinal is the summary for all draws on raw water.
# 
dfrwfinal <- dfrwfinal %>% select(-month_day) %>% add(dfrwslfinal %>% select(-month_day)) %>% mutate(type = dfrwslfinal$type)
#dfrwfinal <- dfrwwglfinal %>% select(-month_day) %>% add(dfrwtanifinal %>% select(-month_day)) %>% mutate(type = dfrwtanifinal$type)
#
# add the month_day column to dfrwfinal
# 
dfrwfinal$month_day <- dfrwwglfinal$month_day
#
# Reorder dfrwfinal columns to move month_day to the first column
dfrwfinal <- dfrwfinal %>% select(month_day, everything())
#
# # Compute the mean for each day over all the years ignoring zeros
# #
# #dfrwslfinal$mean = apply(dfrwslfinal[, 2:13], 1, function(x) mean(x[x>0]))
# #
# # Computing the mean on February 29th with all zero values for WGL  returns NaN. Hoping that this will clear up when there are not treatment values = 0 with all workbooks.
# # 
# # Compute the median for each day over all the years ignoring zeros
# #
# #dfrwslfinal$median = apply(dfrwslfinal[, 2:13], 1, function(x) median(x[x>0]))
# #
# # Computing the median on February 29th with all zero values for WGL  returns NA. Hoping that this will clear up when there are not treatment values = 0 with all workbooks.
# #
# # Determine the maximum by day over all of the days ignoring zeros
# #dfrwslfinal$maximum <- apply(dfrwslfinal[, 2:13], 1, function(x) max(x[x>=0]))
# # 
# # Determine the maximum by day over all of the days ignoring zeros
# #dfrwslfinal$minimum <- apply(dfrwslfinal[, 2:13], 1, function(x) min(x[x>=0]))
# #
# 
# #

