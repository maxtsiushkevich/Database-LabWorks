DROP TABLE IF EXISTS telecom.users CASCADE;
DROP TABLE IF EXISTS telecom.numbers CASCADE;
DROP TABLE IF EXISTS telecom.operations CASCADE;
DROP TABLE IF EXISTS telecom.balances CASCADE;
DROP TABLE IF EXISTS telecom.tariffs CASCADE;
DROP TABLE IF EXISTS telecom.tariffs_numbers CASCADE;
DROP TABLE IF EXISTS telecom.services CASCADE;
DROP TABLE IF EXISTS telecom.tariffs_services CASCADE;

DROP SCHEMA IF EXISTS telecom CASCADE;

CREATE DATABASE Telecom;
CREATE SCHEMA telecom;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP TYPE IF EXISTS status_enum;
DROP TYPE IF EXISTS operation_enum;
DROP TYPE IF EXISTS payment_status_enum;

CREATE TYPE status_enum AS ENUM (
    'Active',
    'Inactive',
    'Suspended',
    'Blocked'
);

CREATE TYPE operation_enum AS ENUM (
    'Call',           -- звонок
    'SMS',            -- SMS
    'Data Usage',     -- трафик
    'Roaming',        -- роуминг
    'Subscription',   -- подписка
	'Not specified'
);

CREATE TYPE payment_status_enum AS ENUM (
    'Not paid',     -- не оплачено
    'Waiting',      -- ожидает оплаты
    'Paid',         -- оплачено
    'Refunded'      -- возвращено
);

CREATE TABLE telecom.users (
    passport_number VARCHAR(20) UNIQUE PRIMARY KEY,
    name VARCHAR(100),
    registration_date TIMESTAMP NOT NULL,
    account_status status_enum DEFAULT 'Inactive'
);

CREATE TABLE telecom.numbers (
    phone_number VARCHAR(20) UNIQUE PRIMARY KEY CHECK (phone_number ~ '^\+375 \d{2} \d{3} \d{2} \d{2}$'),
    status status_enum DEFAULT 'Inactive',
    activation_date TIMESTAMP NOT NULL,
    tariff_activation_date TIMESTAMP NOT NULL,
    user_passport VARCHAR(20),
    FOREIGN KEY (user_passport) REFERENCES telecom.users(passport_number)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);


CREATE TABLE telecom.operations (
	operation_id UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
	date TIMESTAMP NOT NULL,
	operation_type operation_enum DEFAULT 'Not specified',
	payment_status payment_status_enum DEFAULT 'Not paid',
	amount MONEY DEFAULT 0.0,
	passport_number VARCHAR(20),
	phone_number VARCHAR(20),
	FOREIGN KEY (passport_number) REFERENCES telecom.users(passport_number)
	ON DELETE NO ACTION
    ON UPDATE CASCADE,

	FOREIGN KEY (phone_number) REFERENCES telecom.numbers(phone_number)
	ON DELETE NO ACTION
    ON UPDATE CASCADE
);

ALTER TABLE telecom.operations 
ADD CONSTRAINT positive_amount CHECK (amount >= 0.0::MONEY);

CREATE TABLE telecom.balances (
	id UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
    amount MONEY DEFAULT 0.0,
	change_date TIMESTAMP DEFAULT CURRENT_DATE,
	phone_number VARCHAR(20) UNIQUE,
	FOREIGN KEY (phone_number) REFERENCES telecom.numbers(phone_number)
	ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE telecom.tariffs(
	title VARCHAR(50) NOT NULL PRIMARY KEY,
	description VARCHAR(200),
	price MONEY DEFAULT 0.0
);

ALTER TABLE telecom.tariffs 
ADD CONSTRAINT positive_price CHECK (price >= 0.0::MONEY);

CREATE TABLE telecom.tariffs_numbers (
    tariff_title VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20),
	tariff_status status_enum DEFAULT 'Inactive',
    PRIMARY KEY (tariff_title, phone_number),
    FOREIGN KEY (tariff_title) REFERENCES telecom.tariffs(title)
	ON DELETE NO ACTION
    ON UPDATE CASCADE,
	
    FOREIGN KEY (phone_number) REFERENCES telecom.numbers(phone_number)
	ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE telecom.services (
	title VARCHAR(50) UNIQUE PRIMARY KEY,
	description VARCHAR(200),
	price MONEY DEFAULT 0.0,
	type VARCHAR(50)
);

CREATE TABLE telecom.tariffs_services(
	tariff_title VARCHAR(50),
    sevice_title VARCHAR(50),
	sale_on_service_in_tariff MONEY DEFAULT 0.0,
    PRIMARY KEY (tariff_title, sevice_title),
    FOREIGN KEY (tariff_title) REFERENCES telecom.tariffs(title)
	ON DELETE CASCADE
    ON UPDATE CASCADE,
	
    FOREIGN KEY (sevice_title) REFERENCES telecom.services(title)
	ON DELETE CASCADE
    ON UPDATE CASCADE
);
