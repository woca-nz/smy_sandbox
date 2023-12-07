SELECT 
    -- aw.mag_familygroupnumber,
    -- aw.mag_familygroupid,
    -- aw.service,
    -- aw.statuscodename,
    -- aw.referralnumber,
    -- aw.businessunitidname,
    -- aw.mag_referralid,
    -- aw.mag_referraldate,
    -- aw.mag_enrolmentdate,
    -- aw.mag_accepteddate,
    -- aw.mag_datereceived,
    -- aw.mag_exitdate,
    -- aw.mag_individualid,
    -- aw.mag_outcomeid,
    -- aw.mag_goal,
    -- aw.mag_planid,
    -- aw.ownerid,
    -- aw.signoffdate,
    -- -- aw.address1_line3,
    -- -- aw.address1_city,
    -- aw.businessunitid,
    -- o.statuscode AS outcome_status_code,
    -- o.statuscodename AS outcome_status,
    -- o.mag_referralenddate AS outcome_referral_end_date,
    -- o.mag_outcomeid AS outcome_id,
    -- o.mag_serviceidname AS outcome_service_name,
    -- o.mag_familygroupid AS outcome_family_group_id,
    -- o.mag_name AS outcome_name,
    -- o.mag_familygroupprioritydetail AS outcome_priority,
    -- o.mag_outcomenumber AS outcome_number,
    -- o.mag_termcodename AS outcome_term,
    -- o.mag_analysis1name AS outcome_analysis_1,
    -- o.mag_analysis6name AS outcome_analysis_6,
    -- o.mag_domain1 AS outcome_domain_id,
    -- o.mag_domain1name AS outcome_domain_name,
    -- o.mag_outcomearea1 AS outcome_area_id,
    -- o.mag_outcomearea1name AS outcome_area_name,
    -- o.owningbusinessunitname AS outcome_owner,
    -- o.mag_predefinedoutcome AS outcome_predefined_outcome_id,
    -- o.mag_predefinedoutcomename AS outcome_predefined_outcome_name,
    -- o.mag_provideroutcomedomainname AS outcome_provider_outcome_domain_id,
    -- o.mag_provideroutcomedomainname AS outcome_provider_outcome_domain_name,
    o.mag_planid AS outcome_plan_id
FROM mag_outcome o
-- INNER JOIN smy_waipareira_active_whanau aw ON o.mag_familygroupid = aw.mag_familygroupid
-- INNER JOIN smy_waipareira_kaiarihi AS wk ON  wk.mag_contractserviceid = o.mag_serviceid
WHERE o.mag_outcomeid IS NOT NULL
-- AND o.statecode = '0'
-- AND o.statuscode = '2'
-- AND (
--     (o.mag_referralenddate >= '2022-07-01' and o.mag_referralenddate <= '2023-06-30')
--     OR o.mag_referralenddate IS NULL
-- )
AND o.mag_planid = '2ffb73fb-2aa2-e911-a97e-000d3ae12152'

SELECT mag_planid
FROM mag_plan
WHERE mag_planid = '2ffb73fb-2aa2-e911-a97e-000d3ae12152'