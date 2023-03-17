CREATE TABLE "CUSTOMER" (
  "customer_id" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50),
  "email" VARCHAR(200),
);

CREATE TABLE "Mechanic" (
    "mechanic_id" SERIAL PRIMARY KEY,
    "first_name" VARCHAR(50),
    "last_name" VARCHAR(50),
);

CREATE TABLE "Salesperson" (
    "salesperson_id" SERIAL PRIMARY KEY,
    "first_name" VARCHAR(50),
    "last_name" VARCHAR(50),
);

CREATE TABLE "Car" (
    "car_id" SERIAL PRIMARY KEY,
    "make" VARCHAR(50),
    "model" VARCHAR(50),
    "owners" INTEGER ,
    "price" NUMERIC(10,2),
    "salesperson_id" INTEGER REFERENCES "salesperson"(salesperson_id),
);

CREATE TABLE "Invoice" (
    "invoice_id" SERIAL PRIMARY KEY,
    "car_id" INTEGER REFERENCES "Car"(car_id),
    "date" DATETIME ,
    "customer_id" INTEGER REFERENCES "Customer"(customer_id)
);

CREATE TABLE "Service_Ticket" (
    "service_id" SERIAL PRIMARY KEY,
    "date" DATETIME,
    "customer_id" INTEGER REFERENCES "Customer"(customer_id),
    "car_id" INTEGER REFERENCES "Car"(car_id),
    "type" VARCHAR(100),
    "mechanic_id" INTEGER REFERENCES "mechanic"(mechanic_id),
    "cost" NUMERIC(10,2)
);

CREATE OR REPLACE FUNCTION add_customer(firstname VARCHAR, lastname VARCHAR, email VARCHAR)
RETURNS void 
AS $MAIN$
BEGIN
     INSERT INTO "Customer"
     (first_name, last_name, email)
     VALUES(firstname, lastname, email);
END;
$MAIN$
LANGUAGE p1pgsql;

DROP FUNCTION add_customer;

SELECT add_customer('Matt', 'Boston','Matty_b@yahoo.com');
SELECT add_customer('Asia', 'Riley', 'Asiariley@gmail.com');
SELECT add_customer('Drake', 'Bell', 'BigDrake88@hotmail.com');
SELECT add_customer('Tim', 'Moore', 'Timmybean69@gmail.com');

SELECT * FROM "Customer";

CREATE OR REPLACE FUNCTION add_salesperson(firstname VARCHAR, lastname VARCHAR)
RETURNS void
AS $MAIN$
BEGIN
    INSERT INTO "Salesperson"
    (first_name, last_name)
    VALUES(firstname, lastname);
END;
$MAIN$
LANGUAGE p1pgsql;

SELECT add_salesperson('Pooh', 'Shiesty');
SELECT add_salesperson('Big', 'Cheese');
SELECT add_salesperson('Janet', 'Backwood');
SELECT add_salesperson('Pusha', 'P');
SELECT * FROM "Salesperson";

CREATE OR REPLACE FUNCTION add_car(car_id SERIAl, make VARCHAR, model VARCHAR, owners INTEGER, price NUMERIC, salesperson_id INTEGER);
RETURNS void
AS $MAIN$
BEGIN
    INSERT INTO "Car"
    (car_id, make, model, owners, price, salesperson_id)
    VALUES(make, model, price,)
END;
$MAIN$
LANGUAGE plpgsql;


SELECT add_car('Chevy', 'impala','3000',)
SELECT add_car('Kia', 'Forte', '6000')
SELECT add_car('Chevy', 'Cruze', '8000')
SELECT add_car('Chevy', 'Trailblazer', '7000')
SELECT add_car('Honda', 'Accord', '9000')
SELECT add_car('Dodge', 'Charger', '12000')


SELECT * FROM "Car";


CREATE OR REPLACE FUNCTION add_invoice(invoice_id SERIAL, car_id INTEGER, date DATETIME,customer_id INTEGER)
RETURN void
AS $MAIN$
BEGIN
    INSERT INTO "Invoice"
    (Car_id,customer_id,date)
    VALUES(car_id, invoice_id, date);
END;
$MAIN$
LANGUAGE plpgsql;


SELECT * FROM "Car";
SELECT add_invoice(3, 2,('2021/07/21'));
SELECT add_invoice(5, 2,('2023/01/27'));
SELECT add_invoice(7, 5, ('2023/01/01'));
SELECT add_invoice(8, 6, ('2022/05/11'));
SELECT * FROM "Invoice";


CREATE OR REPLACE FUNCTION add_Service_Ticket(service_id SERIAL, date DATETIME,customer_id INTEGER, car_id INTEGER, type VARCHAR(100), mechanic_id INTEGER, cost NUMERIC(10,2))
RETURNS void
AS $MAIN$
BEGIN
     INSERT INTO "Service_Ticket"
     (service_id, "cost", type)
     VALUES(serv_id, cost, type);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_Service_Ticket(1, 850.99, 'Replace broken radiator');
SELECT add_Service_Ticket(2, 100.00, 'Replace broken wipers');
SELECT add_Service_Ticket(3, 20.00, 'Lube wagon wheels');
SELECT add_Service_Ticket(4, 45.99, 'Oil change');

SELECT * FROM "Service_Ticket";

CREATE OR REPLACE FUNCTION add_Mechanic(firstname VARCHAR, lastname VARCHAR)
RETURNS void
AS $MAIN$
BEGIN
     INSERT INTO "Mechanic"
     (first_name, last_name)
     VALUES(firstname, lastname);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_Mechanic('Big', 'Dave');
SELECT add_Mechanic('Mike', 'Jones');
SELECT add_Mechanic('Tom', 'Brady');
SELECT add_Mechanic('Jackie', 'Chan');

SELECT * FROM "Mechanic";

CREATE OR REPLACE PROCEDURE checkPurchased()
LANGUAGE plpgsql
AS $$
BEGIN
    --Checks for whether car was purchased
    -- If it is not, set price to $0 as it was not bought at dealership
    UPDATE "Car"
    SET price = 00.00
    WHERE was_purchased = false;

    COMMIT;
END;
$$


SELECT * FROM "Car";

UPDATE "Car"
SET price = 999.99
WHERE was_purchased = false;

CALL checkPurchased();


SELECT * FROM "Car";



