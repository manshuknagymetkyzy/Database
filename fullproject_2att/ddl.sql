create table stores(
store_id varchar primary key not null ,
name varchar,
city varchar,
address varchar,
start_time time,
end_time time
);
create index store_city on stores(store_id, city);

create table vendors(
vendor_id varchar primary key not null ,
name varchar
);

create table customers(
customer_id varchar primary key not null
);

create table purchases(
purchase_id varchar primary key not null ,
store_id varchar references stores(store_id) not null ,
customer_id varchar references customers(customer_id) not null ,
date date not null ,
time time not null ,
total_amount float not null
);

create table brand(
brand_id varchar primary key not null ,
name varchar
);

create table product_type(
type_id varchar primary key not null ,
name varchar ,
parent_typeid varchar references product_type(type_id),
brand_id varchar references brand(brand_id)
);

create table products(
upc_code varchar primary key not null ,
product_name varchar,
brand_id varchar references brand(brand_id),
type_id varchar references product_type(type_id),
size varchar,
package_type varchar
);

create table inventory(
store_id varchar references stores(store_id) not null ,
upc_code varchar references products(upc_code) not null ,
vendor_id varchar references vendors(vendor_id),
amount integer not null ,
price float not null,
primary key (store_id, upc_code)
);

create table products_in_purchases(
purchase_id varchar references purchases(purchase_id) not null ,
upc_code varchar references products(upc_code) not null ,
quantity integer not null ,
price float not null,
primary key(purchase_id, upc_code)
);
create index product_totalprice on products_in_purchases(upc_code, price);