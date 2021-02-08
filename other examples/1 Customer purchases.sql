use task_class;

create table customers 
(customers_id int,
customers_name varchar(20),
surname varchar(20),
constraint pk_customers primary key (customers_id));

create table companies  
(company_id int,
company_name varchar(20),
constraint pk_companies primary key (company_id));

create table orders  
(order_id int,
customers_id int,
company_id int,
constraint pk_orders primary key (order_id));

insert into customers values 
('1','Adam','Neely'),
('2','Helen', 'Cartner'),
('3','David','Joseph'),
('4','Jane','Aversen');

insert into orders values 
('1','1','1'),
('2','1', '2'),
('3','2','1'),
('4','2','2'),
('5','2','3'),
('6','3', '1'),
('7','3','1'),
('8','3','2'),
('9','3','4');

insert into companies values 
('1','Tesla'),
('2','SpaceX'),
('3','The Boring Company'),
('4','PayPal');

alter table orders                                             
add constraint fk_orders_customers_id
foreign key (customers_id) references customers (customers_id);

alter table orders                                             
add constraint fk_orders_company_id
foreign key (company_id) references companies  (company_id);

select customers_name as customer_name
from customers
where customers_id not in (select customers_id from orders where company_id = 3) 
	  and   
      customers_id in (select customers_id from orders where company_id <= 2)				
order by customers_id  desc;
