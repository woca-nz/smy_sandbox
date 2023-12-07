WITH Referral AS (
    SELECT 
        fg.mag_familygroupnumber,
        fg.mag_familygroupid,
        cs.service_name AS service,
        r.mag_referralnumber AS referralnumber,
        r.mag_referralid,
        r.mag_referraldate,
        r.mag_enrolmentdate,
        r.mag_accepteddate,
        r.mag_datereceived,
        r.mag_exitdate,
        r.mag_individualid,
        p.mag_planid,
        p.mag_signoffdate AS signoffdate, -- helloworld
        r.x_extract_org_slug
    FROM 
        mag_referral r
    INNER JOIN 
        mag_familygroup AS fg ON r.mag_familygroup = fg.mag_familygroupid
    LEFT JOIN 
        mag_plan AS p ON r.mag_planid = p.mag_planid
    LEFT JOIN 
        contact AS c ON r.mag_individualid = c.contactid
    INNER JOIN 
        kaiarahi_contract_services AS cs ON r.mag_contractserviceid = cs.service_id
    WHERE 
        (
            (r.mag_exitdate >= '2022-07-01' AND r.mag_exitdate <= '2023-06-30')
            OR r.mag_exitdate IS NULL
        )
        AND r.mag_referraldate <= '2023-06-30'
        AND r.statuscode != '809730007'
        AND r.mag_familygroup IS NOT NULL
        AND cs.service_id IS NOT NULL
)



SELECT 
    COUNT(DISTINCT mag_familygroupnumber) AS 'Total Referrals',
    -- r.service,
    r.x_extract_org_slug
FROM 
    Referral r
GROUP BY
    r.x_extract_org_slug