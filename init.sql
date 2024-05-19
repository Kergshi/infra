-------------    USERS   ------------------------
CREATE DATABASE users WITH ENCODING = 'UTF8';

\connect users;

CREATE TABLE users (
	id BIGSERIAL PRIMARY KEY,
	name VARCHAR(255),
	email VARCHAR(255),
	phone VARCHAR(30)
);



-----------------   ORDERS ------------------------
CREATE DATABASE orders WITH ENCODING = 'UTF8';

\connect orders;

CREATE TYPE order_status AS ENUM ('collecting', 'inpaid', 'delivering', 'delivered');

CREATE TABLE orders (
	id BIGSERIAL PRIMARY KEY,
	user_id BIGINT NOT NULL,
	address VARCHAR(255) NOT NULL,
	totalcost NUMERIC NOT NULL,
	status order_status
);

CREATE TABLE order_foods (
	order_id BIGINT REFERENCES orders(id) NOT NULL,
	food_id BIGINT NOT NULL,
	amount BIGINT NOT NULL
);

--------------- PAYMENTS  ---------------------------

CREATE DATABASE payments WITH ENCODING = 'UTF8';

\connect payments;

CREATE TABLE payments (
	user_id BIGINT NOT NULL,
	order_id BIGINT NOT NULL,
	totalcost NUMERIC NOT NULL,
	payment_time TIMESTAMP NOT NULL
);

----------------- FOODS ----------------------------

CREATE DATABASE foods WITH ENCODING = 'UTF8';

\connect foods;

CREATE TABLE foods (
	id BIGSERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	cost NUMERIC NOT NULL
);


-------------------- DELIVERY ------------------------

CREATE DATABASE delivery WITH ENCODING = 'UTF8';

\connect delivery;

CREATE TYPE delivery_status AS ENUM ('delivering', 'delivered');

CREATE TABLE couriers (
	id BIGSERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL,
	phone VARCHAR(30) NOT NULL
);

CREATE TABLE deliveries (
	id BIGSERIAL PRIMARY KEY,
	courier_id BIGINT REFERENCES couriers(id) NOT NULL,
	order_id BIGINT NOT NULL,
	address VARCHAR(255) NOT NULL,
	delivery_start TIMESTAMP,
	delivery_end TIMESTAMP,
	status delivery_status
);
