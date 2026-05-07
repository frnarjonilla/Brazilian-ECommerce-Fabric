CREATE TABLE [dbo].[GD_fact_pedidos] (

	[id_pedido] varchar(8000) NULL, 
	[id_sesion_cliente] varchar(8000) NULL, 
	[estado_pedido] varchar(8000) NULL, 
	[fecha_compra] date NULL, 
	[fecha_aprobacion_pedido] date NULL, 
	[fecha_limite_envio] datetime2(6) NULL, 
	[fecha_recepcion_transportista] date NULL, 
	[fecha_entrega_estimada] date NULL, 
	[fecha_entrega_real] date NULL, 
	[id_vendedor] varchar(8000) NULL, 
	[id_producto] varchar(8000) NULL, 
	[id_articulo] varchar(8000) NULL, 
	[precio] float NULL, 
	[precio_envio] float NULL, 
	[precio_total] float NULL
);