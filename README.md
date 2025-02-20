# Mutual-found
https://web.azuresynapse.net/authoring/analyze/sqlscripts/mutualinternship?workspace=%2Fsubscriptions%2Fff80324e-ac84-42be-aad9-ba814df5df14%2FresourceGroups%2Fmutual-funds-rsc-g%2Fproviders%2FMicrosoft.Synapse%2Fworkspaces%2Fmutual

![LINK](https://web.azuresynapse.net/authoring/analyze/sqlscripts/mutualinternship?workspace=%2Fsubscriptions%2Fff80324e-ac84-42be-aad9-ba814df5df14%2FresourceGroups%2Fmutual-funds-rsc-g%2Fproviders%2FMicrosoft.Synapse%2Fworkspaces%2Fmutual)


This README summarizes the SQL queries provided for analyzing mutual fund data. These queries are designed to extract and prepare data for visualization in a business intelligence tool like Power BI.  The queries cover several key aspects of fund analysis, including performance over time, sector allocation, and comparisons against category benchmarks.

Purpose:

The SQL queries in this repository are intended to be used with a mutual fund dataset (e.g., a table named mutual).  They provide a foundation for building an interactive dashboard that can help investors and analysts understand fund performance, risk, and composition.

Queries:
-- Example 1: Year-to-Date Return vs. 52-Week High/Low Change Percentage:
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


--Example 2: Fund Return Over Time: This would visualize the performance history of a fund. You'd likely want to "unpivot" or "melt" the yearly return columns into rows. This is database-specific and can be complex. Here's a general approach using a UNION ALL (most databases support this):
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

#### Fund Return Over Time: This query transforms the yearly return data from columns into rows, making it suitable for time series analysis.  It uses a UNION ALL approach to combine data from different years.  This data can be used to visualize the historical performance of a fund over time.  Note: For larger datasets or more complex scenarios, consider using database-specific pivoting/unpivoting techniques for improved performance.


--Example 3: Sector Allocation: This would visualize the distribution of investments across different sectors.
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
![IMAGE]()

#### Time Series Data for Line Charts (Example): This query demonstrates how to structure data for a time series line chart.  It creates a common table expression (CTE) called HistoricalPerformance with sample date and return values. This is illustrative; you would replace this with actual data from your mutual table or a related historical performance table.

## --Example 4: Performance Comparison for Bar Charts:
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
![IMAGE]()


#### Time Series Data for Line Charts (Example): 
This query demonstrates how to structure data for a time series line chart.  It creates a common table expression (CTE) called HistoricalPerformance with sample date and return values. This is illustrative; you would replace this with actual data from your mutual table or a related historical performance table.
#### Sector Allocation for a Specific Fund:
This query retrieves the sector allocation for a specific fund (e.g., 'AAAAX').  It provides two versions: one that selects the sector percentages directly and another that normalizes the data into sector and percentage columns for easier charting.


## --Example 5: showing the rank position 10 years funds return
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
![IMAGE](https://github.com/jahansamia/Mutual-found/blob/b66bb38572b7d2fdd3649968b4ce52a59938aae5/Azure-SQL-analysis/5%20YEARS%20RETURN.png)

#### Performance Comparison for Bar Charts: 
This query retrieves the fund return and category return for a set of funds.  This data can be used to compare the performance of individual funds against their category benchmarks.

## --Example 5: Fund Ranking showing the rank position 5 years funds return
````
SELECT
    fund_symbol,
    fund_return_5years,
    category_return_5years
FROM
   mutual
WHERE fund_symbol IN ('AAAAX', 'AAAGX', 'ALAFX');
 ````   
![IMAGE]()


#### Fund Ranking:
This query calculates the rank of each fund based on its 5-year return using the RANK() window function. This data can be used to create visualizations showing the relative performance of different funds.
