/* Q4. What are the top skills based on salary for all data analysts?
- Determine which skills are paid more on average across all data analyst roles
- Focus on skills associated with my preferred remote data analyst roles
- Why? To get a better understanding of what skills I should expect to learn during my career to best accelerate salary growth
*/

SELECT
    skills AS skill_name,
    COUNT(skills) AS skill_count,
    ROUND(AVG(salary_year_avg)) AS avg_skill_salary
FROM
    job_postings_fact
LEFT JOIN
    skills_job_dim
    ON skills_job_dim.job_id = job_postings_fact.job_id
LEFT JOIN
    skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skill_name
ORDER BY
    avg_skill_salary DESC
LIMIT 10;
