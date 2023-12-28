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
States, March 2020 to December 2021” \[Link to article in Science
Advances\]](https://www.science.org/doi/10.1126/sciadv.adf9742) and
[“Differences Between Reported COVID-19 Deaths and Estimated Excess
Deaths in Counties Across the United States, March 2020 to February
2022” \[Link to
pre-print\]](https://www.medrxiv.org/content/10.1101/2023.01.16.23284633v1).

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

    -- AC
       |__estimatesMonthly.csv
       |__estimatesMonthlyTotals.csv
       |__estimatesPYears.csv
       |__estimatesStates.csv
       |__estimatesTotal.csv
    -- NC
       |__estimatesMonthly.csv
       |__estimatesMonthlyTotals.csv
       |__estimatesPYears.csv
       |__estimatesStates.csv
       |__estimatesTotal.csv

## Data Dictionaries and Descriptive Statistics

The following tables contain variable names, descriptions, and
descriptive statistics for each of the datasets in this repository.

<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
AC/estimatesMonthly
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
mean: 2020.933, sd: 0.772, nuniq: 3
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
mean: 6.3, sd: 3.206, nuniq: 12
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
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and 3122 more
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
County’ and 1859 more
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
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and 46 more
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
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and 46 more
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
‘New England’ and 4 more
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
COVIDDeathsUCD
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
mean: 44.358, sd: 123.461, nuniq: 497
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
mean: 111.736, sd: 277.211, nuniq: 1672
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
mean: 0.195, sd: 0.396, nuniq: 2
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
mean: 94.222, sd: 221.164, nuniq: 1473
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
mean: 81.049, sd: 207.464, nuniq: 1391
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
mean: 94.512, sd: 221.098, nuniq: 1475
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
mean: 108.995, sd: 235.036, nuniq: 1539
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
mean: 16.737, sd: 82.582, nuniq: 699
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
mean: 2.705, sd: 75.926, nuniq: 690
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
mean: 17.207, sd: 82.655, nuniq: 687
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
mean: 30.613, sd: 90.935, nuniq: 712
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
mean: 0.66, sd: 0.298, nuniq: 1001
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
mean: Inf, nuniq: 77744
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
mean: -0.145, sd: 0.278, nuniq: 15522
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
mean: Inf, nuniq: 12605
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
mean: Inf, nuniq: 14088
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMeanUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths (as underlying cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -8.166 to 670.101
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 0.771, sd: 4.632, nuniq: 93352
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLowUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths (as
underlying cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -18.21 to 507.125
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: -0.13, sd: 2.61, nuniq: 57821
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMedUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths (as underlying cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -7.692 to 662.962
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 0.716, sd: 4.578, nuniq: 26108
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUpUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths (as
underlying cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -4.3 to 842.23
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 1.84, sd: 7.298, nuniq: 51135
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcessUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 (as underlying
cause), exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 0.227
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.009, sd: 0.019, nuniq: 187
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeathsMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the contributing cause of death (ICD-10
diagnosis code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer
are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 7545
</td>
<td style="text-align:left;">
74110
</td>
<td style="text-align:left;">
mean: 45.309, sd: 124.409, nuniq: 532
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMeanMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths (as contributing cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -7.733 to 639.482
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 0.756, sd: 4.507, nuniq: 93525
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLowMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths (as
contributing cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -20.054 to 479.577
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: -0.142, sd: 2.491, nuniq: 57894
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMedMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths (as contributing
cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -7.094 to 639.398
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 0.697, sd: 4.444, nuniq: 25786
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUpMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths (as
contributing cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -2.87 to 787.75
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 1.833, sd: 7.204, nuniq: 51307
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcessMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 (as contributing
cause), exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 0.24
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.01, sd: 0.021, nuniq: 201
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
AC/estimatesMonthlyTotals
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
mean: 2020.933, sd: 0.785, nuniq: 3
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
mean: 6.3, sd: 3.261, nuniq: 12
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeathsUCD
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
mean: 30836.433, sd: 25132, nuniq: 30
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
mean: 284390.167, sd: 36087.541, nuniq: 30
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
mean: 0, sd: 0, nuniq: 1
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
mean: 241452.813, sd: 14266.487, nuniq: 30
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
mean: 229982.228, sd: 13474.105, nuniq: 30
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
mean: 241380.117, sd: 14290.539, nuniq: 30
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
mean: 253145.502, sd: 15044.905, nuniq: 30
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
mean: 42937.353, sd: 29160.263, nuniq: 30
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
mean: 31244.665, sd: 29079.622, nuniq: 30
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
mean: 43010.05, sd: 29140.896, nuniq: 30
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
mean: 54407.938, sd: 29254.475, nuniq: 30
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
mean: 0.978, sd: 0.065, nuniq: 10
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
mean: 0.178, sd: 0.115, nuniq: 30
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
mean: 0.122, sd: 0.11, nuniq: 30
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
mean: 0.177, sd: 0.115, nuniq: 30
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
mean: 0.235, sd: 0.12, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMeanUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths (as underlying cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.569 to 3.114
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.649, sd: 0.703, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLowUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths (as
underlying cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -2.516 to 1.608
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.836, sd: 0.814, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMedUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths (as underlying cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.569 to 3.139
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.655, sd: 0.708, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUpUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths (as
underlying cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 1.149 to 5.487
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2.446, sd: 1.259, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcessUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 (as underlying
cause), exceeds zero.
</td>
<td style="text-align:left;">
Num: 0.127 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.842, sd: 0.249, nuniq: 26
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeathsMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the contributing cause of death (ICD-10
diagnosis code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer
are suppressed.
</td>
<td style="text-align:left;">
Num: 6239 to 105339
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 34886, sd: 27037.674, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMeanMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths (as contributing cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.424 to 2.311
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.362, sd: 0.486, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLowMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths (as
contributing cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -1.477 to 1.318
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.742, sd: 0.601, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMedMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths (as contributing
cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.427 to 2.317
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.367, sd: 0.488, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUpMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths (as
contributing cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 1.003 to 3.589
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.969, sd: 0.789, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcessMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 (as contributing
cause), exceeds zero.
</td>
<td style="text-align:left;">
Num: 0.052 to 0.999
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.758, sd: 0.32, nuniq: 27
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
AC/estimatesPYears
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
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and 3122 more
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
County’ and 1859 more
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
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and 46 more
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
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and 46 more
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
‘New England’ and 4 more
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
COVIDDeathsUCD
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
mean: 142.377, sd: 475.378, nuniq: 705
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
mean: 921.938, sd: 2612.917, nuniq: 2355
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
mean: 0, sd: 0, nuniq: 1
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
mean: 782.24, sd: 2118.193, nuniq: 2149
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
mean: 734.47, sd: 2042.122, nuniq: 2066
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
mean: 782.418, sd: 2118.105, nuniq: 2150
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
mean: 831.717, sd: 2193.913, nuniq: 2225
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
mean: 138.816, sd: 550.72, nuniq: 947
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
mean: 90.05, sd: 489.788, nuniq: 883
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
mean: 139.458, sd: 550.715, nuniq: 953
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
mean: 187.26, sd: 615.636, nuniq: 1013
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
mean: 0.846, sd: 0.258, nuniq: 944
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
mean: Inf, nuniq: 9247
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
mean: 0.042, sd: 0.219, nuniq: 7523
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
mean: Inf, nuniq: 7054
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
mean: Inf, nuniq: 7310
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMeanUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths (as underlying cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -7.748 to 10.707
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 1.505, sd: 1.124, nuniq: 6405
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLowUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths (as
underlying cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -10.5 to 8.526
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 0.478, sd: 1.235, nuniq: 4534
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMedUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths (as underlying cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -7.75 to 10.722
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 1.513, sd: 1.125, nuniq: 3966
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUpUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths (as
underlying cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -5.996 to 14.154
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 2.504, sd: 1.494, nuniq: 4501
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcessUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 (as underlying
cause), exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.485, sd: 0.415, nuniq: 973
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeathsMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the contributing cause of death (ICD-10
diagnosis code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer
are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 21961
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 151.202, sd: 495.956, nuniq: 754
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMeanMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths (as contributing cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -7.152 to 10.716
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 1.277, sd: 0.924, nuniq: 6846
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLowMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths (as
contributing cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -8.923 to 7.714
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 0.361, sd: 1.095, nuniq: 4766
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMedMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths (as contributing
cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -7.154 to 10.7
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 1.284, sd: 0.925, nuniq: 4099
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUpMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths (as
contributing cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -5.535 to 14.5
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 2.167, sd: 1.146, nuniq: 4716
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcessMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 (as contributing
cause), exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.467, sd: 0.397, nuniq: 992
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
AC/estimatesStates
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
‘00’ ‘01’ ‘02’ ‘04’ ‘05’ and 47 more
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
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and 47 more
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
‘New England’ and 5 more
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
COVIDDeathsUCD
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
mean: 35571.5, sd: 127375.928, nuniq: 52
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
mean: 328140.846, sd: 1172212.209, nuniq: 52
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
mean: 0.019, sd: 0.139, nuniq: 2
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
mean: 278599.4, sd: 994963.396, nuniq: 52
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
mean: 272191.519, sd: 972201.855, nuniq: 52
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
mean: 278572.433, sd: 994833.537, nuniq: 52
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
mean: 285036.869, sd: 1017734.626, nuniq: 52
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
mean: 49541.446, sd: 177374.173, nuniq: 52
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
mean: 43103.977, sd: 154624.522, nuniq: 52
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
mean: 49568.413, sd: 177504.418, nuniq: 52
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
mean: 55949.327, sd: 200118.667, nuniq: 52
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
mean: 1, sd: 0, nuniq: 1
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
mean: 0.169, sd: 0.051, nuniq: 52
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
mean: 0.141, sd: 0.05, nuniq: 52
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
mean: 0.169, sd: 0.051, nuniq: 52
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
mean: 0.197, sd: 0.052, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMeanUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths (as underlying cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.745 to 2.404
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.448, sd: 0.33, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLowUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths (as
underlying cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.52 to 1.988
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.226, sd: 0.3, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMedUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths (as underlying cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.75 to 2.393
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.448, sd: 0.33, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUpUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths (as
underlying cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.964 to 3.099
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.667, sd: 0.379, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcessUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 (as underlying
cause), exceeds zero.
</td>
<td style="text-align:left;">
Num: 0.071 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.895, sd: 0.222, nuniq: 29
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeathsMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the contributing cause of death (ICD-10
diagnosis code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer
are suppressed.
</td>
<td style="text-align:left;">
Num: 770 to 1046374
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 40245.154, sd: 144046.628, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMeanMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths (as contributing cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.613 to 1.972
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.257, sd: 0.275, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLowMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths (as
contributing cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.428 to 1.747
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.067, sd: 0.262, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMedMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths (as contributing
cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.617 to 1.978
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.258, sd: 0.275, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUpMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths (as
contributing cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.794 to 2.29
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.446, sd: 0.303, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcessMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 (as contributing
cause), exceeds zero.
</td>
<td style="text-align:left;">
Num: 0.005 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.801, sd: 0.299, nuniq: 40
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
AC/estimatesTotal
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
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and 3122 more
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
County’ and 1859 more
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
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and 46 more
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
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and 46 more
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
‘New England’ and 4 more
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
COVIDDeathsUCD
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
mean: 309.564, sd: 952.339, nuniq: 727
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
mean: 2733.623, sd: 7328.749, nuniq: 2030
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
mean: 0, sd: 0, nuniq: 1
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
mean: 2320.354, sd: 6039.891, nuniq: 1891
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
mean: 2214.583, sd: 5852.852, nuniq: 1875
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
mean: 2320.382, sd: 6040.116, nuniq: 1924
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
mean: 2427.933, sd: 6223.277, nuniq: 1954
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
mean: 412.318, sd: 1354.284, nuniq: 960
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
mean: 305.361, sd: 1185.118, nuniq: 876
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
mean: 413.125, sd: 1353.925, nuniq: 960
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
mean: 518.678, sd: 1530.6, nuniq: 1042
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
mean: 0.938, sd: 0.182, nuniq: 385
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
mean: Inf, nuniq: 3113
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
mean: 0.107, sd: 0.165, nuniq: 3054
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
mean: 0.225, sd: 0.252, nuniq: 3043
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
mean: Inf, nuniq: 3053
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMeanUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths (as underlying cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -17.215 to 10.894
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 1.459, sd: 1.111, nuniq: 2986
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLowUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths (as
underlying cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -20.333 to 9.647
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 0.745, sd: 1.212, nuniq: 2735
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMedUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths (as underlying cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -17.267 to 10.912
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 1.466, sd: 1.112, nuniq: 2627
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUpUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths (as
underlying cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -14.133 to 12.118
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 2.151, sd: 1.15, nuniq: 2721
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcessUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 (as underlying
cause), exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.706, sd: 0.345, nuniq: 807
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeathsMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the contributing cause of death (ICD-10
diagnosis code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer
are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 31004
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 347.836, sd: 1040.48, nuniq: 793
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMeanMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths (as contributing cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -13.59 to 10.011
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 1.285, sd: 0.976, nuniq: 3006
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLowMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths (as
contributing cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -16.053 to 8.865
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 0.653, sd: 1.066, nuniq: 2777
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMedMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths (as contributing
cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -13.632 to 10.027
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 1.291, sd: 0.977, nuniq: 2656
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUpMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths (as
contributing cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -11.158 to 11.135
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 1.895, sd: 1.014, nuniq: 2767
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcessMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 (as contributing
cause), exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.646, sd: 0.357, nuniq: 870
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NC/estimatesMonthly
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
mean: 2020.933, sd: 0.772, nuniq: 3
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
mean: 6.3, sd: 3.206, nuniq: 12
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
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and 3122 more
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
County’ and 1859 more
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
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and 46 more
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
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and 46 more
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
‘New England’ and 4 more
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
COVIDDeathsUCD
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
mean: 44.358, sd: 123.461, nuniq: 497
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
mean: 103.924, sd: 256.619, nuniq: 1567
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
mean: 0.212, sd: 0.409, nuniq: 2
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
mean: 87.232, sd: 203.373, nuniq: 1384
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
mean: 74.824, sd: 191.434, nuniq: 1315
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
mean: 87.522, sd: 203.307, nuniq: 1381
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
mean: 101.225, sd: 215.477, nuniq: 1445
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
mean: 15.915, sd: 80.673, nuniq: 678
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
mean: 2.665, sd: 75.178, nuniq: 666
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
mean: 16.385, sd: 80.756, nuniq: 668
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
mean: 29.031, sd: 87.582, nuniq: 688
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
mean: 0.656, sd: 0.298, nuniq: 1001
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
mean: Inf, nuniq: 76032
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
mean: -0.149, sd: 0.29, nuniq: 14593
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
mean: Inf, nuniq: 12041
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
mean: Inf, nuniq: 13305
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMeanUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths (as underlying cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -8.135 to 659.334
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 0.72, sd: 4.5, nuniq: 93321
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLowUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths (as
underlying cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -21.02 to 481.589
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: -0.13, sd: 2.511, nuniq: 57107
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMedUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths (as underlying cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -6.962 to 673.192
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 0.671, sd: 4.475, nuniq: 25378
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUpUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths (as
underlying cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -3.536 to 832.761
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 1.717, sd: 7.032, nuniq: 49934
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcessUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 (as underlying
cause), exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 0.238
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.009, sd: 0.018, nuniq: 185
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeathsMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the contributing cause of death (ICD-10
diagnosis code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer
are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 7545
</td>
<td style="text-align:left;">
74110
</td>
<td style="text-align:left;">
mean: 45.309, sd: 124.409, nuniq: 532
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMeanMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths (as contributing cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -7.667 to 629.369
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 0.706, sd: 4.372, nuniq: 93514
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLowMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths (as
contributing cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -20.848 to 455.449
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: -0.142, sd: 2.396, nuniq: 57322
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMedMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths (as contributing
cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -7.071 to 649.516
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 0.653, sd: 4.362, nuniq: 24935
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUpMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths (as
contributing cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -3.6 to 774.636
</td>
<td style="text-align:left;">
190
</td>
<td style="text-align:left;">
mean: 1.712, sd: 6.922, nuniq: 49946
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcessMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 (as contributing
cause), exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 0.249
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.01, sd: 0.02, nuniq: 198
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NC/estimatesMonthlyTotals
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
mean: 2020.933, sd: 0.785, nuniq: 3
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
mean: 6.3, sd: 3.261, nuniq: 12
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeathsUCD
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
mean: 30836.433, sd: 25132, nuniq: 30
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
mean: 259143.267, sd: 36250.217, nuniq: 30
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
mean: 0, sd: 0, nuniq: 1
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
mean: 219325.589, sd: 14288.85, nuniq: 30
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
mean: 210226.165, sd: 13711.037, nuniq: 30
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
mean: 219233.617, sd: 14305.039, nuniq: 30
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
mean: 228686.718, sd: 14990.42, nuniq: 30
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
mean: 39817.678, sd: 29041.315, nuniq: 30
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
mean: 30456.548, sd: 28948.844, nuniq: 30
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
mean: 39909.65, sd: 29033.652, nuniq: 30
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
mean: 48917.102, sd: 29098.085, nuniq: 30
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
mean: 0.973, sd: 0.083, nuniq: 10
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
mean: 0.181, sd: 0.125, nuniq: 30
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
mean: 0.132, sd: 0.121, nuniq: 30
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
mean: 0.18, sd: 0.125, nuniq: 30
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
mean: 0.231, sd: 0.13, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMeanUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths (as underlying cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.362 to 2.63
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.449, sd: 0.615, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLowUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths (as
underlying cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -2.294 to 1.622
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.802, sd: 0.765, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMedUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths (as underlying cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.37 to 2.642
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.455, sd: 0.622, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUpUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths (as
underlying cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.934 to 4.334
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 2.077, sd: 0.967, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcessUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 (as underlying
cause), exceeds zero.
</td>
<td style="text-align:left;">
Num: 0.033 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.793, sd: 0.31, nuniq: 24
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeathsMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the contributing cause of death (ICD-10
diagnosis code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer
are suppressed.
</td>
<td style="text-align:left;">
Num: 6239 to 105339
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 34886, sd: 27037.674, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMeanMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths (as contributing cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.23 to 1.935
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.207, sd: 0.44, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLowMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths (as
contributing cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -1.347 to 1.218
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.711, sd: 0.568, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMedMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths (as contributing
cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.22 to 1.953
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.212, sd: 0.444, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUpMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths (as
contributing cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.789 to 2.867
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.688, sd: 0.624, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcessMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 (as contributing
cause), exceeds zero.
</td>
<td style="text-align:left;">
Num: 0.005 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.703, sd: 0.371, nuniq: 28
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NC/estimatesPYears
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
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and 3122 more
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
County’ and 1859 more
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
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and 46 more
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
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and 46 more
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
‘New England’ and 4 more
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
COVIDDeathsUCD
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
mean: 142.377, sd: 475.378, nuniq: 705
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
mean: 841.742, sd: 2388.353, nuniq: 2217
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
mean: 0, sd: 0, nuniq: 1
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
mean: 711.885, sd: 1931.819, nuniq: 2053
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
mean: 670.553, sd: 1875.659, nuniq: 2005
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
mean: 712.058, sd: 1931.7, nuniq: 2059
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
mean: 754.961, sd: 1988.055, nuniq: 2130
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
mean: 128.976, sd: 514.764, nuniq: 912
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
mean: 86.629, sd: 470.231, nuniq: 861
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
mean: 129.633, sd: 514.788, nuniq: 892
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
mean: 170.99, sd: 561.366, nuniq: 963
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
mean: 0.848, sd: 0.259, nuniq: 925
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
mean: Inf, nuniq: 9216
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
mean: 0.05, sd: 0.229, nuniq: 7381
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
mean: Inf, nuniq: 6926
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
mean: Inf, nuniq: 7146
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMeanUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths (as underlying cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -7.235 to 12.132
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 1.404, sd: 1.044, nuniq: 6401
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLowUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths (as
underlying cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -9.465 to 8.214
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 0.468, sd: 1.172, nuniq: 4378
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMedUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths (as underlying cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -7.208 to 12.071
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 1.412, sd: 1.044, nuniq: 3896
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUpUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths (as
underlying cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -5.5 to 15.786
</td>
<td style="text-align:left;">
2961
</td>
<td style="text-align:left;">
mean: 2.314, sd: 1.341, nuniq: 4457
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcessUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 (as underlying
cause), exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.472, sd: 0.413, nuniq: 976
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeathsMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the contributing cause of death (ICD-10
diagnosis code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer
are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 21961
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 151.202, sd: 495.956, nuniq: 754
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMeanMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths (as contributing cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -6.679 to 9.798
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 1.194, sd: 0.87, nuniq: 6843
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLowMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths (as
contributing cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -8.308 to 7.143
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 0.355, sd: 1.043, nuniq: 4670
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMedMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths (as contributing
cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -6.654 to 9.833
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 1.202, sd: 0.869, nuniq: 4079
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUpMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths (as
contributing cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -5.077 to 12.837
</td>
<td style="text-align:left;">
2527
</td>
<td style="text-align:left;">
mean: 2.009, sd: 1.049, nuniq: 4611
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcessMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 (as contributing
cause), exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.447, sd: 0.393, nuniq: 997
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NC/estimatesStates
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
‘00’ ‘01’ ‘02’ ‘04’ ‘05’ and 47 more
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
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and 47 more
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
‘New England’ and 5 more
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
COVIDDeathsUCD
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
mean: 35571.5, sd: 127375.928, nuniq: 52
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
mean: 299010.5, sd: 1068286.723, nuniq: 52
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
mean: 0.019, sd: 0.139, nuniq: 2
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
mean: 253067.987, sd: 903903.79, nuniq: 52
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
mean: 248520.019, sd: 887830.852, nuniq: 52
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
mean: 253035.029, sd: 903822.401, nuniq: 52
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
mean: 257636.717, sd: 919971.74, nuniq: 52
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
mean: 45942.513, sd: 164496.584, nuniq: 52
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
mean: 41373.783, sd: 148444.461, nuniq: 52
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
mean: 45975.471, sd: 164578.278, nuniq: 52
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
mean: 50490.481, sd: 180557.662, nuniq: 52
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
mean: 1, sd: 0, nuniq: 1
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
mean: 0.174, sd: 0.053, nuniq: 52
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
mean: 0.152, sd: 0.052, nuniq: 52
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
mean: 0.174, sd: 0.053, nuniq: 52
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
mean: 0.196, sd: 0.054, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMeanUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths (as underlying cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.693 to 2.127
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.339, sd: 0.287, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLowUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths (as
underlying cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.538 to 1.95
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.179, sd: 0.267, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMedUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths (as underlying cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.692 to 2.126
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.341, sd: 0.287, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUpUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths (as
underlying cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.85 to 2.483
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.498, sd: 0.322, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcessUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 (as underlying
cause), exceeds zero.
</td>
<td style="text-align:left;">
Num: 0.01 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.883, sd: 0.253, nuniq: 30
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeathsMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the contributing cause of death (ICD-10
diagnosis code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer
are suppressed.
</td>
<td style="text-align:left;">
Num: 770 to 1046374
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 40245.154, sd: 144046.628, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMeanMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths (as contributing cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.57 to 1.869
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.164, sd: 0.244, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLowMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths (as
contributing cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.443 to 1.713
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.026, sd: 0.237, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMedMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths (as contributing
cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.569 to 1.869
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.165, sd: 0.244, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUpMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths (as
contributing cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: 0.7 to 2.057
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 1.301, sd: 0.264, nuniq: 52
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcessMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 (as contributing
cause), exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.745, sd: 0.335, nuniq: 37
</td>
</tr>
</tbody>
</table>
<table class="table" style="font-size: 12px; margin-left: auto; margin-right: auto;">
<caption style="font-size: initial !important;">
NC/estimatesTotal
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
‘01001’ ‘01003’ ‘01005’ ‘01007’ ‘01009’ and 3122 more
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
County’ and 1859 more
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
‘01’ ‘02’ ‘04’ ‘05’ ‘06’ and 46 more
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
‘Alabama’ ‘Alaska’ ‘Arizona’ ‘Arkansas’ ‘California’ and 46 more
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
‘New England’ and 4 more
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
COVIDDeathsUCD
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
mean: 309.564, sd: 952.339, nuniq: 727
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
mean: 2491.744, sd: 6675.748, nuniq: 1972
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
mean: 0, sd: 0, nuniq: 1
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
mean: 2108.354, sd: 5501.334, nuniq: 1846
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
mean: 2019.95, sd: 5367.376, nuniq: 1817
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
mean: 2108.251, sd: 5500.039, nuniq: 1829
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
mean: 2199.09, sd: 5636.764, nuniq: 1882
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
mean: 382.438, sd: 1235.66, nuniq: 942
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
mean: 292.34, sd: 1111.236, nuniq: 882
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
mean: 383.383, sd: 1236.912, nuniq: 941
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
mean: 471.465, sd: 1360.878, nuniq: 1004
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
mean: 0.943, sd: 0.177, nuniq: 361
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
mean: Inf, nuniq: 3112
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
mean: 0.119, sd: 0.177, nuniq: 3041
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
mean: 0.242, sd: 0.282, nuniq: 3001
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
mean: Inf, nuniq: 3041
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMeanUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths (as underlying cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -15.702 to 10.105
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 1.397, sd: 1.081, nuniq: 2986
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLowUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths (as
underlying cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -18.6 to 8.941
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 0.742, sd: 1.171, nuniq: 2713
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMedUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths (as underlying cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -15.667 to 10.147
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 1.403, sd: 1.083, nuniq: 2604
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUpUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths (as
underlying cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -12.933 to 11.147
</td>
<td style="text-align:left;">
141
</td>
<td style="text-align:left;">
mean: 2.03, sd: 1.121, nuniq: 2695
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcessUCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 (as underlying
cause), exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.693, sd: 0.35, nuniq: 797
</td>
</tr>
<tr>
<td style="text-align:left;">
COVIDDeathsMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Count of deaths reported in the the National Vital Statistics System
(NVSS) with COVID-19 as the contributing cause of death (ICD-10
diagnosis code = U07.1). Obtained via CDC WONDER. Counts of 9 or fewer
are suppressed.
</td>
<td style="text-align:left;">
Num: 10 to 31004
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 347.836, sd: 1040.48, nuniq: 793
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMeanMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Mean ratio of excess deaths to COVID-19 deaths (as contributing cause),
calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -12.396 to 9.286
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 1.233, sd: 0.952, nuniq: 3007
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioLowMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Lower 5th percentile of ratio of excess deaths to COVID-19 deaths (as
contributing cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -14.684 to 8.216
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 0.655, sd: 1.024, nuniq: 2749
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioMedMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Median ratio of excess deaths to COVID-19 deaths (as contributing
cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -12.368 to 9.324
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 1.239, sd: 0.954, nuniq: 2599
</td>
</tr>
<tr>
<td style="text-align:left;">
ratioUpMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Upper 95th percentile of ratio of excess deaths to COVID-19 deaths (as
contributing cause), calculated as (excDeaths / COVIDDeaths).
</td>
<td style="text-align:left;">
Num: -10.211 to 10.243
</td>
<td style="text-align:left;">
120
</td>
<td style="text-align:left;">
mean: 1.793, sd: 0.997, nuniq: 2743
</td>
</tr>
<tr>
<td style="text-align:left;">
probPositiveNCExcessMCD
</td>
<td style="text-align:left;">
numeric
</td>
<td style="text-align:left;">
Probability that excess deaths not assigned to COVID-19 (as contributing
cause), exceeds zero.
</td>
<td style="text-align:left;">
Num: 0 to 1
</td>
<td style="text-align:left;">
0
</td>
<td style="text-align:left;">
mean: 0.623, sd: 0.364, nuniq: 869
</td>
</tr>
</tbody>
</table>
