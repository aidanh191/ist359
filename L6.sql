create view v_fudgemart_employee_managers as
select * from fudgemart_employees
where employee_id in (
select employee_supervisor_id from
fudgemart_employees)

select employee_firstname + ' ' + employee_lastname as employee_name, employee_jobtitle, employee_department, employee_hourlywage
from v_fudgemart_employee_managers
where employee_hourlywage > 17.00 and employee_jobtitle != 'CEO'

create procedure p_fudgemart_markup_retail_by_department (
@dept varchar(20),
@amount money
)
as
begin
	update fudgemart_products
	set product_retail_price= (product_retail_price + @amount)
	where product_department=@dept
end

execute p_fudgemart_markup_retail_by_department 'Clothing', 2.50
execute p_fudgemart_markup_retail_by_department 'Hardware', 3.75

create procedure p_fudgemart_deactivate_product(
@id int
)
as
begin
	update fudgemart_products
	set product_is_active = 0
	where product_id=@id
end

declare @product_id int
execute @product_id = p_fudgemart_add_product
	@product_name='Monkey-Wrench',
	@product_department='Hardware',
	@product_retail_price=12.95,
	@product_wholesale_price=6.95,
	@product_vendor_id=3

execute p_fudgemart_deactivate_product 54
execute p_fudgemart_deactivate_product 55

select product_name
from v_fudgemart_display_active_products
where product_department = 'Hardware'

create view v_fudgemart_vendors as
select vendor_id, vendor_website, vendor_phone, vendor_name, count(product_name) as product_count 
from fudgemart_vendors left join fudgemart_products on vendor_id=product_vendor_id
group by vendor_id, vendor_name, vendor_phone, vendor_website

select * from v_fudgemart_vendors
where product_count>10
