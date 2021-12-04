select product_name, count(products_in_purchases.upc_code) * products_in_purchases.quantity as "totalamount" from
products_in_purchases inner join purchases p on p.purchase_id = products_in_purchases.purchase_id inner join products p2
on products_in_purchases.upc_code = p2.upc_code and store_id = 'NSF57' group by
products_in_purchases.upc_code, quantity, product_name order by totalamount desc limit 20;

select product_name, count(products_in_purchases.upc_code) * products_in_purchases.quantity as "totalamount" from
products_in_purchases inner join purchases p on p.purchase_id = products_in_purchases.purchase_id inner join products p2
on products_in_purchases.upc_code = p2.upc_code and store_id = 'NSF63' group by
quantity, product_name, products_in_purchases.upc_code order by totalamount desc limit 20;

select product_name, count(products_in_purchases.upc_code) * products_in_purchases.quantity as "totalamount" from
products_in_purchases inner join purchases p on p.purchase_id = products_in_purchases.purchase_id inner join products p2
on products_in_purchases.upc_code = p2.upc_code and store_id = 'TZF1' group by
products_in_purchases.upc_code, quantity, product_name order by totalamount desc limit 20;

select product_name, count(products_in_purchases.upc_code) * products_in_purchases.quantity as "totalamount" from
products_in_purchases inner join purchases p on p.purchase_id = products_in_purchases.purchase_id inner join products p2
on products_in_purchases.upc_code = p2.upc_code and store_id = 'SF12' group by
quantity, product_name, products_in_purchases.upc_code order by totalamount desc limit 20;

select product_name, count(products_in_purchases.upc_code) * products_in_purchases.quantity as "totalamount" from
products_in_purchases inner join purchases p on p.purchase_id = products_in_purchases.purchase_id inner join products p2
on products_in_purchases.upc_code = p2.upc_code and store_id = 'SF1' group by
quantity, product_name, products_in_purchases.upc_code order by totalamount desc limit 20;

select product_name, count(products_in_purchases.upc_code) * products_in_purchases.quantity as "totalamount" from
products_in_purchases inner join purchases p on p.purchase_id = products_in_purchases.purchase_id inner join products p2
on products_in_purchases.upc_code = p2.upc_code inner join stores s on p.store_id = s.store_id and s.store_id like 'NSF%'
group by quantity, product_name, products_in_purchases.upc_code order by totalamount desc limit 20;

select product_name, count(products_in_purchases.upc_code) * products_in_purchases.quantity as "totalamount" from
products_in_purchases inner join purchases p on p.purchase_id = products_in_purchases.purchase_id inner join products p2
on products_in_purchases.upc_code = p2.upc_code inner join stores s on p.store_id = s.store_id and s.store_id like 'TZF%'
group by quantity, product_name, products_in_purchases.upc_code order by totalamount desc limit 20;

select product_name, count(products_in_purchases.upc_code) * products_in_purchases.quantity as "totalamount" from
products_in_purchases inner join purchases p on p.purchase_id = products_in_purchases.purchase_id inner join products p2
on products_in_purchases.upc_code = p2.upc_code inner join stores s on p.store_id = s.store_id and s.store_id like 'SF%'
group by quantity, product_name, products_in_purchases.upc_code order by totalamount desc limit 20;

select stores.store_id, name, sum(total_amount) as "sales" from stores inner join purchases p on stores.store_id = p.store_id
group by stores.store_id, name order by sales desc limit 5;

create view Coke as select store_id, sum(pip.price) as "Cokesales" from purchases inner join products_in_purchases pip on
purchases.purchase_id = pip.purchase_id inner join products p on p.upc_code = pip.upc_code and brand_id = 'B01'
group by store_id;
create view Pepsi as select store_id, sum(pip.price) as "Pepsisales" from purchases inner join products_in_purchases pip on
purchases.purchase_id = pip.purchase_id inner join products p on p.upc_code = pip.upc_code and brand_id = 'B03'
group by store_id;
select p.store_id, "Cokesales", "Pepsisales" from Coke inner join Pepsi P on Coke.store_id = P.store_id where
"Cokesales" > "Pepsisales";

select product_name, count(pip.upc_code) as "total" from products inner join products_in_purchases pip on products.upc_code = pip.upc_code inner join
purchases p on p.purchase_id = pip.purchase_id and p.purchase_id in (select p.purchase_id from products_in_purchases
where products_in_purchases.upc_code = 'P010108') and pip.upc_code != 'P010108' group by product_name order by total desc limit 3;

select name, count(pip.purchase_id) as "total" from products inner join products_in_purchases pip on products.upc_code = pip.upc_code inner join
purchases p on p.purchase_id = pip.purchase_id inner join product_type pt on products.type_id = pt.type_id and
p.purchase_id in (select p.purchase_id from products_in_purchases
where products_in_purchases.upc_code = 'P010108') and pip.upc_code != 'P010108' group by name order by total desc limit 3;
