# Introduction

The primary purpose of this project is to refresh my SQL skills after a year absence from the querying language.  The seconday goal of this project is to also gather insights into in-demand skills and pay potential for remote data analysts both at the very top levels of the profession, as well as overall across all junior, intermediate, and expert roles.  Finally, the results of both efforts will be combined into a single github repository to demonstrate some basic analytical and technical SQL capabilities for future job applications while simultaneously broadening my horizons about the data analytics field as a whole.


# Background

### Dataset
The dataset used contains 2023 job posting data related to myriad of data roles, including data analysts, data scientists, data engineers, etc. The data was obtained and released for use by a YouTube analyst called *Luke Barousse*, whose links are included in the [reference](#references) section.

### Project Goals
The goal of this project is to refresh, implement, and showcase an application of general SQL data manipulation techniques to answer career-relevant questions for a remote data analyst position.  As such, even though the dataset used contains postings for many data-related roles, we will be filtering them out to only show results for work-from-home data analyst postings.  The main insights we want to make from the data revolve around average and top pay, as well as which skills are most in demand.  These insights will be used to better help me focus my career path, and guide which skills I should pick up both now and in the future as I grow.

#### The main questions I aim to answer in this project are below, with links to their associated queries:

1. [What are the top paying remote data analyst jobs?](project_queries\top_paying_data_jobs.sql)
2. [What skills are required for these top paying jobs?](project_queries\top_paying_data_skills.sql)
3. [What skills are most in demand for data analysts?](project_queries\most_desirable_data_skills.sql)
4. [Which skills are associated with higher salaries](project_queries\generally_high_paying_data_skills.sql)
5. [What are the most optimal skills for a data analyst to learn in terms of both high demand and pay?](project_queries\optimal_data_skills_to_learn.sql)

*Additionally, [here](/practice_queries/) is a link to some practice queries, where I was refreshing my SQL techniques.*

# Tools I Used
I utilized the following seven tools to query and analyze my data:<br>

1. **SQL:** My preferred language of choice for querying and sifting through databases for analysis.
2. **PostgreSQL:** The primary database management tool used for this project due its popularity and ease of use, used for all queries in the  [project_queries](/project_queries/) folder.
3. **MySQL:** A secondary database management tool with high popularity, used for queries in the [practice_queries](/practice_queries/) folder to gain experience with this database system.
4. **Visual Studio Code:** My favorite code editor for SQL queries and Python scripts, chosen for its ease of use and my familiarity with using it for the last 1-2 years.
5. **Git, GitHub Desktop, and GitHub:** Used for project sharing, tracking, and future project collaboration efforts.  Chosen due to past experience with these tools, and their current popularity amongst analysts.
6. **SQLiteviz:** This browser-based database housed the dataset used, so was briefly used to extract the data in a csv format to feed into my database.
7. **ChatGPT:** Used for quickly creating markdown tables for query results

# The Analysis
Here we'll re-iterate the questions we want answered from the dataset, followed by an in-depth interpretation of the results of our query.  The queries themselves will be posted for reference, as well as a link to the original query made available in its respective subheader.

### [What are the top paying remote data analyst jobs?](project_queries\top_paying_data_jobs.sql)
<details>
<summary>Click to expand/collapse</summary>

### <span style="color:tan">Query Used:</span>
```sql
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
```
### <span style="color:tan">Query Results:</span>
| Job ID   | Job Title                                   | Job Location | Salary Year Avg | Company Name                                |
|----------|---------------------------------------------|--------------|-----------------|--------------------------------------------|
| 226942   | Data Analyst                                | Anywhere     | 650000.0        | Mantys                                     |
| 547382   | Director of Analytics                       | Anywhere     | 336500.0        | Meta                                       |
| 552322   | Associate Director- Data Insights           | Anywhere     | 255829.5        | AT&T                                       |
| 99305    | Data Analyst, Marketing                    | Anywhere     | 232423.0        | Pinterest Job Advertisements               |
| 1021647  | Data Analyst (Hybrid/Remote)               | Anywhere     | 217000.0        | Uclahealthcareers                          |
| 168310   | Principal Data Analyst (Remote)             | Anywhere     | 205000.0        | SmartAsset                                 |
| 731368   | Director, Data Analyst - HYBRID            | Anywhere     | 189309.0        | Inclusively                                |
| 310660   | Principal Data Analyst, AV Performance Ana. | Anywhere     | 189000.0        | Motional                                   |
| 1749593  | Principal Data Analyst                      | Anywhere     | 186000.0        | SmartAsset                                 |
| 387860   | ERM Data Analyst                            | Anywhere     | 184000.0  

### <span style="color:tan">Query Highlights:</span>
1. 8/10 of the top ten highest paying remote data jobs seem to hover closer to $200,000 annual salary in USD.
2. $650,000 annual salary in USD seems to be the highest paying position for a data analyst, but seems to be an outlier given the vast difference in salary relative to the second highest ranking salary of $336,500.
2. A lot of companies in this top ten list, like Meta, AT&T, Pinterest, etc. have a large clientele base and likely involve handling very large amounts of data.
3. Many of these top paying positions have an implied requirement of previous experience as a data analyst, due to titles implying a lead role such as "Director", "Principal".
4. There are a lot of variety in potential employers for a data analyst, as each listing is from a different company.
5. Full job titles for each posting are very similar, either being primarily a principal analyst, a director analyst, or simply a data analyst.

### <span style="color:tan">Result Interpretation:</span>
Long-term prospects for this career seem positive at first glance.  This query gives an initial impression that there are a multitude of employers looking for data analysts in 2023.  With enough time and experience, it seems reasonable for a data analyst to breach 6 figures eventually as well, which is in the top 10% of earners in the USA as of 2021 as per [investopedia](https://www.investopedia.com/personal-finance/how-much-income-puts-you-top-1-5-10/).  To reach these peek salary levels though, experience, especially with tools related to big data, may be a necessary skillset to fully reach this potential.
</details>

### [What skills are required for these top paying jobs?](project_queries\top_paying_data_skills.sql)
<details>
<summary>Click to expand/collapse</summary>

### <span style="color:tan">Query Used:</span>
```sql
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
```

### <span style="color:tan">Query Result:</span>
| Skill Name | Skill Count |
|------------|-------------|
| sql        | 8           |
| python     | 7           |
| tableau    | 6           |
| r          | 4           |
| pandas     | 3           |
| snowflake  | 3           |
| excel      | 3           |
| azure      | 2           |
| oracle     | 2           |
| aws        | 2           |

### <span style="color:tan">Query Highlights</span>
1. SQL is a required skill for 80% of the top paying jobs
2. Python is a required skill for 70% of the top paying jobs
3. Tableau is a required skill for 60% of the top paying jobs
4. R, an alternative programming language to Python, is only required in 40% of the top paying jobs
5. Other skills used in the top paying data jobs involve cloud-based database systems, such as snowflake, azure, oracle, and aws

### <span style="color:tan">Result Interpretation:</span>
SQL is the premier analasis tool across all high-paying data analyst jobs, followed closely by Python.  Near equally important, however, is the data visualization tool, Tableau, which enables the analyst to create dashboards to better share and distribute their data-borne findings amongst their coworkers.  This makes sense considering that an analyst's role is to not only interpret data, but also to share those insights with others to help guide their company and team in the right direction!  Additionally, it seems important to learn at least one cloud-based data management tool at a high level for these higher paying roles.  That's not too surprising given the rise of off-premise data storage and disaster recovery options lately.
</details>

### [What skills are most in demand across all data analyst jobs?](project_queries\most_desirable_data_skills.sql)
<details>
<summary>Click to expand/collapse</summary>

### <span style="color:tan">Query Used:</span>
```sql
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
LIMIT 5;
```
### <span style="color:tan">Query Result:</span>
| Skill Name | Skill Count |
|------------|-------------|
| sql        | 7291        |
| excel      | 4611        |
| python     | 4330        |
| tableau    | 3745        |
| power bi   | 2609        |

### <span style="color:tan">Query Highlights:</span>
1. SQL is by far the most in-demand skill across all data analyst positions
2. Excel is the second most in-demand skill across all data analyst positions
3. Python is the third most in-demand skill across all data analyst positions
4. Data visualization tools are important to companies
5. Tableau is the most in-demand data visualization tool across all data analyst positions

### <span style="color:tan">Result Interpretation:</span>
Similar to when we focused on only the top ten highest paying data analyst jobs, SQL and Python are held in high esteem as the most desirable data skills by all hiring employers.  Python fell in importance by one rank relative to the top ten job skills ranking, but given that it's a programming language that fewer might be expected to know in junior and mid-level data analyst jobs, it's not too surprising to see a popular data tool like Excel outrank it.  On top of that, data visualization continues to be important regardless of job experience level, since it understandably remains important to be able to convey data findings to your company and team.
</details>

### [Which skills are associated with higher salaries](project_queries\generally_high_paying_data_skills.sql)
<details>
<summary>Click to expand/collapse</summary>

### <span style="color:tan">Query Used:</span>
```sql
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
HAVING
    COUNT(skills) > 50
ORDER BY
    avg_skill_salary DESC
LIMIT 10;
```
### <span style="color:tan">Query Results:</span>
| Skill Name      | Skill Count | Avg Skill Salary |
|-----------------|-------------|------------------|
| pyspark         | 2           | 208172           |
| bitbucket       | 2           | 189155           |
| watson          | 1           | 160515           |
| couchbase       | 1           | 160515           |
| datarobot       | 1           | 155486           |
| gitlab          | 3           | 154500           |
| swift           | 2           | 153750           |
| jupyter         | 3           | 152777           |
| pandas          | 9           | 151821           |
| elasticsearch  | 1           | 145000           |


### <span style="color:tan">Query Highlights:</span>
1. The top paying skills across all data analyst jobs appear very rarely, with none of those in the ranking being mentioned in more than 10 job postings
2. The most in-demand top paying skill is pandas, which is a library for Python
3. The top paying skill in this list is Pyspark, which is the Python API for Apache Spark
4. The second highest paying skill is bitbucket, which is a more private version of github
5. The rest of these skills are low in demand and I'm unfamiliar with currently

### <span style="color:tan">Result Interpretations:</span>
Given Pyspark and Panda's relation to Python, this query seems to support the notion that Python is a heavily desired programming language for Data Analysts - especially to reach higher salary brackets in the career.  The rest of the skills are largely foreign to me, and suggest a need to study up on them to broaden my horizons!  That said, all of the skills listed here don't seem to be very in-demand, implying learning them is more niche and dependant on the role the analyst wishes to pursue, grow, or apply themselves towards.
</details>

### [What are the most optimal skills for a data analyst to learn in terms of both high demand and pay?](project_queries\optimal_data_skills_to_learn.sql)
<details>
<summary>Click to expand/collapse</summary>

### <span style="color:tan">Query Used:</span>
```sql
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
LIMIT 20;
```
### <span style="color:tan">Query Results:</span>
| Skill Name | Skill Count | Avg Skill Salary |
|------------|-------------|------------------|
| snowflake  | 37          | 112948           |
| azure      | 34          | 111225           |
| aws        | 32          | 108317           |
| oracle     | 37          | 104534           |
| looker     | 49          | 103795           |
| python     | 236         | 101397           |
| r          | 148         | 100499           |
| tableau    | 230         | 99288            |
| sas        | 126         | 98902            |
| sql server | 35          | 97786            |

### <span style="color:tan">Query Highlights:</span>
1. Cloud-based database management tools are dominating the top of the highest average salary list across all data jobs
2. Python, R, SQL server, and Tableau are still relevant at the higher end of the salary spectrum, but below cloud-based technology
3. Python is higher in demand and higher paying than its counterpart R
4. Tableau is one of the most in-demand skills on this list, and pays higher than Power BI (which did not make the list)
5. The skill count is significant lower for each skill here, relative to when we looked up the count of each skill across all job postings in query #3

### <span style="color:tan">Result Interpretations:</span>
Once we filter so that only skills shown in the job postings at least 30 times appear in our top 10 ranking list, skills that I'm more familiar with come back into the rankings.  Namely, cloud-based services such as Snowflake, Azure, AQS, and Oracle become the top 4 highest paying skills in general for a remote data analyst.  This emphasizes the importance to learn cloud-based technology as a work-at-home worker if I want to grow my career past junior and/or mid-level salaries.  Programming languages like Python and R (especially the former) also become the dominant data parsing language of choice in higher paying jobs, replacing SQL and Excel, which did not really make the top 10 list.  The data visualization tool Tableau, as always, remains relevant as the analyst communicating tool of choice amonst their peers.

It is also worth noting that skill count in this query is lower than query 3, which focused on getting the skill count for all data analyst jobs.  In query 3, Tableau appeared as a required skill in 3,745 job listings, while here, it only appears 230 times.  This is likely due to the additional filter criteria used here, that excluded all postings that did not include an average salary.  This implies most postings do not include a salary, preferring to discuss or negotiate it instead during the applicant's interviews.  This also explains the vast difference in skill counts between the two queries.
</details><br>

# What I learned
Across all remote data analyst jobs, SQL rules as the most in-demand skill by employers.  This statement seems true even into the higher paying brackets of data jobs, with SQL being the #1 most requested skill across the top 10 highest paying job postings, and SQL server being the 10th highest paying skill across all data jobs, based on average salary.  A data visualization tool, either Tableau or Power BI, is also necessary for summarizing and sharing the analyst's findings and converting it into meaningful information for their peers.  Out of the two visualization tools mentioned, Tableau seems to be highest in both demand and pay.

To break into the higher paying data roles, however, knowledge of at least one programming language (Python or R), and cloud-based data management systems will be necessary.  Python trumps R in both demand and pay, while cloud-based data management systems are more-or-less equal across the four big options: AWS, Oracle, Azure, and Snowflake.  To breach the highest of data analyst salaries will require larger specializations and a wider range of tool knowledge, such as with Pysparks, pandas, jupyter, etc. But these needs are more niche and dependent on the job one would be applying for.

Overall, it seems a great starting point to growing a data analyst career would be to learn the top in-demand skills of SQL, Excel, Tableau, and Python roughly in that order.  Once mastered, the analyst could then consider delving into cloud-based technology and other specializations - which will likely be the path I take going forward.

I also learned just how handy implementing AI like chatGPT can be in simplifying workloads and writing reports or readmes like this one.  One just has to be aware of the sensitivity of data being fed to the AI program since that data gets recycled for the machine to learn.  That wasn't an issue in this case given the data is public, but could definitely be one if handling data should remain private.

# Conclusion
The data analyst profession, as of 2023, seems to be booming.  Data is prevalent in all orders of business, requiring databases to store it and data analysts to analyze it.  Given the broad number of employers that posted for data analyst positions, the average salary range for experienced analysts, and my own passion for the work involved, I believe this to be a positive career path for me to pursue going forward.  As long as I continue growing my abilities in in-demand skills like SQL, Excel, Python, and a data visualization tool of my choice (likely Tablueau), I should be adequately prepared for a long-term career in data analytics!

# References
The dataset used and project concept stemmed from an SQL course video offered by a YouTube analyst under the name *Luke Barousse*.  You can find his YouTube channel and the relevant datasets linked below:

* [Luke Barousse's YouTube channel](https://www.youtube.com/@LukeBarousse)
* [Jobs Dataset](https://lukeb.co/sql_jobs_db)