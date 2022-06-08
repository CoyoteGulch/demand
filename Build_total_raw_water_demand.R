# Build_total_raw_water_demand.R
# This programs reads the Excel Accounting files, WGLXXXX, TANIwithWSPxxxx, TANIwESPXXXX, and StanXXXX to get metered data into a Tidy format for plotting
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
# Load the data for June into dataframe dfrwslfinal
dfrwsljun1 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "A229:A258", col_names = "month_day")
dfrwsljun1$month_day <- as.Date(as.character((dfrwsljun1$month_day)))
#
dfrwsljun2 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2010")
dfrwsljun <- cbind(dfrwsljun1, dfrwsljun2)
#
dfrwsljun3 <- read_excel("Stan2011(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2011")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun3)
#
dfrwsljun4 <- read_excel("Stan2012(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2012")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun4)
#
dfrwsljun5 <- read_excel("Stan2013(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2013")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun5)
#
dfrwsljun6 <- read_excel("Stan2014(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2014")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun6)
#
dfrwsljun7 <- read_excel("Stan2015(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2015")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun7)
#
dfrwsljun8 <- read_excel("Stan2016(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2016")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun8)
#
dfrwsljun9 <- read_excel("Stan2017(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2017")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun9)
#
dfrwsljun10 <- read_excel("Stan2018(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2018")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun10)
#
dfrwsljun11 <- read_excel("Stan2019(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2019")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun11)
#
dfrwsljun12 <- read_excel("Stan2020(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2020")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun12)
#
dfrwsljun13 <- read_excel("Stan2021(decree).xlsm", sheet = "Summary", range = "R229:R258", col_names = "y_2021")
dfrwsljun <- cbind(dfrwsljun, dfrwsljun13)
#
dfrwslfinal <- rbind(dfrwslfinal, dfrwsljun)
#
# Load the data for July into dataframe dfrwslfinal
dfrwsljul1 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "A260:A290", col_names = "month_day")
dfrwsljul1$month_day <- as.Date(as.character((dfrwsljul1$month_day)))
#
dfrwsljul2 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2010")
dfrwsljul <- cbind(dfrwsljul1, dfrwsljul2)
#
dfrwsljul3 <- read_excel("Stan2011(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2011")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul3)
#
dfrwsljul4 <- read_excel("Stan2012(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2012")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul4)
#
dfrwsljul5 <- read_excel("Stan2013(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2013")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul5)
#
dfrwsljul6 <- read_excel("Stan2014(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2014")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul6)
#
dfrwsljul7 <- read_excel("Stan2015(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2015")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul7)
#
dfrwsljul8 <- read_excel("Stan2016(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2016")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul8)
#
dfrwsljul9 <- read_excel("Stan2017(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2017")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul9)
#
dfrwsljul10 <- read_excel("Stan2018(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2018")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul10)
#
dfrwsljul11 <- read_excel("Stan2019(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2019")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul11)
#
dfrwsljul12 <- read_excel("Stan2020(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2020")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul12)
#
dfrwsljul13 <- read_excel("Stan2021(decree).xlsm", sheet = "Summary", range = "R260:R290", col_names = "y_2021")
dfrwsljul <- cbind(dfrwsljul, dfrwsljul13)
#
dfrwslfinal <- rbind(dfrwslfinal, dfrwsljul)
#
# Load the data for August into dataframe dfrwslfinal
dfrwslaug1 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "A292:A322", col_names = "month_day")
dfrwslaug1$month_day <- as.Date(as.character((dfrwslaug1$month_day)))
#
dfrwslaug2 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2010")
dfrwslaug <- cbind(dfrwslaug1, dfrwslaug2)
#
dfrwslaug3 <- read_excel("Stan2011(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2011")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug3)
#
dfrwslaug4 <- read_excel("Stan2012(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2012")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug4)
#
dfrwslaug5 <- read_excel("Stan2013(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2013")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug5)
#
dfrwslaug6 <- read_excel("Stan2014(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2014")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug6)
#
dfrwslaug7 <- read_excel("Stan2015(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2015")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug7)
#
dfrwslaug8 <- read_excel("Stan2016(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2016")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug8)
#
dfrwslaug9 <- read_excel("Stan2017(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2017")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug9)
#
dfrwslaug10 <- read_excel("Stan2018(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2018")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug10)
#
dfrwslaug11 <- read_excel("Stan2019(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2019")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug11)
#
dfrwslaug12 <- read_excel("Stan2020(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2020")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug12)
#
dfrwslaug13 <- read_excel("Stan2021(decree).xlsm", sheet = "Summary", range = "R292:R322", col_names = "y_2021")
dfrwslaug <- cbind(dfrwslaug, dfrwslaug13)
#
dfrwslfinal <- rbind(dfrwslfinal, dfrwslaug)
#
# Load the data for September into dataframe dfrwslfinal
dfrwslsep1 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "A324:A353", col_names = "month_day")
dfrwslsep1$month_day <- as.Date(as.character((dfrwslsep1$month_day)))
#
dfrwslsep2 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2010")
dfrwslsep <- cbind(dfrwslsep1, dfrwslsep2)
#
dfrwslsep3 <- read_excel("Stan2011(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2011")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep3)
#
dfrwslsep4 <- read_excel("Stan2012(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2012")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep4)
#
dfrwslsep5 <- read_excel("Stan2013(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2013")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep5)
#
dfrwslsep6 <- read_excel("Stan2014(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2014")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep6)
#
dfrwslsep7 <- read_excel("Stan2015(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2015")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep7)
#
dfrwslsep8 <- read_excel("Stan2016(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2016")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep8)
#
dfrwslsep9 <- read_excel("Stan2017(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2017")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep9)
#
dfrwslsep10 <- read_excel("Stan2018(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2018")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep10)
#
dfrwslsep11 <- read_excel("Stan2019(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2019")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep11)
#
dfrwslsep12 <- read_excel("Stan2020(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2020")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep12)
#
dfrwslsep13 <- read_excel("Stan2021(decree).xlsm", sheet = "Summary", range = "R324:R353", col_names = "y_2021")
dfrwslsep <- cbind(dfrwslsep, dfrwslsep13)
#
dfrwslfinal <- rbind(dfrwslfinal, dfrwslsep)
#
# Load the data for October into dataframe dfrwslfinal
dfrwsloct1 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "A355:A385", col_names = "month_day")
dfrwsloct1$month_day <- as.Date(as.character((dfrwsloct1$month_day)))
#
dfrwsloct2 <- read_excel("Stan2010(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2010")
dfrwsloct <- cbind(dfrwsloct1, dfrwsloct2)
#
dfrwsloct3 <- read_excel("Stan2011(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2011")
dfrwsloct <- cbind(dfrwsloct, dfrwsloct3)
#
dfrwsloct4 <- read_excel("Stan2012(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2012")
dfrwsloct <- cbind(dfrwsloct, dfrwsloct4)
#
dfrwsloct5 <- read_excel("Stan2013(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2013")
dfrwsloct <- cbind(dfrwsloct, dfrwsloct5)
#
dfrwsloct6 <- read_excel("Stan2014(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2014")
dfrwsloct <- cbind(dfrwsloct, dfrwsloct6)
#
dfrwsloct7 <- read_excel("Stan2015(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2015")
dfrwsloct <- cbind(dfrwsloct, dfrwsloct7)
#
dfrwsloct8 <- read_excel("Stan2016(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2016")
dfrwsloct <- cbind(dfrwsloct, dfrwsloct8)
#
dfrwsloct9 <- read_excel("Stan2017(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2017")
dfrwsloct <- cbind(dfrwsloct, dfrwsloct9)
#
dfrwsloct10 <- read_excel("Stan2018(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2018")
dfrwsloct <- cbind(dfrwsloct, dfrwsloct10)
#
dfrwsloct11 <- read_excel("Stan2019(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2019")
dfrwsloct <- cbind(dfrwsloct, dfrwsloct11)
#
dfrwsloct12 <- read_excel("Stan2020(decree).xlsm", sheet = "Summary", range = "R355:R385", col_names = "y_2020")
dfrwsloct <- cbind(dfrwsloct, dfrwsloct12)
#
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
#
dfrwslnov2 <- read_excel("Stan2011(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2010")
dfrwslnov <- cbind(dfrwslnov1, dfrwslnov2)
#
dfrwslnov3 <- read_excel("Stan2012(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2011")
dfrwslnov <- cbind(dfrwslnov, dfrwslnov3)
#
dfrwslnov4 <- read_excel("Stan2013(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2012")
dfrwslnov <- cbind(dfrwslnov, dfrwslnov4)
#
dfrwslnov5 <- read_excel("Stan2014(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2013")
dfrwslnov <- cbind(dfrwslnov, dfrwslnov5)
#
dfrwslnov6 <- read_excel("Stan2015(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2014")
dfrwslnov <- cbind(dfrwslnov, dfrwslnov6)
#
dfrwslnov7 <- read_excel("Stan2016(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2015")
dfrwslnov <- cbind(dfrwslnov, dfrwslnov7)
#
dfrwslnov8 <- read_excel("Stan2017(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2016")
dfrwslnov <- cbind(dfrwslnov, dfrwslnov8)
#
dfrwslnov9 <- read_excel("Stan2018(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2017")
dfrwslnov <- cbind(dfrwslnov, dfrwslnov9)
#
dfrwslnov10 <- read_excel("Stan2019(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2018")
dfrwslnov <- cbind(dfrwslnov, dfrwslnov10)
#
dfrwslnov11 <- read_excel("Stan2020(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2019")
dfrwslnov <- cbind(dfrwslnov, dfrwslnov11)
#
dfrwslnov12 <- read_excel("Stan2021(decree).xlsm", sheet = "Summary", range = "R9:R38", col_names = "y_2020")
dfrwslnov <- cbind(dfrwslnov, dfrwslnov12)
#
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
#
dfrwsldec2 <- read_excel("Stan2011(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2010")
dfrwsldec <- cbind(dfrwsldec1, dfrwsldec2)
#
dfrwsldec3 <- read_excel("Stan2012(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2011")
dfrwsldec <- cbind(dfrwsldec, dfrwsldec3)
#
dfrwsldec4 <- read_excel("Stan2013(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2012")
dfrwsldec <- cbind(dfrwsldec, dfrwsldec4)
#
dfrwsldec5 <- read_excel("Stan2014(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2013")
dfrwsldec <- cbind(dfrwsldec, dfrwsldec5)
#
dfrwsldec6 <- read_excel("Stan2015(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2014")
dfrwsldec <- cbind(dfrwsldec, dfrwsldec6)
#
dfrwsldec7 <- read_excel("Stan2016(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2015")
dfrwsldec <- cbind(dfrwsldec, dfrwsldec7)
#
dfrwsldec8 <- read_excel("Stan2017(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2016")
dfrwsldec <- cbind(dfrwsldec, dfrwsldec8)
#
dfrwsldec9 <- read_excel("Stan2018(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2017")
dfrwsldec <- cbind(dfrwsldec, dfrwsldec9)
#
dfrwsldec10 <- read_excel("Stan2019(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2018")
dfrwsldec <- cbind(dfrwsldec, dfrwsldec10)
#
dfrwsldec11 <- read_excel("Stan2020(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2019")
dfrwsldec <- cbind(dfrwsldec, dfrwsldec11)
#
dfrwsldec12 <- read_excel("Stan2021(decree).xlsm", sheet = "Summary", range = "R40:R70", col_names = "y_2020")
dfrwsldec <- cbind(dfrwsldec, dfrwsldec12)
#
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
# # The values from the workbooks are negative, change them to positive. They are inflows to the treatment plant and come in negative because they are outflows from the reservoir.
# # 
# dfrwtanifinal[, 2:13] <- dfrwtanifinal[, 2:13] * -1
# #
# # Replace all NA values with 0
# #
# dfrwtanifinal[, 2:13] <- lapply(dfrwtanifinal[, 2:13], function(x) replace(x, is.na(x), 0))
# #
# View(dfrwtanifinal)
# #
# # Add the West Gravel Lakes and Tani dataframes and store the result in dfrwfinal.
# # (Code from: https://stackoverflow.com/questions/30516094/r-add-two-data-frames-with-same-dimensions)
# # 
# dfrwfinal <- dfrwwglfinal %>% select(-month_day) %>% add(dfrwtanifinal %>% select(-month_day)) %>% mutate(type = dfrwtanifinal$type)
# #
# #Add the month_day column to dfrwfinal (code here: https://www.marsja.se/how-to-add-a-column-to-dataframe-in-r-with-tibble-dplyr/ and
# # here (https://www.marsja.se/how-to-add-a-column-to-dataframe-in-r-with-tibble-dplyr/)). order here (
# # https://stackoverflow.com/questions/5620885/how-does-one-reorder-columns-in-a-data-frame)
# #
# dfrwfinal$month_day <- dfrwwglfinal$month_day
# #
# #Move the month_day column to the first column
# #
# dfrwfinal <- dfrwfinal %>% select(month_day, everything())
# #
# # Used during testing
# View(dfrwfinal)

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
