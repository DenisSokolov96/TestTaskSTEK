-- ������� 1
/*�������� ������� select_orders_by_item_name. ��� �������� ���� �������� - ������������ ������� (������),
� ������ ����� ��� ������, � ������� ������� ������� � ������ �������������. ����� ����, ��� ������
���������� ���������� ������� � ��������� ������������� � ������ ��������� ������. ����������� ������
������� ������ ���� ������� � ����� ���������:

- order_id (row_id ������)
- customer (������������ ���������)
- items_count (���������� ������� � ������ ������������� � ���� ������)*/

USE TestTaskDB
/*
IF OBJECT_ID (N'stack.select_orders_by_item_name', N'IF') IS NOT NULL
    DROP FUNCTION stack.select_orders_by_item_name;

GO
CREATE FUNCTION stack.select_orders_by_item_name(@nameItem char(30)) 
	RETURNS @resFind TABLE
	(			
		order_id int,
		customer nvarchar(30),
		items_count int		
	)
	AS
	BEGIN	
		
		WITH table_row_id_Orders AS 			
			(SELECT DISTINCT order_id FROM OrderItems WHERE name = @nameItem),			
			
			table_customer_id__Orders AS 
			(SELECT customer_id,order_id FROM Orders, table_row_id_Orders WHERE table_row_id_Orders.order_id = row_id),

			table_name_Customers AS
			(SELECT name, order_id FROM Customers, table_customer_id__Orders WHERE table_customer_id__Orders.customer_id = row_id),			
			
			table_order_id_and_count AS 
			(SELECT ROW_NUMBER() OVER (ORDER BY order_id) id, order_id, COUNT(*) AS items_count 
			 FROM OrderItems
			 WHERE name = @nameItem
			 GROUP BY order_id)
			

		INSERT INTO @resFind 
		SELECT DISTINCT table_name_Customers.order_id, name, items_count 
		FROM table_name_Customers, table_order_id_and_count
		WHERE table_name_Customers.order_id = table_order_id_and_count.order_id
			
		
		RETURN
	END;
*/	

-- ������� 2
/*�������� ������� calculate_total_price_for_orders_group. ��� �������� row_id ������ (���� ������),
� ���������� ��������� ��������� ���� ������� ���� ������� � ���� ������ (������), ������ 
������������ ������ ����������� �� ����� ��������� �������, ������������� � ������ ������.
������� ������ ���������� �����.*/
/*
IF OBJECT_ID (N'stack.calculate_total_price_for_orders_group', N'IF') IS NOT NULL
    DROP FUNCTION stack.calculate_total_price_for_orders_group;

GO
CREATE FUNCTION stack.calculate_total_price_for_orders_group(@row_id_group Int) 
	RETURNS Int	
	AS
	BEGIN	
		WITH Recursive (row_id, parent_id, group_name) AS
			(SELECT row_id, parent_id, group_name
			 FROM Orders e
			 WHERE row_id = @row_id_group
			 UNION ALL
			 SELECT e.row_id, e.parent_id, e.group_name
			 FROM Orders e
			 JOIN Recursive r ON e.parent_id = r.row_id),
		tabel_row_parent AS (SELECT row_id, parent_id, group_name FROM Recursive r),
		newTable AS 
			(SELECT DISTINCT OrderItems.row_id, OrderItems.price
			 FROM OrderItems , tabel_row_parent			 
			 WHERE OrderItems.order_id = tabel_row_parent.row_id)
			
		SELECT @row_id_group = SUM(price) FROM newTable
		RETURN @row_id_group
	END;
*/

-- ������� 3
/*�������� ������, ������������ ������������ ���� �����������, � ������� ������ ����� � 2020 ���� ��������
��� ������� ���� �������� � ������������� "�������� �������".
����������� ���������� ������� �� �������� ������ ����� ������� � ����� ������� "������".*/

GO
SELECT newtable.name AS name_customer
FROM OrderItems, (	SELECT Orders.row_id, customer_id, name
					FROM Orders, Customers 
					WHERE YEAR(registered_at) = 2020 AND customer_id = Customers.row_id ) as newtable
WHERE OrderItems.order_id = newtable.row_id
GROUP BY newtable.name
HAVING COUNT(distinct order_id) != COUNT( 
					    distinct CASE 
									WHEN OrderItems.name = N'�������� �������' 
									THEN order_id 	
									ELSE 0
							  	 end)

