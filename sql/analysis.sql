/*Запитую зарплати (максимальну, мінімальну та медіанну) для віддалених, гібридних та офісних ролей у різних індустріях*/

select 
	industry,
	MAX(salary_usd) as max_salary,
	MIN (salary_usd) as min_salary,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Salary_usd) AS median_salary_usd,
	remote_flexibility
from jobs
group by industry, remote_flexibility;


