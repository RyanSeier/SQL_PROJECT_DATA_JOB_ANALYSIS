-- CHANGE TIME ZONE (TO CST)
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AS old_date_time,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'CST' AS date_time
FROM
    job_postings_fact
LIMIT 10;