library(ggplot2)
library(scales)
library(patchwork)
#
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
# Build the plot.
# Code from John Volckens
library(dplyr)
library(tidyr)
library(tidyverse) #added to John's code so that ggplot function is available

dfinal21a <- dfinal21 %>%
  mutate(y2021 = `2021`) %>% #rename column
  select(-(`2021`)) %>% # remove old col name
  pivot_longer(cols = Mean:y2021, names_to = "measure", values_to = "data") #tidy the data

#Show the tidy data
View(dfinal21a)

p_2021 <- ggplot() +
  geom_col(data = filter(dfinal21a, measure == "y2021"),
           aes(y = data, x = Month_Day),
           color = "darkblue", fill = "white") +
  geom_line(data = filter(dfinal21a, measure != "y2021"),
            aes(y = data, x = Month_Day, color = measure)) +
  scale_color_manual(values = c("red", "yellow", "darkgreen", "darkviolet")) +
  coord_cartesian(ylim = c(20,150)) + #changed range to include maximums 
  theme(legend.title = element_blank()) + 
  scale_color_discrete(name = "Year") +
  scale_x_date(breaks = "1 month", minor_breaks = "1 day", labels=date_format("%b")) +
  labs(x = "Month", y = "acre-feet", title = "Treatment Plant Production 2021")
# Save the plot to disk
ggsave(filename = "p_f21_bars.pdf", plot = p_2021, units = "in", width = 44, height = 34)
#
# Display the plot
#
print(p_2021)
#
# End production_2021_bars_lines.R