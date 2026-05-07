CREATE TABLE [dbo].[GD_reseñas] (

	[id_reseña] varchar(8000) NULL, 
	[id_pedido] varchar(8000) NULL, 
	[puntuacion_reseña] bigint NULL, 
	[titulo_reseña] varchar(8000) NULL, 
	[comentario_reseña] varchar(8000) NULL, 
	[fecha_reseña] date NULL, 
	[fecha_respuesta_reseña] date NULL
);