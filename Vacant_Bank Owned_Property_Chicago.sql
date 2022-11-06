USE Chicago_Bank_Owned_RE_Vacant;

SELECT *
FROM cbo_vacant_paid_due;

-- Changed datatype from string to date  
UPDATE cbo_vacant_paid_due
SET issued_date = str_to_date('issued_date','%y-%m-%d');

UPDATE cbo_vacant_paid_due
SET last_hearing_date = str_to_date('last_hearing_date','%y-%m-%d');

SELECT *
FROM cbo_vacant_violations;

-- Shows that most entities/banks have fewer distinct property_address(es) than total property_address count 
-- This suggest that the adresseses in the table are counted multiple times for the same bank
-- This is due to multiple violations per address
SELECT entity, COUNT(property_address), COUNT(DISTINCT property_address)
FROM cbo_vacant_paid_due
GROUP BY entity
ORDER BY 2 DESC;

SELECT DISTINCT entity, SUM(total_paid) AS fees_paid, SUM(current_amount_due) AS fees_due
FROM cbo_vacant_paid_due
group by 1
ORDER BY 2 DESC;

-- Most banks are logged multiple times under different spellings/abbreviations e.g Bank of America, & Bank of America Na or N A
-- I will filter out entities with greater than 100 vacant properties
SELECT entity, COUNT(property_address), COUNT(DISTINCT property_address)
FROM cbo_vacant_paid_due
GROUP BY entity
ORDER BY 2 DESC
LIMIT 10;

-- used the over window function to create a column that has a running total of homes for each bank
SELECT entity, COUNT(property_address)
OVER(ORDER BY entity
) AS total_boa_homes
FROM cbo_vacant_paid_due
WHERE entity LIKE '%bank_of_america%' AND issued_date >= '2017/01/01' 
ORDER BY total_boa_homes DESC;

/* showing the percent of homes that are distinct & then averaging them out to signify 
the average percentage of individual vacant homes for that bank.*/


SELECT entity, COUNT(property_address)
OVER(ORDER BY entity
) AS total_us_bank_homes
FROM cbo_vacant_paid_due
WHERE entity LIKE '%us bank%' AND issued_date >= '2017/01/01' 
ORDER BY total_us_bank_homes DESC;

SELECT entity, COUNT(property_address)
OVER(ORDER BY entity
) AS total_deutsche_bank_homes
FROM cbo_vacant_paid_due
WHERE entity LIKE '%deut% bank%' AND issued_date >= '2017/01/01' 
ORDER BY total_deutsche_bank_homes DESC;

SELECT entity, COUNT(property_address)
OVER(ORDER BY entity
) AS total_chase_bank_homes
FROM cbo_vacant_paid_due
WHERE entity LIKE '%chase bank%' AND issued_date >= '2017/01/01' 
ORDER BY total_chase_bank_homes DESC;

SELECT entity, COUNT(property_address)
OVER(ORDER BY entity
) AS total_bank_of_ny_mellon_homes 
FROM cbo_vacant_paid_due
WHERE entity LIKE '%bank of % mellon%' AND issued_date >= '2017/01/01' 
ORDER BY total_bank_of_ny_mellon_homes DESC;

SELECT entity, COUNT(property_address)
OVER(ORDER BY entity
) AS total_citi_bank_homes 
FROM cbo_vacant_paid_due
WHERE entity LIKE '%citi %' AND issued_date >= '2017/01/01' 
ORDER BY total_citi_bank_homes DESC;








 
















