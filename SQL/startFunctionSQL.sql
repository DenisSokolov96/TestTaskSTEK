USE TestTaskDB;
/*
--������� 1
GO
select * FROM stack.select_orders_by_item_name(N'����')
select * from stack.select_orders_by_item_name(N'�������� �������')
select * from stack.select_orders_by_item_name(N'������')
*/

/*
--������� 2
GO
select stack.calculate_total_price_for_orders_group(1) as total_price   -- 703, ��� ������
select stack.calculate_total_price_for_orders_group(2) as total_price   -- 513, ������ '������� ����'
select stack.calculate_total_price_for_orders_group(3) as total_price   -- 510, ������ '����������'
select stack.calculate_total_price_for_orders_group(12) as total_price  -- 190, ������ '����������� ����'
select stack.calculate_total_price_for_orders_group(13) as total_price  -- 190, ����� '�� �������'
*/













