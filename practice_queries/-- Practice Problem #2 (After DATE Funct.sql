-- Practice Problem #2 (After DATE Functions)
SELECT
    EXTRACT(YEAR FROM job_posted_date) AS year_posted,
    EXTRACT(MONTH FROM job_posted_date) AS month_posted,
    COUNT(job_id) AS num_job_postings
FROM
    job_postings_fact
--WHERE
--    EXTRACT(YEAR FROM job_posted_date) = '2023'
GROUP BY
    EXTRACT(MONTH FROM job_posted_date), 
    month_posted,
    year_posted
HAVING
    EXTRACT(YEAR FROM job_posted_date) = '2023'
LIMIT
    15;