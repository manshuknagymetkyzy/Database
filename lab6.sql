-- 1a
select  * from dealer inner join client on dealer.id = client.dealer_id;

-- 1b
select dealer.name, client.name, city, priority, sell.id, date, amount from dealer inner join client
    on dealer.id = client.dealer_id inner join sell on client.id = sell.client_id;

-- 1c
select * from dealer inner join client on dealer.location = client.city;

-- 1d
select sell.id, amount, name, city from client inner join sell on client.id = sell.client_id and
sell.dealer_id = client.dealer_id and amount >= 100 and amount <= 150;

-- 1e
select * from dealer left join client on dealer.id = client.dealer_id;

-- 1f
select client.name, city, dealer.name, charge from client inner join dealer on dealer.id = client.dealer_id;

-- 1g
select client.name, city, dealer.name, charge from client inner join dealer on dealer.id = client.dealer_id and
                                                                               charge > 0.12;

-- 1h
select client.name, city, sell.id, date, amount, dealer.name, charge from client full join sell on
    client.id = sell.client_id full join dealer on client.dealer_id = dealer.id;

-- 1i
select client.name, priority, dealer.name, sell.id, amount from sell inner join client on sell.client_id = client.id
left join dealer on sell.dealer_id = dealer.id where priority is not null
group by client.name, client.priority, dealer.name, sell.id having sum(amount) > 2000;

-- 2a
create view a as select date, count(id), avg(amount), sum(amount) from sell group by date;
select * from a;

-- 2b
create view b as select date, sum(amount) as "total" from sell group by date order by total desc limit 5;
select * from b;

-- 2c
create view c as select name, count(sell.id), avg(amount), sum(amount) from dealer inner join sell
    on dealer.id = sell.dealer_id group by name;
select * from c;

-- 2d
create view d as select location, sum(amount * charge) from dealer inner join sell on dealer.id = sell.dealer_id
group by location;
select * from d;

-- 2e
create view e as select location, count(sell.id), avg(amount * (charge + 1) ), sum(amount * (charge + 1)) as "total"
from dealer inner join sell on dealer.id = sell.dealer_id group by location;
select * from e;

-- 2f
create view f as select city, count(sell.id), avg(amount * (charge + 1)), sum(amount * (charge + 1)) as "total"
from client inner join sell on client.id = sell.client_id inner join dealer on sell.dealer_id = dealer.id group by city;
select * from f;

-- 2g
create view g as select city, e.total as "sales", f.total as "expenses" from f full outer join e on city = location
where f.total > e.total;
select * from g;