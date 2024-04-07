-- CTE and Subquery Practice Problem #2
SELECT 
    company_dim.name AS company_name,
    company_job_count.job_post_count,
    CASE
        WHEN job_post_count <10 THEN 'Small'
        WHEN job_post_count >50 THEN 'Large'
        ELSE 'Medium'
    END AS company_size
FROM (
    SELECT 
        company_id,
        COUNT(job_id) AS job_post_count
    FROM
        job_postings_fact
    GROUP BY
        company_id
    ) AS company_job_count
LEFT JOIN
    company_dim
    ON company_dim.company_id = company_job_count.company_id
--ORDER BY
--    job_post_count DESC
;