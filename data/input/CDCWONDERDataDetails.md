## Details on Data Extraction from CDC WONDER

*All the data should be dowloaded in a folder named CDC and further divided into three folders: AllCausesMonthly (county-month data), AllCausesYearly (county-year data), COVIDUCDYearly (yearly COVID data). The names of the files within these three folders are not important. If you wish to change the folder structure, you will need to updated the code setting the working directories at the start of each RMarkdown file accordingly.*

The CDC WONDER online database query system found at https://wonder.cdc.gov/ was used to extract all mortality data used in this project. To obtain death counts for all-causes mortality, we used the Multiple Cause of Death (Final) database from 1999-2020. We obtained two sets of extracts, one for data at the county-year level and one for data at the county-month level.
For county-year extracts, the data request was submitted for the time period of interest using the request form with the following settings changed from the default:

- Tab 1. Organize table layout: Group results by County and by Year
- Tab 4. Select time period of death: specific period
- Tab 6. Select underlying cause of death: *All* (All Causes of Death)
- Tab 8. Other options: checking Export Results and Show totals. The request generates a text file.

For county and month for the years 1999 through 2019, the data was extracted using six month time periods due to limitations of the CDC Wonder servers. The data request was submitted for each time period of interest using the request form with the following settings changed from the default: 

- Tab 1. Organize table layout: Group results by County and by Month
- Tab 4. Select time period of death: specific period (6 months at a time)
- Tab 6. Select underlying cause of death: *All* (All Causes of Death)
- Tab 8. Other options: checking Export Results and Show totals. The request generates a text file.

To extract data for the time periods of March 2020 to December 2021, we used the Multiple Cause of Death (Provisional) database from 2018 – Last Month database. The data requests were submitted for each time period of interest using the request form with the following settings changed from the default: 

- Tab 1. Organize table layout: Group results by County and by Year
- Tab 4. Select time period of death: March 2020 to December 2021
- Tab 6. Select underlying cause of death: *All* (All Causes of Death)
- Tab 8. Other options: checking Export Results and Show totals. The request generates a text file.

To extract counts of COVID deaths for 2020 and 2021 at the county-year level we used the Multiple Cause of Death (Provisional) database from 2018 – Last Month database. The data requests were submitted for each time period of interest using the request form with the following settings changed from the default: 

- Tab 1. Organize table layout: Group results by County and by Year
- Tab 4. Select time period of death: March 2020 to December 2021
- Tab 6. Select underlying cause of death: U07.1 (COVID-19)
- Tab 8. Other options: checking Export Results and Show totals. The request generates a text file.
