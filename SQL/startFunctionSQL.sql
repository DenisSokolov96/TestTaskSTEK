USE TestTaskDB;
/*
--Задание 1
GO
select * FROM stack.select_orders_by_item_name(N'Факс')
select * from stack.select_orders_by_item_name(N'Кассовый аппарат')
select * from stack.select_orders_by_item_name(N'Стулья')
*/

/*
--Задание 2
GO
select stack.calculate_total_price_for_orders_group(1) as total_price   -- 703, все заказы
select stack.calculate_total_price_for_orders_group(2) as total_price   -- 513, группа 'Частные лица'
select stack.calculate_total_price_for_orders_group(3) as total_price   -- 510, группа 'Оргтехника'
select stack.calculate_total_price_for_orders_group(12) as total_price  -- 190, группа 'Юридические лица'
select stack.calculate_total_price_for_orders_group(13) as total_price  -- 190, заказ 'ИП Федоров'
*/













