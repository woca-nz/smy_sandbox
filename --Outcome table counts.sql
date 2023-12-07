--Outcome table counts 

SELECT
  COUNT(*) AS outcome_count_all,
  COUNT(DISTINCT mag_outcomeid) AS outcome_distinct_outcomeid,
  COUNT(*) - COUNT(DISTINCT mag_outcomeid) AS outcome_dupes,
  ROUND((COUNT(DISTINCT mag_outcomeid) * 100.0) / COUNT(*), 2) AS outcome_percentage
FROM
  [dbo].[mag_outcome]
WHERE
  mag_outcomeid IS NOT NULL;


-- Goals table counts
  SELECT
  COUNT(*) AS goals_count_all,
  COUNT(DISTINCT mag_goalid) AS goals_distinct_goalid,
  COUNT(*) - COUNT(DISTINCT mag_goalid) AS goals_dupes,
  ROUND((COUNT(DISTINCT mag_goalid) * 100.0) / COUNT(*), 2) AS goal_percentage
FROM
  [dbo].[mag_goal]
WHERE
  mag_goalid IS NOT NULL;


  -- referral table counts  
  SELECT
  COUNT(*) AS referral_count_all,
  COUNT(DISTINCT mag_referralid) AS referral_distinct_referralid,
  COUNT(*) - COUNT(DISTINCT mag_referralid) AS referral_dupes,
  ROUND((COUNT(DISTINCT mag_referralid) * 100.0) / COUNT(*), 2) AS referral_percentage
FROM
  [dbo].[mag_referral]
WHERE
  mag_referralid IS NOT NULL;


-- plan table counts
  SELECT
  COUNT(*) AS plan_count_all,
  COUNT(DISTINCT mag_planid) AS plan_distinct_planid,
  COUNT(*) - COUNT(DISTINCT mag_planid) AS plan_dupes,
  ROUND((COUNT(DISTINCT mag_planid) * 100.0) / COUNT(*), 2) AS plan_percentage
FROM
  [dbo].[mag_plan]
WHERE
  mag_planid IS NOT NULL;



