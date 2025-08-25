WITH cleaned AS (
  SELECT
    customer_id,
    full_name,
    email,
    phone,
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
      phone,'+',''),' ',''),'-',''),'(',''),')',''),'.',''),char(9),''),char(10),''),char(13),''),'/',''
    ) AS digits
  FROM customers
),
ru_norm AS (
  SELECT
    *,
    CASE
      WHEN length(digits)=11 AND substr(digits,1,1) IN ('7','8')
        THEN '7' || substr(digits,2)
      WHEN length(digits)=10
        THEN '7' || digits
      ELSE digits
    END AS ru11
  FROM cleaned
)
SELECT
  full_name, substr(email,1,3) || '***' || substr(email, instr(email,'@')) AS masked_email,
  phone AS original_phone,
  CASE
    WHEN length(ru11)=11 AND substr(ru11,1,1)='7'
      THEN '+7 (***) ***-' || substr(ru11, 8, 2) || '-' || substr(ru11, 10, 2)
    WHEN length(digits) >= 4
      THEN '***' || substr(digits, length(digits)-3, 4)
    ELSE '***'
  END AS masked_phone
FROM ru_norm
ORDER BY full_name;
