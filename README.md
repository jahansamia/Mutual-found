#                                                       Exploring-Mutual-Fund-Performance-and-Trends-with-Azure




![image](https://github.com/jahansamia/Mutual-found/blob/0cbb377d45b9337380282bf41814f0385b6749a7/Azure-SQL-analysis/Azure-Synapse-Analytics-1-1-1536x864.png.webp)



## Mutual-Fund-Data-Analysis: An Introduction :
Mutual funds are a popular investment vehicle, pooling money from multiple investors to invest in a diversified portfolio of securities like stocks, bonds, or other assets.  Analyzing mutual fund data is crucial for investors, financial advisors, and researchers to make informed decisions.  This analysis can range from evaluating past performance to predicting future trends, assessing risk, and understanding the composition of a fund's holdings.

## Objective:
The Mutualn Funds data is to provide a snapshot of key metrics for various mutual funds. This allows for comparison and analysis of different funds based on factors like performance (year-to-date, 5-year, 10-year returns), risk (standard deviation, beta), expenses (expense projections), holdings (sector allocation, top holdings), and other relevant data points (yield, Morningstar rating, ESG scores).  Ultimately, the goal is to empower investors and analysts to evaluate funds and make informed investment decisions.This data processing and analysis involves ingesting, storing, exploring, analyzing, visualizing, and reporting on mutual fund data to facilitate informed investment decisions.  Azure SQL and Power BI are the key tools in this process.

## Data-Processing-and-analysis-with-Visualization:
downloaded the provided mutual fund data, cleaned it using Excel, and stored it in both a GitHub repository and an Azure Blob storage container.  Within Azure, I created a resource group containing a storage account, Data Factory, Databricks workspace, and Synapse Analytics workspace.  I then used these services to perform the following data pipeline:
#### Data Ingestion:
The data from Azure Blob storage was ingested into the Synapse SQL pool.
#### Data Transformation:
While the data cleaned in Excel but further transformations in Databricks i used Spark before loading into Synapse.
#### Data Analysis (Synapse SQL):
Synapse SQL was used to query and analyze the mutual fund data. This included calculating performance metrics (returns, risk), comparing funds, analyzing sector allocation, and exploring ESG scores.
#### Data Visualization (Power BI):
Power BI has been used to visualize the results of the Synapse SQL analysis. This would involve creating interactive dashboards and reports to present the key insights.

## Data-Source :   
[Data Source](https://www.kaggle.com/datasets/subhransuss/mutual-funds)
## Built-in Tools:
- [Azure](https://azure.microsoft.com/en-us/)
- [Power BI](https://powerbi.microsoft.com/en-us/)


## Power-BI Dashboard:
![image](https://github.com/jahansamia/Mutual-found/blob/4062a2878e24060e07f7a6cc18252e6aa10221af/Power-BI-Dashboard/Screenshot%20(1).png)

### Analysis:
This Power BI dashboard provides a comprehensive analysis of mutual fund data, offering key insights into performance, risk, and composition. The analysis leverages a dataset containing various metrics for a selection of mutual funds, including returns (year-to-date, 5-year, 10-year, and annual), risk measures (standard deviation, beta), expenses, sector allocation, ESG scores, and other relevant fund characteristics.
### Key Data Insights & Visualizations:
#### Fund Performance Analysis:
Performance is evaluated across multiple timeframes. Line and column charts showcase historical trends, allowing for quick identification of top performers and periods of growth or decline. 
#### Specific visualizations include:
* Sum of fund_return_5years by fund_return_2000 and fund_return_2001: A clustered column chart comparing the 5-year returns alongside returns from specific years (2000 and 2001). This helps visualize how funds performed during different market conditions.
* Sum of fund_return_10years by fund_sector_healthcare: A pie chart breaking down 10-year returns by the healthcare sector allocation. This visualization helps understand the contribution of specific sectors to long-term returns.
* Fund Return 2000 to Fund Return 2010: A line chart visualizing the yearly returns (2000-2010) for selected funds. This facilitates the analysis of performance consistency and trends over a decade

### Summary of Findings
This project uses Azure cloud services and Power BI to analyze mutual fund data, providing investors with a comprehensive and interactive dashboard. Raw data, likely cleaned in Excel, is stored in Azure Blob Storage and ingested into Azure Synapse Analytics via Azure Data Factory. Optional data transformations can be handled by Azure Databricks. Synapse SQL queries enable in-depth analysis of fund performance (returns, trends), risk (volatility), expenses, and holdings. Power BI visualizations, including line charts, column charts, and pie charts, present these insights clearly. The dashboard allows users to compare funds, filter by criteria, and ultimately make informed investment decisions. The combination of Azure's data processing power and Power BI's visualization capabilities creates a robust and scalable solution for mutual fund analysis.

# Azure SQL Quries:

This summarizes the SQL queries provided for analyzing mutual fund data, SQL queries in this repository are intended to be used with a mutual fund dataset.  They provide a foundation for building an interactive dashboard that can help investors and analysts understand fund performance, risk, and composition.

### Queries:
#### Example 1:
Year-to-Date Return vs. 52-Week High/Low Change Percentage:
````
SELECT
    fund_symbol,
    year_to_date_return,
    week52_high_low_change_perc
FROM
    mutual;
````

![IMAGE](https://github.com/jahansamia/Mutual-found/blob/80ea282f29bc13c883e43443d924390f421db333/Azure-SQL-analysis/52WEEKS.png)

Year-to-Date Return vs. 52-Week High/Low Change Percentage: This query retrieves the year-to-date return and the 52-week high/low change percentage for each fund.  This data can be used to explore the relationship between recent performance and price volatility.


#### Example 2:
Fund Return Over Time: This would visualize the performance history of a fund. You'd likely want to "unpivot" or "melt" the yearly return columns into rows. This is database-specific and can be complex. Here's a general approach using a UNION ALL (most databases support this):
````
SELECT fund_symbol, '2020' AS year, fund_return_2020 FROM mutual
UNION ALL
SELECT fund_symbol, '2019' AS year, fund_return_2019 FROM mutual
UNION ALL
SELECT fund_symbol, '2018' AS year, fund_return_2018 FROM mutual
-- ... repeat for all years ...
UNION ALL
SELECT fund_symbol, '2000' AS year, fund_return_2000 FROM mutual
````

![IMAGE]()

#### Fund Return Over Time:
This query transforms the yearly return data from columns into rows, making it suitable for time series analysis.  It uses a UNION ALL approach to combine data from different years.  This data can be used to visualize the historical performance of a fund over time.  Note: For larger datasets or more complex scenarios, consider using database-specific pivoting/unpivoting techniques for improved performance.


#### Example 3:
Sector Allocation: This would visualize the distribution of investments across different sectors.
````
SELECT
    fund_symbol,
    fund_sector_financial_services,
    fund_sector_healthcare,
    fund_sector_industrials,
    fund_sector_real_estate,
    fund_sector_technology,
    fund_sector_utilities
FROM
    mutual;
````

 -- Time Series Data for Line Charts:
````
WITH HistoricalPerformance AS (
    SELECT
        '2023-01-01' AS date, 0.05 AS return_value UNION ALL
    SELECT '2023-02-01', 0.07 UNION ALL
    SELECT '2023-03-01', -0.02 UNION ALL
    -- ... more historical data
    SELECT '2024-01-01', 0.10
)
SELECT
    date,
    return_value
FROM
    HistoricalPerformance
ORDER BY
    date;
````
![IMAGE](https://github.com/jahansamia/Mutual-found/blob/db8d114381d82d7c137d7495372e24dde1efac49/Azure-SQL-analysis/RETURN%20VALUE.png)

#### Time Series Data for Line Charts (Example):
This query demonstrates how to structure data for a time series line chart.  It creates a common table expression (CTE) called HistoricalPerformance with sample date and return values. This is illustrative; you would replace this with actual data from your mutual table or a related historical performance table.

#### Example 4: Performance Comparison for Bar Charts:
````
SELECT
    fund_sector_financial_services,
    fund_sector_healthcare,
    fund_sector_industrials,
    fund_sector_real_estate,
    fund_sector_technology,
    fund_sector_utilities
FROM
    mutual
WHERE fund_symbol = 'AAAAX'

--Or if the sector data is stored in a more normalized way.

SELECT sector, percentage
FROM (
    SELECT 'Financial Services' AS sector, fund_sector_financial_services AS percentage FROM mutual WHERE fund_symbol = 'AAAAX' UNION ALL
    SELECT 'Healthcare', fund_sector_healthcare FROM mutual WHERE fund_symbol = 'AAAAX' UNION ALL
    SELECT 'Industrials', fund_sector_industrials FROM mutual WHERE fund_symbol = 'AAAAX' UNION ALL
    SELECT 'Real Estate', fund_sector_real_estate FROM mutual WHERE fund_symbol = 'AAAAX' UNION ALL
    SELECT 'Technology', fund_sector_technology FROM mutual WHERE fund_symbol = 'AAAAX' UNION ALL
    SELECT 'Utilities', fund_sector_utilities FROM mutual WHERE fund_symbol = 'AAAAX'
) AS sector_allocations
WHERE percentage > 0;
````
![IMAGE](https://github.com/jahansamia/Mutual-found/blob/db8d114381d82d7c137d7495372e24dde1efac49/Azure-SQL-analysis/HEATHCARE.png)


#### Time Series Data for Line Charts (Example): 
This query demonstrates how to structure data for a time series line chart.  It creates a common table expression (CTE) called HistoricalPerformance with sample date and return values. This is illustrative; you would replace this with actual data from your mutual table or a related historical performance table.
#### Sector Allocation for a Specific Fund:
This query retrieves the sector allocation for a specific fund (e.g., 'AAAAX').  It provides two versions: one that selects the sector percentages directly and another that normalizes the data into sector and percentage columns for easier charting.


#### Example 5: showing the rank position 10 years funds return
````
SELECT
    fund_symbol,
    fund_return_5years,
    RANK() OVER (ORDER BY fund_return_5years DESC) AS fund_rank
FROM
    mutual
ORDER BY
    fund_rank;
````
![IMAGE](https://github.com/jahansamia/Mutual-found/blob/09adc22d17c4c3b215886ff7b0daa1608c8911f0/Azure-SQL-analysis/FUND%20RANK.png)

#### Performance Comparison for Bar Charts: 
This query retrieves the fund return and category return for a set of funds.  This data can be used to compare the performance of individual funds against their category benchmarks.

#### Example 5: 
Fund Ranking showing the rank position 5 years funds return
````
SELECT
    fund_symbol,
    fund_return_5years,
    category_return_5years
FROM
   mutual
WHERE fund_symbol IN ('AAAAX', 'AAAGX', 'ALAFX');
 ````   
![IMAGE](https://github.com/jahansamia/Mutual-found/blob/b66bb38572b7d2fdd3649968b4ce52a59938aae5/Azure-SQL-analysis/5%20YEARS%20RETURN.png)


#### Fund Ranking:
This query calculates the rank of each fund based on its 5-year return using the RANK() window function. This data can be used to create visualizations showing the relative performance of different funds.
