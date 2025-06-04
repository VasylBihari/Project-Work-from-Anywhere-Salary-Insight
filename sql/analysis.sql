/*Запитую зарплати (максимальну, мінімальну та медіанну) для віддалених, гібридних та офісних ролей у різних індустріях*/

select 
	industry,
	MAX(salary_usd) as max_salary,
	MIN (salary_usd) as min_salary,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Salary_usd) AS median_salary_usd,
	remote_flexibility
from jobs
group by industry, remote_flexibility;

/*Дослідити вплив географічного розташування на рівень зарплат.*/

select
	location,
	MAX(salary_usd) as max_salary,
	MIN (salary_usd) as min_salary,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Salary_usd) AS median_salary_usd
from jobs
GROUP BY location;


/*Визначити ключові фактори, що впливають на зарплату (досвід, посада, тип зайнятості).*/

SELECT 
    CASE 
        WHEN "Years of Experience" <= 2 THEN '0-2 years'
        WHEN "Years of Experience" <= 5 THEN '3-5 years'
        WHEN "Years of Experience" <= 10 THEN '6-10 years'
        ELSE '10+ years'
    END AS experience_group,
    job_title,
    employment_type,
    COUNT(*) AS job_count,
    ROUND(AVG(salary_usd), 2) AS avg_salary_usd,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Salary_usd) AS median_salary_usd,
    MIN(salary_usd) AS min_salary_usd,
    MAX(salary_usd) AS max_salary_usd
FROM jobs
GROUP BY 
    CASE 
        WHEN "Years of Experience" <= 2 THEN '0-2 years'
        WHEN "Years of Experience" <= 5 THEN '3-5 years'
        WHEN "Years of Experience" <= 10 THEN '6-10 years'
        ELSE '10+ years'
    END,
    job_Title,
    employment_type
ORDER BY experience_group, avg_salary_usd DESC;

/*Топ-5 посад за зарплатою в регіонах*/

WITH RankedJobs AS (
    SELECT 
        Location,
        Job_Title,
        ROUND(AVG(Salary_usd), 2) AS avg_salary_usd,
        COUNT(*) AS job_count,
        ROW_NUMBER() OVER (PARTITION BY Location ORDER BY AVG(Salary_usd) DESC) AS rank
    FROM jobs
    GROUP BY Location, Job_Title
    HAVING COUNT(*) > 5  -- Фільтр для уникнення малих груп
)
SELECT 
    Location,
    Job_Title,
    avg_salary_usd,
    job_count
FROM RankedJobs
WHERE rank <= 5
ORDER BY Location, avg_salary_usd DESC;

/*Найкращі індустрії для Senior-посад*/

SELECT 
    Industry,
    COUNT(*) AS job_count,
    ROUND(AVG(Salary_usd), 2) AS avg_salary_usd,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Salary_usd) AS median_salary_usd,
    MIN(Salary_usd) AS min_salary_usd,
    MAX(Salary_usd) AS max_salary_usd
FROM jobs
WHERE Experience_Level = 'Senior'
GROUP BY Industry
HAVING COUNT(*) > 10  -- Фільтр для уникнення малих груп
ORDER BY avg_salary_usd DESC, job_count DESC
LIMIT 5;


