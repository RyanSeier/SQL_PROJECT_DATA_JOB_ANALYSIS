/* Q1. What are the top paying jobs for a Data Analyst?
- Identify top 10 highest paying work-from-home data analyst jobs
- Focus on job postings with specific salaries (ignore nulls)
- Why? To highlight top-paying opportunities and better guide my future career direction
*/

-- Set up criteria to filter for remote data analyst jobs whose salaries are known
-- Join company details to better understand which companies hire for these top paying jobs
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
LIMIT 10;