-- 1
-- SQL provides large-object data types for character data - clob, and binary data - blob.

-- 2.1
create role accountant;
grant select on transactions to accountant;

create role administrator;
grant insert, delete on accounts to administrator;

create role support;
grant update on transactions to support;

-- 2.2
create user user1;
create user user2;
create user user3;
grant accountant to user1;
grant administrator to user2;
grant support to user3;

-- 2.3
grant select on accounts to user2 with grant option;
grant select on transactions to user3 with grant option ;

-- 2.4
revoke select on accounts from user2 restrict;
revoke grant option for select on transactions from user3;

-- 3.2
alter table customers alter column id set not null;
alter table accounts alter column account_id set not null ;
alter table transactions alter column amount set not null ;

-- 5.1
create index account_index on accounts(account_id, currency);

-- 5.2
create index transaction_index on accounts(currency, balance);

do $$
    declare b int; l int;
-- 6.1
begin

-- 6.2
update accounts set balance = balance + 400 where account_id = 'NT10204';
update accounts set balance = balance - 400 where account_id = 'RS88012';

-- 6.3
    select balance into b from accounts where account_id = 'RS88012';
    select "limit" into l from accounts where account_id = 'RS88012';
    if b < l then rollback;

-- 6.4
    update transactions set status = 'rollback' where id = '3';
    else commit;
    update transactions set status = 'commited' where id = '3';
    end if;
end
$$

-- drop table accounts, customers, transactions;
-- drop user user1, user2, user3;
-- drop role accountant, administrator, support;
