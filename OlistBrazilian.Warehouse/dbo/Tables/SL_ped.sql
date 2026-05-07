CREATE TABLE [dbo].[SL_ped] (

	[order_id] varchar(8000) NULL, 
	[customer_id] varchar(8000) NULL, 
	[order_status] varchar(8000) NULL, 
	[order_purchase_timestamp] date NULL, 
	[order_approved_at] date NULL, 
	[order_delivered_carrier_date] date NULL, 
	[order_delivered_customer_date] date NULL, 
	[order_estimated_delivery_date] date NULL
);