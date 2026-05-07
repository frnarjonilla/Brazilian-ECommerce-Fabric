[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "olist_orders_dataset_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "order_id", DestinationColumnName = "order_id"], [SourceColumnName = "customer_id", DestinationColumnName = "customer_id"], [SourceColumnName = "order_status", DestinationColumnName = "order_status"], [SourceColumnName = "order_purchase_timestamp", DestinationColumnName = "order_purchase_timestamp"], [SourceColumnName = "order_approved_at", DestinationColumnName = "order_approved_at"], [SourceColumnName = "order_delivered_carrier_date", DestinationColumnName = "order_delivered_carrier_date"], [SourceColumnName = "order_delivered_customer_date", DestinationColumnName = "order_delivered_customer_date"], [SourceColumnName = "order_estimated_delivery_date", DestinationColumnName = "order_estimated_delivery_date"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared olist_orders_dataset = let
  Origen = Csv.Document(Web.Contents("https://casalalala-my.sharepoint.com/personal/franciscoarjonillatello_casalalala_onmicrosoft_com/Documents/Brazilian%20E-Commerce%20Public%20Dataset/olist_orders_dataset.csv"), [Delimiter = ",", Columns = 8, QuoteStyle = QuoteStyle.None]),
  #"Encabezados promovidos" = Table.PromoteHeaders(Origen, [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"order_id", type text}, {"customer_id", type text}, {"order_status", type text}, {"order_purchase_timestamp", type datetime}, {"order_approved_at", type datetime}, {"order_delivered_carrier_date", type datetime}, {"order_delivered_customer_date", type datetime}, {"order_estimated_delivery_date", type datetime}}, "es"),
  #"Personalizado agregado" = Table.AddColumn(#"Tipo de columna cambiado", "Filtro", each Mes_a_cargar),
  #"Mes insertado" = Table.AddColumn(#"Personalizado agregado", "Mes", each Date.Month([order_purchase_timestamp]), type nullable number),
  #"Año insertado" = Table.AddColumn(#"Mes insertado", "Año", each Date.Year([order_purchase_timestamp]), type nullable number),
  #"Tipo de columna cambiado 1" = Table.TransformColumnTypes(#"Año insertado", {{"Mes", type text}, {"Año", type text}}),
  #"Personalizado agregado 1" = Table.AddColumn(#"Tipo de columna cambiado 1", "Personalizado", each [Año] & Text.PadStart([Mes], 2, "0")),
  #"Filas filtradas" = Table.SelectRows(#"Personalizado agregado 1", each [Personalizado] = Mes_a_cargar),
  #"Tipo de columna cambiado 2" = Table.TransformColumnTypes(#"Filas filtradas", {{"Filtro", type text}, {"Personalizado", type text}}),
  #"Columnas quitadas" = Table.RemoveColumns(#"Tipo de columna cambiado 2", {"Mes", "Año", "Filtro"}),
  #"Columnas con nombre cambiado" = Table.RenameColumns(#"Columnas quitadas", {{"Personalizado", "Filtro"}}),
  #"Año insertado 1" = Table.AddColumn(#"Columnas con nombre cambiado", "Año", each Date.Year([order_purchase_timestamp]), type nullable number),
  #"Mes insertado 1" = Table.AddColumn(#"Año insertado 1", "Mes", each Date.Month([order_purchase_timestamp]), type nullable number),
  #"Tipo de columna cambiado 3" = Table.TransformColumnTypes(#"Mes insertado 1", {{"Año", type text}, {"Mes", type text}}),
  #"Columnas quitadas 1" = Table.RemoveColumns(#"Tipo de columna cambiado 3", {"Filtro"}),
  #"Personalizado agregado 2" = Table.AddColumn(#"Columnas quitadas 1", "Filtro", each [Año] & Text.PadStart([Mes], 2, "0")),
  #"Texto recortado" = Table.TransformColumns(#"Personalizado agregado 2", {{"Filtro", each Text.Trim(Text.From(_)), type nullable text}}),
  #"Filas filtradas 1" = Table.SelectRows(#"Texto recortado", each [Filtro] = Mes_a_cargar),
  #"Columnas quitadas 2" = Table.RemoveColumns(#"Filas filtradas 1", {"Filtro", "Mes", "Año"})
in
  #"Columnas quitadas 2";
shared Mes_a_cargar = let
  Origen = Csv.Document(Web.Contents("https://casalalala-my.sharepoint.com/personal/franciscoarjonillatello_casalalala_onmicrosoft_com/Documents/Brazilian%20E-Commerce%20Public%20Dataset/Mes_a_cargar.txt"), [Delimiter = ",", Columns = 1, QuoteStyle = QuoteStyle.None]),
  #"Explorar en profundidad" = Origen{0}[Column1],
  #"Texto recortado" = Text.Trim(#"Explorar en profundidad")
in
  #"Texto recortado";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "olist_order_items_dataset_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "order_id", DestinationColumnName = "order_id"], [SourceColumnName = "order_item_id", DestinationColumnName = "order_item_id"], [SourceColumnName = "product_id", DestinationColumnName = "product_id"], [SourceColumnName = "seller_id", DestinationColumnName = "seller_id"], [SourceColumnName = "shipping_limit_date", DestinationColumnName = "shipping_limit_date"], [SourceColumnName = "price", DestinationColumnName = "price"], [SourceColumnName = "freight_value", DestinationColumnName = "freight_value"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared olist_order_items_dataset = let
  Origen = Csv.Document(Web.Contents("https://casalalala-my.sharepoint.com/personal/franciscoarjonillatello_casalalala_onmicrosoft_com/Documents/Brazilian%20E-Commerce%20Public%20Dataset/olist_order_items_dataset.csv"), [Delimiter = ",", Columns = 7, QuoteStyle = QuoteStyle.None]),
  #"Encabezados promovidos" = Table.PromoteHeaders(Origen, [PromoteAllScalars = true])
in
  #"Encabezados promovidos";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "olist_products_dataset_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "product_id", DestinationColumnName = "product_id"], [SourceColumnName = "product_category_name", DestinationColumnName = "product_category_name"], [SourceColumnName = "product_name_lenght", DestinationColumnName = "product_name_lenght"], [SourceColumnName = "product_description_lenght", DestinationColumnName = "product_description_lenght"], [SourceColumnName = "product_photos_qty", DestinationColumnName = "product_photos_qty"], [SourceColumnName = "product_weight_g", DestinationColumnName = "product_weight_g"], [SourceColumnName = "product_length_cm", DestinationColumnName = "product_length_cm"], [SourceColumnName = "product_height_cm", DestinationColumnName = "product_height_cm"], [SourceColumnName = "product_width_cm", DestinationColumnName = "product_width_cm"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared olist_products_dataset = let
  Origen = Csv.Document(Web.Contents("https://casalalala-my.sharepoint.com/personal/franciscoarjonillatello_casalalala_onmicrosoft_com/Documents/Brazilian%20E-Commerce%20Public%20Dataset/olist_products_dataset.csv"), [Delimiter = ",", Columns = 9, QuoteStyle = QuoteStyle.None]),
  #"Encabezados promovidos" = Table.PromoteHeaders(Origen, [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"product_id", type text}, {"product_category_name", type text}, {"product_name_lenght", Int64.Type}, {"product_description_lenght", Int64.Type}, {"product_photos_qty", Int64.Type}, {"product_weight_g", Int64.Type}, {"product_length_cm", Int64.Type}, {"product_height_cm", Int64.Type}, {"product_width_cm", Int64.Type}}, "es")
in
  #"Tipo de columna cambiado";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "olist_customers_dataset_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "customer_id", DestinationColumnName = "customer_id"], [SourceColumnName = "customer_unique_id", DestinationColumnName = "customer_unique_id"], [SourceColumnName = "customer_zip_code_prefix", DestinationColumnName = "customer_zip_code_prefix"], [SourceColumnName = "customer_city", DestinationColumnName = "customer_city"], [SourceColumnName = "customer_state", DestinationColumnName = "customer_state"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared olist_customers_dataset = let
  Origen = Csv.Document(Web.Contents("https://casalalala-my.sharepoint.com/personal/franciscoarjonillatello_casalalala_onmicrosoft_com/Documents/Brazilian%20E-Commerce%20Public%20Dataset/olist_customers_dataset.csv"), [Delimiter = ",", Columns = 5, QuoteStyle = QuoteStyle.None]),
  #"Encabezados promovidos" = Table.PromoteHeaders(Origen, [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"customer_id", type text}, {"customer_unique_id", type text}, {"customer_zip_code_prefix", Int64.Type}, {"customer_city", type text}, {"customer_state", type text}}, "es")
in
  #"Tipo de columna cambiado";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "olist_sellers_dataset_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "seller_id", DestinationColumnName = "seller_id"], [SourceColumnName = "seller_zip_code_prefix", DestinationColumnName = "seller_zip_code_prefix"], [SourceColumnName = "seller_city", DestinationColumnName = "seller_city"], [SourceColumnName = "seller_state", DestinationColumnName = "seller_state"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared olist_sellers_dataset = let
  Origen = Csv.Document(Web.Contents("https://casalalala-my.sharepoint.com/personal/franciscoarjonillatello_casalalala_onmicrosoft_com/Documents/Brazilian%20E-Commerce%20Public%20Dataset/olist_sellers_dataset.csv"), [Delimiter = ",", Columns = 4, Encoding = 65001, QuoteStyle = QuoteStyle.None]),
  #"Encabezados promovidos" = Table.PromoteHeaders(Origen, [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"seller_id", type text}, {"seller_zip_code_prefix", Int64.Type}, {"seller_city", type text}, {"seller_state", type text}}, "es")
in
  #"Tipo de columna cambiado";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "olist_order_reviews_dataset_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "review_id", DestinationColumnName = "review_id"], [SourceColumnName = "order_id", DestinationColumnName = "order_id"], [SourceColumnName = "review_score", DestinationColumnName = "review_score"], [SourceColumnName = "review_comment_title", DestinationColumnName = "review_comment_title"], [SourceColumnName = "review_comment_message", DestinationColumnName = "review_comment_message"], [SourceColumnName = "review_creation_date", DestinationColumnName = "review_creation_date"], [SourceColumnName = "review_answer_timestamp", DestinationColumnName = "review_answer_timestamp"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared olist_order_reviews_dataset = let
  Origen = Csv.Document(Web.Contents("https://casalalala-my.sharepoint.com/personal/franciscoarjonillatello_casalalala_onmicrosoft_com/Documents/Brazilian%20E-Commerce%20Public%20Dataset/olist_order_reviews_dataset.csv"), [Delimiter = ",", Columns = 7, Encoding = 65001, QuoteStyle = QuoteStyle.Csv]),
  #"Encabezados promovidos" = Table.PromoteHeaders(Origen, [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"review_id", type text}, {"order_id", type text}, {"review_score", Int64.Type}, {"review_comment_title", type text}, {"review_comment_message", type text}, {"review_creation_date", type datetime}, {"review_answer_timestamp", type datetime}}, "es")
in
  #"Tipo de columna cambiado";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "product_category_name_translation_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "Column1", DestinationColumnName = "Column1"], [SourceColumnName = "Column2", DestinationColumnName = "Column2"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared product_category_name_translation = let
  Origen = Csv.Document(Web.Contents("https://casalalala-my.sharepoint.com/personal/franciscoarjonillatello_casalalala_onmicrosoft_com/Documents/Brazilian%20E-Commerce%20Public%20Dataset/product_category_name_translation.csv"), [Delimiter = ",", Columns = 2, Encoding = 65001, QuoteStyle = QuoteStyle.None])
in
  Origen;
shared olist_products_dataset_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "BR_productos", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared olist_customers_dataset_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "BR_clientes", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared olist_sellers_dataset_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "BR_vendedores", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared olist_order_reviews_dataset_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "BR_reseñas", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared product_category_name_translation_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "BR_traduccion_categoria", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared olist_orders_dataset_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "BR_ped", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "olist_geolocation_dataset_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "geolocation_zip_code_prefix", DestinationColumnName = "geolocation_zip_code_prefix"], [SourceColumnName = "geolocation_lat", DestinationColumnName = "geolocation_lat"], [SourceColumnName = "geolocation_lng", DestinationColumnName = "geolocation_lng"], [SourceColumnName = "geolocation_city", DestinationColumnName = "geolocation_city"], [SourceColumnName = "geolocation_state", DestinationColumnName = "geolocation_state"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared olist_geolocation_dataset = let
  Origen = Csv.Document(Web.Contents("https://casalalala-my.sharepoint.com/personal/franciscoarjonillatello_casalalala_onmicrosoft_com/Documents/Brazilian%20E-Commerce%20Public%20Dataset/olist_geolocation_dataset.csv"), [Delimiter = ",", Columns = 5, Encoding = 65001, QuoteStyle = QuoteStyle.None]),
  #"Encabezados promovidos" = Table.PromoteHeaders(Origen, [PromoteAllScalars = true]),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos", {{"geolocation_zip_code_prefix", Int64.Type}, {"geolocation_lat", Int64.Type}, {"geolocation_lng", Int64.Type}, {"geolocation_city", type text}, {"geolocation_state", type text}}, "es")
in
  #"Tipo de columna cambiado";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "olist_order_payments_dataset_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "order_id", DestinationColumnName = "order_id"], [SourceColumnName = "payment_sequential", DestinationColumnName = "payment_sequential"], [SourceColumnName = "payment_type", DestinationColumnName = "payment_type"], [SourceColumnName = "payment_installments", DestinationColumnName = "payment_installments"], [SourceColumnName = "payment_value", DestinationColumnName = "payment_value"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared olist_order_payments_dataset = let
  Origen = Csv.Document(Web.Contents("https://casalalala-my.sharepoint.com/personal/franciscoarjonillatello_casalalala_onmicrosoft_com/Documents/Brazilian%20E-Commerce%20Public%20Dataset/olist_order_payments_dataset.csv"), [Delimiter = ",", Columns = 5, QuoteStyle = QuoteStyle.None]),
  #"Encabezados promovidos" = Table.PromoteHeaders(Origen, [PromoteAllScalars = true])
in
  #"Encabezados promovidos";
shared olist_geolocation_dataset_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "BR_geolocalizacion", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared olist_order_items_dataset_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "BR_pedidos_item", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared olist_order_payments_dataset_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "BR_ordenes_pago", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
