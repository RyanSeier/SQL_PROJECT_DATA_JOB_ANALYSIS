-- Core Practice Problem #7
SELECT 
    skills_dim.skills, 
    remote_job_count
FROM (
    SELECT 
        skill_id, 
        COUNT(job_location) AS remote_job_count
    FROM 
        job_postings_fact jobp
    LEFT JOIN 
        skills_job_dim skillp
        ON jobp.job_id = skillp.job_id
    WHERE 
        job_location = 'Anywhere'
    GROUP BY 
        skill_id) AS skill_count
LEFT JOIN 
    skills_dim
    ON skills_dim.skill_id = skill_count.skill_id
ORDER BY 
    remote_job_count DESC
LIMIT 5;