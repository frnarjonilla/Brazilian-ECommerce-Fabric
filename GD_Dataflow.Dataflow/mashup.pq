[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "SL_clientes_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "id_sesion_cliente", DestinationColumnName = "id_sesion_cliente"], [SourceColumnName = "id_cliente", DestinationColumnName = "id_cliente"], [SourceColumnName = "cp_cliente", DestinationColumnName = "cp_cliente"], [SourceColumnName = "ciudad_cliente", DestinationColumnName = "ciudad_cliente"], [SourceColumnName = "estado_cliente", DestinationColumnName = "estado_cliente"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared SL_clientes = let
  Origen = Fabric.Warehouse([HierarchicalNavigation = null]),
  #"Navegación 1" = Origen{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Schema = "dbo", Item = "SL_clientes"]}[Data],
  #"Columnas con nombre cambiado" = Table.RenameColumns(#"Navegación 3", {{"customer_id", "id_sesion_cliente"}}),
  #"Filas ordenadas" = Table.Sort(#"Columnas con nombre cambiado", {{"customer_unique_id", Order.Descending}}),
  #"Columnas con nombre cambiado 1" = Table.RenameColumns(#"Filas ordenadas", {{"customer_unique_id", "id_cliente"}, {"customer_zip_code_prefix", "cp_cliente"}, {"customer_city", "ciudad_cliente"}, {"customer_state", "estado_cliente"}}),
  #"Duplicados quitados" = Table.Distinct(#"Columnas con nombre cambiado 1", {"id_sesion_cliente"}),
  #"Filas ordenadas 1" = Table.Sort(#"Duplicados quitados", {{"id_cliente", Order.Ascending}})
in
  #"Filas ordenadas 1";
shared SL_geolocalizacion = let
  Origen = Fabric.Warehouse([HierarchicalNavigation = null]),
  #"Navegación 1" = Origen{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Schema = "dbo", Item = "SL_geolocalizacion"]}[Data],
  #"Duplicados quitados" = Table.Distinct(#"Navegación 3", {"geolocation_zip_code_prefix"})
in
  #"Duplicados quitados";
shared SL_ped = let
  Origen = Fabric.Warehouse([HierarchicalNavigation = null]),
  #"Navegación 1" = Origen{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Schema = "dbo", Item = "SL_ped"]}[Data],
  #"Filas ordenadas" = Table.Sort(#"Navegación 3", {{"order_id", Order.Ascending}}),
  #"Duplicados quitados" = Table.Distinct(#"Filas ordenadas", {"order_id"})
in
  #"Duplicados quitados";
shared SL_pedidos_items = let
  Origen = Fabric.Warehouse([HierarchicalNavigation = null]),
  #"Navegación 1" = Origen{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Schema = "dbo", Item = "SL_pedidos_item"]}[Data],
  #"Duplicados quitados" = Table.Distinct(#"Navegación 3", {"order_id"})
in
  #"Duplicados quitados";
shared SL_productos = let
  Origen = Fabric.Warehouse([HierarchicalNavigation = null]),
  #"Navegación 1" = Origen{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Schema = "dbo", Item = "SL_productos"]}[Data],
  #"Texto recortado" = Table.TransformColumns(#"Navegación 3", {{"product_category_name", each Text.Trim(_), type nullable text}})
in
  #"Texto recortado";
shared SL_traduccion_categoria = let
  Origen = Fabric.Warehouse([HierarchicalNavigation = null]),
  #"Navegación 1" = Origen{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Schema = "dbo", Item = "SL_traduccion_categoria"]}[Data],
  #"Encabezados promovidos" = Table.PromoteHeaders(#"Navegación 3", [PromoteAllScalars = true]),
  #"Texto recortado" = Table.TransformColumns(#"Encabezados promovidos", {{"product_category_name", each Text.Trim(_), type nullable text}}),
  #"Mayúsculas aplicadas en cada palabra" = Table.TransformColumns(#"Texto recortado", {{"product_category_name", each Text.Proper(_), type nullable text}})
in
  #"Mayúsculas aplicadas en cada palabra";
shared SL_vendedores = let
  Origen = Fabric.Warehouse([HierarchicalNavigation = null]),
  #"Navegación 1" = Origen{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Schema = "dbo", Item = "SL_vendedores"]}[Data]
in
  #"Navegación 3";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "SL_ordenes_pago_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "order_id", DestinationColumnName = "order_id"], [SourceColumnName = "payment_sequential", DestinationColumnName = "payment_sequential"], [SourceColumnName = "payment_type", DestinationColumnName = "payment_type"], [SourceColumnName = "payment_installments", DestinationColumnName = "payment_installments"], [SourceColumnName = "payment_value", DestinationColumnName = "payment_value"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared SL_ordenes_pago = let
  Origen = Fabric.Warehouse([HierarchicalNavigation = null]),
  #"Navegación 1" = Origen{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Schema = "dbo", Item = "SL_ordenes_pago"]}[Data],
  #"Filas ordenadas" = Table.Sort(#"Navegación 3", {{"order_id", Order.Ascending}}),
  #"Duplicados quitados" = Table.Distinct(#"Filas ordenadas", {"order_id"})
in
  #"Duplicados quitados";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "SL_reseñas_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "id_reseña", DestinationColumnName = "id_reseña"], [SourceColumnName = "id_pedido", DestinationColumnName = "id_pedido"], [SourceColumnName = "puntuacion_reseña", DestinationColumnName = "puntuacion_reseña"], [SourceColumnName = "titulo_reseña", DestinationColumnName = "titulo_reseña"], [SourceColumnName = "comentario_reseña", DestinationColumnName = "comentario_reseña"], [SourceColumnName = "fecha_reseña", DestinationColumnName = "fecha_reseña"], [SourceColumnName = "fecha_respuesta_reseña", DestinationColumnName = "fecha_respuesta_reseña"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared SL_reseñas = let
  Origen = Fabric.Warehouse([HierarchicalNavigation = null]),
  #"Navegación 1" = Origen{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Schema = "dbo", Item = "SL_reseñas"]}[Data],
  #"Columnas con nombre cambiado" = Table.RenameColumns(#"Navegación 3", {{"review_id", "id_reseña"}}),
  #"Duplicados quitados" = Table.Distinct(#"Columnas con nombre cambiado", {"id_reseña"}),
  #"Columnas con nombre cambiado 1" = Table.RenameColumns(#"Duplicados quitados", {{"order_id", "id_pedido"}, {"review_score", "puntuacion_reseña"}, {"review_comment_title", "titulo_reseña"}, {"review_comment_message", "comentario_reseña"}, {"review_creation_date", "fecha_reseña"}, {"review_answer_timestamp", "fecha_respuesta_reseña"}})
in
  #"Columnas con nombre cambiado 1";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "GD_pedidos_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "id_pedido", DestinationColumnName = "id_pedido"], [SourceColumnName = "id_sesion_cliente", DestinationColumnName = "id_sesion_cliente"], [SourceColumnName = "estado_pedido", DestinationColumnName = "estado_pedido"], [SourceColumnName = "fecha_compra", DestinationColumnName = "fecha_compra"], [SourceColumnName = "fecha_aprobacion_pedido", DestinationColumnName = "fecha_aprobacion_pedido"], [SourceColumnName = "fecha_limite_envio", DestinationColumnName = "fecha_limite_envio"], [SourceColumnName = "fecha_recepcion_transportista", DestinationColumnName = "fecha_recepcion_transportista"], [SourceColumnName = "fecha_entrega_estimada", DestinationColumnName = "fecha_entrega_estimada"], [SourceColumnName = "fecha_entrega_real", DestinationColumnName = "fecha_entrega_real"], [SourceColumnName = "id_vendedor", DestinationColumnName = "id_vendedor"], [SourceColumnName = "id_producto", DestinationColumnName = "id_producto"], [SourceColumnName = "id_articulo", DestinationColumnName = "id_articulo"], [SourceColumnName = "precio", DestinationColumnName = "precio"], [SourceColumnName = "precio_envio", DestinationColumnName = "precio_envio"], [SourceColumnName = "precio_total", DestinationColumnName = "precio_total"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared GD_pedidos = let
  Origen = Table.NestedJoin(SL_ped, {"order_id"}, SL_pedidos_items, {"order_id"}, "SL_pedidos_items", JoinKind.LeftOuter),
  #"join ped y pedidos item" = Table.ExpandTableColumn(Origen, "SL_pedidos_items", {"order_item_id", "product_id", "seller_id", "shipping_limit_date", "price", "freight_value"}, {"order_item_id", "product_id", "seller_id", "shipping_limit_date", "price", "freight_value"}),
  #"Personalizado agregado" = Table.TransformColumnTypes(Table.AddColumn(#"join ped y pedidos item", "Personalizado", each [price] + [freight_value]), {{"Personalizado", type number}}),
  #"Columnas con nombre cambiado" = Table.RenameColumns(#"Personalizado agregado", {{"Personalizado", "percio_total"}, {"order_id", "id_pedido"}, {"customer_id", "id_sesion_cliente"}, {"order_status", "estado_pedido"}, {"order_purchase_timestamp", "fecha_compra"}, {"order_approved_at", "fecha_aprobacion_pedido"}, {"order_delivered_carrier_date", "fecha_recepcion_transportista"}, {"order_delivered_customer_date", "fecha_entrega_real"}, {"order_estimated_delivery_date", "fecha_entrega_estimada"}}),
  #"Columnas reordenadas" = Table.ReorderColumns(#"Columnas con nombre cambiado", {"id_pedido", "id_sesion_cliente", "estado_pedido", "fecha_compra", "fecha_aprobacion_pedido", "fecha_recepcion_transportista", "fecha_entrega_estimada", "fecha_entrega_real", "order_item_id", "product_id", "seller_id", "shipping_limit_date", "price", "freight_value", "percio_total"}),
  #"Columnas con nombre cambiado 1" = Table.RenameColumns(#"Columnas reordenadas", {{"order_item_id", "id_articulo"}, {"product_id", "id_producto"}, {"seller_id", "id_vendedor"}, {"shipping_limit_date", "fecha_limite_envio"}}),
  #"Columnas reordenadas 1" = Table.ReorderColumns(#"Columnas con nombre cambiado 1", {"id_pedido", "id_sesion_cliente", "estado_pedido", "fecha_compra", "fecha_aprobacion_pedido", "fecha_limite_envio", "fecha_recepcion_transportista", "fecha_entrega_estimada", "fecha_entrega_real", "id_vendedor", "id_producto", "id_articulo", "price", "freight_value", "percio_total"}),
  #"Columnas con nombre cambiado 2" = Table.RenameColumns(#"Columnas reordenadas 1", {{"price", "precio"}, {"freight_value", "precio_envio"}}),
  #"Filas ordenadas" = Table.Sort(#"Columnas con nombre cambiado 2", {{"id_pedido", Order.Ascending}}),
  #"Duplicados quitados" = Table.Distinct(#"Filas ordenadas", {"id_pedido"}),
  Personalizado = #"Duplicados quitados",
  #"Duplicados quitados 1" = Table.Distinct(Personalizado),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Duplicados quitados 1", {{"fecha_limite_envio", type datetime}}),
  #"Columnas con nombre cambiado 3" = Table.RenameColumns(#"Tipo de columna cambiado", {{"percio_total", "precio_total"}})
in
  #"Columnas con nombre cambiado 3";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "GD_vendedores_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "id_vendedor", DestinationColumnName = "id_vendedor"], [SourceColumnName = "cp_vendedor", DestinationColumnName = "cp_vendedor"], [SourceColumnName = "ciudad_vendedor", DestinationColumnName = "ciudad_vendedor"], [SourceColumnName = "estado_vendedor", DestinationColumnName = "estado_vendedor"], [SourceColumnName = "latitud", DestinationColumnName = "latitud"], [SourceColumnName = "longitud", DestinationColumnName = "longitud"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared GD_vendedores = let
  Origen = Table.NestedJoin(SL_vendedores, {"seller_zip_code_prefix"}, SL_geolocalizacion, {"geolocation_zip_code_prefix"}, "SL_geolocalizacion", JoinKind.LeftOuter),
  #"SL_geolocalizacion expandido" = Table.ExpandTableColumn(Origen, "SL_geolocalizacion", {"geolocation_lat", "geolocation_lng"}, {"geolocation_lat", "geolocation_lng"}),
  #"Duplicados quitados" = Table.Distinct(#"SL_geolocalizacion expandido", {"seller_id"}),
  #"Columnas con nombre cambiado" = Table.RenameColumns(#"Duplicados quitados", {{"seller_id", "id_vendedor"}, {"seller_zip_code_prefix", "cp_vendedor"}, {"seller_city", "ciudad_vendedor"}, {"seller_state", "estado_vendedor"}, {"geolocation_lat", "latitud"}, {"geolocation_lng", "longitud"}})
in
  #"Columnas con nombre cambiado";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "GD_prod_cat_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "id_producto", DestinationColumnName = "id_producto"], [SourceColumnName = "nombre_categoría", DestinationColumnName = "nombre_categoría"], [SourceColumnName = "longitud_descripcion", DestinationColumnName = "longitud_descripcion"], [SourceColumnName = "numero_fotos", DestinationColumnName = "numero_fotos"], [SourceColumnName = "peso_producto_gr", DestinationColumnName = "peso_producto_gr"], [SourceColumnName = "longitud_producto_cm", DestinationColumnName = "longitud_producto_cm"], [SourceColumnName = "altura_producto_cm", DestinationColumnName = "altura_producto_cm"], [SourceColumnName = "ancho_producto_cm", DestinationColumnName = "ancho_producto_cm"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared GD_prod_cat = let
  Origen = Table.NestedJoin(SL_productos, {"product_category_name"}, SL_traduccion_categoria, {"product_category_name"}, "SL_traduccion_categoria", JoinKind.LeftOuter),
  #"SL_traduccion_categoria expandido" = Table.ExpandTableColumn(Origen, "SL_traduccion_categoria", {"Product_Category_Name_English"}, {"Product_Category_Name_English"}),
  #"Columnas quitadas" = Table.RemoveColumns(#"SL_traduccion_categoria expandido", {"product_category_name"}),
  #"Columnas reordenadas" = Table.ReorderColumns(#"Columnas quitadas", {"product_id", "Product_Category_Name_English", "product_name_lenght", "product_description_lenght", "product_photos_qty", "product_weight_g", "product_length_cm", "product_height_cm", "product_width_cm"}),
  #"Columnas con nombre cambiado" = Table.RenameColumns(#"Columnas reordenadas", {{"product_id", "id_producto"}, {"Product_Category_Name_English", "nombre_categoría"}}),
  #"Columnas quitadas 1" = Table.RemoveColumns(#"Columnas con nombre cambiado", {"product_name_lenght"}),
  #"Duplicados quitados" = Table.Distinct(#"Columnas quitadas 1", {"id_producto"}),
  #"Columnas con nombre cambiado 1" = Table.RenameColumns(#"Duplicados quitados", {{"product_description_lenght", "longitud_descripcion"}, {"product_photos_qty", "numero_fotos"}, {"product_weight_g", "peso_producto_gr"}, {"product_length_cm", "longitud_producto_cm"}, {"product_height_cm", "altura_producto_cm"}, {"product_width_cm", "ancho_producto_cm"}})
in
  #"Columnas con nombre cambiado 1";
shared SL_clientes_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "GD_clientes", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared SL_reseñas_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "GD_reseñas", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared GD_vendedores_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "GD_dim_vendedores", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared GD_prod_cat_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "GD_dim_prod_cat", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "GD_dim_calendario_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "Fecha", DestinationColumnName = "Fecha"], [SourceColumnName = "Año", DestinationColumnName = "Año"], [SourceColumnName = "Mes", DestinationColumnName = "Mes"], [SourceColumnName = "Mes_Numero", DestinationColumnName = "Mes_Numero"], [SourceColumnName = "Trimestre", DestinationColumnName = "Trimestre"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared GD_dim_calendario = let
    StartDate = #date(2016, 1, 1),
    EndDate = #date(2018, 12, 31),
    NumberOfDays = Duration.Days(EndDate - StartDate) + 1,
    Dates = List.Dates(StartDate, NumberOfDays, #duration(1, 0, 0, 0)),
    TableFromList = Table.FromList(Dates, Splitter.SplitByNothing(), {"Fecha"}, null, ExtraValues.Error),
    ChangedType = Table.TransformColumnTypes(TableFromList,{{"Fecha", type date}}),
    AddYear = Table.AddColumn(ChangedType, "Año", each Date.Year([Fecha]), Int64.Type),
    AddMonthName = Table.AddColumn(AddYear, "Mes", each Text.Proper(Date.MonthName([Fecha])), type text),
    AddMonthNum = Table.AddColumn(AddMonthName, "Mes_Numero", each Date.Month([Fecha]), Int64.Type),
    AddQuarter = Table.AddColumn(AddMonthNum, "Trimestre", each "T" & Text.From(Date.QuarterOfYear([Fecha])), type text)
in
    AddQuarter;
shared GD_dim_calendario_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "GD_dim_calendario", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared SL_ordenes_pago_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "GD_dim_ordenes_pago", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared GD_pedidos_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "GD_fact_pedidos", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
