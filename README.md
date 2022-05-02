# Excess all-cause mortality across counties in the United States, March 2020 to December 2021

This repo includes data and code required to replicate the results in the paper "Excess all-cause mortality across counties in the United States, March 2020 to December 2021". [[Link to Pre-Print]](https://www.medrxiv.org/content/10.1101/2022.04.23.22274192v1.full.pdf)


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

The files are intended to be run in the order in which they appear on the list. We cannot provide mortality data from the CDC WONDER platform but all the other data are given. Detailed instructions on the steps we used to download data from the CDC WONDER platform are given in the CDCWONDERDataDetails.md file within the data/output folder.

Aside from the RMarkdown files within the R folder, we also provide the Python code we used to create monthly population estimates at the county level by interpolating yearly intercensal estimates from the Census Bureau. The Python code is in the form of a Jupyter Notebook. The final population estimates are stored in the output folder.

Here is a brief description of the content of the repository:

- Python: Contains the Python code used to generate monthly population estimates.
- R: Contains the R code used to prepare the data, train the models, assess the models' perfomance, produce the estimates of excess mortality, and produce the figures and tables for the paper.
- data/input: Contains all the data needed to train the models and produce estimates of excess deaths. As mentioned above, the CDC data is not included but instructions on how to download it are given. To reconcile inconsistencies across the various data sources we are using, and to accomodate further analysis with a longer backward time frame (i.e. we trained our final models on data for 2015-2019 but initially considered a wider window), we harmonized county FIPS code following the schema in the FIPSFixes.csv file.
- data/output: Contains all the data generated as a product of the project. This includes monthly population estimates, excess deaths and other related quantities, and a performance file comparing predicted yearly deaths from the monthly model to the actual counts used to decide whether the yearly or monthly model should be used.
- figures: contains all the figures appearing in the paper. Plots of expected versus actual deaths for each county are given in the countyPlots subfolder. An index file (plotIndex.txt) in the same folder can be used to trace each county to the corresponding file.
- tables: contains all the tables in the paper.
