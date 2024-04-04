/* Q2. What are the most required skills for the top-paying data analyst roles identified in Q1?
- Identify the top 10 skills used by data analysts in the highest paying roles previously identified in Q1
- Why?  To determine which skills I should prepare to learn now and going forward to grow my career
*/

-- Recycle Q1 code identifying top 10 roles, set up CTE for use in later subquery
WITH top_10_data_jobs AS (
    SELECT 
        job_id,
        job_title,
        job_location,
        salary_year_avg,
        comp_details.name AS company_name
    FROM 
        job_postings_fact job_details
    LEFT JOIN
        company_dim comp_details
        ON comp_details.company_id = job_details.company_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_location = 'Anywhere'
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)

-- Join list of skills to top 10 roles (subquery), count skill appearance rate, and group by their joined skill names
SELECT
    skills_dim.skills AS skill_name,
    skill_count
FROM (
    SELECT
        skill_id,
        COUNT(skill_id) AS skill_count
    FROM top_10_data_jobs
    LEFT JOIN skills_job_dim
        ON top_10_data_jobs.job_id = skills_job_dim.job_id
    GROUP BY
        skill_id
) AS job_skill_count
LEFT JOIN skills_dim
    ON skills_dim.skill_id = job_skill_count.skill_id
ORDER BY skill_count DESC
LIMIT 10;