-- Core Practice Problem #8
SELECT 
    job_id,
    job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION
    SELECT *
    FROM february_jobs
    UNION
    SELECT *
    FROM march_jobs
) AS first_quarter_postings
WHERE 
    salary_year_avg > 70000
    AND job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC;