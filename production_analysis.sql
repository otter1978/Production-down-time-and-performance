/*
====================================================
Production Efficiency & Downtime Analysis Project
====================================================

Author: Krzysztof Wydra
Tools: PostgreSQL, Power BI
Project Type: Manufacturing / Production Analytics

Description:
This project analyzes production efficiency, operator performance,
and downtime across manufacturing lines.

The analysis includes:
- data cleaning and transformation
- production duration calculations
- operator efficiency analysis
- expected vs actual batch time comparison
- downtime analysis


/*
====================================================
1. DATA CLEANING & VALIDATION
====================================================
*/




-- Detect overnight production batches

SELECT *
FROM line_productivity
WHERE end_time::time < start_time::time;



/*
====================================================
2. PRODUCTION TIME CALCULATION
====================================================
*/


-- Create cleaned production time view

CREATE OR REPLACE VIEW production_time_analysis AS

SELECT 
    batch,
    product,
    operator,
    start_time,
    end_time,

    ROUND(
        (
            CASE 
                WHEN end_time::time < start_time::time
                THEN 
                    EXTRACT(EPOCH FROM (
                        end_time::time - start_time::time
                    )) / 60 + 1440

                ELSE 
                    EXTRACT(EPOCH FROM (
                        end_time::time - start_time::time
                    )) / 60
            END
        )::numeric,
        2
    ) AS production_minutes

FROM line_productivity;



-- Preview cleaned production durations

SELECT *
FROM production_time_analysis;



/*
====================================================
3. OPERATOR PERFORMANCE ANALYSIS
====================================================
*/

-
SELECT 
    operator,

    COUNT(*) AS total_batches,

    ROUND(
        AVG(production_minutes),
        2
    ) AS avg_batch_time,

    ROUND(
        MIN(production_minutes),
        2
    ) AS fastest_batch,

    ROUND(
        MAX(production_minutes),
        2
    ) AS slowest_batch

FROM production_time_analysis

GROUP BY operator

ORDER BY avg_batch_time;



/*
====================================================
4. PRODUCT PERFORMANCE ANALYSIS
====================================================
*/


SELECT 
    pta.product,

    COUNT(*) AS batches,

    ROUND(
        AVG(pta.production_minutes),
        2
    ) AS avg_actual_time,

    ROUND(
        AVG(p.min_batch_time::numeric),
        2
    ) AS expected_time,

    ROUND(
        AVG(pta.production_minutes)
        - AVG(p.min_batch_time::numeric),
        2
    ) AS time_difference

FROM production_time_analysis pta

JOIN products p
ON pta.product = p.product

GROUP BY pta.product

ORDER BY time_difference DESC;



/*
====================================================
5. TOTAL DOWNTIME ANALYSIS
====================================================
*/


SELECT
    ROUND(SUM(line1), 2)  AS down_time1,
    ROUND(SUM(line2), 2)  AS down_time2,
    ROUND(SUM(line3), 2)  AS down_time3,
    ROUND(SUM(line4), 2)  AS down_time4,
    ROUND(SUM(line5), 2)  AS down_time5,
    ROUND(SUM(line6), 2)  AS down_time6,
    ROUND(SUM(line7), 2)  AS down_time7,
    ROUND(SUM(line8), 2)  AS down_time8,
    ROUND(SUM(line9), 2)  AS down_time9,
    ROUND(SUM(line10), 2) AS down_time10,
    ROUND(SUM(line11), 2) AS down_time11,
    ROUND(SUM(line12), 2) AS down_time12
FROM line_downtime;


/*
====================================================
6. KEY BUSINESS INSIGHTS
====================================================

1. CO-2L exceeded expected production time
   by more than 55 minutes on average.

2. CO-600 generated the highest operational workload
   while consistently exceeding expected batch duration.

3. Dee achieved the shortest average production time
   among all operators.

4. Charlie handled the largest number of batches
   but also showed the highest variability in production time.

5. Overnight production batches required special handling
   due to incomplete date-time reporting.

====================================================
*/
