SELECT 
    COUNT(*),
    r.mag_referralid,
    r.mag_referraldate,
    r.mag_enrolmentdate,
    r.mag_accepteddate,
    r.mag_datereceived,
    r.mag_exitdate,
    r.mag_individualid,
    r.ownerid,
    a_4ebee32b6047e7118120e0071b795ca1.mag_familygroupnumber AS familygroupnumber,
    p.mag_signoffdate AS signoffdate,
    --c.address1_line3,
    --c.address1_city,
    su.businessunitid,
    su.businessunitidname
FROM 
    mag_referral r
LEFT JOIN 
    mag_familygroup AS a_4ebee32b6047e7118120e0071b795ca1 ON r.mag_familygroup = a_4ebee32b6047e7118120e0071b795ca1.mag_familygroupid
LEFT JOIN 
    mag_plan AS p ON r.mag_planid = p.mag_planid
--LEFT JOIN 
   -- contact AS c ON r.mag_individualid = c.contactid
LEFT JOIN 
    systemuser AS su ON r.owninguser = su.systemuserid
WHERE 
    mag_contractserviceid = '43FF1E15-7F47-E711-8174-E0071B7FD0F1'
    AND (
        mag_exitdate >= '2022-07-01' 
        OR mag_exitdate IS NULL
    )
    AND r.statuscode != '809730007'
    AND r.mag_planid IS NOT NULL
    AND r.mag_enrolmentdate <= '2023-06-30'
    AND r.mag_enrolmentdate IS NOT NULL
    AND   r.mag_referralid IS NOT NULL
    GROUP BY
    familygroupnumber.mag_familygroupnumber
    ORDER BY 
    r.mag_referraldate ASC; 



-----------------------------------------------------------------------------
# %% folders 

SELECT 
    COUNT(distinct r.mag_familygroup) as Total_Whanau, 
    cs.mag_name as service
    -- r.mag_referralid,
    -- r.mag_referraldate,
    -- r.mag_enrolmentdate,
    -- r.mag_accepteddate,
    -- r.mag_datereceived,
    -- r.mag_exitdate,
    -- r.mag_individualid,
    -- r.ownerid,
    -- fg.mag_familygroupnumber AS familygroupnumber,
    -- p.mag_signoffdate AS signoffdate,
    -- c.address1_line3,
    -- c.address1_city,
    -- su.businessunitid,
    -- su.businessunitidname,
    -- cs.mag_name
FROM 
    mag_referral r
 LEFT JOIN 
    mag_familygroup AS fg ON r.mag_familygroup = fg.mag_familygroupid
 LEFT JOIN 
     mag_plan AS p ON r.mag_planid = p.mag_planid
--LEFT JOIN 
   -- contact AS c ON r.mag_individualid = c.contactid
-- LEFT JOIN 
--     systemuser AS su ON r.owninguser = su.systemuserid
LEFT JOIN 
    mag_contractservice cs on r.mag_contractserviceid = cs.mag_contractserviceid
WHERE 
    --r.mag_contractserviceid = '43FF1E15-7F47-E711-8174-E0071B7FD0F1'
     (
        (r.mag_exitdate >= '2022-07-01' --AND r.mag_exitdate <= '2023-06-30'
        )
        OR r.mag_exitdate IS NULL
    )
    AND r.mag_enrolmentdate <= '2023-06-30'
    --AND r.statuscode != '809730007'
    AND cs.mag_name IN ( 
        'Kaiarahi/Navigator Services',
        'Kaiarahi-Child')
    --AND r.mag_planid IS NOT NULL
   AND r.mag_enrolmentdate IS NOT NULL
    -- AND r.mag_familygroup IS NOT NULL
    -- AND r.mag_referralid IS NOT NULL
GROUP BY
    --r.mag_referralid,
    -- r.mag_referraldate,
    -- r.mag_enrolmentdate,
    -- r.mag_accepteddate,
    -- r.mag_datereceived,
    -- r.mag_exitdate,
    -- r.mag_individualid,
    -- r.ownerid,
    -- a_4ebee32b6047e7118120e0071b795ca1.mag_familygroupnumber,
    -- p.mag_signoffdate,
    -- su.businessunitid,
    -- su.businessunitidname,
     cs.mag_name
-- ORDER BY 
--     r.mag_referraldate ASC;


    --------------------------------------------------------------------------------------------------

    KPI A: Referrals Overlapping with FY (including Family Group Number through join)

-- table
SELECT 
  --count(*) as total,
  COUNT(distinct r.mag_familygroup) as Total_Whanau, 
  cs.mag_name as service
FROM [dbo].[mag_referral] r
LEFT JOIN [dbo].[mag_contractservice] cs on r.mag_contractserviceid = cs.mag_contractserviceid
WHERE r.mag_enrolmentdate <= '2023-06-30'
AND (r.mag_exitdate >= '2022-07-01' OR r.mag_exitdate is null)
AND r.[mag_familygroup] is not null
AND cs.mag_name IN ( 'Kaiarahi Service', 'Kaiarahi Rangatahi (Ruapotaka)',
        'Kaiarahi Service',
        'Kaiarahi/Navigator Services',
        'Kaiarahi/Navigator Services (Hoani)',
        'Kaiarahi/Navigator Services (Ruapotaka)',
        'Kaiarahi-Child')
AND r.mag_enrolmentdate is not null
GROUP BY cs.mag_name;

--------------------------------------------------------------------------

-- Kaiarahi Services View
CREATE VIEW [dbo].[smy_waipareira_kaiarihi]
AS
SELECT DISTINCT mag_contractserviceid, mag_name
FROM [dbo].[mag_contractservice]
WHERE mag_contractserviceid IN (
    '86A96B8E-E7E8-E611-8103-1458D05A2AB0',
    '43FF1E15-7F47-E711-8174-E0071B7FD0F1',
    '64FF1E15-7F47-E711-8174-E0071B7FD0F1'
);



SELECT 
    statecode,
    statecodename, 
    statuscode,
    statuscodename
    --mag_name
FROM mag_referral
GROUP BY 
    statecode,
    statecodename, 
    statuscode,
    statuscodename
    --mag_name

    SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- View: VW_KPI_I
ALTER   VIEW VW_COMPLETED_OUTCOMES
AS
(
    SELECT 
        ar.whanau_number,
        ar.whanau_id,
        ar.referral_id,
        ar.referral_number,
        ar.provider_name,
        ar.service_id,
        ar.enrolment_date        AS referral_enrolment_date,
        ar.exit_date             AS referral_exit_date,
        o.mag_outcomeid,
        o.statuscode,
        MAX(g.mag_completeddate) AS max_goal_completeddate,
        o.mag_referralenddate,
        o.mag_reviewdate,
        o.mag_checkindate,
        o.modifiedon,
        o.orgfilepath

    FROM VW_ACTIVE_REFERRALS AS ar
    INNER JOIN mag_outcome AS o ON o.mag_referralid = ar.referral_id --AND o.orgfilepath = ar.orgfilepath
    LEFT JOIN VW_GOAL_ACHIEVED AS g
    ON g.mag_outcome = o.mag_outcomeid --AND g.orgfilepath = o.orgfilepath
    WHERE o.mag_outcomeid IS NOT NULL
    AND o.statuscode = '2'
    GROUP BY ar.whanau_number,
        ar.whanau_id,
        ar.referral_id,
        ar.referral_number,
        ar.provider_name,
        ar.service_id,
        ar.enrolment_date,
        ar.exit_date,
        o.mag_outcomeid,
        o.statuscode,
        o.mag_referralenddate,
        o.mag_reviewdate,
        o.mag_checkindate,
        o.modifiedon,
        -- o.orgfilepath
)

GO

SELECT 
    aw.mag_familygroupnumber,
    aw.mag_familygroupid,
    aw.service,
    aw.statuscodename,
    aw.referralnumber,
    aw.businessunitidname,
    aw.mag_referralid,
    aw.mag_referraldate,
    aw.mag_enrolmentdate,
    aw.mag_accepteddate,
    aw.mag_datereceived,
    aw.mag_exitdate,
    aw.mag_individualid,
    aw.mag_outcomeid,
    aw.mag_goal,
    aw.mag_planid,
    aw.ownerid,
    aw.signoffdate,
    -- aw.address1_line3,
    -- aw.address1_city,
    aw.businessunitid,
    o.statuscode AS outcome_status_code,
    o.statuscodename AS outcome_status,
    o.mag_referralenddate AS outcome_referral_end_date,
    o.mag_outcomeid AS outcome_id,
    o.mag_serviceidname AS outcome_service_name,
    o.mag_familygroupid AS outcome_family_group_id,
    o.mag_name AS outcome_name,
    o.mag_familygroupprioritydetail AS outcome_priority,
    o.mag_outcomenumber AS outcome_number,
    o.mag_termcodename AS outcome_term,
    o.mag_analysis1name AS outcome_analysis_1,
    o.mag_analysis6name AS outcome_analysis_6,
    o.mag_domain1 AS outcome_domain_id,
    o.mag_domain1name AS outcome_domain_name,
    o.mag_outcomearea1 AS outcome_area_id,
    o.mag_outcomearea1name AS outcome_area_name,
    o.owningbusinessunitname AS outcome_owner,
    o.mag_predefinedoutcome AS outcome_predefined_outcome_id,
    o.mag_predefinedoutcomename AS outcome_predefined_outcome_name,
    o.mag_familygroupprioritydetail AS outcome_priority,
    o.mag_otheroutcomearea AS outcome_other_outcome_area,
    o.wtl_outcomeindicatorresult AS outcome_indicator_result,
    o.wtl_outcomeindicatortext AS outcome_indicator_text,
    o.mag_referralid AS outcome_referral_id,
    o.mag_referralidname AS outcome_referral_name
FROM mag_outcome o
INNER JOIN smy_waipareira_active_whanau aw ON o.mag_familygroupid = aw.mag_familygroupid
-- INNER JOIN smy_waipareira_kaiarihi AS wk ON  wk.mag_contractserviceid = o.mag_serviceid
WHERE o.mag_outcomeid IS NOT NULL
-- AND o.statecode = '0'
AND o.statuscode = '2'
AND (
    (o.mag_referralenddate >= '2022-07-01' and o.mag_referralenddate <= '2023-06-30')
    OR o.mag_referralenddate IS NULL
)