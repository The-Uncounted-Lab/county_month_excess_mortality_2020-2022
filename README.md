# Monthly County Level Excess Mortality
The aim of this project is to build a model to estimate the monthly number of deaths at the county level for the United States. We do so with two different set of models, on using yearly data and the other using monthly data. The yearly model has an advantage over the monthly model when there is a substantial amount of suppression due to the presence of too few deaths (less than 10) in some small counties. The yearly data, by aggregating the information over several months, reduces the chances of suppression and let us build a model that takes advantage of all the available information.

The project consists of 12 main RMarkdown files:

- dataCreationAC.Rmd: Cleans the data for All-Causes deaths.
- dataCreationNC.Rmd: Cleans the data for Natural-Causes deaths.
- exMortModelsAC.Rmd: Estimates the monthly level models for All-Causes deaths.
- exMortModelsNC.Rmd: Estimates the monthly level models for Natural-Causes deaths.
- exMortModelsYearlyAC.Rmd: Estimates the yearly level models for All-Causes deaths.
- exMortModelsYearlyNC.Rmd: Estimates the yearly level models for Natural-Causes deaths.
- exMortPerformanceAC.Rmd: Assesses the models join performance and creates diagnosic plots for All-Causes deaths.
- exMortPerformanceNC.Rmd: Assesses the models join performance and creates diagnosic plots for All-Causes deaths.
- exMortEstimatesACPI.Rmd: Generates excess deaths estimates for All-Causes mortality for two separate periods, Jan-Dec 2020 and Jan-Oct 2021.
- exMortEstimatesAggACPI.Rmd: Generates excess deaths estimates for All-Causes mortality for the entire pandemic, Jan 2020 - Oct 2021.
- exMortEstimatesNCPI.Rmd: Generates excess deaths estimates for Natural-Causes mortality for two separate periods, Jan-Dec 2020 and Jan-Oct 2021.
- exMortEstimatesAggNCPI.Rmd: Generates excess deaths estimates for All-Causes mortality for the entire pandemic, Jan 2020 - Oct 2021.
