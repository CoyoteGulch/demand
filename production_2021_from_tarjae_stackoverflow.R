library(tidyverse)
library(scales)

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
# data manipulation
dfinal21_long <- dfinal21 %>% 
  pivot_longer(
    cols = c(`2021`, Mean, Median, Maximum, Minimum),
    names_to = "names", 
    values_to = "values"
  ) %>% 
  mutate(color = case_when(names=="Mean" ~ "red",
                           names=="Median" ~ "yellow",
                           names=="Maximum" ~ "darkgreen",
                           names=="Minimum" ~ "darkviolet")) %>% 
  arrange(names)

# function for custom transformation of y axis
shift_trans = function(d = 0) {
  scales::trans_new("shift", transform = function(x) x - d, inverse = function(x) x + d)
}

# plot

p_21 <- ggplot()  + 
  geom_col(data= dfinal21_long[1:10,],mapping = aes(x=Month_Day,y=values), size = 1, color = "darkblue", fill = "white" ) +
  geom_line(data= dfinal21_long[11:50,],mapping=aes(x=Month_Day,y=values, color=color), size = 1.0) +
  scale_x_date(breaks = "1 month", minor_breaks = "1 day", labels=date_format("%b")) +
  labs(x = "Month", y = "acre-feet", title = "Treatment Plant Production 2021") + 
  scale_y_continuous(trans = shift_trans(20))+
  scale_color_manual(labels = c("Maximum","Mean","Median","Minimum"), values = c("red","yellow","darkgreen","darkviolet")) +
  theme_minimal() +
  theme(legend.position="bottom") +
  theme(legend.title=element_blank())

print(p_21)