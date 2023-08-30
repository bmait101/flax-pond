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
  select(year, date, time, d_n, location, depth, area, spp_code, common_name, total_caught, mean_weight)

# Simple plot to look at things
flax |> 
  ggplot(aes(date, total_caught)) + 
  geom_point() + 
  facet_wrap(vars(common_name))


# flounder density by site
flax |> 
  mutate(density = mean_weight/area) |> 
  filter(common_name=="Flounder") |> 
  ggplot(aes(date, density)) + 
  geom_point() + 
  facet_wrap(vars(location))



