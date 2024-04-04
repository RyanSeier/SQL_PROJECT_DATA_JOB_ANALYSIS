/* Q3. What are the most in-demand skills across all roles for a data analyst?
- Identify the top 5 desirable skills across all data analyst roles
- Focus on remote data analyst roles, regardless or salary or either criteria
- Why? Q2 provided brief insight into which skills will be important long-term for my career, but this query will help identify which ones I should prioritize when getting started
*/

SELECT
    skills_dim.skills AS skill_name,
    skill_count
FROM (
        SELECT 
            skill_id,
            COUNT(skill_id) AS skill_count
        FROM 
            job_postings_fact job_details
        LEFT JOIN
            skills_job_dim
            ON skills_job_dim.job_id = job_details.job_id
        WHERE 
            job_title_short = 'Data Analyst'
            AND job_location = 'Anywhere'
        GROUP BY
            skill_id
    ) AS job_skill_count
LEFT JOIN
    skills_dim
    ON skills_dim.skill_id = job_skill_count.skill_id
ORDER BY
    skill_count DESC
LIMIT 5
;