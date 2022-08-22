## Full Analysis of the table dailyActivityCleaned

# Assigning Days of the week to days, as well as weekdays and weekends
SELECT
	"ActivityDate", to_char("ActivityDate", 'Day') AS "Day"
FROM
	"dailyActivityCleaned"
;
# Confirmed that entry one, 4/12/2016, is in fact a Tuesday

# Same as above, but pulling all columns including 'dayOfWeek'
SELECT
	*,
	"ActivityDate", to_char("ActivityDate", 'Day') AS "dayofweek"
FROM
	"dailyActivityCleaned"
;
# Confirmed, Exported as 'dailyActivityCleaned2'

# Assigning 'Weekday' and 'Weekend' Values does not work to each day of week
# Using SELECT and WHERE statements don't recognize any day of the week except wednesday
# Using the query below shows that the prior query and export added trailing spaces behind many weekday names
# TRIM function fixes issue
SELECT
	"dayOfWeek"
FROM
	"dailyActivityCleaned2"
WHERE
	TRIM("dayOfWeek") = 'Tuesday'
;
# Returns 'Tuesday'

# Attempt 2 at assigning 'Weekday' and 'Weekend' values to a new column
SELECT 
	*,
	CASE
		WHEN TRIM("dayOfWeek") = 'Monday' THEN 'Weekday'
		WHEN TRIM("dayOfWeek") = 'Tuesday' THEN 'Weekday'
		WHEN TRIM("dayOfWeek") = 'Wednesday' THEN 'Weekday'
		WHEN TRIM("dayOfWeek") = 'Thursday' THEN 'Weekday'
		WHEN TRIM("dayOfWeek") = 'Friday' THEN 'Weekday'
		ELSE 'Weekend'
	END AS "partOfWeek"
FROM
	"dailyActivityCleaned2"
;
# Success, Exported as 'dailyActivityCleaned3'


# Avg Steps, Distance, and Calories for Weekdays and Weekends
SELECT
	"partOfWeek", 
	AVG("TotalSteps") AS "avgSteps",
	AVG("TotalDistance") AS "avgDistance",
	AVG("Calories") AS "avgCalories"
FROM
	"dailyActivityCleaned3"
GROUP BY "partOfWeek"
; 
# Weekend Avg Steps: 8293.47, Weekday Avg Steps: 8327.72
# Weekend Avg Distance: 5.98(), Weekday Avg Steps: 5.98()
# Weekend Avg Calories: 2371, Weekday Avg Calories: 2358

# Compare avg steps and avg calories by day of the week
SELECT
	"dayOfWeek", 
	AVG("TotalSteps") AS avgSteps,
	AVG("Calories") AS avgCalories
FROM
	"dailyActivityCleaned3"
GROUP BY "dayOfWeek"
ORDER BY avgSteps DESC
;
# Tuesday and Saturday are the most active, while Friday and Sunday are most sedentary

# Count number of recorded days where there were equal or more steps than CDC recommended 10,000 Steps
SELECT
	COUNT(*)
FROM
	"dailyActivityCleaned3"
WHERE
	"TotalSteps" >= 10000
;
SELECT
	COUNT(*)
FROM
	"dailyActivityCleaned3"
;
# 303 Days / 863 "Cleaned" Days Recorded

# Calories Vs Total Steps
SELECT
	"Calories", "TotalSteps"
FROM
	"dailyActivityCleaned3"
ORDER BY
	"TotalSteps"
;

# Calories Vs Active Distances Combined
SELECT
	"Calories", 
	"TotalDistance"
FROM
	"dailyActivityCleaned3"
ORDER BY
	"TotalSteps"
;



