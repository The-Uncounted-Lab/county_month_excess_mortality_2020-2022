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
library(lubridate)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(paletteer)
library(colorspace)


rm(list=ls())

i_am('R/maps_stripplot.R')

inDir <- here('data','input')
outDir <- here('data','output')

## read in datasets
FIPSFixes <- read_csv(paste0(inDir, "/FIPSHarmonization/FIPSFixes.csv"))
estwaves <- read_csv(paste0(outDir, "/estimatesWaves.csv"))
estmonths <- read_csv(paste0(outDir, "/estimatesMonthly.csv"))
estyears <- read_csv(paste0(outDir, "/estimatesPYears.csv"))

counties <- us_counties()


states <- us_states()


estwaves <- left_join(estwaves, as.data.frame(us_counties())[, c("geoid", "stusps")], by = c("FIPSCode" = "geoid"))



exmort_periods <- estwaves %>% mutate(period = wave)

FIPSFixes <- FIPSFixes %>%
  dplyr::rename(oldFIPSCode = FIPSCode,
                FIPSCode = newFIPSCode)

exmort_periods <- exmort_periods %>%
  left_join(FIPSFixes,by='FIPSCode') %>%
  mutate(altFIPSCode = if_else(is.na(oldFIPSCode),FIPSCode,oldFIPSCode)) %>%
  select(-oldFIPSCode)


exmort_periods <- exmort_periods %>%
  mutate(countyName = if_else(FIPSCode == '35013','Dona Ana',countyName),
         countyStateName = paste0(countyName,' (',stusps,')'))



# Transform to Albers for making map of US
counties <- st_transform(counties, 5070)

counties <- counties %>%
  select(geoid,stusps,geometry) %>%
  filter(stusps != 'PR') %>%
  select(-stusps) %>%
  dplyr::rename(FIPSCodeGeo = geoid) 

counties <- tigris::shift_geometry(counties)

states <- states %>% filter(stusps!='PR')
states <- tigris::shift_geometry(states)

exmort_periods_spatial <- 
  counties %>%
  left_join(exmort_periods,by=c('FIPSCodeGeo'='altFIPSCode')) %>%
  sf::st_as_sf()


exmort_periods_spatial <- exmort_periods_spatial %>% mutate(relativeExc = (imputedDeaths/expDeathsMed) - 1)

duplicated(exmort_periods_spatial$FIPSCodeGeo[exmort_periods_spatial$pandemicYear == "Mar 2020 - Feb 2021"]) %>% sum()

exmort_periods_spatial$FIPSCodeGeo[exmort_periods_spatial$pandemicYear == "Mar 2020 - Feb 2021"][duplicated(exmort_periods_spatial$FIPSCodeGeo[exmort_periods_spatial$pandemicYear == "Mar 2020 - Feb 2021"])]

duplicated_counties <- exmort_periods_spatial[exmort_periods_spatial$FIPSCodeGeo %in% c("02195" ,"02105"), ]

# Hoonah-Angoon Census Area, AK (FIPS code = 02105). The Hoonah-Angoon Census Area was created from the remainder of the former Skagway-Hoonah-Angoon Census Area (FIPS code = 02232) when Skagway Municipality (FIPS code = 02230) was created effective June 20, 2007. Estimates for this area are on Vintage 2008 and later bridged-race population files. Effective January 3, 2013, part of this area was removed and merged with the new Petersburg Borough (02280). Note that no data for Hoonah-Angoon Census Area appear on NCHS birth and mortality files until 2014. (https://www.cdc.gov/nchs/nvss/bridged_race/county_geography_bridge_race.pdf)

duplicated_counties_unique <- duplicated_counties[c(1, 3, 6, 8), ]

exmort_periods_spatial <- exmort_periods_spatial %>% filter(!FIPSCodeGeo %in% c("02195" ,"02105"))

exmort_periods_spatial <- rbind(exmort_periods_spatial, duplicated_counties_unique)



##########################
# Maps
##########################



num_cats <- 6

quantiles_for_relativeExc <-  c(-Inf, 0, round((exmort_periods_spatial$relativeExc %>% quantile(., probs = c(0.3, 0.6, 0.8, 0.95), na.rm = T))/0.05)*0.05, Inf)


quantiles_for_relativeExc_prct <- round(quantiles_for_relativeExc*100, 2)[2:num_cats]

quantiles_for_relativeExc_prct_int <- paste0("(", paste0(quantiles_for_relativeExc_prct, "%"), ", ", lead(paste0(quantiles_for_relativeExc_prct, "%")), "]")

quantiles_for_relativeExc_prct_int <- c(paste0(intToUtf8(8804), quantiles_for_relativeExc_prct[1], "%"),
                                        quantiles_for_relativeExc_prct_int[-(num_cats-1)],
                                        paste0(">", quantiles_for_relativeExc_prct[num_cats-1], "%"))

exmort_periods_spatial$relativeExcDiscrete <- factor(cut(exmort_periods_spatial$relativeExc, quantiles_for_relativeExc), 
                                                     labels=quantiles_for_relativeExc_prct_int)


table(exmort_periods_spatial$relativeExcDiscrete, exmort_periods_spatial$period)

# Relative Excess Mortality map

jpeg(paste0(here('figures'), "/map_relativeExc_by_wave.jpg"), res = 300, w = 3600, h = 2500)

exmort_periods_spatial %>% 
  mutate(period = factor(period, levels = c(1, 2, 3, 4), labels = c("Initial (Mar - Aug 2020)", "Winter (Oct 2020 - Feb 2021)", "Delta (Aug - Oct 2021)", "Omicron (Nov 2021 - Feb 2022)"))) %>%  filter(!is.na(period)) %>%
  ggplot() +
  geom_sf(mapping=aes(fill = relativeExcDiscrete),
          colour = NA) +
  geom_sf(data = states, color = "gray30", fill='transparent', size = 0.05) +
  scale_fill_discrete_sequential(palette = "Red-Yellow", nmax = 6, rev = T) +
  labs(fill='Relative Excess (%)') +
  coord_sf() +
  facet_wrap(~period, ncol = 2) +
  theme_map() +
  theme(legend.position = 'bottom', legend.direction="horizontal",
        strip.background = element_rect(colour = "white", fill = "white"),
        strip.text = element_text(size = 14, face = "bold"))


dev.off()

from_cut <- c(0, 0.75, 0.95, 0.99, 0.999, 1)
to_cut <- c(0, 0.1, 0.4, 0.6, 0.8, 1)


exp_sqrt <- function(x = seq(0, 1, 0.01), to = to_cut, from = from_cut){
  ind_x <- cut(x, from, include.lowest = T)
  x_transformed <- x
  for(ind in 1:length(levels(ind_x))){
    x_transformed[ind_x %in% levels(ind_x)[ind]]  <- to[ind] + (x[ind_x %in% levels(ind_x)[ind]] - from[ind])*(to[ind + 1] - to[ind])/(from[ind + 1] - from[ind])
  }
  x_transformed 
    
}


inv_exp_sqrt <- function(x = seq(0, 1, 0.01), from = to_cut, to = from_cut){
  ind_x <- cut(x, from, include.lowest = T)
  x_transformed <- x
  for(ind in 1:length(levels(ind_x))){
    x_transformed[ind_x %in% levels(ind_x)[ind]]  <- to[ind] + (x[ind_x %in% levels(ind_x)[ind]] - from[ind])*(to[ind + 1] - to[ind])/(from[ind + 1] - from[ind])
  }
  x_transformed
  
}

exp_sqrt_trans <- function() {
  trans_new(name = "exp_sqrt",
            transform = exp_sqrt,
            inverse = inv_exp_sqrt)
}


# Probability of Positive Excess Mortality map

jpeg(paste0(here('figures'), "/map_probPositive_by_wave.jpg"), res = 300, w = 3600, h = 2500)

exmort_periods_spatial %>% 
  mutate(period = factor(period, levels = c(1, 2, 3, 4), labels = c("Initial (Mar - Aug 2020)", "Winter (Oct 2020 - Feb 2021)", "Delta (Aug - Oct 2021)", "Omicron (Nov 2021 - Feb 2022)"))) %>%  filter(!is.na(period)) %>%
  ggplot() +
  geom_sf(mapping=aes(fill = probPositive),
          colour = NA) +
  geom_sf(data = states, color = "gray30", fill='transparent', size = 0.05) +
  scale_fill_scico(palette='oslo',direction=,begin = 0.95, end=0.25, na.value="grey", trans = "exp_sqrt", breaks = from_cut) +
  labs(fill='Probability of Positive Relative Excess (%)   ') +
  coord_sf() +
  facet_wrap(~period, ncol = 2) +
  theme_map() +
  theme(legend.position = 'bottom',
        strip.background = element_rect(colour = "white", fill = "white"),
        strip.text = element_text(size = 14, face = "bold")) +
  guides(fill = guide_colourbar(barwidth = 15, barheight = 0.5))

dev.off()


##########################
# Strip plot
##########################


exmort_periods <- estyears %>% mutate(pandemicYear = factor(pandemicYear, levels = c("Mar 2020 - Feb 2021", "Mar 2021 - Feb 2022")))


exmort_periods <- left_join(exmort_periods, as.data.frame(us_counties())[, c("geoid", "stusps")], by = c("FIPSCode" = "geoid"))


exmort_periods <- exmort_periods %>%
  left_join(FIPSFixes,by='FIPSCode') %>%
  mutate(altFIPSCode = if_else(is.na(oldFIPSCode),FIPSCode,oldFIPSCode)) %>%
  select(-oldFIPSCode)


exmort_periods <- exmort_periods %>%
  mutate(countyName = if_else(FIPSCode == '35013','Dona Ana',countyName),
         countyStateName = paste0(countyName,' (',stusps,')'))


exmort_periods_spatial <- 
  counties %>%
  left_join(exmort_periods,by=c('FIPSCodeGeo'='altFIPSCode')) %>%
  sf::st_as_sf()



exmort_periods_spatial <- exmort_periods_spatial %>% mutate(relativeExc = (deaths/expDeathsMed) - 1)

exmort_years_ori_pop_avg <- estmonths %>% group_by(FIPSCode) %>% summarise(pop = mean(pop, na.rm = T))

pop_avg_fipscode_index <- exmort_years_ori_pop_avg$FIPSCode[exmort_years_ori_pop_avg$pop >= 30000]


exmort_periods_spatial <- exmort_periods_spatial %>% left_join(exmort_years_ori_pop_avg, by = "FIPSCode")

top_N <- 30

dat_temp <- exmort_periods_spatial  %>% 
  filter(pandemicYear == "Mar 2020 - Feb 2021") %>% 
  filter(!duplicated(FIPSCode)) %>% 
  mutate(metro_binary = metroCat) %>% 
  group_by(metro_binary) %>% 
  slice_max(pop, n = top_N) %>% select(pandemicYear, FIPSCode, countyName, stusps, relativeExc, metro_binary, excDeathsMed) 

# dat_temp <- dat_temp[!duplicated(dat_temp$FIPSCode), ]

dat_temp$countyName2 <- paste0(dat_temp$countyName, " (", dat_temp$stusps, ")")

dat_temp <- dat_temp %>% arrange(relativeExc)

dat_temp$countyName2 <- factor(dat_temp$countyName2, levels = dat_temp$countyName2)


dat_temp2 <- exmort_periods_spatial %>% 
  filter(FIPSCode %in% dat_temp$FIPSCode & pandemicYear == "Mar 2021 - Feb 2022") %>% 
  filter(!duplicated(FIPSCode)) %>% 
  mutate(metro_binary = metroCat) %>% 
  group_by(metro_binary) %>% 
  select(pandemicYear, FIPSCode, countyName, stusps, relativeExc, metro_binary) 

dat_temp2 <- dat_temp2 %>% left_join(as.data.frame(dat_temp[c("FIPSCode", "excDeathsMed")])[, 1:2], by = "FIPSCode")

dat_temp2$countyName2 <- paste0(dat_temp2$countyName, " (", dat_temp2$stusps, ")")


dat_temp2$countyName2 <- factor(dat_temp2$countyName2, levels = dat_temp$countyName2)

dat_temp_stripplot <- rbind(dat_temp, dat_temp2) %>% arrange(countyName2, metro_binary) %>% mutate(paired = rep(1:(dim(dat_temp)[1]/4), each = 2))


dat_temp_stripplot$arrow_color <- factor("grey")
dat_temp_stripplot$arrow_size <- factor("1.2")


dat_temp_stripplot_for_arrow <- dat_temp_stripplot





dat_temp_stripplot_for_arrow$relativeExc[dat_temp_stripplot_for_arrow$pandemicYear == "Mar 2021 - Feb 2022"] <- sapply(dat_temp_stripplot_for_arrow$FIPSCode[dat_temp_stripplot_for_arrow$pandemicYear == "Mar 2021 - Feb 2022"], function(x){
  if(dat_temp_stripplot_for_arrow$relativeExc[dat_temp_stripplot_for_arrow$pandemicYear == "Mar 2021 - Feb 2022" & dat_temp_stripplot_for_arrow$FIPSCode == x] > dat_temp_stripplot_for_arrow$relativeExc[dat_temp_stripplot_for_arrow$pandemicYear == "Mar 2020 - Feb 2021" & dat_temp_stripplot_for_arrow$FIPSCode == x]){
    dat_temp_stripplot_for_arrow$relativeExc[dat_temp_stripplot_for_arrow$pandemicYear == "Mar 2021 - Feb 2022" & dat_temp_stripplot_for_arrow$FIPSCode == x]#+ 0.016
  }else{
    dat_temp_stripplot_for_arrow$relativeExc[dat_temp_stripplot_for_arrow$pandemicYear == "Mar 2021 - Feb 2022" & dat_temp_stripplot_for_arrow$FIPSCode == x]#- 0.016
  }
}
)

dat_temp_stripplot_for_arrow$acolor <- NA


dat_temp_stripplot_for_arrow$acolor[dat_temp_stripplot_for_arrow$pandemicYear == "Mar 2021 - Feb 2022"] <- sapply(dat_temp_stripplot_for_arrow$FIPSCode[dat_temp_stripplot_for_arrow$pandemicYear == "Mar 2021 - Feb 2022"], function(x){
  if(dat_temp_stripplot_for_arrow$relativeExc[dat_temp_stripplot_for_arrow$pandemicYear == "Mar 2021 - Feb 2022" & dat_temp_stripplot_for_arrow$FIPSCode == x] > dat_temp_stripplot_for_arrow$relativeExc[dat_temp_stripplot_for_arrow$pandemicYear == "Mar 2020 - Feb 2021" & dat_temp_stripplot_for_arrow$FIPSCode == x]){
    "#E9752BFF"
  }else{
    "#95C5E1FF"
  }
}
) 

dat_temp_stripplot_for_arrow$acolor[dat_temp_stripplot_for_arrow$pandemicYear == "Mar 2020 - Feb 2021"] <- dat_temp_stripplot_for_arrow$acolor[dat_temp_stripplot_for_arrow$pandemicYear == "Mar 2021 - Feb 2022"]


stripplot_year1_2 <-
  dat_temp_stripplot_for_arrow %>% mutate(pandemicYear = factor(pandemicYear, levels = c("Mar 2020 - Feb 2021", "Mar 2021 - Feb 2022"))) %>%  arrange(FIPSCode, pandemicYear) %>%
  ggplot(aes(x = relativeExc, 
             # y = reorder(countyName2, excDeathsMed)
             y = countyName2
  )
  ) + 
  geom_line(aes(group = paired, color = acolor), size = 0.8) +
  geom_point(data = dat_temp_stripplot_for_arrow[dat_temp_stripplot_for_arrow$pandemicYear == "Mar 2020 - Feb 2021", ], aes(color = acolor) , shape = 108, stroke = 4, show.legend = F) +
  geom_point(data = dat_temp_stripplot_for_arrow[dat_temp_stripplot_for_arrow$pandemicYear == "Mar 2021 - Feb 2022", ], aes(color = acolor) , shape = 16, stroke = 2, show.legend = F) +
  scale_x_continuous(breaks=c(0, 0.5, 1),
                     labels=c("0%", "50%","100%"), limits = c(-0.1, 1)) +
  labs(x = "Relative Excess (%)", y = "", size = "") +
  facet_wrap(~ metro_binary, scales = "free", nrow = 2) +
  scale_colour_identity(name = "", guide = "legend", labels  = c("Decrease", "Increase")) +
  scale_size_manual(values = c(1)) +
  theme_minimal() +
  theme(legend.position = 'bottom', legend.direction="horizontal",
        strip.background = element_rect(colour = "white", fill = "white"),
        strip.text = element_text(size = 10, face = "bold"),
        panel.grid.minor.x = element_blank(),
        line = element_line(color = "grey40"),
        text = element_text(color = "grey10", size = 10),
        panel.border = element_blank(),
        panel.grid.major = element_line(
          color = "grey40",
          size = .1
        ),
        axis.ticks = element_blank()
  )

jpeg(paste0(here('figures'), "/stripplot.jpg"), res = 300, h = 3000, w = 4000)

stripplot_year1_2

dev.off()



