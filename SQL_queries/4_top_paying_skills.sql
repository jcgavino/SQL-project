/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/

create view top_pay_skills2 as (
    SELECT 
        skills,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND search_location = 'Canada' 
    GROUP BY
        skills
    ORDER BY
        avg_salary DESC
    LIMIT 25
)
[
  {
    "skills": "looker",
    "avg_salary": "130250"
  },
  {
    "skills": "snowflake",
    "avg_salary": "123333"
  },
  {
    "skills": "redshift",
    "avg_salary": "120000"
  },
  {
    "skills": "typescript",
    "avg_salary": "108416"
  },
  {
    "skills": "bigquery",
    "avg_salary": "107833"
  },
  {
    "skills": "spark",
    "avg_salary": "107479"
  },
  {
    "skills": "hadoop",
    "avg_salary": "107167"
  },
  {
    "skills": "aws",
    "avg_salary": "105000"
  },
  {
    "skills": "gcp",
    "avg_salary": "105000"
  },
  {
    "skills": "azure",
    "avg_salary": "103671"
  },
  {
    "skills": "javascript",
    "avg_salary": "101750"
  },
  {
    "skills": "databricks",
    "avg_salary": "101014"
  },
  {
    "skills": "sheets",
    "avg_salary": "100625"
  },
  {
    "skills": "visio",
    "avg_salary": "100500"
  },
  {
    "skills": "jira",
    "avg_salary": "100500"
  },
  {
    "skills": "express",
    "avg_salary": "99150"
  },
  {
    "skills": "sap",
    "avg_salary": "99150"
  },
  {
    "skills": "r",
    "avg_salary": "98500"
  },
  {
    "skills": "tableau",
    "avg_salary": "95315"
  },
  {
    "skills": "python",
    "avg_salary": "92494"
  },
  {
    "skills": "power bi",
    "avg_salary": "92100"
  },
  {
    "skills": "sql",
    "avg_salary": "91092"
  },
  {
    "skills": "sql server",
    "avg_salary": "90000"
  },
  {
    "skills": "sas",
    "avg_salary": "88750"
  },
  {
    "skills": "vba",
    "avg_salary": "83875"
  }
]