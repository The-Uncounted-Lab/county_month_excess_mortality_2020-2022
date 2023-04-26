library(tidyverse)
library(USAboundaries)
library(sf)
library(ggthemes)
library(RColorBrewer)
library(patchwork)
library(scales)
library(scico)
library(cartography)
library(here)
library(readr)
library(maps)
library(gganimate)
library(ggthemr)
library(grid)
library(magick)
library(arrow)
library(USAboundariesData)

## set working directory
setwd("/Users/zhenweizhou/Documents/GitHub/Vital-Stats-Integrity-Proj/monthly_county_level_excess_mortality")

## read in datasets
exmort_monthly_ori <- read_csv("./data/output/exMortEstimatesMonthlyINLA.csv")
FIPSFixes <- read_csv("./data/input/FIPSHarmonization/FIPSFixes.csv")

## define pead periods
# exmort_monthly_ori$month <- format(exmort_monthly_ori$monthYear, "%m") %>% as.integer()
# 
# exmort_monthly_ori$year <- format(exmort_monthly_ori$monthYear, "%Y") %>% as.integer()
# 
# exmort_monthly_ori <- exmort_monthly_ori %>%
#   dplyr::rename(deaths = imputedDeaths)
# 
# exmort_monthly <- exmort_monthly_ori

exmort_monthly <- exmort_monthly_ori %>% 
  rename(deaths = imputedDeaths) %>% 
  mutate(
    month = format(monthYear, "%m") %>% as.integer(),
    yead = format(monthYear, "%Y") %>% as.integer(),
    Period = ifelse(as.Date("2020-03-01") <= monthYear  & monthYear < as.Date("2020-09-01"), "Initial Peak",
                                                                   ifelse(as.Date("2020-11-01") <= monthYear & monthYear < as.Date("2021-03-01"), "Winter Peak",
                                                                          ifelse(as.Date("2021-08-01") <= monthYear & monthYear < as.Date("2021-11-01"), "Delta Peak",
                                                                                 ifelse(as.Date("2021-12-01") <= monthYear & monthYear < as.Date("2022-03-01"), "Omicron Peak", "Others")))))


exmort_variant_period <- exmort_monthly %>% group_by(FIPSCode, Period) %>% summarize_at(c("deaths", "expDeathsUp", "expDeathsMed", "expDeathsLow", "pop"), sum)


exmort_variant_period_other_vars <- exmort_monthly %>% group_by(FIPSCode, Period) %>% select(csCode:state, metroCat:BEARegion, Period)

exmort_variant_period_other_vars <- exmort_variant_period_other_vars[!duplicated(paste0(exmort_variant_period_other_vars$FIPSCode, exmort_variant_period_other_vars$Period)), ]

exmort_variant_period <- left_join(exmort_variant_period, exmort_variant_period_other_vars, by = c("FIPSCode", "Period"))


exmort_variant_period <- exmort_variant_period %>% mutate(relativeExc = (deaths/expDeathsMed) - 1)

quantiles_for_relativeExc <- quantile(exmort_variant_period$relativeExc, seq(0, 1, length = 9))

quantiles_for_relativeExc[1] <- -Inf
quantiles_for_relativeExc[length(quantiles_for_relativeExc)] <- Inf

quantiles_for_relativeExc_prct <- round(quantiles_for_relativeExc*100, 2)[2:8]

quantiles_for_relativeExc_prct_int <- paste0("(", paste0(quantiles_for_relativeExc_prct, "%"), ", ", lead(paste0(quantiles_for_relativeExc_prct, "%")), "]")

quantiles_for_relativeExc_prct_int <- c(paste0(intToUtf8(8804), quantiles_for_relativeExc_prct[1], "%"),
                                        quantiles_for_relativeExc_prct_int[-7],
                                        paste0(intToUtf8(8805), quantiles_for_relativeExc_prct[7], "%"))

exmort_variant_period$relativeExcDiscrete <- factor(cut(exmort_variant_period$relativeExc, quantiles_for_relativeExc), 
                                                    labels=quantiles_for_relativeExc_prct_int)




FIPSFixes <- FIPSFixes %>%
  dplyr::rename(oldFIPSCode = FIPSCode,
                FIPSCode = newFIPSCode)

exmort_variant_period <- exmort_variant_period %>%
  left_join(FIPSFixes,by='FIPSCode') %>%
  mutate(altFIPSCode = if_else(is.na(oldFIPSCode),FIPSCode,oldFIPSCode)) %>%
  select(-oldFIPSCode)


exmort_variant_period <- exmort_variant_period %>%
  mutate(countyName = if_else(FIPSCode == '35013','Dona Ana',countyName),
         countyStateName = paste0(countyName,' (',stateStr,')'))


counties <- us_counties()
# Transform to Albers for making map of US
counties <- st_transform(counties, 5070)

counties <- counties %>%
  select(geoid,stusps,geometry) %>%
  filter(stusps != 'PR') %>%
  select(-stusps) %>%
  dplyr::rename(FIPSCodeGeo = geoid) 

counties <- tigris::shift_geometry(counties)


states <- us_states()
states <- states %>% filter(stusps!='PR')
states <- tigris::shift_geometry(states)


exmort_variant_period_spatial <- 
  counties %>%
  left_join(exmort_variant_period,by=c('FIPSCodeGeo'='altFIPSCode')) %>%
  sf::st_as_sf()


jpeg("./figures/map_by_variants_peak_period.jpg", res = 300, w = 3600, h = 2500)

exmort_variant_period_spatial %>% mutate(Period = factor(Period, levels = c("Others", "Initial Peak", "Winter Peak", "Delta Peak", "Omicron Peak"))) %>%  filter(Period != "Others") %>% 
  ggplot() +
  geom_sf(mapping=aes(fill = relativeExcDiscrete),
          color = "gray30", size = 0.05) +
  geom_sf(data = states, color = "black", fill='transparent', size = 0.05) +
  scale_fill_manual(values = rev(c("#67001F", "#B2182B", "#D6604D", "#F4A582", "#FDDBC7", "#fce5d7", "#F7F7F7", "#92C5DE"))) +
  labs(fill='Relative Excess (%)') +
  coord_sf() +
  facet_wrap(~Period, ncol = 2) +
  # labs(title = paste0("Period")) +
  theme_map() +
  theme(legend.position = 'bottom',
        strip.background = element_rect(colour = "white", fill = "white"),
        strip.text = element_text(size = 14, face = "bold"))


dev.off()

# brewer.pal(11, "RdBu")
#