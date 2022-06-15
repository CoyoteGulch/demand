# Program to graph dfrwfinal with daily values in bars and lines for median, max, and min, and average
#
library(dplyr)
library(readxl)
library(magrittr)
library(tibble)
library(tidyr)
library(ggplot2)
library(scales)
library(patchwork)
library(tidyverse)
#
# Read the file dfrwfinal from disk and store it in a tibble named dfrwfinaltibble
dfrwfinaltibble <- read.csv("dfrwfinal.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE, check.names = FALSE)
dfrwfinaltibble <- tibble(dfrwfinaltibble)
#
# Tidy dfrwfinaltibble
dfrwfinaltibble <- dfrwfinaltibble %>% pivot_longer(c(y_2010, y_2011, y_2012, y_2013, y_2014, y_2015, y_2016, y_2017, y_2018, y_2019, y_2020, y_2021), names_to = "year", values_to = "acre_feet" )
#
# Change the month_day column adding the year so that ggplot can treat it as a date
dfrwfinaltibble$month_day <- paste(dfrwfinaltibble$month_day, str_sub(x$year, 3, 6))
# Used during testing
View(dfrwfinaltibble)
#
# Plot the data
#p <- ggplot(dfrwfinaltibble)
#

