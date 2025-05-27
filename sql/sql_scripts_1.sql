/*Створюємо таблицю з курсами валют*/

CREATE TABLE exchange_rates (
    currency_code TEXT PRIMARY KEY,
    exchange_rate_to_usd NUMERIC NOT NULL
);


/*ДОДАЄМО курси валют*/
INSERT INTO exchange_rates (currency_code, exchange_rate_to_usd)
VALUES ('JPY', 0.0067);

select *
from exchange_rates;
