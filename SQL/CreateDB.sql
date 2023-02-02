if object_id('dbo.OrderItems') is not null
   drop table dbo.OrderItems;
go

if object_id('dbo.Orders') is not null
   drop table dbo.Orders;
go

if object_id('dbo.Customers') is not null
   drop table dbo.Customers;
go



-- ���������
create table TestTaskDB.dbo.Customers
(
   row_id int identity not null,
   name nvarchar(max) not null,           -- ������������ ���������

   constraint PK_Customers
      primary key nonclustered(row_id)
);
go


create table dbo.Orders
(
   row_id int identity not null,
   parent_id int,                         -- row_id ������������ ������
   group_name nvarchar(max),              -- ������������ ������ �������
   customer_id int,                       -- row_id ���������
   registered_at date                     -- ���� ����������� ������

   constraint PK_Orders
      primary key nonclustered (row_id),
   constraint FK_Orders_Folder 
      foreign key (parent_id) 
      references dbo.Orders(row_id)
      on delete no action
      on update no action,
   constraint FK_Customers
      foreign key (customer_id)
      references dbo.Customers(row_id)
      on delete cascade
      on update cascade
);
go

-- ������� �������
create table dbo.OrderItems
(
   row_id int identity not null,
   order_id int not null,                 -- row_id ������
   name nvarchar(max) not null,           -- ������������ �������
   price int not null,                    -- ��������� ������� � ������

   constraint PK_OrderItems
      primary key nonclustered (row_id),
   constraint FK_OrderItems_Orders
      foreign key (order_id) 
      references dbo.Orders(row_id)
      on delete cascade
      on update cascade
);
go


insert into dbo.Customers                                                               -- 1
values(N'������');
insert into dbo.Customers                                                               -- 2
values(N'������');
insert into dbo.Customers                                                               -- 3
values(N'�������');
insert into dbo.Customers                                                               -- 4
values(N'�� �������');

insert into dbo.Orders(parent_id, group_name, customer_id, registered_at)               -- 1
values (null, N'��� ������', null, null);

   insert into dbo.Orders(parent_id, group_name, customer_id, registered_at)            -- 2
   values (1, N'������� ����', null, null);

      insert into dbo.Orders(parent_id, group_name, customer_id, registered_at)         -- 3
      values (2, N'����������', null, null);

         insert into dbo.Orders(parent_id, group_name, customer_id, registered_at)      -- 4
         values (3, null, 1, '2019/10/02');

         insert into dbo.Orders(parent_id, group_name, customer_id, registered_at)      -- 5
         values (3, null, 1, '2020/05/17');

       insert into dbo.Orders(parent_id, group_name, customer_id, registered_at)        -- 6
         values (3, null, 1, '2020/04/28');

       insert into dbo.Orders(parent_id, group_name, customer_id, registered_at)        -- 7
         values (3, null, 2, '2019/08/05');

       insert into dbo.Orders(parent_id, group_name, customer_id, registered_at)        -- 8
         values (3, null, 2, '2020/05/17');

       insert into dbo.Orders(parent_id, group_name, customer_id, registered_at)        -- 9
         values (3, null, 2, '2020/02/11');

      insert into dbo.Orders(parent_id, group_name, customer_id, registered_at)         -- 10
      values (2, N'����������', null, null);

         insert into dbo.Orders(parent_id, group_name, customer_id, registered_at)      -- 11
         values (10, null, 3, '2020/04/09');

   insert into dbo.Orders(parent_id, group_name, customer_id, registered_at)            -- 12
   values (1, N'����������� ����', null, null);

      insert into dbo.Orders(parent_id, group_name, customer_id, registered_at)         -- 13
      values (12, null, 4, '2020/06/25');

insert into dbo.OrderItems(order_id, name, price)
values (4, N'�������', 30);
insert into dbo.OrderItems(order_id, name, price)
values (4, N'����', 20);


insert into dbo.OrderItems(order_id, name, price)
values (5, N'�������', 50);
insert into dbo.OrderItems(order_id, name, price)
values (5, N'�������� �������', 40);
insert into dbo.OrderItems(order_id, name, price)
values (5, N'����', 30);


insert into dbo.OrderItems(order_id, name, price)
values (6, N'�������� �������', 30);
insert into dbo.OrderItems(order_id, name, price)
values (6, N'�������� �������', 40);


insert into dbo.OrderItems(order_id, name, price)
values (7, N'������������� �������', 50);
insert into dbo.OrderItems(order_id, name, price)
values (7, N'�����������', 10);
insert into dbo.OrderItems(order_id, name, price)
values (7, N'�������� �������', 60);


insert into dbo.OrderItems(order_id, name, price)
values (8, N'�������', 50);
insert into dbo.OrderItems(order_id, name, price)
values (8, N'�����������', 10);


insert into dbo.OrderItems(order_id, name, price)
values (9, N'���������� �������', 50);
insert into dbo.OrderItems(order_id, name, price)
values (9, N'�������� �������', 40);


insert into dbo.OrderItems(order_id, name, price)
values (11, N'������', 2);
insert into dbo.OrderItems(order_id, name, price)
values (11, N'�����', 1);


insert into dbo.OrderItems(order_id, name, price)
values (13, N'�����', 100);
insert into dbo.OrderItems(order_id, name, price)
values (13, N'������', 70);
insert into dbo.OrderItems(order_id, name, price)
values (13, N'����', 20);
go

