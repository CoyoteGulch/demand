#Copyright: City of Thornton Water Resources
#Author: John Orr
#This program is used to aggregate diversion data from the drought years of 2002, 2006, and 2012
#and plot the change in storage based on COT diversions, production, and storage. The starting 
#storage is the non-drought yelibar storage from January 2018.

library(tidyverse)
library(readxl)
library(ggplot2)

# Read the diversion data from Excel and store it in a dataframe.

droughtanalysisdata <- read_excel("droughtanalysisdata.xlsx", sheet = "2002 UCC")
df <- droughtanalysisdata[, c("Month", "Total")]
colnames(df) <- c("Month", "UCC02")

droughtanalysisdata1 <- read_excel("droughtanalysisdata.xlsx", sheet = "2006 UCC")
df1 <- droughtanalysisdata1[, c("Month", "Total")]
colnames(df1) <- c("Month","UCC06")

dftotal <- merge(df, df1)

droughtanalysisdata2 <- read_excel("droughtanalysisdata.xlsx", sheet = "2012 UCC")
df2 <- droughtanalysisdata2[, c("Month", "Total")]
colnames(df2) <- c("Month", "UCC12")

dftotal <- merge(dftotal, df2)

droughtanalysisdata3 <- read_excel("droughtanalysisdata.xlsx", sheet = "2002 LCC")
df3 <- droughtanalysisdata3[, c("Month", "Total")]
colnames(df3) <- c("Month", "LCC02")

dftotal <- merge(dftotal, df3)

droughtanalysisdata4 <- read_excel("droughtanalysisdata.xlsx", sheet = "2006 LCC")
df4 <- droughtanalysisdata4[, c("Month", "Total")]
colnames(df4) <- c("Month", "LCC06")

dftotal <- merge(dftotal, df4)

droughtanalysisdata5 <- read_excel("droughtanalysisdata.xlsx", sheet = "2012 LCC")
df5 <- droughtanalysisdata5[, c("Month", "Total")]
colnames(df5) <- c("Month", "LCC12")

dftotal <- merge(dftotal, df5)

droughtanalysisdata6 <- read_excel("droughtanalysisdata.xlsx", sheet = "2002 SP")
df6 <- droughtanalysisdata6[, c("Month", "Total")]
colnames(df6) <- c("Month", "SP02")

dftotal <- merge(dftotal, df6)

droughtanalysisdata7 <- read_excel("droughtanalysisdata.xlsx", sheet = "2006 SP")
df7 <- droughtanalysisdata7[, c("Month", "Total")]
colnames(df7) <- c("Month", "SP06")

dftotal <- merge(dftotal, df7)

droughtanalysisdata8 <- read_excel("droughtanalysisdata.xlsx", sheet = "2012 SP")
df8 <- droughtanalysisdata8[, c("Month", "Total")]
colnames(df8) <- c("Month", "SP12")

dftotal <- merge(dftotal, df8)

#Add a column to hold the diversion data average by month for the 3 drought years
dftotal <- add_column(dftotal, rowSums(dftotal[2:10] / 3), .after = NULL)
names(dftotal)[11] <- "droughtavg"

#Add a column with the abbreviated names of the months of the year
dftotal <- add_column(dftotal, c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))
names(dftotal)[12] <- "monthname"

#Create a 3 year dataframe for diversion totals
dftotal3 <- rbind(dftotal, dftotal)
dftotal3 <- rbind(dftotal3, dftotal)

#Add a column with 36 months of dates
#Build the sequence
dateseq <- seq(as.Date("2017/1/1"), by = "month", length.out = 36)

dftotal3 <- add_column(dftotal3, dateseq)

#Production data for 2017
dfprod <- read_excel("droughtanalysisdata.xlsx", sheet = "2017 Prod")
dfprod1 <- dfprod[, c("Month", "Total")]
colnames(dfprod1) <- c("Month", "droughtavg")

#Add a column with the abbreviated names of the months of the year
dfprod1 <- add_column(dfprod1, c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))
names(dfprod1)[3] <- "monthname"

#Create a 3 year dataframe for production totals
dfprod3 <- rbind(dfprod1, dfprod1)
dfprod3 <- rbind(dfprod3, dfprod1)

#Add a column with 36 months of dates
#Build the sequence
dateseq <- seq(as.Date("2017/1/1"), by = "month", length.out = 36)

dfprod3 <- add_column(dfprod3, dateseq)

#Storage calculation from Excel
dfstor <- read_excel("droughtanalysisdata.xlsx", sheet = "Storage")
dfstor1 <- dfstor[, c("Month", "Beg_Stor")]
colnames(dfstor1) <- c("Month", "Beg")

#Add a column with the abbreviated names of the months of the year
dfstor1 <- add_column(dfstor1, c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))
names(dfstor1)[3] <- "monthname"
dfstor1 <- add_column(dfstor, dateseq)

#Plot the data
dplot <- ggplot(data = dftotal3, aes(x=dateseq, y=droughtavg)) +
         geom_col(aes(fill = "Diversions")) +
         scale_x_discrete(limits = dftotal3$dateseq, labels = c(format(dftotal3$dateseq, "%b"))) +
         scale_y_log10(name = "Acre-Feet", breaks = c(0,100, 500, 1000, 2000, 6000, 15000, 30000)) +
         ggtitle("Senior Rights and a Three Year Drought") + theme(plot.title = element_text(face = "bold", color = "Blue")) +
         xlab("Month") +
         theme(axis.text.x=element_text(angle=60, hjust=1)) +
         theme(axis.text.x = element_text(face="bold", color="Black", size=5)) +
         geom_line(data = dfstor1, aes(x = dateseq, y = Beg_Stor, color="Storage"), size = 1) +
         geom_line(data = dfprod3, aes(x = dateseq, y = droughtavg, color="Production"), size = 1) +
         scale_fill_manual(values=c("Diversions"="cyan")) +
         scale_color_manual(values=c("Storage"="blue", "Production"="magenta"))

print(dplot)