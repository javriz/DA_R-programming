#import excel file for data-analysis

library(readxl)
flights_df <- read_xlsx("C:/Users/auxte/OneDrive/Desktop/DA-PURDUE/R/1657873325_flightdelays.xlsx")

### Checking missing data?
sum(is.na(flights_df))

## skimr() - expands on summary() by providing larger set of statistics
library(skimr)

skim(flights_df)


## Data Visualization in R

# Histogram
hist(flights_df$schedtime)
hist(flights_df$schedtime, col = "blue")

############
library(ggplot2)
library(dplyr)
library(lubridate)
library(tidyr)
library(scales)

flights_df <- flights_df %>%
  mutate(
    # Convert scheduled time
    sched_datetime = as.POSIXct(sprintf("%04d", schedtime), format = "%H%M"),
    sched_hour = hour(sched_datetime),
    sched_time = format(sched_datetime, "%H:%M"),
    
    # Convert departure time
    dep_datetime = as.POSIXct(sprintf("%04d", deptime), format = "%H%M"),
    dep_hour = hour(dep_datetime),
    dep_time = format(dep_datetime, "%H:%M"),
    
    # Convert date
    date = as.Date(date, format = "%m/%d/%Y"),
    day_of_week = wday(date, label = TRUE, abbr = FALSE),
    
    # Enhance delay status
    delay_status = factor(delay, levels = c("ontime", "delayed")),
    delay_minutes = ifelse(delay == "delayed", 
                           abs(as.numeric(difftime(dep_datetime, sched_datetime, units = "mins"))), 
                           0)
  )

### peak flight hours
ggplot(flights_df, aes(x = sched_hour)) +
  geom_histogram(binwidth = 1, fill = "steelblue", alpha = 0.8) +
  labs(title = "Distribution of Scheduled Departure Times",
       subtitle = "Peak flight hours throughout the day",
       x = "Hour of Day", y = "Number of Flights") +
  scale_x_continuous(breaks = seq(0, 23, by = 2)) +
  theme_minimal()

## Departure Delays by Hour
ggplot(flights_df, aes(x = sched_hour, y = delay_minutes, group = sched_hour)) +
  geom_boxplot(fill = "steelblue", outlier.alpha = 0.5) +
  labs(title = "Departure Delay Distribution by Scheduled Hour",
       x = "Scheduled Hour", y = "Delay (minutes)") +
  theme_minimal()

##  Busiest Destinations
top_dests <- flights_df %>%
  count(dest, sort = TRUE) %>%
  head(10)
ggplot(top_dests, aes(x = reorder(dest, n), y = n)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "Top 3 Busiest Destinations",
       x = "Destination Airport", y = "Number of Flights") +
  theme_minimal()


##























  










