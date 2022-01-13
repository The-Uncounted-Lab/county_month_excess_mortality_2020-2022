COVID Mortality Data
================
Eugenio Paglino
13 January, 2022

To understand whether the monthly county-level data on COVID deaths
released by the CDC is reliable, we can try to replicate familiar trends
and patterns in COVID mortality. We start by plotting the national
number of daily COVID deaths as estimated from the data. Because we only
have data with monthly frequency, the number of monthly deaths was
divided by 30 to obtain daily estimates.

![National Daily Deaths due to
COVID](exMortCOVIDDeaths_files/figure-gfm/unnamed-chunk-9-1.png) We can
further decompose the national-level data by census region as see if we
observe the familiar patter where, for example, the North East was hit
harder by the first wave while the South saw higher mortality in late
2020 and 2021.

![Daily Deaths due to COVID by Census
Region](exMortCOVIDDeaths_files/figure-gfm/unnamed-chunk-10-1.png)

Finally, for the moment, we can further decompose each census region
into its sub-regions to see how deaths were distributed within each
area.

![Daily Deaths due to COVID by Census
Sub-Region](exMortCOVIDDeaths_files/figure-gfm/unnamed-chunk-11-1.png)
