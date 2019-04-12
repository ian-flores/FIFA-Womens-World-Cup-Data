library(tidyverse)
library(lubridate)

world_cup <- read_csv('matches.csv')

part_1 <- world_cup %>%
    filter(str_length(date) > 18) %>%
    mutate(date = ymd_hms(date)) %>%
    filter(!is.na(date)) %>%
    mutate(date = as_date(date))

part_2 <- world_cup %>%
    mutate(home_team = str_trim(home_team)) %>%
    filter(str_length(date) > 18) %>%
    mutate(new_date = ymd_hms(date)) %>%
    filter(is.na(new_date)) %>%
    mutate(date = str_split(date, '\\[')[[1]][1],
           date = dmy(date)) %>%
    select(-new_date)

part_3 <- world_cup %>%
    filter(str_length(date) <= 18) %>%
    mutate(date = dmy(date))

world_cup <- bind_rows(part_1, part_2, part_3)

world_cup %>%
    write_csv('wwc_world_cup.csv')
