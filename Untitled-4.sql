
SELECT 
    fg.mag_familygroupnumber,
    fg.mag_familygroupid,
    cs.mag_name AS service,
    r.statuscodename,
    r.mag_referralnumber AS referralnumber,
     su.businessunitidname,
    r.mag_referralid,
    r.mag_referraldate,
    r.mag_enrolmentdate,
    r.mag_accepteddate,
    r.mag_datereceived,
    r.mag_exitdate,
    r.mag_individualid,
    r.mag_outcomeid,
    p.mag_goal,
    r.mag_planid,
    r.ownerid,
    p.mag_signoffdate AS signoffdate,
    -- -- c.address1_line3,
    -- -- c.address1_city,
    su.businessunitid
FROM 
    mag_referral r
LEFT JOIN 
    mag_familygroup AS fg ON r.mag_familygroup = fg.mag_familygroupid
LEFT JOIN 
    mag_plan AS p ON r.mag_planid = p.mag_planid
-- LEFT JOIN 
--     contact AS c ON r.mag_individualid = c.contactid
LEFT JOIN 
    systemuser AS su ON r.owninguser = su.systemuserid
LEFT JOIN 
    smy_waipareira_kaiarihi AS cs ON r.mag_contractserviceid = cs.mag_contractserviceid
WHERE 
    (
        (r.mag_exitdate >= '2023-07-01' AND r.mag_exitdate <= '2023-09-30')
        OR r.mag_exitdate IS NULL
    )
    AND r.mag_referraldate <= '2023-09-30'
    AND r.statuscode != '809730007'
    -- AND r.mag_planid IS NOT NULL
    -- AND r.mag_referraldate IS NOT NULL
    AND r.mag_familygroup IS NOT NULL
    AND cs.mag_contractserviceid IS NOT NULL
  --  AND r.mag_referralid IS NOT NULL
GROUP BY
    fg.mag_familygroupnumber,
    cs.mag_name,
    r.statuscodename,
    r.mag_referralnumber,
    r.mag_referralid,
    r.mag_referraldate,
    r.mag_enrolmentdate,
    r.mag_accepteddate,
    r.mag_datereceived,
    r.mag_exitdate,
    r.mag_individualid,
    r.mag_outcomeid,
    p.mag_goal,
    r.mag_planid,
    r.ownerid,
    p.mag_signoffdate,
    -- c.address1_line3,
    -- c.address1_city,
    su.businessunitid,
    su.businessunitidname,
    fg.mag_familygroupid

GO

SELECT *
FROM smy_waipareira_active_whanau
ORDER BY mag_referraldate DESC


--------------------------------------------------

SELECT mag_planid
FROM mag_plan
WHERE mag_planid = '2ffb73fb-2aa2-e911-a97e-000d3ae12152'
```
