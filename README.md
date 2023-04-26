# Monthly County Level Excess Mortality

This repo includes data and code required to replicate the results in the paper "Excess all-cause mortality across counties in the United States, March 2020 to December 2021". [[Link to Pre-Print]](https://www.medrxiv.org/content/10.1101/2022.04.23.22274192v4) and "Differences Between Reported COVID-19 Deaths and Estimated Excess Deaths in Counties Across the United States, March 2020 to February 2022" [Link to Pre-Print]](https://www.medrxiv.org/content/10.1101/2023.01.16.23284633v1).

The aim of this project is to estimate monthly deaths at the county level for the United States for the period March 2020 - August 2022 in the counterfactual scenario of no COVID-19 pandemic. We do so with a Bayesian hierarchical model with a flexible time component and a spatial component. To deal with suppression of death counts < 10, we employ a set of state-year censored Poisson models to estimate the censored death counts. We then adjust the total number of imputed deaths making sure that the sum of non-suppressed and imputed deaths equal the state yearly death count (very unlikely to be suppressed).

The project consists of several RMarkdown and R files:

- cleanMortalityData.Rmd: Cleans the all-cause mortality data.
- cleanCOVIDData.Rmd: Cleans the data for COVID mortality.
- modelFitMonthly.Rmd: Fit the monthly level model for all-cause deaths.
- modelSummary.Rmd: Extracts the model's parameters and hyperparameters and creates summary tables and graphs.
- crossValidationMonthly.Rmd: Runs cross-validation on the model and produces a set of estimates to be used to evaluate the model.
- modelEvaluationMonthly.Rmd: Evaluates model performance using the cross-validation data.
- createSimsDF.Rmd: Creates a dataframe with county-month samples from the model's posterior distribution for death counts. This dataframe is used to construct estimates of death counts with posterior intervals at different levels of aggregation.
- estimates*.Rmd: These files (estimatesMonthly, estimatesPandemicYears, estimatesWaves, estimatesStates, estimatesStateMonths, and estimatesMonthlyTotals) produce estimates of expected death counts, excess death counts, and relative excess at different levels of temporal and geographical aggregation.
- summaryTable.Rmd: Produces a metro-division level table summarizing the key results by pandemic year.
- summaryTableFinal.Rmd: Produces an alternative metro-division level table summarizing the key results for the entire period.
- scatterPlots: Produces scatter plots of excess mortality in year 1 (March 2020 - February 2021) and year 2 (March 2021 - February 2022) and of excess mortality against COVID-19 mortality.
- timeBarsGraphDivision.Rmd: Produces a graph showing how relative excess evolved during the pandemic for each division, separating large metro areas and other areas.
- plotsForSubmission.Rmd: Creates the geofacet plot and the heatmap plot of count-level excess mortality.
- map_by_period_relative_exc_to_eugenio.R: Creates maps of relative excess.
- countyPlots: Produces a set of county-level plots of observed vs. expected deaths.

The files are intended to be run in the order in which they appear on the list. Detailed instructions on the steps we used to download data from the CDC WONDER platform are given in the CDCWONDERDataDetails.md file within the data/output folder.

Aside from the R files within the R folder, we also provide the Python code we used to create monthly population estimates at the county level by interpolating yearly intercensal estimates from the Census Bureau. The Python code is in the form of a Jupyter Notebook. The final population estimates are stored in the output folder.

All estimates can be produced for a combination of all-cause (AC) or natural-cause (NC) mortality data and COVID as Underlying Cause of Death (UCD) or COVID as a contributing cause of death (MCD).

Here is a brief description of the content of the repository:

- Python: Contains the Python code used to generate monthly population estimates.
- R: Contains the R code used to prepare the data, train the models, assess the models' perfomance, produce the estimates of excess mortality, and produce the figures and tables for the paper.
- data/input: Contains all the data needed to train the models and produce estimates of excess deaths. To reconcile inconsistencies across the various data sources we are using, and to accomodate further analysis with a longer backward time frame (i.e. we trained our final models on data for 2015-2019 but initially considered a wider window), we harmonized county FIPS code following the schema in the FIPSFixes.csv file.
- data/output: Will contain all the data that will be generated as a product of the project. We already included different sets of estimates compliant with the CDC Wonder user agreement.
- figures: contains all the figures and tables appearing in the paper.

