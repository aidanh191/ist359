/*************************/
/* 1                     */
/*************************/
/*Aidan Harrington*/

GO

/*************************/
/* 2                     */
/*************************/
create table pizza_orders(
order_id int identity (1,1) not null,
order_crust varchar (20) not null,
order_size varchar (20) not null,
order_cost money not null,
order_date date not null)

GO

/*************************/
/* 3                     */
/*************************/
insert into pizza_orders(order_crust, order_size, order_cost, order_date) values
('thin', 'small', 12.50, '9/30/2022'),
('deep dish', 'small', 12.50, '9/21/2022'),
('detroit', 'large', 14.00, '9/25/2022')


GO

/*************************/
/* 4                     */
/*************************/
alter table pizza_orders
add constraint foreign key pizza_orders(fk_toppings) references toppings(toppings_id)

GO

/*************************/
/* 5                     */
/*************************/
select * from pizza_orders
where order_date > GETDATE()


GO