/*Перевіряємо назви колонок і типи даних в колонках*/

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'jobs';

/*Запит для швидкого перегляду даних (перші 10 рядків)*/

SELECT *
FROM jobs
LIMIT 10;

/*Оцінюємо обсяг даних (загальна кількість рядків)*/

SELECT 
	COUNT(*)
FROM jobs;

/*Перевірка на пропущені значення (NULL)*/

SELECT *
FROM jobs
WHERE 'company' IS NULL
   OR 'job_title' IS NULL
   OR 'industry' IS NULL
   OR 'location' IS NULL
   OR 'employment_type' IS NULL
   OR 'Location' IS NULL
   OR 'remote_flexibility' IS NULL
   OR 'salary_annual' IS NULL
   OR 'Currency' IS NULL
   OR 'Years of Experience' IS NULL;

   /*Перевірка на коректність значень*/

SELECT 
	MAX(salary_annual) as max_salary,
	MIN (salary_annual) as min_salary,
	MAX ("Years of Experience") as max_experience,
	MIN ("Years of Experience") as min_experience
FROM jobs;


/*Створюємо таблицю з курсами валют*/

CREATE TABLE exchange_rates (
    currency_code TEXT PRIMARY KEY,
    exchange_rate_to_usd NUMERIC NOT NULL
);


/*ДОДАЄМО курси валют*/
INSERT INTO exchange_rates (currency_code, exchange_rate_to_usd)
VALUES 
	('EUR', 1.08),
	('INR', 0.012),
	('GBP', 1.27),
	('CAD', 0.74),
	('AUD', 0.66),
	('JPY', 0.0067);
	

/*Перевіряємо дані в створеній таблиці*/
select *
from exchange_rates;

