-- Заполнение таблицы telecom.users
INSERT INTO telecom.users (passport_number, name, registration_date, account_status)
VALUES 
    ('АВ1234567', 'John Doe', '2022-11-05', 'Active'),
    ('ВМ9406029', 'Jane Smith', '2023-10-06', 'Active'),
    ('НВ0395865', 'Michael Johnson', '2022-09-07', 'Inactive'),
    ('КН7654567', 'Emily Davis', '2021-08-08', 'Active'),
    ('МР2345678', 'David Brown', '2019-07-09', 'Suspended'),
	('МС8765443', 'Emily Davis', '2023-06-13', 'Active'),
    ('КВ4567653', 'David Brown', '2022-05-11', 'Suspended'),
	('РР4565353', 'Emily Davis', '2022-04-12', 'Active'),
    ('MP9495938', 'David Brown', '2018-03-13', 'Suspended'),
	('AB9394785', 'Emily Davis', '2017-02-14', 'Active');

-- Заполнение таблицы telecom.numbers
INSERT INTO telecom.numbers (phone_number, status, activation_date, tariff_activation_date, user_passport)
VALUES
    ('+375 44 134 24 35', 'Active', '2023-01-20', '2023-01-20', 'АВ1234567'),
    ('+375 29 488 35 33', 'Active', '2023-12-25', '2023-12-25', 'ВМ9406029'),
    ('+375 17 159 59 94', 'Inactive', '2023-03-15', '2023-03-15', 'НВ0395865'),
    ('+375 44 119 20 35', 'Active', '2023-04-10', '2023-04-10', 'КН7654567'),
    ('+375 44 144 24 23', 'Suspended', '2023-05-17', '2023-05-17', 'МР2345678'),
    ('+375 29 178 68 31', 'Inactive', '2023-06-27', '2023-06-27', 'МС8765443'),
	('+375 33 175 11 14', 'Inactive', '2023-03-15', '2023-03-15', 'КВ4567653'),
    ('+375 33 256 25 76', 'Active', '2023-04-10', '2023-04-10', 'РР4565353'),
    ('+375 29 996 73 04', 'Suspended', '2023-05-17', '2023-05-17', 'MP9495938'),
    ('+375 33 930 67 50', 'Inactive', '2023-06-27', '2023-06-27', 'МС8765443');

-- Заполнение таблицы telecom.operations
INSERT INTO telecom.operations (date, operation_type, payment_status, amount, passport_number, phone_number)
VALUES
    ('2023-01-20 08:30:00', 'Call', 'Paid', 25.50, 'НВ0395865', '+375 17 159 59 94'),
    ('2023-02-25 12:45:00', 'SMS', 'Paid', 10.75, 'КН7654567', '+375 44 119 20 35'),
    ('2023-03-15 15:20:00', 'Data Usage', 'Not paid', 30.20, 'МС8765443', '+375 33 930 67 50'),
    ('2023-04-10 09:10:00', 'Roaming', 'Paid', 45.30, 'КН7654567', '+375 44 119 20 35'),
    ('2023-05-17 17:55:00', 'Subscription', 'Waiting', 20.00, 'MP9495938', '+375 29 996 73 04'),
    ('2023-06-27 11:20:00', 'Call', 'Paid', 15.80, 'АВ1234567', '+375 44 134 24 35');

-- Заполнение таблицы telecom.balances
INSERT INTO telecom.balances (amount, change_date, phone_number)
VALUES	
    (-10.00, '2023-01-20', '+375 44 134 24 35'),
    (75.25, '2023-02-25', '+375 29 488 35 33'),
    (63.00, '2023-03-15', '+375 17 159 59 94'),
    (74.50, '2023-04-10', '+375 44 119 20 35'),
    (92.75, '2023-05-17', '+375 44 144 24 23'),
    (94.30, '2023-06-27', '+375 29 178 68 31'),
	(40.00, '2023-01-20', '+375 33 175 11 14'),
    (93.25, '2023-02-25', '+375 33 256 25 76'),
    (-11.00, '2023-03-15', '+375 29 996 73 04'),
    (14.50, '2023-04-10', '+375 33 930 67 50');

-- Заполнение таблицы telecom.tariffs
INSERT INTO telecom.tariffs (title, description, price)
VALUES
    ('Basic Plan', 'Basic plan for calls (300 min)', 29.99),
    ('Standard Plan', 'Standart plan for calls and traffic (500 min + 20GB)', 49.99),
    ('Premium Plan', 'Premium plan for calls and traffic (1000 min + 50GB)', 79.99),
	('Internet Plan', 'Plan for Internet (30GB)', 19.99),
    ('Call Plan', 'Plan for calls (100 min)', 15.99),
    ('Roaming Plan', 'Plan for international calls (500 min)', 159.99);

-- Заполнение таблицы telecom.tariffs_numbers
INSERT INTO telecom.tariffs_numbers (phone_number, tariff_title, tariff_status)
VALUES
    ('+375 44 134 24 35', 'Basic Plan', 'Active'),
    ('+375 29 488 35 33', 'Standard Plan', 'Active'),
    ('+375 17 159 59 94', 'Roaming Plan', 'Inactive'),
    ('+375 44 119 20 35', 'Premium Plan', 'Active'),
    ('+375 44 144 24 23', 'Standard Plan', 'Suspended'),
	('+375 29 178 68 31', 'Basic Plan', 'Active'),
    ('+375 33 175 11 14', 'Internet Plan', 'Active'),
    ('+375 33 256 25 76', 'Call Plan', 'Inactive'),
    ('+375 29 996 73 04', 'Premium Plan', 'Active'),
    ('+375 33 930 67 50', 'Basic Plan', 'Inactive');

-- Заполнение таблицы telecom.services
INSERT INTO telecom.services (title, description, type, price)
VALUES
    ('Voicemail', 'Voicemail service for missed calls', 'Communication', 10.00),
    ('Call Forwarding', 'Forward your calls to another number', 'Communication', 20.00),
    ('International Roaming', 'Use your phone abroad', 'Roaming', 30.00);

-- Заполнение таблицы telecom.tariffs_services
INSERT INTO telecom.tariffs_services (tariff_title, sevice_title, sale_on_service_in_tariff)
VALUES
    ('Basic Plan', 'Voicemail', 5.00),
    ('Premium Plan', 'Call Forwarding', 10.00),
    ('Internet Plan', 'International Roaming', 15.00),
    ('Call Plan', 'Call Forwarding', 10.00),
    ('Roaming Plan', 'International Roaming', 13.00);
