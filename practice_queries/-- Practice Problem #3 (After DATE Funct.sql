-- Practice Problem #3 (After DATE Function)
SELECT DISTINCT
    company.name AS company_name,
--    job_post.job_posted_date::DATE AS posted_date,
    job_post.job_health_insurance
FROM
    company_dim AS company
RIGHT JOIN
    job_postings_fact AS job_post
    ON job_post.company_id = company.company_id
WHERE
    (job_health_insurance = TRUE) AND
    (EXTRACT(year FROM job_posted_date) = '2023') AND
    (EXTRACT(MONTH FROM job_posted_date) BETWEEN 4 AND 6)
--LIMIT 10
;