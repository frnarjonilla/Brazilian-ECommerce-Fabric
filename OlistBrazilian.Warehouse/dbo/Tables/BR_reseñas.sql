CREATE TABLE [dbo].[BR_reseñas] (

	[review_id] varchar(8000) NULL, 
	[order_id] varchar(8000) NULL, 
	[review_score] bigint NULL, 
	[review_comment_title] varchar(8000) NULL, 
	[review_comment_message] varchar(8000) NULL, 
	[review_creation_date] datetime2(6) NULL, 
	[review_answer_timestamp] datetime2(6) NULL
);