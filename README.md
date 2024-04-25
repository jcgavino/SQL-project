# SQL_Project_Job_Prospects
I stumbled upon a dataset of job postings, collected and shared by Luke Barousse. It encompasses diverse job opportunities ranging from analysts to engineers. This specific version is geared towards extracting insights from the Canadian job market and honing my SQL query and database management abilities. You can find more information about the dataset used in this project in the repository by @[lukebarousse](https://github.com/lukebarousse). A big shoutout to Luke and Kelly Adams for this learning opportunity!


## Introduction
With this dataset, my aim was to explore the salary ranges, required skills, geographical distribution, and job availability within the field of data-related positions across the country.

Some questions that SQL queries will be able to answer are:
1. What are the top-paying data jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

## Tools
I used several tools to explore the dataset.
  - SQL - formulated and explored queries to get insights from the data
  - PostgreSQL - database to handle various tasks with regards to the dataset such as uploading, querying, and creating tables 
  - Vscode - tool where to query and manage the database
  - PowerBI - connected to PostgreSQL to view the tables and create simple charts
  - Git and Github - to share my repository 
  
## Analysis
### Query # 1 : Top-Paying Jobs

```sql
    SELECT	
      job_id,
      job_title,
      job_location,
      job_schedule_type,
      salary_year_avg,
      job_posted_date,
        name as company_name
    FROM
        job_postings_fact as jpf
    LEFT JOIN company_dim as cd on jpf.company_id=cd.company_id
    where salary_year_avg IS NOT NULL and 
          job_title_short like '%Data%Analyst%' and
          search_location = 'Canada'
    order by salary_year_avg desc
    limit 20
```

In Canada, the top positions for Data Analysts exhibit a significant salary range, spanning from 100k to 175k. The majority of these coveted roles are at the senior, lead, or managerial levels. <br>
<br>
<img src="https://github.com/jcgavino/SQL_Project/blob/main/PowerBi/Query1_Table.png" width="400" height="400">
<br>

### Query # 2 : Top Skills

```sql
    with top_paying_jobs as (
        SELECT	
            job_id,
            job_title,
            salary_year_avg,
            name as company_name
        FROM
            job_postings_fact as jpf
        LEFT JOIN company_dim as cd on jpf.company_id=cd.company_id
        where salary_year_avg IS NOT NULL and 
            job_title_short like 'Data Analyst' and
            search_location like 'Canada'
        order by salary_year_avg desc
        limit 20
    )
    select top_paying_jobs.*,
            skills
    from top_paying_jobs
    inner join skills_job_dim on top_paying_jobs.job_id=skills_job_dim.job_id
    inner join skills_dim on skills_job_dim.skill_id=skills_dim.skill_id
    order by salary_year_avg desc;
```

The skills highlighted in the top job postings include SQL, Python, Tableau, SAS, and Excel. Once more, SQL stands out as a fundamental skill essential for data analysis. This is followed by Python for programming and Tableau for visualization. <br>
<br>
<img src="https://github.com/jcgavino/SQL_Project/blob/main/PowerBi/Query2_NeededSkills.png">
<br>

### Query # 3 : Top Skills

```sql
      SELECT 
          skills,
          COUNT(skills_job_dim.job_id) AS demand_count
      FROM job_postings_fact
      INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
      INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
      WHERE
          job_title_short = 'Data Analyst' 
          AND search_location = 'Canada' 
      GROUP BY
          skills
      ORDER BY
          demand_count DESC
      LIMIT 5
```
On a general note, SQL, Excel, Python, Tableau, and PowerBI tops the list of skills for data analyst jobs in Canada. <br>
<br>
<img src="https://github.com/jcgavino/SQL_Project/blob/main/PowerBi/Query3_DemandSkills.png">
<br>

### Query # 4 : Top Paying Skills
```sql
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
```
Skills in data visualization and BI tools such as Looker and Tableau, along with expertise in data warehousing technologies like Snowflake and Redshift, are among the highest-paying in the dataset, with average salaries ranging from $95,315 to $130,250. Cloud platform proficiency in AWS, GCP, and Azure also commands competitive salaries, averaging around $105,000. Meanwhile, expertise in programming languages like TypeScript and Python, as well as statistical analysis tools like SAS and R, remains valuable, with average salaries ranging from $83,875 to $108,416. <br>
<br>
<img src="https://github.com/jcgavino/SQL_Project/blob/main/PowerBi/Query4_Top_Paying_Skills.png">
<br>

### Query # 5 : Optimal Skills
```sql
    SELECT 
      skills_dim.skill_id,
      skills_dim.skills,
      COUNT(skills_job_dim.job_id) AS demand_count,
      ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
      job_title_short = 'Data Analyst'
      AND salary_year_avg IS NOT NULL
      AND search_location = 'Canada' 
    GROUP BY
      skills_dim.skill_id
    HAVING
      COUNT(skills_job_dim.job_id) > 10
    ORDER BY
      avg_salary DESC,
      demand_count DESC
    LIMIT 25;
```
To prioritize skills with both high demand and high salary, we should emphasize proficiency in SQL and Python. <br>
<br>
<img src="https://github.com/jcgavino/SQL_Project/blob/main/PowerBi/Query5_Optimal_Skills.png">
<br>

### Other # 1 : Job Location
Data-related job opportunities in Canada are primarily concentrated in Toronto, with 3484 postings. Additionally, locations listed as Canada and Anywhere likely denote remote positions, accounting for approximately 7300 listings collectively. Following Toronto, Vancouver and Montreal emerge as the next prominent areas, boasting 788 and 667 job postings respectively. <br>
<br>
<img src="https://github.com/jcgavino/SQL_Project/blob/main/PowerBi/Others1_Data_Job_Location.png">
<br>

### Other # 2 : Job Title Salary
Entry-level positions such as Business Analysts and Data Analysts offer salaries around $90k, while Machine Learning Engineers earn the highest salary at $148k. Senior roles including Senior Data Scientists and Analysts, Software and Cloud Engineers, and Data Engineers command higher salaries, averaging around $120k. <br>
<br>
<img src="https://github.com/jcgavino/SQL_Project/blob/main/PowerBi/Others1_Data_Job_Salary.png">
<br>

## Learnings
Exploring the trends and dynamics of the Canadian data industry was enlightening and provided valuable insights into potential career paths. Throughout this journey, I focused on honing essential skills crucial for securing a role in data analytics. These included:

1. Advancing proficiency in SQL by practicing more complex queries and engaging in real-life data analysis scenarios.
2. Gaining foundational knowledge in PostgreSQL to understand the fundamentals of database management.
3. Becoming skilled in Git and GitHub to establish and manage my own repository, facilitating seamless collaboration and sharing of projects.
4. Transitioning from static data files to dynamic analysis using PowerBI, enabling direct connections to databases for more insightful and interactive reporting.

## Conclusion
Some key takeaways:
- Although data-related jobs offer lucrative salaries, acquiring the necessary skills is crucial to enter the industry.
- Prioritize mastering top-rated skill sets like SQL, a visualization tool such as Tableau or PowerBI, spreadsheet software like Google Sheets or Excel, and a programming language like R or Python.
- To increase earning potential, consider expanding expertise in database and cloud-focused tools.
- Data Scientists and Machine Learning Engineers command the highest salaries among data-related positions.
