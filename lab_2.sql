-- 1

-- DDL is used to create the database schema.
-- DML is used to populate and manipulate database.
-- DDL commands CREATE, ALTER, DROP
-- DML commands INSERT, UPDATE, DELETE, SELECT

-- 2

create table customers
    (id integer NOT NULL UNIQUE ,
    full_name varchar(50) NOT NULL ,
    timestamp timestamp NOT NULL ,
    delivery_address text NOT NULL ,
    primary key (id));

create table orders
    (code integer NOT NULL UNIQUE ,
    customer_id integer REFERENCES customers (id),
    total_sum double precision NOT NULL CHECK ( total_sum > 0 ),
    is_paid boolean NOT NULL ,
    primary key (code));

create table products
    (id varchar NOT NULL UNIQUE ,
    name varchar NOT NULL UNIQUE ,
    description text,
    price double precision NOT NULL CHECK ( price > 0 ),
    primary key (id));

create table order_items
    (order_code integer NOT NULL UNIQUE REFERENCES orders (code),
    product_id varchar NOT NULL UNIQUE REFERENCES products (id) ,
    quantity integer NOT NULL CHECK ( quantity > 0 ),
    PRIMARY KEY(order_code, product_id));

-- 3

create table students
    (full_name varchar NOT NULL ,
    age integer NOT NULL ,
    birth_date date NOT NULL ,
    gender varchar NOT NULL ,
    gpa double precision NOT NULL ,
    information text NOT NULL ,
    need_for_dormitory boolean NOT NULL ,
    additional_info text,
    PRIMARY KEY (full_name));

create table instructors
    (full_name varchar NOT NULL ,
    possibility_for_rl boolean NOT NULL ,
    PRIMARY KEY (full_name));

create table languages
    (language varchar NOT NULL ,
    instructor varchar NOT NULL REFERENCES instructors(full_name),
    PRIMARY KEY (language, instructor));

create table experience
    (instructor varchar NOT NULL REFERENCES instructors(full_name),
    university varchar,
    PRIMARY KEY (instructor, university));

create table lesson_participants
    (lesson_title varchar NOT NULL ,
    instructor varchar NOT NULL REFERENCES instructors(full_name),
    students varchar NOT NULL REFERENCES students(full_name),
    room integer NOT NULL ,
    PRIMARY KEY (lesson_title));

--4

INSERT INTO customers VALUES (01, 'Manshuk Nagymetkyzy', '2021-09-22 23:23:26', 'Turgut Ozaly 70');
INSERT INTO products VALUES ('B10', 'bread', 'rye bread Aksai nan with raisins', 200.00);
INSERT INTO orders VALUES (1, 01, 200.00, true );
INSERT INTO order_items VALUES (1, 'B10', 1);

UPDATE customers SET delivery_address = 'Karimova 70' WHERE  delivery_address = 'Turgut Ozaly 70';
UPDATE products SET price = 250.00 WHERE id  = 'B10';
UPDATE orders SET total_sum = 500.00 WHERE customer_id = 01;
UPDATE order_items SET quantity = 2 WHERE order_code = 1;

DELETE FROM order_items WHERE order_code = 1;
DELETE FROM products WHERE id = 'B10';
DELETE FROM orders WHERE customer_id = 01;
DELETE FROM customers WHERE delivery_address = 'Karimova 70';