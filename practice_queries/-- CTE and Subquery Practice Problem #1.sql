-- CTE and Subquery Practice Problem #1
WITH skill_id_count AS (
    SELECT skill_id, COUNT(skill_id) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
)

SELECT skills.skills AS skill_name,
    skillc.skill_count
FROM skill_id_count skillc
LEFT JOIN skills_dim skills
    ON skillc.skill_id = skills.skill_id
ORDER BY skill_count DESC
LIMIT 5;