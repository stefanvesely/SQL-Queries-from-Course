WITH CTE AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY ObjectKey ORDER BY (SELECT NULL)) AS row_num
    FROM ContentPrints
)
DELETE FROM CTE
WHERE row_num > 1;