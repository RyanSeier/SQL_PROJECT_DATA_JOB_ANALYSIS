/* Q5. What are the most optimal skills to learn as a data analyst?
- Identify the most optimal skills to learn as a data analyst going forward, based on both desirability and average salary.
- Focus on remote data analyst jobs, with skills that show up at least 30 times
- Why?  We learned which skills are highest paying for the top 10 data analyst positions in Q2.  
This query will let us hone in on skills that are both higher paying and commonly in-demand for beginner and mid-level analysts as well.
*/

SELECT
    skills_dim.skills AS skill_name,
    COUNT(skills) AS skill_count,
    ROUND(AVG(salary_year_avg),0) AS avg_skill_salary
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
    job_work_from_home = TRUE AND
    salary_year_avg IS NOT NULL
GROuP BY
    skill_name
HAVING
    COUNT(skills) > 30
ORDER BY
    avg_skill_salary DESC
LIMIT 10;