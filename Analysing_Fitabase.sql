---Checked for # of participants by counting number of distinct Ids in each dataset
SELECT 
  COUNT (DISTINCT Id) AS Total_Ids 
FROM 
  [bellabeat_project].[dbo].[Daily_Activity_Cleaned]
  
---How many times each of the users wore/used the FitBit tracker
SELECT 
  Id, 
  COUNT(Id) AS Total_Id 
FROM 
  [bellabeat_project].[dbo].[Daily_Activity_Cleaned] 
GROUP BY 
  Id 

---Breakdown the users by how much they wore their FitBit Fitness Tracker. I created three user types
SELECT 
  Id, 
  COUNT(Id) AS Total_Logged_Uses, 
  CASE 
  WHEN COUNT(Id) BETWEEN 25 and 31 THEN 'Active User' 
  WHEN COUNT(Id) BETWEEN 15 and 24 THEN 'Moderate User' 
  WHEN COUNT(Id) BETWEEN 0  and 14 THEN 'Light User' 
  END Fitbit_Usage_Type 
FROM 
  [bellabeat_project].[dbo].[Daily_Activity_Cleaned] 
GROUP BY 
  Id 

---MIN, MAX, & AVG of total steps, total distance, calories and activity levels by Id
SELECT 
  Id, 
  MIN(TotalSteps) AS Min_Total_Steps, 
  MAX(TotalSteps) AS Max_Total_Steps, 
  AVG(TotalSteps) AS Avg_Total_Stpes, 
  MIN(TotalDistance) AS Min_Total_Distance, 
  MAX(TotalDistance) AS Max_Total_Distance, 
  AVG(TotalDistance) AS Avg_Total_Distance, 
  MIN(Calories) AS Min_Total_Calories, 
  MAX(Calories) AS Max_Total_Calories, 
  AVG(Calories) AS Avg_Total_Calories, 
  MIN(VeryActiveMinutes) AS Min_Very_Active_Minutes, 
  MAX(VeryActiveMinutes) AS Max_Very_Active_Minutes, 
  AVG(VeryActiveMinutes) AS Avg_Very_Active_Minutes, 
  MIN(FairlyActiveMinutes) AS Min_Fairly_Active_Minutes, 
  MAX(FairlyActiveMinutes) AS Max_Fairly_Active_Minutes, 
  AVG(FairlyActiveMinutes) AS Avg_Fairly_Active_Minutes, 
  MIN(LightlyActiveMinutes) AS Min_Lightly_Active_Minutes, 
  MAX(LightlyActiveMinutes) AS Max_Lightly_Active_Minutes, 
  AVG(LightlyActiveMinutes) AS Avg_Lightly_Active_Minutes, 
  MIN(SedentaryActiveMinutes) AS Min_Sedentary_Minutes, 
  MAX(SedentaryActiveMinutes) AS Max_Sedentary_Minutes, 
  AVG(SedentaryActiveMinutes) AS Avg_Sedentary_Minutes 
From 
  [bellabeat_project].[dbo].[Daily_Activity_Cleaned]
Group BY 
  Id 
  
---Averages of the different types of minutes by Id
SELECT 
  Id, 
  avg(VeryActiveMinutes) AS Avg_Very_Active_Minutes, 
  avg(FairlyActiveMinutes) AS Avg_Fairly_Active_Minutes, 
  avg(LightlyActiveMinutes) AS Avg_Lightly_Active_Minutes, 
  avg(SedentaryActiveMinutes) AS Avg_Sedentary_Minutes 
FROM 
  [bellabeat_project].[dbo].[Daily_Activity_Cleaned] 
GROUP BY 
  Id 

---Average active minutes by week day before moving on to user types.
SELECT 
  DISTINCT [WeekDay], 
  ROUND (avg(VeryActiveMinutes), 2) AS Avg_Very_Active_Minutes, 
  ROUND (avg(FairlyActiveMinutes), 2) AS Avg_Fairly_Active_Minutes, 
  ROUND (avg(LightlyActiveMinutes), 2) AS Avg_Lightly_Active_Minutes, 
  ROUND (avg(SedentaryActiveMinutes), 2) AS Avg_Sedentary_Minutes 
FROM 
  [bellabeat_project].[dbo].[Daily_Activity_Cleaned] 
GROUP BY 
  [WeekDay]
  
---User Types by Total Steps 
SELECT 
  Id, 
  avg(TotalSteps) AS Avg_Total_Steps, 
  CASE 
  WHEN avg(TotalSteps) < 5000 THEN 'Inactive' 
  WHEN avg(TotalSteps) BETWEEN 5000 AND 7499 THEN 'Low Active User' 
  WHEN avg(TotalSteps) BETWEEN 7500 AND 9999 THEN 'Average Active User' 
  WHEN avg(TotalSteps) BETWEEN 10000 AND 12499 THEN 'Active User' 
  WHEN avg(TotalSteps) >= 12500 THEN 'Very Active User' 
  END User_Type 
FROM 
  [bellabeat_project].[dbo].[Daily_Activity_Cleaned] 
GROUP BY 
  Id 
  
---Calories, Steps & Active Minutes by ID
SELECT 
  Id, 
  Sum(TotalSteps) AS Sum_total_steps, 
  SUM(Calories) AS Sum_Calories, 
  SUM(VeryActiveMinutes + FairlyActiveMinutes) AS Sum_Active_Minutes 
FROM 
  [bellabeat_project].[dbo].[Daily_Activity_Cleaned] 
GROUP BY 
  Id 
  
---Total Steps, Total Distance, Total Calories by Day
SELECT 
  DISTINCT [WeekDay], 
  AVG(TotalSteps) AS AVG_TotalSteps, 
  AVG(TotalDistance) AS AVG_TotalDistance, 
  AVG(Calories) AS AVG_TotalCalories 
FROM 
  [bellabeat_project].[dbo].[Daily_Activity_Cleaned]
GROUP BY 
  [WeekDay] 
ORDER BY 
  AVG_TotalSteps DESC

---Total Steps by Hour
SELECT 
  Time, 
  SUM(StepTotal) AS Total_Steps_By_Hour 
FROM 
  [bellabeat_project].[dbo].[Hourly_Steps_Cleaned] 
GROUP BY 
  Time 
ORDER BY 
  Total_Steps_By_Hour DESC 
  
---which date had the most minutes of sleep from all the users
SELECT 
  SleepDay, 
  SUM(TotalMinutesAsleep) AS Total_Minutes_Asleep 
FROM 
  [bellabeat_project].[dbo].[sleepDay_Cleaned] 
WHERE 
  SleepDay IS NOT NULL 
GROUP BY 
  SleepDay 
  
---Average minutes slept, total steps and calories by user Id
SELECT 
  a.Id, 
  avg(a.TotalSteps) AS AvgTotalSteps, 
  avg(a.Calories) AS AvgCalories, 
  avg(s.TotalMinutesAsleep) AS AvgTotalMinutesAsleep 
FROM 
  [bellabeat_project].[dbo].[Daily_Activity_Cleaned] AS a 
  INNER JOIN [bellabeat_project].[dbo].[sleepDay_Cleaned] AS s 
ON a.Id = s.Id 
GROUP BY 
  a.Id
  
  
  
  
  
  
  
