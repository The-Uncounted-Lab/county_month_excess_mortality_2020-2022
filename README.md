# Monthly County Level Excess Mortality
The aim of this project is to build a model to estimate monthly death rates (number of deaths divided by population) at the county level for the United States. We do so with two different set of models, on using yearly data and the other using monthly data. The yearly model has an advantage over the monthly model when there is a substantial amount of suppression due to the presence of too few deaths (less than 10) in some small counties. The yearly data, by aggregating the information over several months, reduces the chances of suppression and let us build a model that takes advantage of all the available information.

The project consists of 8 main RMarkdown files:

- dataCreation.Rmd: Cleans the data for All-Causes deaths.
- modelsFitMonthly.Rmd: Estimates the monthly level models for All-Causes deaths.
- modelsFitYearly.Rmd: Estimates the yearly level models for All-Causes deaths.
- modelsPerformance.Rmd: Assesses the models performance and creates diagnosic plots for All-Causes deaths.
- exMortEstimates.Rmd: Generates excess deaths estimates for All-Causes mortality for two separate periods, Mar-Dec 2020 and Jan-Dec 2021.
- graphsPart1.Rmd: Produces figures 1, 2, and 3.
- graphsPart2.Rmd: Produces figures 4 and 5.
- summaryTable: Produces table 1.

The files are intended to be run in the order in which they appear on the list. We cannot provide mortality data from the CDC WONDER platform but all the other data is given.
