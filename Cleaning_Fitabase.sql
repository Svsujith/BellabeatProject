---Cleaning Daily_Activity_WeekDay
CREATE TABLE [bellabeat_project].[dbo].[Daily_Activity_Cleaned]
(Id FLOAT, ActivityDate DATE, TotalSteps FLOAT, TotalDistance FLOAT, LoggedActiveDistance FLOAT,VeryActiveDistance FLOAT, ModeratelyActiveDistance FLOAT, 
	LightlyActiveDistance FLOAT, SedentaryActiveDistance FLOAT, VeryActiveMinutes FLOAT, FairlyActiveMinutes FLOAT, LightlyActiveMinutes FLOAT, SedentaryActiveMinutes FLOAT,
	Calories FLOAT, [WeekDay] nvarchar(50))

INSERT INTO [bellabeat_project].[dbo].[Daily_Activity_Cleaned]
	(Id, ActivityDate, TotalSteps, TotalDistance, LoggedActiveDistance,VeryActiveDistance, ModeratelyActiveDistance, 
	LightlyActiveDistance, SedentaryActiveDistance, VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes, SedentaryActiveMinutes,
	Calories, [WeekDay])

SELECT 
	Id,
	CAST(ActivityDate AS DATE) AS ActivityDate,
	CAST(TotalSteps AS FLOAT) AS TotalSteps,
	CAST(TotalDistance AS FLOAT) AS TotalDistance,
	CAST(LoggedActiveDistance AS FLOAT) AS LoggedActiveDistance,
	CAST(VeryActiveDistance AS FLOAT) AS VeryActiveDistance,
	CAST(ModeratelyActiveDistance AS FLOAT) AS ModeratelyActiveDistance,
	CAST(LightlyActiveDistance AS FLOAT) AS LightActiveDistance,
	CAST(SedentaryActiveDistance AS FLOAT) AS SedentaryActiveDistance,
	CAST(VeryActiveMinutes AS FLOAT) AS VeryActiveMinutes,
	CAST(FairlyActiveMinutes AS FLOAT) AS FairlyActiveMinutes,
	CAST(LightlyActiveMinutes AS FLOAT) AS LightlyActiveMinutes,
	CAST(SedentaryActiveMinutes AS FLOAT) AS SedentaryActiveMinutes,
	CAST(Calories AS FLOAT) AS Calories,
	[WeekDay]

FROM [bellabeat_project].[dbo].[Daily_Activity]

---Cleaning sleepDay
CREATE TABLE [bellabeat_project].[dbo].[sleepDay_Cleaned]
(Id float, SleepDay DATE, TotalSleepRecords float, TotalMinutesAsleep float, TotalTimeInBed float)

INSERT INTO [bellabeat_project].[dbo].[sleepDay_Cleaned]
	(Id, SleepDay, TotalSleepRecords, TotalMinutesAsleep, TotalTimeInBed)
SELECT
CAST(Id AS float) AS Id,
CAST(SleepDay AS DATE) AS SleepDay,
CAST(TotalSleepRecords AS float) AS TotalSleepRecords,
CAST(TotalMinutesAsleep AS float) AS TotalMinutesAsleep,
CAST(TotalTimeInBed AS float) AS TotalTimeInBed
FROM [bellabeat_project].[dbo].[sleepDay]

---Remove Duplicate data from sleepDay
DELETE FROM [bellabeat_project].[dbo].[sleepDay_Cleaned]
WHERE Id NOT IN (
  SELECT MIN(Id)
  FROM [bellabeat_project].[dbo].[sleepDay_Cleaned]
  GROUP BY SleepDay, TotalSleepRecords, TotalMinutesAsleep, TotalTimeInBed
);


---Cleaning Hourly_Steps
CREATE TABLE [bellabeat_project].[dbo].[Hourly_Steps_Cleaned]
(Id float, [Date] DATE, [Time] TIME, StepTotal FLOAT)

INSERT INTO [bellabeat_project].[dbo].[Hourly_Steps_Cleaned]
	(Id, [Date], [Time], StepTotal)
SELECT
CAST(Id AS float) AS Id,
CAST(DATEPART(YEAR, ActivityHour) AS VARCHAR(4)) + '-' + CAST(DATEPART(MONTH, ActivityHour) AS VARCHAR(2)) + '-' + CAST(DATEPART(DAY, ActivityHour) AS VARCHAR(2)) AS [Date],
CAST(DATEPART(HOUR, ActivityHour) AS VARCHAR(2)) + ':' + CAST(DATEPART(MINUTE, ActivityHour) AS VARCHAR(2)) + ':' + CAST(DATEPART(SECOND, ActivityHour) AS VARCHAR(2)) AS [Time],
CAST(StepTotal AS FLOAT) AS StepTotal
FROM [bellabeat_project].[dbo].[Hourly_Steps]

