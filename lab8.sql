-- 1a
create function inc(val integer) returns integer as $$
begin
return val + 1;
end; $$
language plpgsql;
select inc(5);

-- 1b
create function get_sum(a numeric, b numeric) returns numeric as $$
begin
return a + b;
end; $$
language plpgsql;
select get_sum(4, 6);

-- 1c
create function div_two(x integer) returns boolean as $$
begin
if(x % 2 = 0) then return true;
else return false;
end if;
end; $$
language plpgsql;
select div_two(4);
select div_two(3);

-- 1d
create function password(p varchar, out ok boolean) as $$
begin
if length(p) < 8 then ok = false;
else ok = true;
end if;
end;
$$
language plpgsql;
select password('1fgdgdvaa9');

-- 1e
create function inc_dec(val integer, out inc integer, out de integer) as $$
begin
inc := val + 1;
de := val - 1;
end; $$
language plpgsql;
select * from inc_dec(5);

--2a
create table emp(
empname text,
salary integer,
experience integer,
discount integer,
birth_date date,
age integer,
price integer,
password varchar,
val integer,
taskd boolean,
taske integer,
last_date timestamp
);
create function emp_stamp() returns trigger language plpgsql as $$
begin
if new.empname is null then raise exception 'empname cannot be null';
end if;
if new.salary is null then
raise exception '% cannot have null salary', new.empname;
end if ;
new.last_date := current_timestamp;
return new;
end;
$$;
create trigger emp_stamp before insert or update on emp for each row execute function emp_stamp();

-- 2b
create function compute_age() returns trigger language plpgsql as $$
begin
if new.birth_date is null then raise exception 'birth_date cannot be null';
end if;
new.age := round((current_date - new.birth_date) / 365.25);
return new;
end;
$$;
create trigger compute_age before insert or update on emp for each row execute function compute_age();

-- 2с
create function add_tax() returns trigger language plpgsql as $$
begin
if new.price is null then raise exception 'price cannot be null';
end if ;
new.price := 1.12 * new.price;
return new;
end;
$$;
create trigger add_tax before insert or update on emp for each row execute function add_tax();

-- 2d
create function prevent_del() returns trigger language plpgsql as $$
begin
raise exception 'this row cannot be deleted';
end;
$$;
create trigger prevent_del before delete on emp for each row execute function prevent_del();

--2e
create function two_func() returns trigger language plpgsql as $$
begin
if password(new.password) = true then
new.taskd := true;
new.taske := inc_dec(new.val);
end if;
return new;
end;
$$;
create trigger launch after insert on emp for each row execute function two_func();

-- 3
-- A function returns a value and a procedure just executes commands.

--4a
create table empl(
id integer primary key ,
name varchar,
date_of_birth date,
age integer,
salary integer,
workexperience integer,
discount integer
);

create or replace procedure task_a() as $$
begin
update empl set salary = 1.1 * salary * (empl.workexperience / 2) and empl.discount =
(discount * (empl.workexperience / 2)) + 10 where empl.workexperience > 2;
update empl set discount = (discount * (empl.workexperience/5)) + 1 where empl.workexperience > 5;
end;
$$
language plpgsql;

--4b
create or replace procedure task_b() as $$
begin
update empl set salary = 1.15 * salary where age >= 40;
update empl set salary = 1.15 * salary and discount = 20 where empl.workexperience > 8;
end;
$$ language plpgsql;

-- 5
create table members(
memid integer primary key ,
surname character varying(200),
firstname character varying(200),
address character varying(300),
zipcode integer,
telephone character varying(20),
recommendedby integer references members(memid),
joindate timestamp
);
create table facilities(
facid integer primary key ,
name character varying(100),
membercost numeric,
guestcost numeric,
initialoutlay numeric,
monthlymaintenance numeric
);
create table bookings(
facid integer references facilities(facid),
memid integer references members(memid),
starttime timestamp,
slots integer
);
with recursive recommenders(recommender, member) as(
select recommendedby, memid from members union select members.recommendedby, members.memid from recommenders
inner join members on members.recommendedby = recommenders.member
)
select * from recommenders where member = 22 or member = 12 order by recommender desc, member asc;