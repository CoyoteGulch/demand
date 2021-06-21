# Copyright: City of Thornton Water Resources
# Author: John Orr
# This program is used to extract treatment plant production data, by day, for the years 2010 through
# 2020. The source Excel files are generated from treatment plant each day and must be in the same
# directory as the program file. The workbooks are organized by water year (stars on November 1st). Run this 
# program from R or RStudio by opening the project file Demand Management.Rproj and sourcing BuildTotalProduction.R.
# I had to edit the source Excel files, in a few cases, for February 29th to make sure that Read_Excel returns "na"
# for non-leap years so that is the reason to have them in the directory. Output is a .csv with production by day
# and the month and day for target years.
#
# Load the necessary R libraries
#
library(readxl)
#
# Read the data from each workbook for the month of January from 2011 through 2020 and write it to the dataframe
# dfinal.
#
dfjan1 <- read_excel("Plant Production 2010.xlsm", sheet = "January", range = "A5:A35", col_names = "Month_Day")
dfjan1$Month_Day <- as.Date(as.character((dfjan1$Month_Day)))
dfjan2 <- read_excel("Plant Production 2010.xlsm", sheet = "January", range = "AH5:AH35", col_names = "2010")
dfinal <- cbind(dfjan1, dfjan2)
dfjan3 <- read_excel("Plant Production 2011.xlsm", sheet = "January", range = "AD5:AD35", col_names = "2011")
dfinal <- cbind(dfinal, dfjan3)
dfjan4 <- read_excel("Plant Production 2012.xlsm", sheet = "January", range = "AD5:AD35", col_names = "2012")
dfinal <- cbind(dfinal, dfjan4)
dfjan5 <- read_excel("Plant Production 2013.xlsm", sheet = "January", range = "AD5:AD35", col_names = "2013")
dfinal <- cbind(dfinal, dfjan5)
dfjan6 <- read_excel("Plant Production 2014.xlsm", sheet = "January", range = "AD5:AD35", col_names = "2014")
dfinal <- cbind(dfinal, dfjan6)
dfjan7 <- read_excel("Plant Production 2015.xlsm", sheet = "January", range = "AD5:AD35", col_names = "2015")
dfinal <- cbind(dfinal, dfjan7)
dfjan8 <- read_excel("Plant Production 2016.xlsm", sheet = "January", range = "AD5:AD35", col_names = "2016")
dfinal <- cbind(dfinal, dfjan8)
dfjan9 <- read_excel("Plant Production 2017.xlsm", sheet = "January", range = "AD5:AD35", col_names = "2017")
dfinal <- cbind(dfinal, dfjan9)
dfjan10 <- read_excel("Plant Production 2018.xlsm", sheet = "January", range = "AD5:AD35", col_names = "2018")
dfinal <- cbind(dfinal, dfjan10)
dfjan11 <- read_excel("Plant Production 2019.xlsm", sheet = "January", range = "AD5:AD35", col_names = "2019")
dfinal <- cbind(dfinal, dfjan11)
dfjan12 <- read_excel("Plant Production WY2020.xlsm", sheet = "January", range = "AD5:AD35", col_names = "2020")
dfinal <- cbind(dfinal, dfjan12)
#
# Read the data from each workbook for the month of February from 2011 through 2020 and write it to the dataframe
# dfinal.
#
dffeb1 <- read_excel("Plant Production 2010.xlsm", sheet = "February", range = "A5:A33", col_names = "Month_Day")
dffeb1$Month_Day <- as.Date(as.character((dffeb1$Month_Day)))
dffeb2 <- read_excel("Plant Production 2010.xlsm", sheet = "February", range = "AH5:AH33", col_names = "2010")
dffeb <- cbind(dffeb1, dffeb2)
dffeb3 <- read_excel("Plant Production 2011.xlsm", sheet = "February", range = "AD5:AD33", col_names = "2011")
dffeb <- cbind(dffeb, dffeb3)
dffeb4 <- read_excel("Plant Production 2012.xlsm", sheet = "February", range = "AD5:AD33", col_names = "2012")
dffeb <- cbind(dffeb, dffeb4)
dffeb5 <- read_excel("Plant Production 2013.xlsm", sheet = "February", range = "AD5:AD33", col_names = "2013")
dffeb <- cbind(dffeb, dffeb5)
dffeb6 <- read_excel("Plant Production 2014.xlsm", sheet = "February", range = "AD5:AD33", col_names = "2014")
dffeb <- cbind(dffeb, dffeb6)
dffeb7 <- read_excel("Plant Production 2015.xlsm", sheet = "February", range = "AD5:AD33", col_names = "2015")
dffeb <- cbind(dffeb, dffeb7)
dffeb8 <- read_excel("Plant Production 2016.xlsm", sheet = "February", range = "AD5:AD33", col_names = "2016")
dffeb <- cbind(dffeb, dffeb8)
dffeb9 <- read_excel("Plant Production 2017.xlsm", sheet = "February", range = "AD5:AD33", col_names = "2017")
dffeb <- cbind(dffeb, dffeb9)
dffeb10 <- read_excel("Plant Production 2018.xlsm", sheet = "February", range = "AD5:AD33", col_names = "2018")
dffeb <- cbind(dffeb, dffeb10)
dffeb11 <- read_excel("Plant Production 2019.xlsm", sheet = "February", range = "AD5:AD33", col_names = "2019")
dffeb <- cbind(dffeb, dffeb11)
dffeb12 <- read_excel("Plant Production WY2020.xlsm", sheet = "February", range = "AD5:AD33", col_names = "2020")
dffeb <- cbind(dffeb, dffeb12)
#
dfinal <- rbind(dfinal, dffeb)
#
# Read the data from each workbook for the month of March from 2011 through 2020 and write it to the dataframe
# dfinal.
#
dfmar1 <- read_excel("Plant Production 2010.xlsm", sheet = "March", range = "A5:A35", col_names = "Month_Day")
dfmar2 <- read_excel("Plant Production 2010.xlsm", sheet = "March", range = "AH5:AH35", col_names = "2010")
dfmar <- cbind(dfmar1, dfmar2)
dfmar3 <- read_excel("Plant Production 2011.xlsm", sheet = "March", range = "AD5:AD35", col_names = "2011")
dfmar <- cbind(dfmar, dfmar3)
dfmar4 <- read_excel("Plant Production 2012.xlsm", sheet = "March", range = "AD5:AD35", col_names = "2012")
dfmar <- cbind(dfmar, dfmar4)
dfmar5 <- read_excel("Plant Production 2013.xlsm", sheet = "March", range = "AD5:AD35", col_names = "2013")
dfmar <- cbind(dfmar, dfmar5)
dfmar6 <- read_excel("Plant Production 2014.xlsm", sheet = "March", range = "AD5:AD35", col_names = "2014")
dfmar <- cbind(dfmar, dfmar6)
dfmar7 <- read_excel("Plant Production 2015.xlsm", sheet = "March", range = "AD5:AD35", col_names = "2015")
dfmar <- cbind(dfmar, dfmar7)
dfmar8 <- read_excel("Plant Production 2016.xlsm", sheet = "March", range = "AD5:AD35", col_names = "2016")
dfmar <- cbind(dfmar, dfmar8)
dfmar9 <- read_excel("Plant Production 2017.xlsm", sheet = "March", range = "AD5:AD35", col_names = "2017")
dfmar <- cbind(dfmar, dfmar9)
dfmar10 <- read_excel("Plant Production 2018.xlsm", sheet = "March", range = "AD5:AD35", col_names = "2018")
dfmar <- cbind(dfmar, dfmar10)
dfmar11 <- read_excel("Plant Production 2019.xlsm", sheet = "March", range = "AD5:AD35", col_names = "2019")
dfmar <- cbind(dfmar, dfmar11)
dfmar12 <- read_excel("Plant Production WY2020.xlsm", sheet = "March", range = "AD5:AD35", col_names = "2020")
dfmar <- cbind(dfmar, dfmar12)
#
dfinal <- rbind(dfinal, dfmar)
#
# Read the data from each workbook for the month of April from 2011 through 2020 and write it to the dataframe
# dfinal.
#
dfapr1 <- read_excel("Plant Production 2010.xlsm", sheet = "April", range = "A5:A34", col_names = "Month_Day")
dfapr2 <- read_excel("Plant Production 2010.xlsm", sheet = "April", range = "AH5:AH34", col_names = "2010")
dfapr <- cbind(dfapr1, dfapr2)
dfapr3 <- read_excel("Plant Production 2011.xlsm", sheet = "April", range = "AD5:AD34", col_names = "2011")
dfapr <- cbind(dfapr, dfapr3)
dfapr4 <- read_excel("Plant Production 2012.xlsm", sheet = "April", range = "AD5:AD34", col_names = "2012")
dfapr <- cbind(dfapr, dfapr4)
dfapr5 <- read_excel("Plant Production 2013.xlsm", sheet = "April", range = "AD5:AD34", col_names = "2013")
dfapr <- cbind(dfapr, dfapr5)
dfapr6 <- read_excel("Plant Production 2014.xlsm", sheet = "April", range = "AD5:AD34", col_names = "2014")
dfapr <- cbind(dfapr, dfapr6)
dfapr7 <- read_excel("Plant Production 2015.xlsm", sheet = "April", range = "AD5:AD34", col_names = "2015")
dfapr <- cbind(dfapr, dfapr7)
dfapr8 <- read_excel("Plant Production 2016.xlsm", sheet = "April", range = "AD5:AD34", col_names = "2016")
dfapr <- cbind(dfapr, dfapr8)
dfapr9 <- read_excel("Plant Production 2017.xlsm", sheet = "April", range = "AD5:AD34", col_names = "2017")
dfapr <- cbind(dfapr, dfapr9)
dfapr10 <- read_excel("Plant Production 2018.xlsm", sheet = "April", range = "AD5:AD34", col_names = "2018")
dfapr <- cbind(dfapr, dfapr10)
dfapr11 <- read_excel("Plant Production 2019.xlsm", sheet = "April", range = "AD5:AD34", col_names = "2019")
dfapr <- cbind(dfapr, dfapr11)
dfapr12 <- read_excel("Plant Production WY2020.xlsm", sheet = "April", range = "AD5:AD34", col_names = "2020")
dfapr <- cbind(dfapr, dfapr12)
#
dfinal <- rbind(dfinal, dfapr)
#
# Read the data from each workbook for the month of May from 2011 through 2020 and write it to the dataframe
# dfinal.
#
dfmay1 <- read_excel("Plant Production 2010.xlsm", sheet = "May", range = "A5:A35", col_names = "Month_Day")
dfmay2 <- read_excel("Plant Production 2010.xlsm", sheet = "May", range = "AH5:AH35", col_names = "2010")
dfmay <- cbind(dfmay1, dfmay2)
dfmay3 <- read_excel("Plant Production 2011.xlsm", sheet = "May", range = "AD5:AD35", col_names = "2011")
dfmay <- cbind(dfmay, dfmay3)
dfmay4 <- read_excel("Plant Production 2012.xlsm", sheet = "May", range = "AD5:AD35", col_names = "2012")
dfmay <- cbind(dfmay, dfmay4)
dfmay5 <- read_excel("Plant Production 2013.xlsm", sheet = "May", range = "AD5:AD35", col_names = "2013")
dfmay <- cbind(dfmay, dfmay5)
dfmay6 <- read_excel("Plant Production 2014.xlsm", sheet = "May", range = "AD5:AD35", col_names = "2014")
dfmay <- cbind(dfmay, dfmay6)
dfmay7 <- read_excel("Plant Production 2015.xlsm", sheet = "May", range = "AD5:AD35", col_names = "2015")
dfmay <- cbind(dfmay, dfmay7)
dfmay8 <- read_excel("Plant Production 2016.xlsm", sheet = "May", range = "AD5:AD35", col_names = "2016")
dfmay <- cbind(dfmay, dfmay8)
dfmay9 <- read_excel("Plant Production 2017.xlsm", sheet = "May", range = "AD5:AD35", col_names = "2017")
dfmay <- cbind(dfmay, dfmay9)
dfmay10 <- read_excel("Plant Production 2018.xlsm", sheet = "May", range = "AD5:AD35", col_names = "2018")
dfmay <- cbind(dfmay, dfmay10)
dfmay11 <- read_excel("Plant Production 2019.xlsm", sheet = "May", range = "AD5:AD35", col_names = "2019")
dfmay <- cbind(dfmay, dfmay11)
dfmay12 <- read_excel("Plant Production WY2020.xlsm", sheet = "May", range = "AD5:AD35", col_names = "2020")
dfmay <- cbind(dfmay, dfmay12)
#
dfinal <- rbind(dfinal, dfmay)
#
# Read the data from each workbook for the month of June from 2011 through 2020 and write it to the dataframe
# dfinal.
#
dfjun1 <- read_excel("Plant Production 2010.xlsm", sheet = "June", range = "A5:A34", col_names = "Month_Day")
dfjun2 <- read_excel("Plant Production 2010.xlsm", sheet = "June", range = "AH5:AH34", col_names = "2010")
dfjun <- cbind(dfjun1, dfjun2)
dfjun3 <- read_excel("Plant Production 2011.xlsm", sheet = "June", range = "AD5:AD34", col_names = "2011")
dfjun <- cbind(dfjun, dfjun3)
dfjun4 <- read_excel("Plant Production 2012.xlsm", sheet = "June", range = "AD5:AD34", col_names = "2012")
dfjun <- cbind(dfjun, dfjun4)
dfjun5 <- read_excel("Plant Production 2013.xlsm", sheet = "June", range = "AD5:AD34", col_names = "2013")
dfjun <- cbind(dfjun, dfjun5)
dfjun6 <- read_excel("Plant Production 2014.xlsm", sheet = "June", range = "AD5:AD34", col_names = "2014")
dfjun <- cbind(dfjun, dfjun6)
dfjun7 <- read_excel("Plant Production 2015.xlsm", sheet = "June", range = "AD5:AD34", col_names = "2015")
dfjun <- cbind(dfjun, dfjun7)
dfjun8 <- read_excel("Plant Production 2016.xlsm", sheet = "June", range = "AD5:AD34", col_names = "2016")
dfjun <- cbind(dfjun, dfjun8)
dfjun9 <- read_excel("Plant Production 2017.xlsm", sheet = "June", range = "AD5:AD34", col_names = "2017")
dfjun <- cbind(dfjun, dfjun9)
dfjun10 <- read_excel("Plant Production 2018.xlsm", sheet = "June", range = "AD5:AD34", col_names = "2018")
dfjun <- cbind(dfjun, dfjun10)
dfjun11 <- read_excel("Plant Production 2019.xlsm", sheet = "June", range = "AD5:AD34", col_names = "2019")
dfjun <- cbind(dfjun, dfjun11)
dfjun12 <- read_excel("Plant Production WY2020.xlsm", sheet = "June", range = "AD5:AD34", col_names = "2020")
dfjun <- cbind(dfjun, dfjun12)
#
dfinal <- rbind(dfinal, dfjun)
#
# Read the data from each workbook for the month of July from 2011 through 2020 and write it to the dataframe
# dfinal.
#
dfjul1 <- read_excel("Plant Production 2010.xlsm", sheet = "July", range = "A5:A35", col_names = "Month_Day")
dfjul2 <- read_excel("Plant Production 2010.xlsm", sheet = "July", range = "AH5:AH35", col_names = "2010")
dfjul <- cbind(dfjul1, dfjul2)
dfjul3 <- read_excel("Plant Production 2011.xlsm", sheet = "July", range = "AH5:AH35", col_names = "2011")
dfjul <- cbind(dfjul, dfjul3)
dfjul4 <- read_excel("Plant Production 2012.xlsm", sheet = "July", range = "AH5:AH35", col_names = "2012")
dfjul <- cbind(dfjul, dfjul4)
dfjul5 <- read_excel("Plant Production 2013.xlsm", sheet = "July", range = "AH5:AH35", col_names = "2013")
dfjul <- cbind(dfjul, dfjul5)
dfjul6 <- read_excel("Plant Production 2014.xlsm", sheet = "July", range = "AH5:AH35", col_names = "2014")
dfjul <- cbind(dfjul, dfjul6)
dfjul7 <- read_excel("Plant Production 2015.xlsm", sheet = "July", range = "AH5:AH35", col_names = "2015")
dfjul <- cbind(dfjul, dfjul7)
dfjul8 <- read_excel("Plant Production 2016.xlsm", sheet = "July", range = "AH5:AH35", col_names = "2016")
dfjul <- cbind(dfjul, dfjul8)
dfjul9 <- read_excel("Plant Production 2017.xlsm", sheet = "July", range = "AH5:AH35", col_names = "2017")
dfjul <- cbind(dfjul, dfjul9)
dfjul10 <- read_excel("Plant Production 2018.xlsm", sheet = "July", range = "AH5:AH35", col_names = "2018")
dfjul <- cbind(dfjul, dfjul10)
dfjul11 <- read_excel("Plant Production 2019.xlsm", sheet = "July", range = "AH5:AH35", col_names = "2019")
dfjul <- cbind(dfjul, dfjul11)
dfjul12 <- read_excel("Plant Production WY2020.xlsm", sheet = "July", range = "AH5:AH35", col_names = "2020")
dfjul <- cbind(dfjul, dfjul12)
#
dfinal <- rbind(dfinal, dfjul)
#
# Read the data from each workbook for the month of August from 2011 through 2020 and write it to the dataframe
# dfinal.
#
dfaug1 <- read_excel("Plant Production 2010.xlsm", sheet = "August", range = "A5:A35", col_names = "Month_Day")
dfaug2 <- read_excel("Plant Production 2010.xlsm", sheet = "August", range = "AH5:AH35", col_names = "2010")
dfaug <- cbind(dfaug1, dfaug2)
dfaug3 <- read_excel("Plant Production 2011.xlsm", sheet = "August", range = "AD5:AD35", col_names = "2011")
dfaug <- cbind(dfaug, dfaug3)
dfaug4 <- read_excel("Plant Production 2012.xlsm", sheet = "August", range = "AD5:AD35", col_names = "2012")
dfaug <- cbind(dfaug, dfaug4)
dfaug5 <- read_excel("Plant Production 2013.xlsm", sheet = "August", range = "AD5:AD35", col_names = "2013")
dfaug <- cbind(dfaug, dfaug5)
dfaug6 <- read_excel("Plant Production 2014.xlsm", sheet = "August", range = "AD5:AD35", col_names = "2014")
dfaug <- cbind(dfaug, dfaug6)
dfaug7 <- read_excel("Plant Production 2015.xlsm", sheet = "August", range = "AD5:AD35", col_names = "2015")
dfaug <- cbind(dfaug, dfaug7)
dfaug8 <- read_excel("Plant Production 2016.xlsm", sheet = "August", range = "AD5:AD35", col_names = "2016")
dfaug <- cbind(dfaug, dfaug8)
dfaug9 <- read_excel("Plant Production 2017.xlsm", sheet = "August", range = "AD5:AD35", col_names = "2017")
dfaug <- cbind(dfaug, dfaug9)
dfaug10 <- read_excel("Plant Production 2018.xlsm", sheet = "August", range = "AD5:AD35", col_names = "2018")
dfaug <- cbind(dfaug, dfaug10)
dfaug11 <- read_excel("Plant Production 2019.xlsm", sheet = "August", range = "AD5:AD35", col_names = "2019")
dfaug <- cbind(dfaug, dfaug11)
dfaug12 <- read_excel("Plant Production WY2020.xlsm", sheet = "August", range = "AD5:AD35", col_names = "2020")
dfaug <- cbind(dfaug, dfaug12)
#
dfinal <- rbind(dfinal, dfaug)
#
# Read the data from each workbook for the month of September from 2011 through 2020 and write it to the dataframe
# dfinal.
#
dfsep1 <- read_excel("Plant Production 2010.xlsm", sheet = "September", range = "A5:A34", col_names = "Month_Day")
dfsep2 <- read_excel("Plant Production 2010.xlsm", sheet = "September", range = "AH5:AH34", col_names = "2010")
dfsep <- cbind(dfsep1, dfsep2)
dfsep3 <- read_excel("Plant Production 2011.xlsm", sheet = "September", range = "AD5:AD34", col_names = "2011")
dfsep <- cbind(dfsep, dfsep3)
dfsep4 <- read_excel("Plant Production 2012.xlsm", sheet = "September", range = "AD5:AD34", col_names = "2012")
dfsep <- cbind(dfsep, dfsep4)
dfsep5 <- read_excel("Plant Production 2013.xlsm", sheet = "September", range = "AD5:AD34", col_names = "2013")
dfsep <- cbind(dfsep, dfsep5)
dfsep6 <- read_excel("Plant Production 2014.xlsm", sheet = "September", range = "AD5:AD34", col_names = "2014")
dfsep <- cbind(dfsep, dfsep6)
dfsep7 <- read_excel("Plant Production 2015.xlsm", sheet = "September", range = "AD5:AD34", col_names = "2015")
dfsep <- cbind(dfsep, dfsep7)
dfsep8 <- read_excel("Plant Production 2016.xlsm", sheet = "September", range = "AD5:AD34", col_names = "2016")
dfsep <- cbind(dfsep, dfsep8)
dfsep9 <- read_excel("Plant Production 2017.xlsm", sheet = "September", range = "AD5:AD34", col_names = "2017")
dfsep <- cbind(dfsep, dfsep9)
dfsep10 <- read_excel("Plant Production 2018.xlsm", sheet = "September", range = "AD5:AD34", col_names = "2018")
dfsep <- cbind(dfsep, dfsep10)
dfsep11 <- read_excel("Plant Production 2019.xlsm", sheet = "September", range = "AD5:AD34", col_names = "2019")
dfsep <- cbind(dfsep, dfsep11)
dfsep12 <- read_excel("Plant Production WY2020.xlsm", sheet = "September", range = "AP5:AP34", col_names = "2020")
dfsep <- cbind(dfsep, dfsep12)
#
dfinal <- rbind(dfinal, dfsep)
#
# Read the data from each workbook for the month of October from 2011 through 2020 and write it to the dataframe
# dfinal.
#
dfoct1 <- read_excel("Plant Production 2010.xlsm", sheet = "October", range = "A5:A35", col_names = "Month_Day")
dfoct2 <- read_excel("Plant Production 2010.xlsm", sheet = "October", range = "AH5:AH35", col_names = "2010")
dfoct <- cbind(dfoct1, dfoct2)
dfoct3 <- read_excel("Plant Production 2011.xlsm", sheet = "October", range = "AD5:AD35", col_names = "2011")
dfoct <- cbind(dfoct, dfoct3)
dfoct4 <- read_excel("Plant Production 2012.xlsm", sheet = "October", range = "AD5:AD35", col_names = "2012")
dfoct <- cbind(dfoct, dfoct4)
dfoct5 <- read_excel("Plant Production 2013.xlsm", sheet = "October", range = "AD5:AD35", col_names = "2013")
dfoct <- cbind(dfoct, dfoct5)
dfoct6 <- read_excel("Plant Production 2014.xlsm", sheet = "October", range = "AD5:AD35", col_names = "2014")
dfoct <- cbind(dfoct, dfoct6)
dfoct7 <- read_excel("Plant Production 2015.xlsm", sheet = "October", range = "AD5:AD35", col_names = "2015")
dfoct <- cbind(dfoct, dfoct7)
dfoct8 <- read_excel("Plant Production 2016.xlsm", sheet = "October", range = "AD5:AD35", col_names = "2016")
dfoct <- cbind(dfoct, dfoct8)
dfoct9 <- read_excel("Plant Production 2017.xlsm", sheet = "October", range = "AD5:AD35", col_names = "2017")
dfoct <- cbind(dfoct, dfoct9)
dfoct10 <- read_excel("Plant Production 2018.xlsm", sheet = "October", range = "AD5:AD35", col_names = "2018")
dfoct <- cbind(dfoct, dfoct10)
dfoct11 <- read_excel("Plant Production 2019.xlsm", sheet = "October", range = "AD5:AD35", col_names = "2019")
dfoct <- cbind(dfoct, dfoct11)
dfoct12 <- read_excel("Plant Production WY2020.xlsm", sheet = "October", range = "AP5:AP35", col_names = "2020")
dfoct <- cbind(dfoct, dfoct12)
#
dfinal <- rbind(dfinal, dfoct)
#
# Read the data from each workbook for the month of November from 2011 through 2020 and write it to the dataframe
# dfinal.
#
dfnov1 <- read_excel("Plant Production 2011.xlsm", sheet = "November", range = "A5:A34", col_names = "Month_Day")
dfnov2 <- read_excel("Plant Production 2011.xlsm", sheet = "November", range = "AD5:AD34", col_names = "2010")
dfnov <- cbind(dfnov1, dfnov2)
dfnov3 <- read_excel("Plant Production 2012.xlsm", sheet = "November", range = "AD5:AD34", col_names = "2011")
dfnov <- cbind(dfnov, dfnov3)
dfnov4 <- read_excel("Plant Production 2013.xlsm", sheet = "November", range = "AD5:AD34", col_names = "2012")
dfnov <- cbind(dfnov, dfnov4)
dfnov5 <- read_excel("Plant Production 2014.xlsm", sheet = "November", range = "AD5:AD34", col_names = "2013")
dfnov <- cbind(dfnov, dfnov5)
dfnov6 <- read_excel("Plant Production 2015.xlsm", sheet = "November", range = "AD5:AD34", col_names = "2014")
dfnov <- cbind(dfnov, dfnov6)
dfnov7 <- read_excel("Plant Production 2015.xlsm", sheet = "November", range = "AD5:AD34", col_names = "2015")
dfnov <- cbind(dfnov, dfnov7)
dfnov8 <- read_excel("Plant Production 2017.xlsm", sheet = "November", range = "AD5:AD34", col_names = "2016")
dfnov <- cbind(dfnov, dfnov8)
dfnov9 <- read_excel("Plant Production 2018.xlsm", sheet = "November", range = "AD5:AD34", col_names = "2017")
dfnov <- cbind(dfnov, dfnov9)
dfnov10 <- read_excel("Plant Production 2019.xlsm", sheet = "November", range = "AD5:AD34", col_names = "2018")
dfnov <- cbind(dfnov, dfnov10)
dfnov11 <- read_excel("Plant Production WY2020.xlsm", sheet = "November", range = "AD5:AD34", col_names = "2019")
dfnov <- cbind(dfnov, dfnov11)
dfnov12 <- read_excel("Plant Production WY2021.xlsm", sheet = "November", range = "AD5:AD34", col_names = "2020")
dfnov <- cbind(dfnov, dfnov12)
#
dfinal <- rbind(dfinal, dfnov)
#
# Read the data from each workbook for the month of December from 2011 through 2020 and write it to the dataframe
# dfinal.
#
dfdec1 <- read_excel("Plant Production 2011.xlsm", sheet = "December", range = "A5:A35", col_names = "Month_Day")
dfdec2 <- read_excel("Plant Production 2011.xlsm", sheet = "December", range = "AD5:AD35", col_names = "2010")
dfdec <- cbind(dfdec1, dfdec2)
dfdec3 <- read_excel("Plant Production 2012.xlsm", sheet = "December", range = "AD5:AD35", col_names = "2011")
dfdec <- cbind(dfdec, dfdec3)
dfdec4 <- read_excel("Plant Production 2013.xlsm", sheet = "December", range = "AD5:AD35", col_names = "2012")
dfdec <- cbind(dfdec, dfdec4)
dfdec5 <- read_excel("Plant Production 2014.xlsm", sheet = "December", range = "AD5:AD35", col_names = "2013")
dfdec <- cbind(dfdec, dfdec5)
dfdec6 <- read_excel("Plant Production 2015.xlsm", sheet = "December", range = "AD5:AD35", col_names = "2014")
dfdec <- cbind(dfdec, dfdec6)
dfdec7 <- read_excel("Plant Production 2015.xlsm", sheet = "December", range = "AD5:AD35", col_names = "2015")
dfdec <- cbind(dfdec, dfdec7)
dfdec8 <- read_excel("Plant Production 2017.xlsm", sheet = "December", range = "AD5:AD35", col_names = "2016")
dfdec <- cbind(dfdec, dfdec8)
dfdec9 <- read_excel("Plant Production 2018.xlsm", sheet = "December", range = "AD5:AD35", col_names = "2017")
dfdec <- cbind(dfdec, dfdec9)
dfdec10 <- read_excel("Plant Production 2019.xlsm", sheet = "December", range = "AD5:AD35", col_names = "2018")
dfdec <- cbind(dfdec, dfdec10)
dfdec11 <- read_excel("Plant Production WY2020.xlsm", sheet = "December", range = "AD5:AD35", col_names = "2019")
dfdec <- cbind(dfdec, dfdec11)
dfdec12 <- read_excel("Plant Production WY2021.xlsm", sheet = "December", range = "AD5:AD35", col_names = "2020")
dfdec <- cbind(dfdec, dfdec12)
#
dfinal <- rbind(dfinal, dfdec)
#
# Compute the mean for each day over all the years
#
dfinal$Mean = apply(dfinal[2:12], 1, mean, na.rm = TRUE)
#
# Compute the median for each day over all the years
#
dfinal$Median = apply(dfinal[2:12], 1, median, na.rm = TRUE)

# Determine the maximum by day over all of the days
dfinal$Maximum <- apply(dfinal[2:12], 1, max, na.rm = TRUE)
#
# Determine the minimum value by day over all of the days
dfinal$Minimum <- apply(dfinal[2:12], 1, min, na.rm = TRUE)
#
# Replace the values in the Month_Day column with just the month and day. The dates from the Excel workbooks have
# incorrect years.
dfinal[1] <- format(dfinal[1], "%m-%d")
#
# Calculate the average acre-feet per day by day. Population numbers are from the demand workbook 
# WR Water Demands 2065 BO 242K - February 2020 updated 02262020.xlsx
# Open the workbook and load the population into the dataframe
pop <- data.frame(read_excel("WR Water Demands 2065 BO 242K - February 2020 updated 02262020.xlsx", sheet = "Data", range = "C8:C17", col_names = "population"))
#
# Used during testing
View(pop)
# Used during testing
View(dfinal)
#
# Write the dataframe to a .csv file
write.csv(dfinal,'dfinal.csv', row.names = FALSE)
#
# End of BuildTotalProduction.R




