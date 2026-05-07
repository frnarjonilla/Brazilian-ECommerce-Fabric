CREATE TABLE [dbo].[BR_ped] (

	[order_id] varchar(8000) NULL, 
	[customer_id] varchar(8000) NULL, 
	[order_status] varchar(8000) NULL, 
	[order_purchase_timestamp] datetime2(6) NULL, 
	[order_approved_at] datetime2(6) NULL, 
	[order_delivered_carrier_date] datetime2(6) NULL, 
	[order_delivered_customer_date] datetime2(6) NULL, 
	[order_estimated_delivery_date] datetime2(6) NULL
);