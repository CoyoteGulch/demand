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
library(dplyr)
#
# Read the workbook and create a new dataframe with the values from Excel.
#
# Load the data for January into dataframe dfrwfinal
dfrwjan1 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "A72:A102", col_names = "month_day")
dfrwjan1$month_day <- as.Date(as.character((dfrwjan1$month_day)))
dfrwjan2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2010")
dfrwfinal <- cbind(dfrwjan1, dfrwjan2)
dfrwjan3 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2011")
dfrwfinal <- cbind(dfrwfinal, dfrwjan3)
dfrwjan4 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2012")
dfrwfinal <- cbind(dfrwfinal, dfrwjan4)
dfrwjan5 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2013")
dfrwfinal <- cbind(dfrwfinal, dfrwjan5)
dfrwjan6 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2014")
dfrwfinal <- cbind(dfrwfinal, dfrwjan6)
dfrwjan7 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2015")
dfrwfinal <- cbind(dfrwfinal, dfrwjan7)
dfrwjan8 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2016")
dfrwfinal <- cbind(dfrwfinal, dfrwjan8)
dfrwjan9 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2017")
dfrwfinal <- cbind(dfrwfinal, dfrwjan9)
dfrwjan10 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2018")
dfrwfinal <- cbind(dfrwfinal, dfrwjan10)
dfrwjan11 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2019")
dfrwfinal <- cbind(dfrwfinal, dfrwjan11)
dfrwjan12 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2020")
dfrwfinal <- cbind(dfrwfinal, dfrwjan12)
dfrwjan13 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D72:D102", col_names = "y_2021")
dfrwfinal <- cbind(dfrwfinal, dfrwjan13)
#
# Load the data for February into dataframe dfrwfinal
dfrwfeb1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A104:A132", col_names = "month_day")
dfrwfeb1$month_day <- as.Date(as.character((dfrwfeb1$month_day)))
dfrwfeb2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2010")
dfrwfeb <- cbind(dfrwfeb1, dfrwfeb2)
dfrwfeb3 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2011")
dfrwfeb <- cbind(dfrwfeb, dfrwfeb3)
dfrwfeb4 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2012")
dfrwfeb <- cbind(dfrwfeb, dfrwfeb4)
dfrwfeb5 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2013")
dfrwfeb <- cbind(dfrwfeb, dfrwfeb5)
dfrwfeb6 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2014")
dfrwfeb <- cbind(dfrwfeb, dfrwfeb6)
dfrwfeb7 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2015")
dfrwfeb <- cbind(dfrwfeb, dfrwfeb7)
dfrwfeb8 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2016")
dfrwfeb <- cbind(dfrwfeb, dfrwfeb8)
dfrwfeb9 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2017")
dfrwfeb <- cbind(dfrwfeb, dfrwfeb9)
dfrwfeb10 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2018")
dfrwfeb <- cbind(dfrwfeb, dfrwfeb10)
dfrwfeb11 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2019")
dfrwfeb <- cbind(dfrwfeb, dfrwfeb11)
dfrwfeb12 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2020")
dfrwfeb <- cbind(dfrwfeb, dfrwfeb12)
dfrwfeb13 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D104:D132", col_names = "y_2021")
dfrwfeb <- cbind(dfrwfeb, dfrwfeb13)
#
dfrwfinal <- rbind(dfrwfinal, dfrwfeb)
#
# Load the data for March into dataframe dfrwfinal
dfrwmar1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A134:A164", col_names = "month_day")
dfrwmar1$month_day <- as.Date(as.character((dfrwmar1$month_day)))
dfrwmar2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2010")
dfrwmar <- cbind(dfrwmar1, dfrwmar2)
dfrwmar3 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2011")
dfrwmar <- cbind(dfrwmar, dfrwmar3)
dfrwmar4 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2012")
dfrwmar <- cbind(dfrwmar, dfrwmar4)
dfrwmar5 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2013")
dfrwmar <- cbind(dfrwmar, dfrwmar5)
dfrwmar6 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2014")
dfrwmar <- cbind(dfrwmar, dfrwmar6)
dfrwmar7 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2015")
dfrwmar <- cbind(dfrwmar, dfrwmar7)
dfrwmar8 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2016")
dfrwmar <- cbind(dfrwmar, dfrwmar8)
dfrwmar9 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2017")
dfrwmar <- cbind(dfrwmar, dfrwmar9)
dfrwmar10 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2018")
dfrwmar <- cbind(dfrwmar, dfrwmar10)
dfrwmar11 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2019")
dfrwmar <- cbind(dfrwmar, dfrwmar11)
dfrwmar12 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2020")
dfrwmar <- cbind(dfrwmar, dfrwmar12)
dfrwmar13 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D134:D164", col_names = "y_2021")
dfrwmar <- cbind(dfrwmar, dfrwmar13)
#
dfrwfinal <- rbind(dfrwfinal, dfrwmar)
#
# Load the data for April into dataframe dfrwfinal
dfrwapr1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A166:A195", col_names = "month_day")
dfrwapr1$month_day <- as.Date(as.character((dfrwapr1$month_day)))
dfrwapr2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2010")
dfrwapr <- cbind(dfrwapr1, dfrwapr2)
dfrwapr3 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2011")
dfrwapr <- cbind(dfrwapr, dfrwapr3)
dfrwapr4 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2012")
dfrwapr <- cbind(dfrwapr, dfrwapr4)
dfrwapr5 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2013")
dfrwapr <- cbind(dfrwapr, dfrwapr5)
dfrwapr6 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2014")
dfrwapr <- cbind(dfrwapr, dfrwapr6)
dfrwapr7 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2015")
dfrwapr <- cbind(dfrwapr, dfrwapr7)
dfrwapr8 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2016")
dfrwapr <- cbind(dfrwapr, dfrwapr8)
dfrwapr9 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2017")
dfrwapr <- cbind(dfrwapr, dfrwapr9)
dfrwapr10 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2018")
dfrwapr <- cbind(dfrwapr, dfrwapr10)
dfrwapr11 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2019")
dfrwapr <- cbind(dfrwapr, dfrwapr11)
dfrwapr12 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2020")
dfrwapr <- cbind(dfrwapr, dfrwapr12)
dfrwapr13 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D166:D195", col_names = "y_2021")
dfrwapr <- cbind(dfrwapr, dfrwapr13)
#
dfrwfinal <- rbind(dfrwfinal, dfrwapr)
#
# Load the data for May into dataframe dfrwfinal
dfrwmay1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A197:A227", col_names = "month_day")
dfrwmay1$month_day <- as.Date(as.character((dfrwmay1$month_day)))
dfrwmay2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2010")
dfrwmay <- cbind(dfrwmay1, dfrwmay2)
dfrwmay3 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2011")
dfrwmay <- cbind(dfrwmay, dfrwmay3)
dfrwmay4 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2012")
dfrwmay <- cbind(dfrwmay, dfrwmay4)
dfrwmay5 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2013")
dfrwmay <- cbind(dfrwmay, dfrwmay5)
dfrwmay6 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2014")
dfrwmay <- cbind(dfrwmay, dfrwmay6)
dfrwmay7 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2015")
dfrwmay <- cbind(dfrwmay, dfrwmay7)
dfrwmay8 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2016")
dfrwmay <- cbind(dfrwmay, dfrwmay8)
dfrwmay9 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2017")
dfrwmay <- cbind(dfrwmay, dfrwmay9)
dfrwmay10 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2018")
dfrwmay <- cbind(dfrwmay, dfrwmay10)
dfrwmay11 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2019")
dfrwmay <- cbind(dfrwmay, dfrwmay11)
dfrwmay12 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2020")
dfrwmay <- cbind(dfrwmay, dfrwmay12)
dfrwmay13 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D197:D227", col_names = "y_2021")
dfrwmay <- cbind(dfrwmay, dfrwmay13)
#
dfrwfinal <- rbind(dfrwfinal, dfrwmay)
#
# Load the data for June into dataframe dfrwfinal
dfrwjun1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A229:A258", col_names = "month_day")
dfrwjun1$month_day <- as.Date(as.character((dfrwjun1$month_day)))
dfrwjun2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2010")
dfrwjun <- cbind(dfrwjun1, dfrwjun2)
dfrwjun3 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2011")
dfrwjun <- cbind(dfrwjun, dfrwjun3)
dfrwjun4 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2012")
dfrwjun <- cbind(dfrwjun, dfrwjun4)
dfrwjun5 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2013")
dfrwjun <- cbind(dfrwjun, dfrwjun5)
dfrwjun6 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2014")
dfrwjun <- cbind(dfrwjun, dfrwjun6)
dfrwjun7 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2015")
dfrwjun <- cbind(dfrwjun, dfrwjun7)
dfrwjun8 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2016")
dfrwjun <- cbind(dfrwjun, dfrwjun8)
dfrwjun9 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2017")
dfrwjun <- cbind(dfrwjun, dfrwjun9)
dfrwjun10 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2018")
dfrwjun <- cbind(dfrwjun, dfrwjun10)
dfrwjun11 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2019")
dfrwjun <- cbind(dfrwjun, dfrwjun11)
dfrwjun12 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2020")
dfrwjun <- cbind(dfrwjun, dfrwjun12)
dfrwjun13 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D229:D258", col_names = "y_2021")
dfrwjun <- cbind(dfrwjun, dfrwjun13)
#
dfrwfinal <- rbind(dfrwfinal, dfrwjun)
#
# Load the data for July into dataframe dfrwfinal
dfrwjul1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A260:A290", col_names = "month_day")
dfrwjul1$month_day <- as.Date(as.character((dfrwjul1$month_day)))
dfrwjul2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2010")
dfrwjul <- cbind(dfrwjul1, dfrwjul2)
dfrwjul3 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2011")
dfrwjul <- cbind(dfrwjul, dfrwjul3)
dfrwjul4 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2012")
dfrwjul <- cbind(dfrwjul, dfrwjul4)
dfrwjul5 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2013")
dfrwjul <- cbind(dfrwjul, dfrwjul5)
dfrwjul6 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2014")
dfrwjul <- cbind(dfrwjul, dfrwjul6)
dfrwjul7 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2015")
dfrwjul <- cbind(dfrwjul, dfrwjul7)
dfrwjul8 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2016")
dfrwjul <- cbind(dfrwjul, dfrwjul8)
dfrwjul9 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2017")
dfrwjul <- cbind(dfrwjul, dfrwjul9)
dfrwjul10 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2018")
dfrwjul <- cbind(dfrwjul, dfrwjul10)
dfrwjul11 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2019")
dfrwjul <- cbind(dfrwjul, dfrwjul11)
dfrwjul12 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2020")
dfrwjul <- cbind(dfrwjul, dfrwjul12)
dfrwjul13 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D260:D290", col_names = "y_2021")
dfrwjul <- cbind(dfrwjul, dfrwjul13)
#
dfrwfinal <- rbind(dfrwfinal, dfrwjul)
#
# Load the data for August into dataframe dfrwfinal
dfrwaug1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A292:A322", col_names = "month_day")
dfrwaug1$month_day <- as.Date(as.character((dfrwaug1$month_day)))
dfrwaug2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2010")
dfrwaug <- cbind(dfrwaug1, dfrwaug2)
dfrwaug3 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2011")
dfrwaug <- cbind(dfrwaug, dfrwaug3)
dfrwaug4 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2012")
dfrwaug <- cbind(dfrwaug, dfrwaug4)
dfrwaug5 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2013")
dfrwaug <- cbind(dfrwaug, dfrwaug5)
dfrwaug6 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2014")
dfrwaug <- cbind(dfrwaug, dfrwaug6)
dfrwaug7 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2015")
dfrwaug <- cbind(dfrwaug, dfrwaug7)
dfrwaug8 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2016")
dfrwaug <- cbind(dfrwaug, dfrwaug8)
dfrwaug9 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2017")
dfrwaug <- cbind(dfrwaug, dfrwaug9)
dfrwaug10 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2018")
dfrwaug <- cbind(dfrwaug, dfrwaug10)
dfrwaug11 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2019")
dfrwaug <- cbind(dfrwaug, dfrwaug11)
dfrwaug12 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2020")
dfrwaug <- cbind(dfrwaug, dfrwaug12)
dfrwaug13 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D292:D322", col_names = "y_2021")
dfrwaug <- cbind(dfrwaug, dfrwaug13)
#
dfrwfinal <- rbind(dfrwfinal, dfrwaug)
#
# Load the data for September into dataframe dfrwfinal
dfrwsep1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A324:A353", col_names = "month_day")
dfrwsep1$month_day <- as.Date(as.character((dfrwsep1$month_day)))
dfrwsep2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2010")
dfrwsep <- cbind(dfrwsep1, dfrwsep2)
dfrwsep3 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2011")
dfrwsep <- cbind(dfrwsep, dfrwsep3)
dfrwsep4 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2012")
dfrwsep <- cbind(dfrwsep, dfrwsep4)
dfrwsep5 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2013")
dfrwsep <- cbind(dfrwsep, dfrwsep5)
dfrwsep6 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2014")
dfrwsep <- cbind(dfrwsep, dfrwsep6)
dfrwsep7 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2015")
dfrwsep <- cbind(dfrwsep, dfrwsep7)
dfrwsep8 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2016")
dfrwsep <- cbind(dfrwsep, dfrwsep8)
dfrwsep9 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2017")
dfrwsep <- cbind(dfrwsep, dfrwsep9)
dfrwsep10 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2018")
dfrwsep <- cbind(dfrwsep, dfrwsep10)
dfrwsep11 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2019")
dfrwsep <- cbind(dfrwsep, dfrwsep11)
dfrwsep12 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2020")
dfrwsep <- cbind(dfrwsep, dfrwsep12)
dfrwsep13 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D324:D353", col_names = "y_2021")
dfrwsep <- cbind(dfrwsep, dfrwsep13)
#
dfrwfinal <- rbind(dfrwfinal, dfrwsep)
#
# Load the data for October into dataframe dfrwfinal
# NOte: I copied the formats from the October range of cells A355:L385 into the WGL2011.xlsm workbook. read_excel would not return values from column D. This seemed to work as the read from WGL2011.xlsm now works.
dfrwoct1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A355:A385", col_names = "month_day")
dfrwoct1$month_day <- as.Date(as.character((dfrwoct1$month_day)))
dfrwoct2 <- read_excel("WGL2010.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2010")
dfrwoct <- cbind(dfrwoct1, dfrwoct2)
dfrwoct3 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2011")
dfrwoct <- cbind(dfrwoct, dfrwoct3)
dfrwoct4 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2012")
dfrwoct <- cbind(dfrwoct, dfrwoct4)
dfrwoct5 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2013")
dfrwoct <- cbind(dfrwoct, dfrwoct5)
dfrwoct6 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2014")
dfrwoct <- cbind(dfrwoct, dfrwoct6)
dfrwoct7 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2015")
dfrwoct <- cbind(dfrwoct, dfrwoct7)
dfrwoct8 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2016")
dfrwoct <- cbind(dfrwoct, dfrwoct8)
dfrwoct9 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2017")
dfrwoct <- cbind(dfrwoct, dfrwoct9)
dfrwoct10 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2018")
dfrwoct <- cbind(dfrwoct, dfrwoct10)
dfrwoct11 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2019")
dfrwoct <- cbind(dfrwoct, dfrwoct11)
dfrwoct12 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2020")
dfrwoct <- cbind(dfrwoct, dfrwoct12)
dfrwoct13 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D355:D385", col_names = "y_2021")
dfrwoct <- cbind(dfrwoct, dfrwoct13)
#
dfrwfinal <- rbind(dfrwfinal, dfrwoct)
#
#
# Load the data for November into dataframe dfrwfinal. NOTE that the workbooks conform to the DWR water year and therefore run from November in one year through October the following year, so in order to get November and December for e.g. "2010" you need the WGL2011 workbook.
dfrwnov1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A9:A38", col_names = "month_day")
dfrwnov1$month_day <- as.Date(as.character((dfrwnov1$month_day)))
dfrwnov2 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2010")
dfrwnov <- cbind(dfrwnov1, dfrwnov2)
dfrwnov3 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2011")
dfrwnov <- cbind(dfrwnov, dfrwnov3)
dfrwnov4 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2012")
dfrwnov <- cbind(dfrwnov, dfrwnov4)
dfrwnov5 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2013")
dfrwnov <- cbind(dfrwnov, dfrwnov5)
dfrwnov6 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2014")
dfrwnov <- cbind(dfrwnov, dfrwnov6)
dfrwnov7 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2015")
dfrwnov <- cbind(dfrwnov, dfrwnov7)
dfrwnov8 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2016")
dfrwnov <- cbind(dfrwnov, dfrwnov8)
dfrwnov9 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2017")
dfrwnov <- cbind(dfrwnov, dfrwnov9)
dfrwnov10 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2018")
dfrwnov <- cbind(dfrwnov, dfrwnov10)
dfrwnov11 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2019")
dfrwnov <- cbind(dfrwnov, dfrwnov11)
dfrwnov12 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2020")
dfrwnov <- cbind(dfrwnov, dfrwnov12)
dfrwnov13 <- read_excel("WGL2022.xlsm", sheet = "Sum", range = "D9:D38", col_names = "y_2021")
dfrwnov <- cbind(dfrwnov, dfrwnov13)
#
# Load the data for December into dataframe dfrwfinal. NOTE that the workbooks conform to the DWR water year and therefore run from November in one year through October the following year, so in order to get November and December for e.g. "2010" you need the WGL2011 workbook.
dfrwdec1 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "A40:A70", col_names = "month_day")
dfrwdec1$month_day <- as.Date(as.character((dfrwdec1$month_day)))
dfrwdec2 <- read_excel("WGL2011.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2010")
dfrwdec <- cbind(dfrwdec1, dfrwdec2)
dfrwdec3 <- read_excel("WGL2012.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2011")
dfrwdec <- cbind(dfrwdec, dfrwdec3)
dfrwdec4 <- read_excel("WGL2013.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2012")
dfrwdec <- cbind(dfrwdec, dfrwdec4)
dfrwdec5 <- read_excel("WGL2014.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2013")
dfrwdec <- cbind(dfrwdec, dfrwdec5)
dfrwdec6 <- read_excel("WGL2015.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2014")
dfrwdec <- cbind(dfrwdec, dfrwdec6)
dfrwdec7 <- read_excel("WGL2016.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2015")
dfrwdec <- cbind(dfrwdec, dfrwdec7)
dfrwdec8 <- read_excel("WGL2017.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2016")
dfrwdec <- cbind(dfrwdec, dfrwdec8)
dfrwdec9 <- read_excel("WGL2018.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2017")
dfrwdec <- cbind(dfrwdec, dfrwdec9)
dfrwdec10 <- read_excel("WGL2019.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2018")
dfrwdec <- cbind(dfrwdec, dfrwdec10)
dfrwdec11 <- read_excel("WGL2020.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2019")
dfrwdec <- cbind(dfrwdec, dfrwdec11)
dfrwdec12 <- read_excel("WGL2021.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2020")
dfrwdec <- cbind(dfrwdec, dfrwdec12)
dfrwdec13 <- read_excel("WGL2022.xlsm", sheet = "Sum", range = "D40:D70", col_names = "y_2021")
dfrwdec <- cbind(dfrwdec, dfrwdec13)
#

dfrwfinal <- rbind(dfrwfinal, dfrwdec)
#
# Change all zero values to NA. Zero values affect mean, median, etc.
# 
#dfrwfinal <- na_if(dfrwfinal, 0)

# The values from the workbooks are negative, change them to positive. They are inflows to the treatment plant and come in negative because they are outflows from the reservoir.
# 
dfrwfinal[2:13] <- dfrwfinal[2:13] * -1
#
# Compute the mean for each day over all the years
#
dfrwfinal$mean = apply(dfrwfinal[2:13], 1, mean, na_rm = TRUE)
#
# Compute the median for each day over all the years
#
dfrwfinal$median = apply(dfrwfinal[2:13], 1, median, na_rm = TRUE)
#
# Determine the maximum by day over all of the days
dfrwfinal$maximum <- apply(dfrwfinal[2:13], 1, max, na_rm = TRUE)
# 
# Determine the maximum by day over all of the days
dfrwfinal$minimum <- apply(dfrwfinal[2:13], 1, min, na_rm = TRUE)
#

View(dfrwfinal)
