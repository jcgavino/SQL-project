# SQL_Project_Job_Prospects
I stumbled upon a dataset of job postings, collected and shared by Luke Barousse. It encompasses diverse job opportunities ranging from analysts to engineers. This specific version is geared towards extracting insights from the Canadian job market and honing my SQL query and database management abilities.

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
Query # 1 : Top-Paying Jobs

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


## Learnings
## Conclusion
