-- Example 1: Year-to-Date Return vs. 52-Week High/Low Change Percentage: This could show the relationship between recent performance and the range of price fluctuation

SELECT
    fund_symbol,
    year_to_date_return,
    week52_high_low_change_perc
FROM
    mutual;


--Example 2: Fund Return Over Time: This would visualize the performance history of a fund. You'd likely want to "unpivot" or "melt" the yearly return columns into rows. This is database-specific and can be complex. Here's a general approach using a UNION ALL (most databases support this):
    SELECT fund_symbol, '2020' AS year, fund_return_2020 FROM mutual
UNION ALL
SELECT fund_symbol, '2019' AS year, fund_return_2019 FROM mutual
UNION ALL
SELECT fund_symbol, '2018' AS year, fund_return_2018 FROM mutual
-- ... repeat for all years ...
UNION ALL
SELECT fund_symbol, '2000' AS year, fund_return_2000 FROM mutual

--Example 3: Sector Allocation: This would visualize the distribution of investments across different sectors.

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


 -- Time Series Data for Line Charts:

--Let's assume you have a table (or can create a CTE from your data) with historical fund performance data, including a date column and a return value.

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
;

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
WHERE percentage > 0; -- Filter out zero percentages for cleaner charts


--. Performance Comparison for Bar Charts:

SELECT
    fund_symbol,
    fund_return_5years,
    category_return_5years
FROM
   mutual
WHERE fund_symbol IN ('AAAAX', 'AAAGX', 'ALAFX'); -- Example funds


--showing the rank position 10 years funds return

SELECT
    fund_symbol,
    fund_return_5years,
    RANK() OVER (ORDER BY fund_return_10years DESC) AS fund_rank
FROM
    mutual
ORDER BY
    fund_rank;
