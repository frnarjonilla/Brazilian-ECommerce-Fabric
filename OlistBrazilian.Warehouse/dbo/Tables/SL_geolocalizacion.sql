CREATE TABLE [dbo].[SL_geolocalizacion] (

	[geolocation_zip_code_prefix] bigint NULL, 
	[geolocation_lat] bigint NULL, 
	[geolocation_lng] bigint NULL, 
	[geolocation_city] varchar(8000) NULL, 
	[geolocation_state] varchar(8000) NULL
);