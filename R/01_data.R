# Code by Bryan M Maitland
# 2023-Aug-30

library(tidyverse)
library(here)

# flax$density <- flax$mean_weight/flax$area  #calculate biomass density

# Load data
flax <- read_csv(here("data", "flaxdata_R.csv"))|> janitor::clean_names()
species <- read_csv(here("data", "spp-codes.csv")) |> janitor::clean_names()

# clean and tidy
flax <- flax |> 
  left_join(species, by = "spp_code") |> 
  select(year, date, time, d_n, location, depth, area, spp_code, common_name, total_caught, mean_weight) |> 
  mutate(density = mean_weight/area)

# Simple plot to look at things
flax |> 
  ggplot(aes(date, density)) + 
  geom_point() + 
  facet_wrap(vars(common_name), scales = "free_y")


# flounder density
flax |> 
  # filter(common_name=="Flounder",year!="72 (2nd)",year!="72 (3rd)") |>
  mutate(month = month(date, label = TRUE)) |> 
  ggplot(aes(month, density)) + 
  geom_bar(stat = "identity") + 
  # facet_wrap(vars(year), scales = "free") +
  geom_smooth(se = FALSE)


plot(flax$area ~ flax$depth)
