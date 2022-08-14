# Count Total Rows as Test
SELECT
	COUNT(*) as totalRows
FROM
	"dailyActivity3"
;
# 940 Total Rows or Days 

# Find the number of disctinct UserIds
SELECT
	COUNT(DISTINCT "Id")
FROM
	"dailyActivity";
 # 33 Unique Users, Does not match the 30 in the description
  
# Find when the recordings started and began
SELECT
	MIN("ActivityDate") AS startDate, MAX("ActivityDate") AS enddate
FROM
	"dailyActivity"
;
# start date 4/12/2016 end date 5/9/2016

# Check for duplicates
SELECT
	"Id", "ActivityDate", COUNT(*) AS numRow
FROM
	"dailyActivity"
GROUP BY
	"Id", "ActivityDate"
HAVING COUNT(*) > 1
;
# No duplicates found

SELECT 
	LENGTH("Id")
FROM
	"dailyActivity"
;
# Confriming proper length of 'Id' is 10

SELECT 
	LENGTH("Id")
FROM
	"dailyActivity"
WHERE
	LENGTH("Id") > 10
	OR
	LENGTH("Id") < 10
;
# All Ids are proper length

SELECT 
	"Id", COUNT(*) AS "numZeroDays"
FROM
	"dailyActivity"
WHERE
	CAST("TotalSteps" AS int) = 0
GROUP BY "Id"
;
# 15 participants had zero step days

SELECT
SUM(z.numZeroStepsDays) AS totalDaysZeroSteps
FROM(
	SELECT COUNT(*) AS numZeroStepsDays
	FROM "dailyActivity"
	WHERE CAST("TotalSteps" AS int) = 0
	) AS z
;
# 77 Days were recorded with zero steps

SELECT
	"SedentaryMinutes"
FROM
	"dailyActivity"
WHERE
	Cast("TotalSteps" AS int) = 0
;
# Sedentary hours per day are almost all 24. These fitbits are probably completely inactive
# Created a new table: dailyActivity3, in order to make ActivityDate a permanant date, 
# deleted column LoggedActivityDistance as all rows were zero, permantly made  TotalSteps an integer.

# Delete all rows that have zero steps to make the data as accurate as possible.
DELETE FROM 
	"dailyActivity3"
WHERE 
	"TotalSteps" = 0
;
# Confirmed 77 Rows Deleted, Exported table dailyActivityCleaned
