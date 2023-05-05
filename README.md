Monthly County Level Excess Mortality in the United States, 2020-2022
================

<!-- README.md is generated from README.Rmd. Please edit that file -->

**Table of Contents**

1.  Introduction
2.  Overview of Repository
3.  Available Data Files
4.  Data Dictionaries and Descriptive Statistics

## Introduction

This repo includes data and code required to replicate the results in
the paper [“Excess all-cause mortality across counties in the United
States, March 2020 to December 2021” \[Link to
Pre-Print\]](https://www.medrxiv.org/content/10.1101/2022.04.23.22274192v4)
and [“Differences Between Reported COVID-19 Deaths and Estimated Excess
Deaths in Counties Across the United States, March 2020 to February
2022” \[Link to
Pre-Print\]](https://www.medrxiv.org/content/10.1101/2023.01.16.23284633v1).

The aim of this project is to estimate monthly deaths at the county
level for the United States for the period March 2020 - August 2022 in
the counterfactual scenario of no COVID-19 pandemic. We do so with a
Bayesian hierarchical model with a flexible time component and a spatial
component. To deal with suppression of death counts \< 10, we employ a
set of state-year censored Poisson models to estimate the censored death
counts. We then adjust the total number of imputed deaths making sure
that the sum of non-suppressed and imputed deaths equal the state yearly
death count (very unlikely to be suppressed).

## Overview of Repository

### General repository structure

The repository is organized in several directories:

- `Python`: Contains the Python code used to generate monthly population
  estimates.
- `R`: Contains the R code used to prepare the data, train the models,
  assess the models’ perfomance, produce the estimates of excess
  mortality, and produce the figures and tables for the paper.
- `data/input`: Contains all the data needed to train the models and
  produce estimates of excess deaths. To reconcile inconsistencies
  across the various data sources we are using, and to accomodate
  further analysis with a longer backward time frame (i.e. we trained
  our final models on data for 2015-2019 but initially considered a
  wider window), we harmonized county FIPS code following the schema in
  the FIPSFixes.csv file.
- `data/output`: Will contain all the data that will be generated as a
  product of the project. We already included different sets of
  estimates compliant with the CDC Wonder user agreement.
- `figures`: contains all the figures and tables appearing in the paper.

### Main programs

The project consists of several RMarkdown and R files:

- `cleanMortalityData.Rmd`: Cleans the all-cause mortality data.
- `cleanCOVIDData.Rmd`: Cleans the data for COVID mortality.
- `modelFitMonthly.Rmd`: Fit the monthly level model for all-cause
  deaths.
- `modelSummary.Rmd`: Extracts the model’s parameters and
  hyperparameters and creates summary tables and graphs.
- `crossValidationMonthly.Rmd`: Runs cross-validation on the model and
  produces a set of estimates to be used to evaluate the model.
- `modelEvaluationMonthly.Rmd`: Evaluates model performance using the
  cross-validation data.
- `createSimsDF.Rmd`: Creates a dataframe with county-month samples from
  the model’s posterior distribution for death counts. This dataframe is
  used to construct estimates of death counts with posterior intervals
  at different levels of aggregation.
- `estimates*.Rmd`: These files (estimatesMonthly,
  estimatesPandemicYears, estimatesWaves, estimatesStates,
  estimatesStateMonths, and estimatesMonthlyTotals) produce estimates of
  expected death counts, excess death counts, and relative excess at
  different levels of temporal and geographical aggregation.
- `summaryTable.Rmd`: Produces a metro-division level table summarizing
  the key results by pandemic year.
- `summaryTableFinal.Rmd`: Produces an alternative metro-division level
  table summarizing the key results for the entire period.
- `scatterPlots`: Produces scatter plots of excess mortality in year 1
  (March 2020 - February 2021) and year 2 (March 2021 - February 2022)
  and of excess mortality against COVID-19 mortality.
- `timeBarsGraphDivision.Rmd`: Produces a graph showing how relative
  excess evolved during the pandemic for each division, separating large
  metro areas and other areas.
- `plotsForSubmission.Rmd`: Creates the geofacet plot and the heatmap
  plot of count-level excess mortality.
- `map_by_period_relative_exc_to_eugenio.R`: Creates maps of relative
  excess.
- countyPlots: Produces a set of county-level plots of observed
  vs. expected deaths.

The files are intended to be run in the order in which they appear on
this list. Detailed instructions on the steps we used to download data
from the CDC WONDER platform are given in
`data/output/CDCWONDERDataDetails.md`.

Aside from the R files within the R folder, we also provide the Python
code we used to create monthly population estimates at the county level
by interpolating yearly intercensal estimates from the Census Bureau.
The Python code is in the form of a Jupyter Notebook. The final
population estimates are stored in the output folder.

All estimates can be produced for a combination of all-cause (AC) or
natural-cause (NC) mortality data and COVID as Underlying Cause of Death
(UCD) or COVID as a contributing cause of death (MCD).

## Available Data Files

Public versions of our estimates are available in the `data/output`
directory.

Datasets are sorted in sub-directories based on the underlying data used
to produce them as follows.

Expected mortality was modeled as either:

- **AC**: all-cause mortality
- **NC**: natural-cause mortality, excluding external causes of death

Deaths attributed to COVID-19 were defined as either:

- **UCD**: underlying cause of death (COVID-19 was listed as the single
  underlying cause of death on a death certificate)
- **MCD**: multiple causes of death (COVID-19 was listed as one of
  multiple causes of death on a death certificate)

The following datasets are available:

    -- ACMCD
       |__estimatesMonthly.csv
       |__estimatesMonthlyTotals.csv
       |__estimatesPYears.csv
       |__estimatesStates.csv
       |__estimatesTotal.csv
    -- ACUCD
       |__estimatesMonthly.csv
       |__estimatesMonthlyTotals.csv
       |__estimatesPYears.csv
       |__estimatesStates.csv
       |__estimatesTotal.csv
    -- NCMCD
       |__estimatesMonthly.csv
       |__estimatesMonthlyFull.csv
       |__estimatesMonthlyTotals.csv
       |__estimatesPYears.csv
       |__estimatesPYearsFull.csv
       |__estimatesStates.csv
       |__estimatesTotal.csv
       |__estimatesTotalFull.csv
    -- NCUCD
       |__estimatesMonthly.csv
       |__estimatesMonthlyFull.csv
       |__estimatesMonthlyTotals.csv
       |__estimatesPYears.csv
       |__estimatesPYearsFull.csv
       |__estimatesStates.csv
       |__estimatesTotal.csv
       |__estimatesTotalFull.csv
       |__estimatesYearly.csv

## Data Dictionaries and Descriptive Statistics

The following tables contain variable names, descriptions, and
descriptive statistics for each of the datasets in this repository.

<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
ACMCD/estimatesMonthly
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
year
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Calendar year.
</td>
<td style="text-align:left;">
Num: 2020 to 2022
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2020.933, median: 2021, sd: 0.772, nuniq: 3
</td>
</tr>
<tr>
<td style="text-align:left;">
month
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Calendar month.
</td>
<td style="text-align:left;">
Num: 1 to 12
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 6.3, median: 6, sd: 3.206, nuniq: 12
</td>
</tr>
<tr>
<td style="text-align:left;">
FIPSCode
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
5-digit Federal Information Processing Standards (FIPS) code that
uniquely identifies United States counties. First 2 digits represent
state, final 3 digits represent county within that state. Includes
leading zeroes. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3127
</td>
</tr>
<tr>
<td style="text-align:left;">
countyName
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the county or county-like area. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘Abbeville County’ ‘Acadia Parish’ ‘Accomack County’ ‘Ada County’ ‘Adair
County’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1864
</td>
</tr>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 9
</td>
</tr>
<tr>
<td style="text-align:left;">
metroCat
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2013 NCHS Urban-Rural Classification Scheme for Counties
</td>
<td style="text-align:left;">
‘Large Central Metro’ ‘Large Fringe Metro’ ‘Medium or Small Metro’ ‘Non
Metro’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 7545
</td>
<td style="text-align:left;">
74110
</td>
<td style="text-align:left;">
mean: 45.309, median: 21, sd: 124.409, nuniq: 532
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 14781
</td>
<td style="text-align:left;">
18315
</td>
<td style="text-align:left;">
mean: 111.736, median: 40, sd: 277.211, nuniq: 1672
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.195, median: 0, sd: 0.396, nuniq: 2
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 6152
</td>
<td style="text-align:left;">
18315
</td>
<td style="text-align:left;">
mean: 94.222, median: 34, sd: 221.164, nuniq: 1473
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 5845
</td>
<td style="text-align:left;">
18315
</td>
<td style="text-align:left;">
mean: 81.049, median: 25, sd: 207.464, nuniq: 1391
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 1 to 6153
</td>
<td style="text-align:left;">
18315
</td>
<td style="text-align:left;">
mean: 94.512, median: 34, sd: 221.098, nuniq: 1475
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 3 to 6474
</td>
<td style="text-align:left;">
18315
</td>
<td style="text-align:left;">
mean: 108.995, median: 44, sd: 235.036, nuniq: 1539
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -146 to 8628
</td>
<td style="text-align:left;">
18315
</td>
<td style="text-align:left;">
mean: 16.737, median: 5, sd: 82.582, nuniq: 699
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -243 to 8306
</td>
<td style="text-align:left;">
18315
</td>
<td style="text-align:left;">
mean: 2.705, median: -4, sd: 75.926, nuniq: 690
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -147 to 8627
</td>
<td style="text-align:left;">
18315
</td>
<td style="text-align:left;">
mean: 17.207, median: 6, sd: 82.655, nuniq: 687
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -69 to 8936
</td>
<td style="text-align:left;">
18315
</td>
<td style="text-align:left;">
mean: 30.613, median: 15, sd: 90.935, nuniq: 712
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.66, median: 0.715, sd: 0.298, nuniq: 1001
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.674 to Inf
</td>
<td style="text-align:left;">
479
</td>
<td style="text-align:left;">
mean: Inf, median: 0.246, nuniq: 77744
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -1 to 6.333
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: -0.145, median: -0.139, sd: 0.278, nuniq: 15522
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -1 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.132, nuniq: 12605
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -1 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.69, nuniq: 14088
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: -7.733 to 639.482
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 0.756, median: 0.168, sd: 4.507, nuniq: 93525
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -20.054 to 479.577
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: -0.142, median: -0.164, sd: 2.491, nuniq: 57895
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -7.094 to 639.398
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 0.697, median: 0.125, sd: 4.444, nuniq: 25786
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -2.87 to 787.75
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 1.833, median: 0.713, sd: 7.204, nuniq: 51307
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 0.24
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.01, median: 0.001, sd: 0.021, nuniq: 201
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
ACMCD/estimatesMonthlyTotals
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
year
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Calendar year.
</td>
<td style="text-align:left;">
Num: 2020 to 2022
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2020.933, median: 2021, sd: 0.785, nuniq: 3
</td>
</tr>
<tr>
<td style="text-align:left;">
month
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Calendar month.
</td>
<td style="text-align:left;">
Num: 1 to 12
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 6.3, median: 6, sd: 3.261, nuniq: 12
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 6239 to 105339
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 34886, median: 27332, sd: 27037.674, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 244671 to 372916
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 284390.167, median: 275087, sd: 36087.541, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 0
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0, median: 0, sd: 0, nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 224828.26 to 277204.721
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 241452.813, median: 238576.792, sd: 14266.487, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 214756.85 to 262536.3
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 229982.228, median: 227646.4, sd: 13474.105, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 224592 to 277172
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 241380.117, median: 238526, sd: 14290.539, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 234665.35 to 291143.6
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 253145.502, median: 249818.65, sd: 15044.905, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 3664.327 to 108560.152
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 42937.353, median: 37120.803, sd: 29160.263, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -9212.6 to 96498.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 31244.665, median: 26015.225, sd: 29079.622, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 3683.5 to 108708.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 43010.05, median: 37203.5, sd: 29140.896, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 16723.7 to 119924.6
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 54407.938, median: 48325.7, sd: 29254.475, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0.701 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.978, median: 1, sd: 0.065, nuniq: 10
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.016 to 0.422
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.178, median: 0.155, sd: 0.115, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -0.036 to 0.357
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.122, median: 0.103, sd: 0.11, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.015 to 0.422
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.177, median: 0.155, sd: 0.115, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.073 to 0.486
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.235, median: 0.211, sd: 0.12, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: 0.424 to 2.311
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.362, median: 1.371, sd: 0.486, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -1.477 to 1.318
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.742, median: 0.947, sd: 0.601, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.427 to 2.317
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.367, median: 1.375, sd: 0.488, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 1.003 to 3.589
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.969, median: 1.771, sd: 0.789, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0.052 to 0.999
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.758, median: 0.927, sd: 0.32, nuniq: 27
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
ACMCD/estimatesPYears
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
pandemicYear
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
12-month ranges beginning in March 2020, each representing one year of
the COVID-19 pandemic in the United States. Note that the most recent
pandemic year be be incomplete due to data lags. If this is the case,
the pandemic year will include fewer than 12 months, as indicated in
this field.
</td>
<td style="text-align:left;">
‘Mar 2020 - Feb 2021’ ‘Mar 2021 - Feb 2022’ ‘Mar 2022 - Aug 2022’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3
</td>
</tr>
<tr>
<td style="text-align:left;">
FIPSCode
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
5-digit Federal Information Processing Standards (FIPS) code that
uniquely identifies United States counties. First 2 digits represent
state, final 3 digits represent county within that state. Includes
leading zeroes. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3127
</td>
</tr>
<tr>
<td style="text-align:left;">
countyName
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the county or county-like area. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘Abbeville County’ ‘Acadia Parish’ ‘Accomack County’ ‘Ada County’ ‘Adair
County’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1864
</td>
</tr>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 9
</td>
</tr>
<tr>
<td style="text-align:left;">
metroCat
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2013 NCHS Urban-Rural Classification Scheme for Counties
</td>
<td style="text-align:left;">
‘Large Central Metro’ ‘Large Fringe Metro’ ‘Medium or Small Metro’ ‘Non
Metro’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 21961
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 151.202, median: 50.5, sd: 495.956, nuniq: 754
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 92760
</td>
<td style="text-align:left;">
128
</td>
<td style="text-align:left;">
mean: 921.938, median: 286, sd: 2612.917, nuniq: 2355
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 0
</td>
<td style="text-align:left;">
128
</td>
<td style="text-align:left;">
mean: 0, median: 0, sd: 0, nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 2 to 63869
</td>
<td style="text-align:left;">
128
</td>
<td style="text-align:left;">
mean: 782.24, median: 242, sd: 2118.193, nuniq: 2149
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 61892
</td>
<td style="text-align:left;">
128
</td>
<td style="text-align:left;">
mean: 734.47, median: 214, sd: 2042.122, nuniq: 2066
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 2 to 63881
</td>
<td style="text-align:left;">
128
</td>
<td style="text-align:left;">
mean: 782.418, median: 242, sd: 2118.105, nuniq: 2150
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 5 to 65838
</td>
<td style="text-align:left;">
128
</td>
<td style="text-align:left;">
mean: 831.717, median: 272, sd: 2193.913, nuniq: 2225
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -336 to 28890
</td>
<td style="text-align:left;">
128
</td>
<td style="text-align:left;">
mean: 138.816, median: 37, sd: 550.72, nuniq: 947
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -540 to 26921
</td>
<td style="text-align:left;">
128
</td>
<td style="text-align:left;">
mean: 90.05, median: 10, sd: 489.788, nuniq: 883
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -335 to 28878
</td>
<td style="text-align:left;">
128
</td>
<td style="text-align:left;">
mean: 139.458, median: 38, sd: 550.715, nuniq: 953
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -151 to 30867
</td>
<td style="text-align:left;">
128
</td>
<td style="text-align:left;">
mean: 187.26, median: 66, sd: 615.636, nuniq: 1013
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.846, median: 0.988, sd: 0.258, nuniq: 944
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.955 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.177, nuniq: 9247
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -0.964 to 7
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.042, median: 0.045, sd: 0.219, nuniq: 7523
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.956 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.169, nuniq: 7054
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.944 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.311, nuniq: 7310
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: -7.152 to 10.716
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 1.277, median: 1.241, sd: 0.924, nuniq: 6846
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -8.923 to 7.714
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 0.361, median: 0.592, sd: 1.095, nuniq: 4766
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -7.154 to 10.7
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 1.284, median: 1.249, sd: 0.925, nuniq: 4099
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -5.535 to 14.5
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 2.167, median: 1.882, sd: 1.146, nuniq: 4716
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.467, median: 0.473, sd: 0.397, nuniq: 992
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
ACMCD/estimatesStates
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘00’ ‘01’ ‘02’ ‘04’ ‘05’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘United States’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 5
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 10
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 770 to 1046374
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 40245.154, median: 13713.5, sd: 144046.628, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 14291 to 8531662
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 328140.846, median: 126703, sd: 1172212.209, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.019, median: 0, sd: 0.139, nuniq: 2
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 11477.023 to 7243584.397
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 278599.4, median: 108389.277, sd: 994963.396, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 11184.7 to 7077834
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 272191.519, median: 105928.65, sd: 972201.855, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 11468 to 7242646.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 278572.433, median: 108379.5, sd: 994833.537, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 11798.2 to 7409390.7
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 285036.869, median: 110952.45, sd: 1017734.626, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 1367.878 to 1288077.603
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 49541.446, median: 17727.615, sd: 177374.173, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: 959.6 to 1122271.3
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 43103.977, median: 14413.75, sd: 154624.522, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 1361.5 to 1289015.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 49568.413, median: 17750.25, sd: 177504.418, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 1763.4 to 1453828
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 55949.327, median: 20940.75, sd: 200118.667, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 1 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1, median: 1, sd: 0, nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.085 to 0.282
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.169, median: 0.167, sd: 0.051, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: 0.059 to 0.25
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.141, median: 0.14, sd: 0.05, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.084 to 0.281
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.169, median: 0.167, sd: 0.051, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.11 to 0.314
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.197, median: 0.194, sd: 0.052, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: 0.613 to 1.972
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.257, median: 1.262, sd: 0.275, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.428 to 1.747
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.067, median: 1.08, sd: 0.262, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.617 to 1.978
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.258, median: 1.263, sd: 0.275, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.794 to 2.29
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.446, median: 1.408, sd: 0.303, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0.005 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.801, median: 0.968, sd: 0.299, nuniq: 40
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
ACMCD/estimatesTotal
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
period
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Month range that the data represent.
</td>
<td style="text-align:left;">
‘March 2020 - August 2022’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
FIPSCode
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
5-digit Federal Information Processing Standards (FIPS) code that
uniquely identifies United States counties. First 2 digits represent
state, final 3 digits represent county within that state. Includes
leading zeroes. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3127
</td>
</tr>
<tr>
<td style="text-align:left;">
countyName
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the county or county-like area. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘Abbeville County’ ‘Acadia Parish’ ‘Accomack County’ ‘Ada County’ ‘Adair
County’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1864
</td>
</tr>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 9
</td>
</tr>
<tr>
<td style="text-align:left;">
metroCat
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2013 NCHS Urban-Rural Classification Scheme for Counties
</td>
<td style="text-align:left;">
‘Large Central Metro’ ‘Large Fringe Metro’ ‘Medium or Small Metro’ ‘Non
Metro’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 31004
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 347.836, median: 117, sd: 1040.48, nuniq: 793
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 202440
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
mean: 2733.623, median: 904, sd: 7328.749, nuniq: 2030
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 0
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
mean: 0, median: 0, sd: 0, nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 5 to 157801
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
mean: 2320.354, median: 759, sd: 6039.891, nuniq: 1891
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 1 to 152990
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
mean: 2214.583, median: 700, sd: 5852.852, nuniq: 1875
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 5 to 157800
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
mean: 2320.382, median: 760, sd: 6040.116, nuniq: 1924
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 9 to 162427
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
mean: 2427.933, median: 820, sd: 6223.277, nuniq: 1954
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -258 to 44638
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
mean: 412.318, median: 136, sd: 1354.284, nuniq: 960
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -305 to 40012
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
mean: 305.361, median: 76, sd: 1185.118, nuniq: 876
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -259 to 44640
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
mean: 413.125, median: 137, sd: 1353.925, nuniq: 960
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -212 to 49449
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
mean: 518.678, median: 194, sd: 1530.6, nuniq: 1042
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.938, median: 1, sd: 0.182, nuniq: 385
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.958 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.187, nuniq: 3113
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -0.964 to 1.938
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.107, median: 0.102, sd: 0.165, nuniq: 3054
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.959 to 3.875
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.225, median: 0.184, sd: 0.252, nuniq: 3043
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.951 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.275, nuniq: 3053
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: -13.59 to 10.011
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 1.285, median: 1.246, sd: 0.976, nuniq: 3006
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -16.053 to 8.865
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 0.653, median: 0.773, sd: 1.066, nuniq: 2777
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -13.632 to 10.027
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 1.291, median: 1.249, sd: 0.977, nuniq: 2656
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -11.158 to 11.135
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 1.895, median: 1.745, sd: 1.014, nuniq: 2767
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.646, median: 0.779, sd: 0.357, nuniq: 870
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
ACUCD/estimatesMonthly
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
year
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Calendar year.
</td>
<td style="text-align:left;">
Num: 2020 to 2022
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2020.933, median: 2021, sd: 0.772, nuniq: 3
</td>
</tr>
<tr>
<td style="text-align:left;">
month
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Calendar month.
</td>
<td style="text-align:left;">
Num: 1 to 12
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 6.3, median: 6, sd: 3.206, nuniq: 12
</td>
</tr>
<tr>
<td style="text-align:left;">
FIPSCode
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
5-digit Federal Information Processing Standards (FIPS) code that
uniquely identifies United States counties. First 2 digits represent
state, final 3 digits represent county within that state. Includes
leading zeroes. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3127
</td>
</tr>
<tr>
<td style="text-align:left;">
countyName
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the county or county-like area. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘Abbeville County’ ‘Acadia Parish’ ‘Accomack County’ ‘Ada County’ ‘Adair
County’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1864
</td>
</tr>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 9
</td>
</tr>
<tr>
<td style="text-align:left;">
metroCat
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2013 NCHS Urban-Rural Classification Scheme for Counties
</td>
<td style="text-align:left;">
‘Large Central Metro’ ‘Large Fringe Metro’ ‘Medium or Small Metro’ ‘Non
Metro’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 7270
</td>
<td style="text-align:left;">
76235
</td>
<td style="text-align:left;">
mean: 44.358, median: 20, sd: 123.461, nuniq: 497
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 14781
</td>
<td style="text-align:left;">
18315
</td>
<td style="text-align:left;">
mean: 111.736, median: 40, sd: 277.211, nuniq: 1672
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.195, median: 0, sd: 0.396, nuniq: 2
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 6152
</td>
<td style="text-align:left;">
18315
</td>
<td style="text-align:left;">
mean: 94.222, median: 34, sd: 221.164, nuniq: 1473
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 5845
</td>
<td style="text-align:left;">
18315
</td>
<td style="text-align:left;">
mean: 81.049, median: 25, sd: 207.464, nuniq: 1391
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 1 to 6153
</td>
<td style="text-align:left;">
18315
</td>
<td style="text-align:left;">
mean: 94.512, median: 34, sd: 221.098, nuniq: 1475
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 3 to 6474
</td>
<td style="text-align:left;">
18315
</td>
<td style="text-align:left;">
mean: 108.995, median: 44, sd: 235.036, nuniq: 1539
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -146 to 8628
</td>
<td style="text-align:left;">
18315
</td>
<td style="text-align:left;">
mean: 16.737, median: 5, sd: 82.582, nuniq: 699
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -243 to 8306
</td>
<td style="text-align:left;">
18315
</td>
<td style="text-align:left;">
mean: 2.705, median: -4, sd: 75.926, nuniq: 690
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -147 to 8627
</td>
<td style="text-align:left;">
18315
</td>
<td style="text-align:left;">
mean: 17.207, median: 6, sd: 82.655, nuniq: 687
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -69 to 8936
</td>
<td style="text-align:left;">
18315
</td>
<td style="text-align:left;">
mean: 30.613, median: 15, sd: 90.935, nuniq: 712
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.66, median: 0.715, sd: 0.298, nuniq: 1001
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.674 to Inf
</td>
<td style="text-align:left;">
479
</td>
<td style="text-align:left;">
mean: Inf, median: 0.246, nuniq: 77744
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -1 to 6.333
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: -0.145, median: -0.139, sd: 0.278, nuniq: 15522
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -1 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.132, nuniq: 12605
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -1 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.69, nuniq: 14088
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: -8.166 to 670.101
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 0.771, median: 0.171, sd: 4.632, nuniq: 93352
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -18.21 to 507.125
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: -0.13, median: -0.164, sd: 2.61, nuniq: 57821
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -7.692 to 662.962
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 0.716, median: 0.131, sd: 4.578, nuniq: 26108
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -4.3 to 842.23
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 1.84, median: 0.715, sd: 7.298, nuniq: 51135
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 0.227
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.009, median: 0, sd: 0.019, nuniq: 187
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
ACUCD/estimatesMonthlyTotals
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
year
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Calendar year.
</td>
<td style="text-align:left;">
Num: 2020 to 2022
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2020.933, median: 2021, sd: 0.785, nuniq: 3
</td>
</tr>
<tr>
<td style="text-align:left;">
month
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Calendar month.
</td>
<td style="text-align:left;">
Num: 1 to 12
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 6.3, median: 6, sd: 3.261, nuniq: 12
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 3662 to 96235
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 30836.433, median: 24485, sd: 25132, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 244671 to 372916
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 284390.167, median: 275087, sd: 36087.541, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 0
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0, median: 0, sd: 0, nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 224828.26 to 277204.721
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 241452.813, median: 238576.792, sd: 14266.487, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 214756.85 to 262536.3
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 229982.228, median: 227646.4, sd: 13474.105, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 224592 to 277172
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 241380.117, median: 238526, sd: 14290.539, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 234665.35 to 291143.6
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 253145.502, median: 249818.65, sd: 15044.905, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 3664.327 to 108560.152
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 42937.353, median: 37120.803, sd: 29160.263, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -9212.6 to 96498.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 31244.665, median: 26015.225, sd: 29079.622, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 3683.5 to 108708.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 43010.05, median: 37203.5, sd: 29140.896, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 16723.7 to 119924.6
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 54407.938, median: 48325.7, sd: 29254.475, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0.701 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.978, median: 1, sd: 0.065, nuniq: 10
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.016 to 0.422
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.178, median: 0.155, sd: 0.115, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -0.036 to 0.357
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.122, median: 0.103, sd: 0.11, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.015 to 0.422
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.177, median: 0.155, sd: 0.115, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.073 to 0.486
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.235, median: 0.211, sd: 0.12, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: 0.569 to 3.114
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.649, median: 1.537, sd: 0.703, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -2.516 to 1.608
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.836, median: 1.094, sd: 0.814, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.569 to 3.139
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.655, median: 1.541, sd: 0.708, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 1.149 to 5.487
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2.446, median: 1.951, sd: 1.259, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0.127 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.842, median: 0.98, sd: 0.249, nuniq: 26
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
ACUCD/estimatesPYears
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
pandemicYear
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
12-month ranges beginning in March 2020, each representing one year of
the COVID-19 pandemic in the United States. Note that the most recent
pandemic year be be incomplete due to data lags. If this is the case,
the pandemic year will include fewer than 12 months, as indicated in
this field.
</td>
<td style="text-align:left;">
‘Mar 2020 - Feb 2021’ ‘Mar 2021 - Feb 2022’ ‘Mar 2022 - Aug 2022’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3
</td>
</tr>
<tr>
<td style="text-align:left;">
FIPSCode
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
5-digit Federal Information Processing Standards (FIPS) code that
uniquely identifies United States counties. First 2 digits represent
state, final 3 digits represent county within that state. Includes
leading zeroes. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3127
</td>
</tr>
<tr>
<td style="text-align:left;">
countyName
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the county or county-like area. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘Abbeville County’ ‘Acadia Parish’ ‘Accomack County’ ‘Ada County’ ‘Adair
County’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1864
</td>
</tr>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 9
</td>
</tr>
<tr>
<td style="text-align:left;">
metroCat
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2013 NCHS Urban-Rural Classification Scheme for Counties
</td>
<td style="text-align:left;">
‘Large Central Metro’ ‘Large Fringe Metro’ ‘Medium or Small Metro’ ‘Non
Metro’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 21128
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 142.377, median: 47, sd: 475.378, nuniq: 705
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 92760
</td>
<td style="text-align:left;">
128
</td>
<td style="text-align:left;">
mean: 921.938, median: 286, sd: 2612.917, nuniq: 2355
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 0
</td>
<td style="text-align:left;">
128
</td>
<td style="text-align:left;">
mean: 0, median: 0, sd: 0, nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 2 to 63869
</td>
<td style="text-align:left;">
128
</td>
<td style="text-align:left;">
mean: 782.24, median: 242, sd: 2118.193, nuniq: 2149
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 61892
</td>
<td style="text-align:left;">
128
</td>
<td style="text-align:left;">
mean: 734.47, median: 214, sd: 2042.122, nuniq: 2066
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 2 to 63881
</td>
<td style="text-align:left;">
128
</td>
<td style="text-align:left;">
mean: 782.418, median: 242, sd: 2118.105, nuniq: 2150
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 5 to 65838
</td>
<td style="text-align:left;">
128
</td>
<td style="text-align:left;">
mean: 831.717, median: 272, sd: 2193.913, nuniq: 2225
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -336 to 28890
</td>
<td style="text-align:left;">
128
</td>
<td style="text-align:left;">
mean: 138.816, median: 37, sd: 550.72, nuniq: 947
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -540 to 26921
</td>
<td style="text-align:left;">
128
</td>
<td style="text-align:left;">
mean: 90.05, median: 10, sd: 489.788, nuniq: 883
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -335 to 28878
</td>
<td style="text-align:left;">
128
</td>
<td style="text-align:left;">
mean: 139.458, median: 38, sd: 550.715, nuniq: 953
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -151 to 30867
</td>
<td style="text-align:left;">
128
</td>
<td style="text-align:left;">
mean: 187.26, median: 66, sd: 615.636, nuniq: 1013
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.846, median: 0.988, sd: 0.258, nuniq: 944
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.955 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.177, nuniq: 9247
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -0.964 to 7
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.042, median: 0.045, sd: 0.219, nuniq: 7523
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.956 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.169, nuniq: 7054
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.944 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.311, nuniq: 7310
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: -7.748 to 10.707
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 1.505, median: 1.405, sd: 1.124, nuniq: 6405
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -10.5 to 8.526
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 0.478, median: 0.706, sd: 1.235, nuniq: 4534
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -7.75 to 10.722
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 1.513, median: 1.41, sd: 1.125, nuniq: 3966
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -5.996 to 14.154
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 2.504, median: 2.091, sd: 1.494, nuniq: 4501
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.485, median: 0.527, sd: 0.415, nuniq: 973
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
ACUCD/estimatesStates
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘00’ ‘01’ ‘02’ ‘04’ ‘05’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘United States’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 5
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 10
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 569 to 924859
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 35571.5, median: 11508, sd: 127375.928, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 14291 to 8531662
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 328140.846, median: 126703, sd: 1172212.209, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.019, median: 0, sd: 0.139, nuniq: 2
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 11477.023 to 7243584.397
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 278599.4, median: 108389.277, sd: 994963.396, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 11184.7 to 7077834
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 272191.519, median: 105928.65, sd: 972201.855, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 11468 to 7242646.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 278572.433, median: 108379.5, sd: 994833.537, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 11798.2 to 7409390.7
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 285036.869, median: 110952.45, sd: 1017734.626, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 1367.878 to 1288077.603
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 49541.446, median: 17727.615, sd: 177374.173, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: 959.6 to 1122271.3
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 43103.977, median: 14413.75, sd: 154624.522, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 1361.5 to 1289015.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 49568.413, median: 17750.25, sd: 177504.418, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 1763.4 to 1453828
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 55949.327, median: 20940.75, sd: 200118.667, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 1 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1, median: 1, sd: 0, nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.085 to 0.282
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.169, median: 0.167, sd: 0.051, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: 0.059 to 0.25
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.141, median: 0.14, sd: 0.05, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.084 to 0.281
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.169, median: 0.167, sd: 0.051, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.11 to 0.314
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.197, median: 0.194, sd: 0.052, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: 0.745 to 2.404
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.448, median: 1.42, sd: 0.33, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.52 to 1.988
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.226, median: 1.234, sd: 0.3, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.75 to 2.393
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.448, median: 1.42, sd: 0.33, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.964 to 3.099
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.667, median: 1.624, sd: 0.379, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0.071 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.895, median: 0.996, sd: 0.222, nuniq: 29
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
ACUCD/estimatesTotal
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
period
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Month range that the data represent.
</td>
<td style="text-align:left;">
‘March 2020 - August 2022’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
FIPSCode
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
5-digit Federal Information Processing Standards (FIPS) code that
uniquely identifies United States counties. First 2 digits represent
state, final 3 digits represent county within that state. Includes
leading zeroes. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3127
</td>
</tr>
<tr>
<td style="text-align:left;">
countyName
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the county or county-like area. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘Abbeville County’ ‘Acadia Parish’ ‘Accomack County’ ‘Ada County’ ‘Adair
County’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1864
</td>
</tr>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 9
</td>
</tr>
<tr>
<td style="text-align:left;">
metroCat
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2013 NCHS Urban-Rural Classification Scheme for Counties
</td>
<td style="text-align:left;">
‘Large Central Metro’ ‘Large Fringe Metro’ ‘Medium or Small Metro’ ‘Non
Metro’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 29168
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 309.564, median: 104.5, sd: 952.339, nuniq: 727
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 202440
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
mean: 2733.623, median: 904, sd: 7328.749, nuniq: 2030
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 0
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
mean: 0, median: 0, sd: 0, nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 5 to 157801
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
mean: 2320.354, median: 759, sd: 6039.891, nuniq: 1891
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 1 to 152990
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
mean: 2214.583, median: 700, sd: 5852.852, nuniq: 1875
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 5 to 157800
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
mean: 2320.382, median: 760, sd: 6040.116, nuniq: 1924
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 9 to 162427
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
mean: 2427.933, median: 820, sd: 6223.277, nuniq: 1954
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -258 to 44638
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
mean: 412.318, median: 136, sd: 1354.284, nuniq: 960
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -305 to 40012
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
mean: 305.361, median: 76, sd: 1185.118, nuniq: 876
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -259 to 44640
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
mean: 413.125, median: 137, sd: 1353.925, nuniq: 960
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -212 to 49449
</td>
<td style="text-align:left;">
6
</td>
<td style="text-align:left;">
mean: 518.678, median: 194, sd: 1530.6, nuniq: 1042
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.938, median: 1, sd: 0.182, nuniq: 385
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.958 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.187, nuniq: 3113
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -0.964 to 1.938
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.107, median: 0.102, sd: 0.165, nuniq: 3054
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.959 to 3.875
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.225, median: 0.184, sd: 0.252, nuniq: 3043
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.951 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.275, nuniq: 3053
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: -17.215 to 10.894
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 1.459, median: 1.412, sd: 1.111, nuniq: 2986
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -20.333 to 9.647
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 0.745, median: 0.882, sd: 1.212, nuniq: 2735
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -17.267 to 10.912
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 1.466, median: 1.416, sd: 1.112, nuniq: 2627
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -14.133 to 12.118
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 2.151, median: 1.981, sd: 1.15, nuniq: 2721
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.706, median: 0.879, sd: 0.345, nuniq: 807
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NCMCD/estimatesMonthly
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
year
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Calendar year.
</td>
<td style="text-align:left;">
Num: 2020 to 2022
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2020.933, median: 2021, sd: 0.772, nuniq: 3
</td>
</tr>
<tr>
<td style="text-align:left;">
month
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Calendar month.
</td>
<td style="text-align:left;">
Num: 1 to 12
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 6.3, median: 6, sd: 3.206, nuniq: 12
</td>
</tr>
<tr>
<td style="text-align:left;">
FIPSCode
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
5-digit Federal Information Processing Standards (FIPS) code that
uniquely identifies United States counties. First 2 digits represent
state, final 3 digits represent county within that state. Includes
leading zeroes. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3127
</td>
</tr>
<tr>
<td style="text-align:left;">
countyName
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the county or county-like area. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘Abbeville County’ ‘Acadia Parish’ ‘Accomack County’ ‘Ada County’ ‘Adair
County’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1864
</td>
</tr>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 9
</td>
</tr>
<tr>
<td style="text-align:left;">
metroCat
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2013 NCHS Urban-Rural Classification Scheme for Counties
</td>
<td style="text-align:left;">
‘Large Central Metro’ ‘Large Fringe Metro’ ‘Medium or Small Metro’ ‘Non
Metro’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 7545
</td>
<td style="text-align:left;">
74110
</td>
<td style="text-align:left;">
mean: 45.309, median: 21, sd: 124.409, nuniq: 532
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 14256
</td>
<td style="text-align:left;">
19917
</td>
<td style="text-align:left;">
mean: 103.924, median: 38, sd: 256.619, nuniq: 1567
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.212, median: 0, sd: 0.409, nuniq: 2
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 5775
</td>
<td style="text-align:left;">
19917
</td>
<td style="text-align:left;">
mean: 87.232, median: 31, sd: 203.373, nuniq: 1384
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 5494
</td>
<td style="text-align:left;">
19917
</td>
<td style="text-align:left;">
mean: 74.824, median: 23, sd: 191.434, nuniq: 1315
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 1 to 5770
</td>
<td style="text-align:left;">
19917
</td>
<td style="text-align:left;">
mean: 87.522, median: 32, sd: 203.307, nuniq: 1381
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 3 to 6067
</td>
<td style="text-align:left;">
19917
</td>
<td style="text-align:left;">
mean: 101.225, median: 42, sd: 215.477, nuniq: 1445
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -146 to 8480
</td>
<td style="text-align:left;">
19917
</td>
<td style="text-align:left;">
mean: 15.915, median: 5, sd: 80.673, nuniq: 678
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -275 to 8189
</td>
<td style="text-align:left;">
19917
</td>
<td style="text-align:left;">
mean: 2.665, median: -4, sd: 75.178, nuniq: 666
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -147 to 8485
</td>
<td style="text-align:left;">
19917
</td>
<td style="text-align:left;">
mean: 16.385, median: 6, sd: 80.756, nuniq: 668
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -71 to 8761
</td>
<td style="text-align:left;">
19917
</td>
<td style="text-align:left;">
mean: 29.031, median: 14, sd: 87.582, nuniq: 688
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.656, median: 0.706, sd: 0.298, nuniq: 1001
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.643 to Inf
</td>
<td style="text-align:left;">
631
</td>
<td style="text-align:left;">
mean: Inf, median: 0.266, nuniq: 76032
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -1 to 6.333
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: -0.149, median: -0.146, sd: 0.29, nuniq: 14593
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -1 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.135, nuniq: 12041
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -1 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.737, nuniq: 13305
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: -7.667 to 629.369
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 0.706, median: 0.152, sd: 4.372, nuniq: 93514
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -20.848 to 455.449
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: -0.142, median: -0.158, sd: 2.396, nuniq: 57322
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -7.071 to 649.516
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 0.653, median: 0.112, sd: 4.362, nuniq: 24935
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -3.6 to 774.636
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 1.712, median: 0.675, sd: 6.922, nuniq: 49946
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 0.249
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.01, median: 0, sd: 0.02, nuniq: 198
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NCMCD/estimatesMonthlyFull
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
year
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Calendar year.
</td>
<td style="text-align:left;">
Num: 2015 to 2022
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2018.348, median: 2018, sd: 2.219, nuniq: 8
</td>
</tr>
<tr>
<td style="text-align:left;">
month
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Calendar month.
</td>
<td style="text-align:left;">
Num: 1 to 12
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 6.326, median: 6, sd: 3.414, nuniq: 12
</td>
</tr>
<tr>
<td style="text-align:left;">
FIPSCode
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
5-digit Federal Information Processing Standards (FIPS) code that
uniquely identifies United States counties. First 2 digits represent
state, final 3 digits represent county within that state. Includes
leading zeroes. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3127
</td>
</tr>
<tr>
<td style="text-align:left;">
countyName
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the county or county-like area. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘Abbeville County’ ‘Acadia Parish’ ‘Accomack County’ ‘Ada County’ ‘Adair
County’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1864
</td>
</tr>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 9
</td>
</tr>
<tr>
<td style="text-align:left;">
metroCat
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2013 NCHS Urban-Rural Classification Scheme for Counties
</td>
<td style="text-align:left;">
‘Large Central Metro’ ‘Large Fringe Metro’ ‘Medium or Small Metro’ ‘Non
Metro’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 7545
</td>
<td style="text-align:left;">
267984
</td>
<td style="text-align:left;">
mean: 45.309, median: 21, sd: 124.409, nuniq: 532
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 14256
</td>
<td style="text-align:left;">
67911
</td>
<td style="text-align:left;">
mean: 94.127, median: 35, sd: 223.813, nuniq: 2028
</td>
</tr>
<tr>
<td style="text-align:left;">
imputedDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths with values imputed for counts of 9 or fewer.
</td>
<td style="text-align:left;">
Num: 0 to 14256
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 73.023, median: 24, sd: 199.277, nuniq: 2038
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.236, median: 0, sd: 0.425, nuniq: 2
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 0.018 to 6287.981
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 68.9, median: 22.614, sd: 182.129, nuniq: 110294
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 6159.95
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 58.615, median: 15, sd: 173.144, nuniq: 3047
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 6287.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 68.722, median: 22, sd: 182.114, nuniq: 2701
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 6416
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 79.797, median: 31, sd: 191.261, nuniq: 3333
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -307.794 to 8480.146
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 4.123, median: 0.183, sd: 42.273, nuniq: 52291
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -428.1 to 8189
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: -6.774, median: -6, sd: 40.085, nuniq: 1213
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -310 to 8485.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 4.3, median: 0, sd: 42.292, nuniq: 982
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -182.9 to 8761.1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 14.408, median: 8, sd: 46.523, nuniq: 1178
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.52, median: 0.483, sd: 0.298, nuniq: 1001
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.729 to Inf
</td>
<td style="text-align:left;">
2378
</td>
<td style="text-align:left;">
mean: Inf, median: 0.122, nuniq: 233156
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -1 to 6.333
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: -0.241, median: -0.231, sd: 0.245, nuniq: 27286
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -1 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0, nuniq: 21951
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -1 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.545, nuniq: 25250
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: -21.22 to 629.369
</td>
<td style="text-align:left;">
584
</td>
<td style="text-align:left;">
mean: 0.229, median: 0.013, sd: 2.559, nuniq: 286378
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -34.203 to 455.449
</td>
<td style="text-align:left;">
584
</td>
<td style="text-align:left;">
mean: -0.478, median: -0.315, sd: 1.574, nuniq: 116885
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -21.208 to 649.516
</td>
<td style="text-align:left;">
584
</td>
<td style="text-align:left;">
mean: 0.217, median: 0, sd: 2.54, nuniq: 52417
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -11.516 to 774.636
</td>
<td style="text-align:left;">
584
</td>
<td style="text-align:left;">
mean: 0.972, median: 0.438, sd: 4.055, nuniq: 117182
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 0.249
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.005, median: 0, sd: 0.014, nuniq: 199
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NCMCD/estimatesMonthlyTotals
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
year
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Calendar year.
</td>
<td style="text-align:left;">
Num: 2020 to 2022
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2020.933, median: 2021, sd: 0.785, nuniq: 3
</td>
</tr>
<tr>
<td style="text-align:left;">
month
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Calendar month.
</td>
<td style="text-align:left;">
Num: 1 to 12
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 6.3, median: 6, sd: 3.261, nuniq: 12
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 6239 to 105339
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 34886, median: 27332, sd: 27037.674, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 217972 to 347459
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 259143.267, median: 249988.5, sd: 36250.217, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 0
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0, median: 0, sd: 0, nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 203016.531 to 254282.081
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 219325.589, median: 217040.93, sd: 14288.85, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 195291.1 to 243252.7
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 210226.165, median: 208120.825, sd: 13711.037, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 202735 to 254421.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 219233.617, median: 217040.5, sd: 14305.039, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 211085.5 to 265685.3
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 228686.718, median: 226021.675, sd: 14990.42, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 1434.549 to 105971.11
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 39817.678, median: 34783.514, sd: 29041.315, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -8401.25 to 96479.75
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 30456.548, median: 25524.425, sd: 28948.844, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 1375 to 106213
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 39909.65, median: 34891.75, sd: 29033.652, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 10966.9 to 115119.15
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 48917.102, median: 43941.875, sd: 29098.085, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0.617 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.973, median: 1, sd: 0.083, nuniq: 10
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.007 to 0.449
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.181, median: 0.159, sd: 0.125, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -0.037 to 0.392
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.132, median: 0.112, sd: 0.121, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.006 to 0.45
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.18, median: 0.159, sd: 0.125, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.052 to 0.507
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.231, median: 0.209, sd: 0.13, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: 0.23 to 1.935
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.207, median: 1.276, sd: 0.44, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -1.347 to 1.218
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.711, median: 0.934, sd: 0.568, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.22 to 1.953
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.212, median: 1.278, sd: 0.444, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.789 to 2.867
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.688, median: 1.609, sd: 0.624, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0.005 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.703, median: 0.897, sd: 0.371, nuniq: 28
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NCMCD/estimatesPYears
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
pandemicYear
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
12-month ranges beginning in March 2020, each representing one year of
the COVID-19 pandemic in the United States. Note that the most recent
pandemic year be be incomplete due to data lags. If this is the case,
the pandemic year will include fewer than 12 months, as indicated in
this field.
</td>
<td style="text-align:left;">
‘Mar 2020 - Feb 2021’ ‘Mar 2021 - Feb 2022’ ‘Mar 2022 - Aug 2022’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3
</td>
</tr>
<tr>
<td style="text-align:left;">
FIPSCode
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
5-digit Federal Information Processing Standards (FIPS) code that
uniquely identifies United States counties. First 2 digits represent
state, final 3 digits represent county within that state. Includes
leading zeroes. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3127
</td>
</tr>
<tr>
<td style="text-align:left;">
countyName
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the county or county-like area. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘Abbeville County’ ‘Acadia Parish’ ‘Accomack County’ ‘Ada County’ ‘Adair
County’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1864
</td>
</tr>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 9
</td>
</tr>
<tr>
<td style="text-align:left;">
metroCat
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2013 NCHS Urban-Rural Classification Scheme for Counties
</td>
<td style="text-align:left;">
‘Large Central Metro’ ‘Large Fringe Metro’ ‘Medium or Small Metro’ ‘Non
Metro’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 21961
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 151.202, median: 50.5, sd: 495.956, nuniq: 754
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 87034
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 841.742, median: 263, sd: 2388.353, nuniq: 2217
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 0
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 0, median: 0, sd: 0, nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 2 to 59425
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 711.885, median: 223, sd: 1931.819, nuniq: 2053
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 58010
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 670.553, median: 196, sd: 1875.659, nuniq: 2005
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 2 to 59433
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 712.058, median: 223, sd: 1931.7, nuniq: 2059
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 5 to 60890
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 754.961, median: 251, sd: 1988.055, nuniq: 2130
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -314 to 27608
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 128.976, median: 35, sd: 514.764, nuniq: 912
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -467 to 26144
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 86.629, median: 11, sd: 470.231, nuniq: 861
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -310 to 27601
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 129.633, median: 36, sd: 514.788, nuniq: 892
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -174 to 29023
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 170.99, median: 63, sd: 561.366, nuniq: 963
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.848, median: 0.99, sd: 0.259, nuniq: 925
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.941 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.186, nuniq: 9216
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -0.954 to 7
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.05, median: 0.051, sd: 0.229, nuniq: 7381
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.941 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.178, nuniq: 6926
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.923 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.323, nuniq: 7146
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: -6.679 to 9.798
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 1.194, median: 1.172, sd: 0.87, nuniq: 6843
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -8.308 to 7.143
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 0.355, median: 0.583, sd: 1.043, nuniq: 4670
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -6.654 to 9.833
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 1.202, median: 1.178, sd: 0.869, nuniq: 4079
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -5.077 to 12.837
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 2.009, median: 1.76, sd: 1.049, nuniq: 4611
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.447, median: 0.432, sd: 0.393, nuniq: 997
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NCMCD/estimatesPYearsFull
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
pandemicYear
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
12-month ranges beginning in March 2020, each representing one year of
the COVID-19 pandemic in the United States. Note that the most recent
pandemic year be be incomplete due to data lags. If this is the case,
the pandemic year will include fewer than 12 months, as indicated in
this field.
</td>
<td style="text-align:left;">
‘Mar 2020 - Feb 2021’ ‘Mar 2021 - Feb 2022’ ‘Mar 2022 - Aug 2022’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3
</td>
</tr>
<tr>
<td style="text-align:left;">
FIPSCode
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
5-digit Federal Information Processing Standards (FIPS) code that
uniquely identifies United States counties. First 2 digits represent
state, final 3 digits represent county within that state. Includes
leading zeroes. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3127
</td>
</tr>
<tr>
<td style="text-align:left;">
countyName
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the county or county-like area. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘Abbeville County’ ‘Acadia Parish’ ‘Accomack County’ ‘Ada County’ ‘Adair
County’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1864
</td>
</tr>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 9
</td>
</tr>
<tr>
<td style="text-align:left;">
metroCat
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2013 NCHS Urban-Rural Classification Scheme for Counties
</td>
<td style="text-align:left;">
‘Large Central Metro’ ‘Large Fringe Metro’ ‘Medium or Small Metro’ ‘Non
Metro’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 21961
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 151.202, median: 50.5, sd: 495.956, nuniq: 754
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 87034
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 841.742, median: 263, sd: 2388.353, nuniq: 2217
</td>
</tr>
<tr>
<td style="text-align:left;">
imputedDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths with values imputed for counts of 9 or fewer.
</td>
<td style="text-align:left;">
Num: 1 to 87034
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 828.722, median: 256, sd: 2371.954, nuniq: 2226
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.016, median: 0, sd: 0.124, nuniq: 2
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 0.148 to 59425.803
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 701.393, median: 218.183, sd: 1918.718, nuniq: 9320
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 58010.35
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 660.351, median: 192, sd: 1862.935, nuniq: 2689
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 59433
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 701.099, median: 218, sd: 1918.626, nuniq: 2334
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 1 to 60890
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 743.385, median: 246, sd: 1974.691, nuniq: 2860
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -314.783 to 27608.197
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 127.329, median: 34.755, sd: 511.029, nuniq: 9107
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -467.1 to 26144
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 85.337, median: 10, sd: 466.766, nuniq: 1314
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -310 to 27601
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 127.624, median: 35, sd: 511.042, nuniq: 1150
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -174.95 to 29023.65
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 168.371, median: 61, sd: 557.389, nuniq: 1465
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.848, median: 0.99, sd: 0.259, nuniq: 925
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.941 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.186, nuniq: 9216
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -0.954 to 7
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.05, median: 0.051, sd: 0.229, nuniq: 7381
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.941 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.178, nuniq: 6926
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.923 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.323, nuniq: 7146
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: -6.679 to 9.798
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 1.194, median: 1.172, sd: 0.87, nuniq: 6843
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -8.308 to 7.143
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 0.355, median: 0.583, sd: 1.043, nuniq: 4670
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -6.654 to 9.833
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 1.202, median: 1.178, sd: 0.869, nuniq: 4079
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -5.077 to 12.837
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 2.009, median: 1.76, sd: 1.049, nuniq: 4611
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.447, median: 0.432, sd: 0.393, nuniq: 997
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NCMCD/estimatesStates
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘00’ ‘01’ ‘02’ ‘04’ ‘05’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘United States’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 5
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 10
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 770 to 1046374
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 40245.154, median: 13713.5, sd: 144046.628, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 12194 to 7774273
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 299010.5, median: 115183.5, sd: 1068286.723, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.019, median: 0, sd: 0.139, nuniq: 2
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 9526.845 to 6579767.662
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 253067.987, median: 97574.266, sd: 903903.79, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 9307.9 to 6462703.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 248520.019, median: 95766.3, sd: 887830.852, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 9527.5 to 6579169.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 253035.029, median: 97578.25, sd: 903822.401, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 9749 to 6696820.8
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 257636.717, median: 99328.4, sd: 919971.74, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 1106.52 to 1194505.338
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 45942.513, median: 15538.154, sd: 164496.584, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: 804.7 to 1077452.2
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 41373.783, median: 13381.25, sd: 148444.461, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 1120 to 1195103.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 45975.471, median: 15591.75, sd: 164578.278, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 1413.1 to 1311569.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 50490.481, median: 17759.65, sd: 180557.662, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 1 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1, median: 1, sd: 0, nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.079 to 0.293
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.174, median: 0.169, sd: 0.053, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: 0.056 to 0.268
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.152, median: 0.148, sd: 0.052, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.08 to 0.292
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.174, median: 0.169, sd: 0.053, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.103 to 0.319
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.196, median: 0.191, sd: 0.054, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: 0.57 to 1.869
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.164, median: 1.162, sd: 0.244, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.443 to 1.713
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.026, median: 1.027, sd: 0.237, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.569 to 1.869
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.165, median: 1.164, sd: 0.244, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.7 to 2.057
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.301, median: 1.301, sd: 0.264, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.745, median: 0.935, sd: 0.335, nuniq: 37
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NCMCD/estimatesTotal
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
period
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Month range that the data represent.
</td>
<td style="text-align:left;">
‘March 2020 - August 2022’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
FIPSCode
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
5-digit Federal Information Processing Standards (FIPS) code that
uniquely identifies United States counties. First 2 digits represent
state, final 3 digits represent county within that state. Includes
leading zeroes. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3127
</td>
</tr>
<tr>
<td style="text-align:left;">
countyName
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the county or county-like area. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘Abbeville County’ ‘Acadia Parish’ ‘Accomack County’ ‘Ada County’ ‘Adair
County’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1864
</td>
</tr>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 9
</td>
</tr>
<tr>
<td style="text-align:left;">
metroCat
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2013 NCHS Urban-Rural Classification Scheme for Counties
</td>
<td style="text-align:left;">
‘Large Central Metro’ ‘Large Fringe Metro’ ‘Medium or Small Metro’ ‘Non
Metro’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 31004
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 347.836, median: 117, sd: 1040.48, nuniq: 793
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 187569
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 2491.744, median: 827.5, sd: 6675.748, nuniq: 1972
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 0
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 0, median: 0, sd: 0, nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 4 to 146494
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 2108.354, median: 691, sd: 5501.334, nuniq: 1846
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 1 to 143137
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 2019.95, median: 638.5, sd: 5367.376, nuniq: 1817
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 4 to 146433
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 2108.251, median: 691.5, sd: 5500.039, nuniq: 1829
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 8 to 149933
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 2199.09, median: 747, sd: 5636.764, nuniq: 1882
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -258 to 41074
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 382.438, median: 128, sd: 1235.66, nuniq: 942
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -310 to 37635
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 292.34, median: 74, sd: 1111.236, nuniq: 882
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -258 to 41136
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 383.383, median: 129, sd: 1236.912, nuniq: 941
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -208 to 44431
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 471.465, median: 184, sd: 1360.878, nuniq: 1004
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.943, median: 1, sd: 0.177, nuniq: 361
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.944 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.196, nuniq: 3112
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -0.954 to 2.25
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.119, median: 0.111, sd: 0.177, nuniq: 3041
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.944 to 4.571
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.242, median: 0.193, sd: 0.282, nuniq: 3001
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.934 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.287, nuniq: 3041
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: -12.396 to 9.286
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 1.233, median: 1.201, sd: 0.952, nuniq: 3007
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -14.684 to 8.216
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 0.655, median: 0.764, sd: 1.024, nuniq: 2749
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -12.368 to 9.324
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 1.239, median: 1.202, sd: 0.954, nuniq: 2599
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -10.211 to 10.243
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 1.793, median: 1.643, sd: 0.997, nuniq: 2743
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.623, median: 0.747, sd: 0.364, nuniq: 869
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NCMCD/estimatesTotalFull
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
period
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Month range that the data represent.
</td>
<td style="text-align:left;">
‘March 2020 - August 2022’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
FIPSCode
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
5-digit Federal Information Processing Standards (FIPS) code that
uniquely identifies United States counties. First 2 digits represent
state, final 3 digits represent county within that state. Includes
leading zeroes. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3127
</td>
</tr>
<tr>
<td style="text-align:left;">
countyName
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the county or county-like area. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘Abbeville County’ ‘Acadia Parish’ ‘Accomack County’ ‘Ada County’ ‘Adair
County’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1864
</td>
</tr>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 9
</td>
</tr>
<tr>
<td style="text-align:left;">
metroCat
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2013 NCHS Urban-Rural Classification Scheme for Counties
</td>
<td style="text-align:left;">
‘Large Central Metro’ ‘Large Fringe Metro’ ‘Medium or Small Metro’ ‘Non
Metro’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 31004
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 347.836, median: 117, sd: 1040.48, nuniq: 793
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 187569
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 2491.744, median: 827.5, sd: 6675.748, nuniq: 1972
</td>
</tr>
<tr>
<td style="text-align:left;">
imputedDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths with values imputed for counts of 9 or fewer.
</td>
<td style="text-align:left;">
Num: 2 to 187569
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2486.176, median: 823, sd: 6669.306, nuniq: 1977
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.002, median: 0, sd: 0.047, nuniq: 2
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 0.927 to 146494.048
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2104.179, median: 690.642, sd: 5496.06, nuniq: 3123
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 143137.95
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2015.773, median: 636, sd: 5362.306, nuniq: 2136
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 1 to 146433
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2103.637, median: 690, sd: 5494.8, nuniq: 1953
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 3 to 149933.1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2194.258, median: 746, sd: 5631.416, nuniq: 2230
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -258.248 to 41074.952
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 381.997, median: 128.114, sd: 1234.436, nuniq: 3111
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -310.05 to 37635.9
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 291.918, median: 74, sd: 1110.164, nuniq: 1265
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -258 to 41136
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 382.539, median: 128, sd: 1235.702, nuniq: 1119
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -208.95 to 44431.05
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 470.403, median: 183, sd: 1359.571, nuniq: 1407
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.943, median: 1, sd: 0.177, nuniq: 361
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.944 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.196, nuniq: 3112
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -0.954 to 2.25
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.119, median: 0.111, sd: 0.177, nuniq: 3041
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.944 to 4.571
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.242, median: 0.193, sd: 0.282, nuniq: 3001
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.934 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.287, nuniq: 3041
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: -12.396 to 9.286
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 1.233, median: 1.201, sd: 0.952, nuniq: 3007
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -14.684 to 8.216
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 0.655, median: 0.764, sd: 1.024, nuniq: 2749
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -12.368 to 9.324
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 1.239, median: 1.202, sd: 0.954, nuniq: 2599
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -10.211 to 10.243
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 1.793, median: 1.643, sd: 0.997, nuniq: 2743
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.623, median: 0.747, sd: 0.364, nuniq: 869
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NCUCD/estimatesMonthly
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
year
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Calendar year.
</td>
<td style="text-align:left;">
Num: 2020 to 2022
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2020.933, median: 2021, sd: 0.772, nuniq: 3
</td>
</tr>
<tr>
<td style="text-align:left;">
month
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Calendar month.
</td>
<td style="text-align:left;">
Num: 1 to 12
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 6.3, median: 6, sd: 3.206, nuniq: 12
</td>
</tr>
<tr>
<td style="text-align:left;">
FIPSCode
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
5-digit Federal Information Processing Standards (FIPS) code that
uniquely identifies United States counties. First 2 digits represent
state, final 3 digits represent county within that state. Includes
leading zeroes. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3127
</td>
</tr>
<tr>
<td style="text-align:left;">
countyName
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the county or county-like area. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘Abbeville County’ ‘Acadia Parish’ ‘Accomack County’ ‘Ada County’ ‘Adair
County’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1864
</td>
</tr>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 9
</td>
</tr>
<tr>
<td style="text-align:left;">
metroCat
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2013 NCHS Urban-Rural Classification Scheme for Counties
</td>
<td style="text-align:left;">
‘Large Central Metro’ ‘Large Fringe Metro’ ‘Medium or Small Metro’ ‘Non
Metro’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 7270
</td>
<td style="text-align:left;">
76235
</td>
<td style="text-align:left;">
mean: 44.358, median: 20, sd: 123.461, nuniq: 497
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 14256
</td>
<td style="text-align:left;">
19917
</td>
<td style="text-align:left;">
mean: 103.924, median: 38, sd: 256.619, nuniq: 1567
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.212, median: 0, sd: 0.409, nuniq: 2
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 5775
</td>
<td style="text-align:left;">
19917
</td>
<td style="text-align:left;">
mean: 87.232, median: 31, sd: 203.373, nuniq: 1384
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 5494
</td>
<td style="text-align:left;">
19917
</td>
<td style="text-align:left;">
mean: 74.824, median: 23, sd: 191.434, nuniq: 1315
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 1 to 5770
</td>
<td style="text-align:left;">
19917
</td>
<td style="text-align:left;">
mean: 87.522, median: 32, sd: 203.307, nuniq: 1381
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 3 to 6067
</td>
<td style="text-align:left;">
19917
</td>
<td style="text-align:left;">
mean: 101.225, median: 42, sd: 215.477, nuniq: 1445
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -146 to 8480
</td>
<td style="text-align:left;">
19917
</td>
<td style="text-align:left;">
mean: 15.915, median: 5, sd: 80.673, nuniq: 678
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -275 to 8189
</td>
<td style="text-align:left;">
19917
</td>
<td style="text-align:left;">
mean: 2.665, median: -4, sd: 75.178, nuniq: 666
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -147 to 8485
</td>
<td style="text-align:left;">
19917
</td>
<td style="text-align:left;">
mean: 16.385, median: 6, sd: 80.756, nuniq: 668
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -71 to 8761
</td>
<td style="text-align:left;">
19917
</td>
<td style="text-align:left;">
mean: 29.031, median: 14, sd: 87.582, nuniq: 688
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.656, median: 0.706, sd: 0.298, nuniq: 1001
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.643 to Inf
</td>
<td style="text-align:left;">
631
</td>
<td style="text-align:left;">
mean: Inf, median: 0.266, nuniq: 76032
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -1 to 6.333
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: -0.149, median: -0.146, sd: 0.29, nuniq: 14593
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -1 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.135, nuniq: 12041
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -1 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.737, nuniq: 13305
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: -8.135 to 659.334
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 0.72, median: 0.155, sd: 4.5, nuniq: 93321
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -21.02 to 481.589
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: -0.13, median: -0.156, sd: 2.511, nuniq: 57107
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -6.962 to 673.192
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 0.671, median: 0.118, sd: 4.475, nuniq: 25378
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -3.536 to 832.761
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 1.717, median: 0.674, sd: 7.032, nuniq: 49934
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 0.238
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.009, median: 0, sd: 0.018, nuniq: 185
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NCUCD/estimatesMonthlyFull
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
year
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Calendar year.
</td>
<td style="text-align:left;">
Num: 2015 to 2022
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2018.348, median: 2018, sd: 2.219, nuniq: 8
</td>
</tr>
<tr>
<td style="text-align:left;">
month
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Calendar month.
</td>
<td style="text-align:left;">
Num: 1 to 12
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 6.326, median: 6, sd: 3.414, nuniq: 12
</td>
</tr>
<tr>
<td style="text-align:left;">
FIPSCode
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
5-digit Federal Information Processing Standards (FIPS) code that
uniquely identifies United States counties. First 2 digits represent
state, final 3 digits represent county within that state. Includes
leading zeroes. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3127
</td>
</tr>
<tr>
<td style="text-align:left;">
countyName
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the county or county-like area. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘Abbeville County’ ‘Acadia Parish’ ‘Accomack County’ ‘Ada County’ ‘Adair
County’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1864
</td>
</tr>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 9
</td>
</tr>
<tr>
<td style="text-align:left;">
metroCat
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2013 NCHS Urban-Rural Classification Scheme for Counties
</td>
<td style="text-align:left;">
‘Large Central Metro’ ‘Large Fringe Metro’ ‘Medium or Small Metro’ ‘Non
Metro’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 7270
</td>
<td style="text-align:left;">
270109
</td>
<td style="text-align:left;">
mean: 44.358, median: 20, sd: 123.461, nuniq: 497
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 14256
</td>
<td style="text-align:left;">
67911
</td>
<td style="text-align:left;">
mean: 94.127, median: 35, sd: 223.813, nuniq: 2028
</td>
</tr>
<tr>
<td style="text-align:left;">
imputedDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths with values imputed for counts of 9 or fewer.
</td>
<td style="text-align:left;">
Num: 0 to 14256
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 73.023, median: 24, sd: 199.277, nuniq: 2038
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.236, median: 0, sd: 0.425, nuniq: 2
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 0.018 to 6287.981
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 68.9, median: 22.614, sd: 182.129, nuniq: 110294
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 6159.95
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 58.615, median: 15, sd: 173.144, nuniq: 3047
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 6287.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 68.722, median: 22, sd: 182.114, nuniq: 2701
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 6416
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 79.797, median: 31, sd: 191.261, nuniq: 3333
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -307.794 to 8480.146
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 4.123, median: 0.183, sd: 42.273, nuniq: 52291
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -428.1 to 8189
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: -6.774, median: -6, sd: 40.085, nuniq: 1213
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -310 to 8485.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 4.3, median: 0, sd: 42.292, nuniq: 982
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -182.9 to 8761.1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 14.408, median: 8, sd: 46.523, nuniq: 1178
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.52, median: 0.483, sd: 0.298, nuniq: 1001
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.729 to Inf
</td>
<td style="text-align:left;">
2378
</td>
<td style="text-align:left;">
mean: Inf, median: 0.122, nuniq: 233156
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -1 to 6.333
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: -0.241, median: -0.231, sd: 0.245, nuniq: 27286
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -1 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0, nuniq: 21951
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -1 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.545, nuniq: 25250
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: -21.401 to 659.334
</td>
<td style="text-align:left;">
584
</td>
<td style="text-align:left;">
mean: 0.233, median: 0.013, sd: 2.632, nuniq: 285606
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -35.833 to 481.589
</td>
<td style="text-align:left;">
584
</td>
<td style="text-align:left;">
mean: -0.475, median: -0.316, sd: 1.636, nuniq: 116738
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -20.75 to 673.192
</td>
<td style="text-align:left;">
584
</td>
<td style="text-align:left;">
mean: 0.223, median: 0, sd: 2.606, nuniq: 53166
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -12 to 832.761
</td>
<td style="text-align:left;">
584
</td>
<td style="text-align:left;">
mean: 0.974, median: 0.439, sd: 4.117, nuniq: 117070
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 0.238
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.005, median: 0, sd: 0.012, nuniq: 185
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NCUCD/estimatesMonthlyTotals
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
year
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Calendar year.
</td>
<td style="text-align:left;">
Num: 2020 to 2022
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2020.933, median: 2021, sd: 0.785, nuniq: 3
</td>
</tr>
<tr>
<td style="text-align:left;">
month
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Calendar month.
</td>
<td style="text-align:left;">
Num: 1 to 12
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 6.3, median: 6, sd: 3.261, nuniq: 12
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 3662 to 96235
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 30836.433, median: 24485, sd: 25132, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 217972 to 347459
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 259143.267, median: 249988.5, sd: 36250.217, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 0
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0, median: 0, sd: 0, nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 203016.531 to 254282.081
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 219325.589, median: 217040.93, sd: 14288.85, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 195291.1 to 243252.7
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 210226.165, median: 208120.825, sd: 13711.037, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 202735 to 254421.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 219233.617, median: 217040.5, sd: 14305.039, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 211085.5 to 265685.3
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 228686.718, median: 226021.675, sd: 14990.42, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 1434.549 to 105971.11
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 39817.678, median: 34783.514, sd: 29041.315, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -8401.25 to 96479.75
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 30456.548, median: 25524.425, sd: 28948.844, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 1375 to 106213
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 39909.65, median: 34891.75, sd: 29033.652, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 10966.9 to 115119.15
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 48917.102, median: 43941.875, sd: 29098.085, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0.617 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.973, median: 1, sd: 0.083, nuniq: 10
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.007 to 0.449
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.181, median: 0.159, sd: 0.125, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -0.037 to 0.392
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.132, median: 0.112, sd: 0.121, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.006 to 0.45
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.18, median: 0.159, sd: 0.125, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.052 to 0.507
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.231, median: 0.209, sd: 0.13, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: 0.362 to 2.63
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.449, median: 1.384, sd: 0.615, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -2.294 to 1.622
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.802, median: 1.066, sd: 0.765, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.37 to 2.642
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.455, median: 1.39, sd: 0.622, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.934 to 4.334
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2.077, median: 1.772, sd: 0.967, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0.033 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.793, median: 0.972, sd: 0.31, nuniq: 24
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NCUCD/estimatesPYears
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
pandemicYear
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
12-month ranges beginning in March 2020, each representing one year of
the COVID-19 pandemic in the United States. Note that the most recent
pandemic year be be incomplete due to data lags. If this is the case,
the pandemic year will include fewer than 12 months, as indicated in
this field.
</td>
<td style="text-align:left;">
‘Mar 2020 - Feb 2021’ ‘Mar 2021 - Feb 2022’ ‘Mar 2022 - Aug 2022’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3
</td>
</tr>
<tr>
<td style="text-align:left;">
FIPSCode
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
5-digit Federal Information Processing Standards (FIPS) code that
uniquely identifies United States counties. First 2 digits represent
state, final 3 digits represent county within that state. Includes
leading zeroes. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3127
</td>
</tr>
<tr>
<td style="text-align:left;">
countyName
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the county or county-like area. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘Abbeville County’ ‘Acadia Parish’ ‘Accomack County’ ‘Ada County’ ‘Adair
County’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1864
</td>
</tr>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 9
</td>
</tr>
<tr>
<td style="text-align:left;">
metroCat
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2013 NCHS Urban-Rural Classification Scheme for Counties
</td>
<td style="text-align:left;">
‘Large Central Metro’ ‘Large Fringe Metro’ ‘Medium or Small Metro’ ‘Non
Metro’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 21128
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 142.377, median: 47, sd: 475.378, nuniq: 705
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 87034
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 841.742, median: 263, sd: 2388.353, nuniq: 2217
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 0
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 0, median: 0, sd: 0, nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 2 to 59425
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 711.885, median: 223, sd: 1931.819, nuniq: 2053
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 58010
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 670.553, median: 196, sd: 1875.659, nuniq: 2005
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 2 to 59433
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 712.058, median: 223, sd: 1931.7, nuniq: 2059
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 5 to 60890
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 754.961, median: 251, sd: 1988.055, nuniq: 2130
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -314 to 27608
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 128.976, median: 35, sd: 514.764, nuniq: 912
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -467 to 26144
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 86.629, median: 11, sd: 470.231, nuniq: 861
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -310 to 27601
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 129.633, median: 36, sd: 514.788, nuniq: 892
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -174 to 29023
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 170.99, median: 63, sd: 561.366, nuniq: 963
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.848, median: 0.99, sd: 0.259, nuniq: 925
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.941 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.186, nuniq: 9216
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -0.954 to 7
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.05, median: 0.051, sd: 0.229, nuniq: 7381
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.941 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.178, nuniq: 6926
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.923 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.323, nuniq: 7146
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: -7.235 to 12.132
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 1.404, median: 1.326, sd: 1.044, nuniq: 6401
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -9.465 to 8.214
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 0.468, median: 0.698, sd: 1.172, nuniq: 4378
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -7.208 to 12.071
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 1.412, median: 1.333, sd: 1.044, nuniq: 3896
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -5.5 to 15.786
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 2.314, median: 1.962, sd: 1.341, nuniq: 4457
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.472, median: 0.495, sd: 0.413, nuniq: 976
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NCUCD/estimatesPYearsFull
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
pandemicYear
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
12-month ranges beginning in March 2020, each representing one year of
the COVID-19 pandemic in the United States. Note that the most recent
pandemic year be be incomplete due to data lags. If this is the case,
the pandemic year will include fewer than 12 months, as indicated in
this field.
</td>
<td style="text-align:left;">
‘Mar 2020 - Feb 2021’ ‘Mar 2021 - Feb 2022’ ‘Mar 2022 - Aug 2022’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3
</td>
</tr>
<tr>
<td style="text-align:left;">
FIPSCode
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
5-digit Federal Information Processing Standards (FIPS) code that
uniquely identifies United States counties. First 2 digits represent
state, final 3 digits represent county within that state. Includes
leading zeroes. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3127
</td>
</tr>
<tr>
<td style="text-align:left;">
countyName
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the county or county-like area. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘Abbeville County’ ‘Acadia Parish’ ‘Accomack County’ ‘Ada County’ ‘Adair
County’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1864
</td>
</tr>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 9
</td>
</tr>
<tr>
<td style="text-align:left;">
metroCat
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2013 NCHS Urban-Rural Classification Scheme for Counties
</td>
<td style="text-align:left;">
‘Large Central Metro’ ‘Large Fringe Metro’ ‘Medium or Small Metro’ ‘Non
Metro’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 21128
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 142.377, median: 47, sd: 475.378, nuniq: 705
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 87034
</td>
<td style="text-align:left;">
146
</td>
<td style="text-align:left;">
mean: 841.742, median: 263, sd: 2388.353, nuniq: 2217
</td>
</tr>
<tr>
<td style="text-align:left;">
imputedDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths with values imputed for counts of 9 or fewer.
</td>
<td style="text-align:left;">
Num: 1 to 87034
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 828.722, median: 256, sd: 2371.954, nuniq: 2226
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.016, median: 0, sd: 0.124, nuniq: 2
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 0.148 to 59425.803
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 701.393, median: 218.183, sd: 1918.718, nuniq: 9320
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 58010.35
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 660.351, median: 192, sd: 1862.935, nuniq: 2689
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 59433
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 701.099, median: 218, sd: 1918.626, nuniq: 2334
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 1 to 60890
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 743.385, median: 246, sd: 1974.691, nuniq: 2860
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -314.783 to 27608.197
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 127.329, median: 34.755, sd: 511.029, nuniq: 9107
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -467.1 to 26144
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 85.337, median: 10, sd: 466.766, nuniq: 1314
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -310 to 27601
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 127.624, median: 35, sd: 511.042, nuniq: 1150
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -174.95 to 29023.65
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 168.371, median: 61, sd: 557.389, nuniq: 1465
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.848, median: 0.99, sd: 0.259, nuniq: 925
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.941 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.186, nuniq: 9216
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -0.954 to 7
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.05, median: 0.051, sd: 0.229, nuniq: 7381
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.941 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.178, nuniq: 6926
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.923 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.323, nuniq: 7146
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: -7.235 to 12.132
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 1.404, median: 1.326, sd: 1.044, nuniq: 6401
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -9.465 to 8.214
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 0.468, median: 0.698, sd: 1.172, nuniq: 4378
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -7.208 to 12.071
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 1.412, median: 1.333, sd: 1.044, nuniq: 3896
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -5.5 to 15.786
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 2.314, median: 1.962, sd: 1.341, nuniq: 4457
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.472, median: 0.495, sd: 0.413, nuniq: 976
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NCUCD/estimatesStates
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘00’ ‘01’ ‘02’ ‘04’ ‘05’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘United States’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 5
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 10
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 569 to 924859
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 35571.5, median: 11508, sd: 127375.928, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 12194 to 7774273
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 299010.5, median: 115183.5, sd: 1068286.723, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.019, median: 0, sd: 0.139, nuniq: 2
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 9526.845 to 6579767.662
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 253067.987, median: 97574.266, sd: 903903.79, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 9307.9 to 6462703.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 248520.019, median: 95766.3, sd: 887830.852, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 9527.5 to 6579169.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 253035.029, median: 97578.25, sd: 903822.401, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 9749 to 6696820.8
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 257636.717, median: 99328.4, sd: 919971.74, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 1106.52 to 1194505.338
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 45942.513, median: 15538.154, sd: 164496.584, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: 804.7 to 1077452.2
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 41373.783, median: 13381.25, sd: 148444.461, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 1120 to 1195103.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 45975.471, median: 15591.75, sd: 164578.278, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: 1413.1 to 1311569.5
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 50490.481, median: 17759.65, sd: 180557.662, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 1 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1, median: 1, sd: 0, nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.079 to 0.293
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.174, median: 0.169, sd: 0.053, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: 0.056 to 0.268
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.152, median: 0.148, sd: 0.052, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.08 to 0.292
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.174, median: 0.169, sd: 0.053, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: 0.103 to 0.319
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.196, median: 0.191, sd: 0.054, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: 0.693 to 2.127
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.339, median: 1.327, sd: 0.287, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.538 to 1.95
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.179, median: 1.194, sd: 0.267, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.692 to 2.126
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.341, median: 1.33, sd: 0.287, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.85 to 2.483
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.498, median: 1.474, sd: 0.322, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0.01 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.883, median: 0.996, sd: 0.253, nuniq: 30
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NCUCD/estimatesTotal
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
period
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Month range that the data represent.
</td>
<td style="text-align:left;">
‘March 2020 - August 2022’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
FIPSCode
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
5-digit Federal Information Processing Standards (FIPS) code that
uniquely identifies United States counties. First 2 digits represent
state, final 3 digits represent county within that state. Includes
leading zeroes. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3127
</td>
</tr>
<tr>
<td style="text-align:left;">
countyName
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the county or county-like area. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘Abbeville County’ ‘Acadia Parish’ ‘Accomack County’ ‘Ada County’ ‘Adair
County’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1864
</td>
</tr>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 9
</td>
</tr>
<tr>
<td style="text-align:left;">
metroCat
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2013 NCHS Urban-Rural Classification Scheme for Counties
</td>
<td style="text-align:left;">
‘Large Central Metro’ ‘Large Fringe Metro’ ‘Medium or Small Metro’ ‘Non
Metro’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 29168
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 309.564, median: 104.5, sd: 952.339, nuniq: 727
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 187569
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 2491.744, median: 827.5, sd: 6675.748, nuniq: 1972
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 0
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 0, median: 0, sd: 0, nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 4 to 146494
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 2108.354, median: 691, sd: 5501.334, nuniq: 1846
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 1 to 143137
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 2019.95, median: 638.5, sd: 5367.376, nuniq: 1817
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 4 to 146433
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 2108.251, median: 691.5, sd: 5500.039, nuniq: 1829
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 8 to 149933
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 2199.09, median: 747, sd: 5636.764, nuniq: 1882
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -258 to 41074
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 382.438, median: 128, sd: 1235.66, nuniq: 942
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -310 to 37635
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 292.34, median: 74, sd: 1111.236, nuniq: 882
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -258 to 41136
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 383.383, median: 129, sd: 1236.912, nuniq: 941
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -208 to 44431
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 471.465, median: 184, sd: 1360.878, nuniq: 1004
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.943, median: 1, sd: 0.177, nuniq: 361
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.944 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.196, nuniq: 3112
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -0.954 to 2.25
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.119, median: 0.111, sd: 0.177, nuniq: 3041
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.944 to 4.571
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.242, median: 0.193, sd: 0.282, nuniq: 3001
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.934 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.287, nuniq: 3041
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: -15.702 to 10.105
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 1.397, median: 1.362, sd: 1.081, nuniq: 2986
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -18.6 to 8.941
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 0.742, median: 0.874, sd: 1.171, nuniq: 2713
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -15.667 to 10.147
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 1.403, median: 1.365, sd: 1.083, nuniq: 2604
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -12.933 to 11.147
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 2.03, median: 1.858, sd: 1.121, nuniq: 2695
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.693, median: 0.864, sd: 0.35, nuniq: 797
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NCUCD/estimatesTotalFull
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
period
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Month range that the data represent.
</td>
<td style="text-align:left;">
‘March 2020 - August 2022’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1
</td>
</tr>
<tr>
<td style="text-align:left;">
FIPSCode
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
5-digit Federal Information Processing Standards (FIPS) code that
uniquely identifies United States counties. First 2 digits represent
state, final 3 digits represent county within that state. Includes
leading zeroes. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3127
</td>
</tr>
<tr>
<td style="text-align:left;">
countyName
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the county or county-like area. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘Abbeville County’ ‘Acadia Parish’ ‘Accomack County’ ‘Ada County’ ‘Adair
County’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1864
</td>
</tr>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 9
</td>
</tr>
<tr>
<td style="text-align:left;">
metroCat
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2013 NCHS Urban-Rural Classification Scheme for Counties
</td>
<td style="text-align:left;">
‘Large Central Metro’ ‘Large Fringe Metro’ ‘Medium or Small Metro’ ‘Non
Metro’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 29168
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 309.564, median: 104.5, sd: 952.339, nuniq: 727
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 187569
</td>
<td style="text-align:left;">
7
</td>
<td style="text-align:left;">
mean: 2491.744, median: 827.5, sd: 6675.748, nuniq: 1972
</td>
</tr>
<tr>
<td style="text-align:left;">
imputedDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths with values imputed for counts of 9 or fewer.
</td>
<td style="text-align:left;">
Num: 2 to 187569
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2486.176, median: 823, sd: 6669.306, nuniq: 1977
</td>
</tr>
<tr>
<td style="text-align:left;">
suppressed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">

Flag indicating whether output has been suppressed. The CDC WONDER data
use agreement prohibits presenting or publishing death counts of 9 or
fewer, or death rates based on counts of 9 or fewer.

1 = suppression applied, 0 = not suppressed.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.002, median: 0, sd: 0.047, nuniq: 2
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 0.927 to 146494.048
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2104.179, median: 690.642, sd: 5496.06, nuniq: 3123
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 143137.95
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2015.773, median: 636, sd: 5362.306, nuniq: 2136
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 1 to 146433
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2103.637, median: 690, sd: 5494.8, nuniq: 1953
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 3 to 149933.1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2194.258, median: 746, sd: 5631.416, nuniq: 2230
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -258.248 to 41074.952
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 381.997, median: 128.114, sd: 1234.436, nuniq: 3111
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -310.05 to 37635.9
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 291.918, median: 74, sd: 1110.164, nuniq: 1265
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -258 to 41136
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 382.539, median: 128, sd: 1235.702, nuniq: 1119
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -208.95 to 44431.05
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 470.403, median: 183, sd: 1359.571, nuniq: 1407
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.943, median: 1, sd: 0.177, nuniq: 361
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.944 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.196, nuniq: 3112
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of relative excess deaths, calculated as (excDeaths
/ expDeaths).
</td>
<td style="text-align:left;">
Num: -0.954 to 2.25
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.119, median: 0.111, sd: 0.177, nuniq: 3041
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median relative excess deaths, calculated as (excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.944 to 4.571
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.242, median: 0.193, sd: 0.282, nuniq: 3001
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of relative excess deaths, calculated as
(excDeaths / expDeaths).
</td>
<td style="text-align:left;">
Num: -0.934 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.287, nuniq: 3041
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMean
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMean / COVIDDeathsMean).
</td>
<td style="text-align:left;">
Num: -15.702 to 10.105
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 1.397, median: 1.362, sd: 1.081, nuniq: 2986
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -18.6 to 8.941
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 0.742, median: 0.874, sd: 1.171, nuniq: 2713
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -15.667 to 10.147
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 1.403, median: 1.365, sd: 1.083, nuniq: 2604
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -12.933 to 11.147
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 2.03, median: 1.858, sd: 1.121, nuniq: 2695
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.693, median: 0.864, sd: 0.35, nuniq: 797
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NCUCD/estimatesYearly
</caption>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Class
</th>
<th style="text-align:left;">
Label
</th>
<th style="text-align:left;">
Values
</th>
<th style="text-align:left;">
Missing
</th>
<th style="text-align:left;">
Summary
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
FIPSCode
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
5-digit Federal Information Processing Standards (FIPS) code that
uniquely identifies United States counties. First 2 digits represent
state, final 3 digits represent county within that state. Includes
leading zeroes. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 3127
</td>
</tr>
<tr>
<td style="text-align:left;">
countyName
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the county or county-like area. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘Abbeville County’ ‘Acadia Parish’ ‘Accomack County’ ‘Ada County’ ‘Adair
County’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 1864
</td>
</tr>
<tr>
<td style="text-align:left;">
state
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Full state name. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
stateFIPS
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2-digit code that uniquely identifies United States states, territories,
and outlying regions. Includes leading zeroes. Place of residence of the
decedents.
</td>
<td style="text-align:left;">
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 51
</td>
</tr>
<tr>
<td style="text-align:left;">
census_region
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Region. Census Divisions are nested within Census
Regions. Place of residence of the decedents.
</td>
<td style="text-align:left;">
‘North Central’ ‘Northeast’ ‘South’ ‘West’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
census_division
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
Name of the US Census Division. States are nested within Census
Divisions, which are further nested within Census Regions. Place of
residence of the decedents.
</td>
<td style="text-align:left;">
‘East North Central’ ‘East South Central’ ‘Middle Atlantic’ ‘Mountain’
‘New England’ and more
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 9
</td>
</tr>
<tr>
<td style="text-align:left;">
metroCat
</td>
<td style="text-align:left;">
character
</td>
<td style="text-align:left;">
2013 NCHS Urban-Rural Classification Scheme for Counties
</td>
<td style="text-align:left;">
‘Large Central Metro’ ‘Large Fringe Metro’ ‘Medium or Small Metro’ ‘Non
Metro’
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
nuniq: 4
</td>
</tr>
<tr>
<td style="text-align:left;">
year
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Calendar year.
</td>
<td style="text-align:left;">
Num: 2020 to 2022
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2021, median: 2021, sd: 0.817, nuniq: 3
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the underlying cause of death (ICD-10 diagnosis
code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer are
suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 13959
</td>
<td style="text-align:left;">
2045
</td>
<td style="text-align:left;">
mean: 124.799, median: 43, sd: 388.006, nuniq: 714
</td>
</tr>
<tr>
<td style="text-align:left;">
deaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the National Vital Statistics System (NVSS)
obtained via CDC WONDER. Counts of 9 or fewer are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 76395
</td>
<td style="text-align:left;">
121
</td>
<td style="text-align:left;">
mean: 839.771, median: 275, sd: 2284.342, nuniq: 2223
</td>
</tr>
<tr>
<td style="text-align:left;">
imputedDeaths
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths with values imputed for counts of 9 or fewer.
</td>
<td style="text-align:left;">
Num: 1 to 76395
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 829.013, median: 270, sd: 2271.512, nuniq: 2232
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 52866.65
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 619.361, median: 191, sd: 1681.112, nuniq: 2775
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median model-predicted expected deaths count.
</td>
<td style="text-align:left;">
Num: 0 to 58877
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 698.693, median: 224, sd: 1861.253, nuniq: 2495
</td>
</tr>
<tr>
<td style="text-align:left;">
expDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of the posterior interval for model-predicted
expected deaths count.
</td>
<td style="text-align:left;">
Num: 1 to 65322.25
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 784.3, median: 261, sd: 2055.012, nuniq: 3086
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of estimated excess deaths, calculated as (deaths -
expDeaths).
</td>
<td style="text-align:left;">
Num: -1112.75 to 12724.75
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 44.713, median: 6.95, sd: 316.651, nuniq: 1466
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median estimated excess deaths, calculated as (deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -220 to 17518
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 130.321, median: 42, sd: 454.262, nuniq: 1219
</td>
</tr>
<tr>
<td style="text-align:left;">
excDeathsUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of estimated excess deaths, calculated as
(deaths - expDeaths).
</td>
<td style="text-align:left;">
Num: -71 to 23528.35
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 209.652, median: 77.05, sd: 614.437, nuniq: 1786
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
NULL
</td>
<td style="text-align:left;">
Num: -0.95 to 6
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.038, median: 0.031, sd: 0.215, nuniq: 7575
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
NULL
</td>
<td style="text-align:left;">
Num: -0.931 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.199, nuniq: 7056
</td>
</tr>
<tr>
<td style="text-align:left;">
relExcUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
NULL
</td>
<td style="text-align:left;">
Num: -0.9 to Inf
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: Inf, median: 0.404, nuniq: 7213
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLow
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsLow / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -9.692 to 4.905
</td>
<td style="text-align:left;">
2045
</td>
<td style="text-align:left;">
mean: 0.164, median: 0.37, sd: 1.078, nuniq: 4962
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMed
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths, calculated as
(excDeathsMed / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -7.385 to 8.083
</td>
<td style="text-align:left;">
2045
</td>
<td style="text-align:left;">
mean: 1.436, median: 1.405, sd: 0.875, nuniq: 4083
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUp
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths,
calculated as (excDeathsUp / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -5.462 to 12.3
</td>
<td style="text-align:left;">
2045
</td>
<td style="text-align:left;">
mean: 2.603, median: 2.373, sd: 1.092, nuniq: 4931
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.873, median: 0.975, sd: 0.215, nuniq: 860
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcess
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.529, median: 0.621, sd: 0.366, nuniq: 985
</td>
</tr>
<tr>
<td style="text-align:left;">
pop
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
NULL
</td>
<td style="text-align:left;">
Num: 47.785 to 9975809.875
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 106197.893, median: 25855.396, sd: 335845.898, nuniq: 9379
</td>
</tr>
</tbody>
</table>
