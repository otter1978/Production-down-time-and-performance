Production Efficiency & Downtime Analysis
Project Overview
This project analyzes production efficiency, operator performance, and production line downtime using manufacturing process data. The analysis was performed using PostgreSQL for data cleaning and SQL analysis, and Power BI for interactive dashboard creation and visualization.
The goal of the project was to identify operational inefficiencies, compare actual production times with expected benchmarks, and detect production bottlenecks across products, operators, and production lines.
________________________________________
Tools Used
•	PostgreSQL 
•	Microsoft Power BI 
•	Power Query 
•	DAX 
•	SQL 
________________________________________
Dataset Description
The project uses manufacturing production datasets containing:
•	production batches 
•	operators 
•	production start and end times 
•	downtime by production line 
•	product specifications and expected batch times 
Datasets included:
•	line_productivity 
•	line_downtime 
•	products 
•	metadata 
The downtime_factors dataset was reviewed during the data understanding phase but was excluded from the final analysis due to inconsistent structure and lack of reliable linkage with downtime records.
________________________________________
Data Cleaning & Preparation
Several data quality issues were identified and resolved during the project:
•	handled missing downtime values 
•	corrected inconsistent time formats 
•	fixed overnight production batches crossing midnight 
•	transformed downtime data from wide to long format using Power Query Unpivot 
•	converted text-based time columns into proper time format 
•	standardized downtime structure for line-level analysis 
A special handling logic was implemented for production batches spanning across midnight to ensure accurate duration calculations.
________________________________________
SQL Analysis
The SQL analysis focused on:
•	production batch duration calculations 
•	operator efficiency analysis 
•	product performance benchmarking 
•	expected vs actual production time comparison 
•	downtime aggregation 
•	operational KPI calculations 
Key SQL techniques used:
•	JOINs 
•	CASE WHEN 
•	Views 
•	Aggregations 
•	Data cleaning logic 
•	Time calculations 
•	NULL handling 
________________________________________
Power BI Dashboard
An interactive dashboard was created in Microsoft Power BI to visualize:
•	total production batches 
•	average production time 
•	total downtime 
•	operator performance 
•	product efficiency 
•	expected vs actual production duration 
•	downtime by production line 
The dashboard includes:
•	KPI cards 
•	bar charts 
•	slicers 
•	operational performance comparisons 
________________________________________
Key Insights
•	CO-2L showed the highest deviation from expected production time, exceeding benchmarks by over 55 minutes on average. 
•	CO-600 generated the highest operational workload and consistently exceeded expected production duration. 
•	Dee achieved the lowest average batch production time among operators. 
•	Charlie handled the highest number of production batches but also showed the highest variability in production duration. 
•	Denis processed the lowest number of batches wit lowest average batch production time
•	Significant downtime concentration was identified on selected production lines, indicating potential operational bottlenecks. 
•	Several data quality issues were identified during analysis, highlighting the importance of data validation in manufacturing reporting systems. 
________________________________________
Business Recommendations
•	Investigate production process inefficiencies for CO-2L and CO-600 products. 
•	Review operational conditions on production lines with the highest downtime. 
•	For deeper investigation of lines performance it is necessary to standardize reporting processes to improve data quality. 
•	Analyze workload distribution between operators and production lines to reduce production variability. 
•	Improve timestamp consistency by storing full production date and time values for overnight batches to ensure accurate production duration calculations. 
•	Review the level of competence and knowledge of operators

