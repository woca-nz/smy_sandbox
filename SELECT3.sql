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
    c.address1_line3,
    c.address1_city,
    su.businessunitid
FROM 
    mag_referral r
LEFT JOIN 
    mag_familygroup AS fg ON r.mag_familygroup = fg.mag_familygroupid
LEFT JOIN 
    mag_plan AS p ON r.mag_planid = p.mag_planid
LEFT JOIN 
    contact AS c ON r.mag_individualid = c.contactid
-- LEFT JOIN 
    -- systemuser AS su ON r.owninguser = su.systemuserid
LEFT JOIN 
   kaiarahi_contract_services AS cs ON r.mag_contractserviceid = cs.mag_contractserviceid
WHERE 
    (
        (r.mag_exitdate >= '2022-07-01' AND r.mag_exitdate <= '2023-06-30')
        OR r.mag_exitdate IS NULL
    )
    AND r.mag_referraldate <= '2023-06-30'
    AND r.statuscode != '809730007'
    -- AND r.mag_planid IS NOT NULL
    -- AND r.mag_referraldate IS NOT NULL
    AND r.mag_familygroup IS NOT NULL
    AND cs.mag_contractserviceid IS NOT NULL