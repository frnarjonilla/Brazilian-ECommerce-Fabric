[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "olist_products_dataset_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "product_id", DestinationColumnName = "product_id"], [SourceColumnName = "product_category_name", DestinationColumnName = "product_category_name"], [SourceColumnName = "product_name_lenght", DestinationColumnName = "product_name_lenght"], [SourceColumnName = "product_description_lenght", DestinationColumnName = "product_description_lenght"], [SourceColumnName = "product_photos_qty", DestinationColumnName = "product_photos_qty"], [SourceColumnName = "product_weight_g", DestinationColumnName = "product_weight_g"], [SourceColumnName = "product_length_cm", DestinationColumnName = "product_length_cm"], [SourceColumnName = "product_height_cm", DestinationColumnName = "product_height_cm"], [SourceColumnName = "product_width_cm", DestinationColumnName = "product_width_cm"]}], DynamicSchema = false, UpdateMethod = [Kind = "Append"], TypeSettings = [Kind = "Table"]]]}]
shared olist_products_dataset = let
  Origen = PowerPlatform.Dataflows([]),
  #"Navegación 1" = Origen{[Id = "Workspaces"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[dataflowId = "588c8f46-ff2a-40b7-839a-e35b82e702b8"]}[Data],
  #"Navegación 4" = #"Navegación 3"{[entity = "olist_products_dataset", version = ""]}[Data],
  #"Filas ordenadas" = Table.Sort(#"Navegación 4", {{"product_id", Order.Descending}}),
  #"Mayúsculas aplicadas en cada palabra" = Table.TransformColumns(#"Filas ordenadas", {{"product_category_name", each Text.Proper(_), type nullable text}}),
  #"Duplicados quitados" = Table.Distinct(#"Mayúsculas aplicadas en cada palabra", {"product_id"})
in
  #"Duplicados quitados";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "olist_order_reviews_dataset_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "review_id", DestinationColumnName = "review_id"], [SourceColumnName = "order_id", DestinationColumnName = "order_id"], [SourceColumnName = "review_score", DestinationColumnName = "review_score"], [SourceColumnName = "review_comment_title", DestinationColumnName = "review_comment_title"], [SourceColumnName = "review_comment_message", DestinationColumnName = "review_comment_message"], [SourceColumnName = "review_creation_date", DestinationColumnName = "review_creation_date"], [SourceColumnName = "review_answer_timestamp", DestinationColumnName = "review_answer_timestamp"]}], DynamicSchema = false, UpdateMethod = [Kind = "Append"], TypeSettings = [Kind = "Table"]]]}]
shared olist_order_reviews_dataset = let
  Origen = PowerPlatform.Dataflows([]),
  #"Navegación 1" = Origen{[Id = "Workspaces"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[dataflowId = "588c8f46-ff2a-40b7-839a-e35b82e702b8"]}[Data],
  #"Navegación 4" = #"Navegación 3"{[entity = "olist_order_reviews_dataset", version = ""]}[Data],
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Navegación 4", {{"review_creation_date", type date}, {"review_answer_timestamp", type date}}),
  #"Duplicados quitados" = Table.Distinct(#"Tipo de columna cambiado", {"review_id"})
in
  #"Duplicados quitados";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "olist_order_items_dataset_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "order_id", DestinationColumnName = "order_id"], [SourceColumnName = "order_item_id", DestinationColumnName = "order_item_id"], [SourceColumnName = "product_id", DestinationColumnName = "product_id"], [SourceColumnName = "seller_id", DestinationColumnName = "seller_id"], [SourceColumnName = "shipping_limit_date", DestinationColumnName = "shipping_limit_date"], [SourceColumnName = "price", DestinationColumnName = "price"], [SourceColumnName = "freight_value", DestinationColumnName = "freight_value"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared olist_order_items_dataset = let
  Origen = PowerPlatform.Dataflows([]),
  #"Navegación 1" = Origen{[Id = "Workspaces"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[dataflowId = "588c8f46-ff2a-40b7-839a-e35b82e702b8"]}[Data],
  #"Navegación 4" = #"Navegación 3"{[entity = "olist_order_items_dataset", version = ""]}[Data],
  #"Duplicados quitados" = Table.Distinct(#"Navegación 4", {"order_id"}),
  #"Valor reemplazado" = Table.ReplaceValue(#"Duplicados quitados", ".", ",", Replacer.ReplaceText, {"shipping_limit_date", "price"}),
  #"Valor reemplazado 1" = Table.ReplaceValue(#"Valor reemplazado", ".", ",", Replacer.ReplaceText, {"freight_value"}),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Valor reemplazado 1", {{"price", type number}, {"freight_value", type number}})
in
  #"Tipo de columna cambiado";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "olist_order_payments_dataset_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "order_id", DestinationColumnName = "order_id"], [SourceColumnName = "payment_sequential", DestinationColumnName = "payment_sequential"], [SourceColumnName = "payment_type", DestinationColumnName = "payment_type"], [SourceColumnName = "payment_installments", DestinationColumnName = "payment_installments"], [SourceColumnName = "payment_value", DestinationColumnName = "payment_value"]}], DynamicSchema = false, UpdateMethod = [Kind = "Append"], TypeSettings = [Kind = "Table"]]]}]
shared olist_order_payments_dataset = let
  Origen = PowerPlatform.Dataflows([]),
  #"Navegación 1" = Origen{[Id = "Workspaces"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[dataflowId = "588c8f46-ff2a-40b7-839a-e35b82e702b8"]}[Data],
  #"Navegación 4" = #"Navegación 3"{[entity = "olist_order_payments_dataset", version = ""]}[Data],
  #"Mayúsculas aplicadas en cada palabra" = Table.TransformColumns(#"Navegación 4", {{"payment_type", each Text.Proper(_), type nullable text}}),
  #"Duplicados quitados" = Table.Distinct(#"Mayúsculas aplicadas en cada palabra", {"order_id"}),
  #"Filas ordenadas" = Table.Sort(#"Duplicados quitados", {{"order_id", Order.Ascending}}),
  #"Valor reemplazado" = Table.ReplaceValue(#"Filas ordenadas", ".", ",", Replacer.ReplaceText, {"payment_value"}),
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Valor reemplazado", {{"payment_value", type number}})
in
  #"Tipo de columna cambiado";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "olist_sellers_dataset_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "seller_id", DestinationColumnName = "seller_id"], [SourceColumnName = "seller_zip_code_prefix", DestinationColumnName = "seller_zip_code_prefix"], [SourceColumnName = "seller_city", DestinationColumnName = "seller_city"], [SourceColumnName = "seller_state", DestinationColumnName = "seller_state"]}], DynamicSchema = false, UpdateMethod = [Kind = "Append"], TypeSettings = [Kind = "Table"]]]}]
shared olist_sellers_dataset = let
  Origen = PowerPlatform.Dataflows([]),
  #"Navegación 1" = Origen{[Id = "Workspaces"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[dataflowId = "588c8f46-ff2a-40b7-839a-e35b82e702b8"]}[Data],
  #"Navegación 4" = #"Navegación 3"{[entity = "olist_sellers_dataset", version = ""]}[Data],
  #"Mayúsculas aplicadas en cada palabra" = Table.TransformColumns(#"Navegación 4", {{"seller_city", each Text.Proper(_), type nullable text}}),
  #"Duplicados quitados" = Table.Distinct(#"Mayúsculas aplicadas en cada palabra", {"seller_id"})
in
  #"Duplicados quitados";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "product_category_name_translation_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "Column1", DestinationColumnName = "Column1"], [SourceColumnName = "Column2", DestinationColumnName = "Column2"]}], DynamicSchema = false, UpdateMethod = [Kind = "Append"], TypeSettings = [Kind = "Table"]]]}]
shared product_category_name_translation = let
  Origen = PowerPlatform.Dataflows([]),
  #"Navegación 1" = Origen{[Id = "Workspaces"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[dataflowId = "588c8f46-ff2a-40b7-839a-e35b82e702b8"]}[Data],
  #"Navegación 4" = #"Navegación 3"{[entity = "product_category_name_translation", version = ""]}[Data],
  #"Mayúsculas aplicadas en cada palabra" = Table.TransformColumns(#"Navegación 4", {{"Column2", each Text.Proper(_), type nullable text}}),
  #"Duplicados quitados" = Table.Distinct(#"Mayúsculas aplicadas en cada palabra", {"Column1"})
in
  #"Duplicados quitados";
shared olist_orders_dataset = let
  Origen = PowerPlatform.Dataflows([]),
  #"Navegación 1" = Origen{[Id = "Workspaces"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[dataflowId = "588c8f46-ff2a-40b7-839a-e35b82e702b8"]}[Data],
  #"Navegación 4" = #"Navegación 3"{[entity = "olist_orders_dataset", version = ""]}[Data],
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Navegación 4", {{"order_purchase_timestamp", type date}, {"order_approved_at", type date}, {"order_delivered_carrier_date", type date}, {"order_estimated_delivery_date", type date}}),
  #"Filas ordenadas" = Table.Sort(#"Tipo de columna cambiado", {{"order_delivered_customer_date", Order.Descending}}),
  #"Tipo de columna cambiado 1" = Table.TransformColumnTypes(#"Filas ordenadas", {{"order_delivered_customer_date", type date}}),
  #"Mayúsculas aplicadas en cada palabra" = Table.TransformColumns(#"Tipo de columna cambiado 1", {{"order_status", each Text.Proper(_), type nullable text}}),
  #"Duplicados quitados" = Table.Distinct(#"Mayúsculas aplicadas en cada palabra", {"order_id"})
in
  #"Duplicados quitados";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "olist_geolocation_dataset_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "geolocation_zip_code_prefix", DestinationColumnName = "geolocation_zip_code_prefix"], [SourceColumnName = "geolocation_lat", DestinationColumnName = "geolocation_lat"], [SourceColumnName = "geolocation_lng", DestinationColumnName = "geolocation_lng"], [SourceColumnName = "geolocation_city", DestinationColumnName = "geolocation_city"], [SourceColumnName = "geolocation_state", DestinationColumnName = "geolocation_state"]}], DynamicSchema = false, UpdateMethod = [Kind = "Append"], TypeSettings = [Kind = "Table"]]]}]
shared olist_geolocation_dataset = let
  Origen = PowerPlatform.Dataflows([]),
  #"Navegación 1" = Origen{[Id = "Workspaces"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[dataflowId = "588c8f46-ff2a-40b7-839a-e35b82e702b8"]}[Data],
  #"Navegación 4" = #"Navegación 3"{[entity = "olist_geolocation_dataset", version = ""]}[Data],
  #"Mayúsculas aplicadas en cada palabra" = Table.TransformColumns(#"Navegación 4", {{"geolocation_city", each Text.Proper(_), type nullable text}})
in
  #"Mayúsculas aplicadas en cada palabra";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "olist_customers_dataset_DataDestination", IsNewTarget = true], Settings = [Kind = "Manual", AllowCreation = true, ColumnSettings = [Mappings = {[SourceColumnName = "customer_id", DestinationColumnName = "customer_id"], [SourceColumnName = "customer_unique_id", DestinationColumnName = "customer_unique_id"], [SourceColumnName = "customer_zip_code_prefix", DestinationColumnName = "customer_zip_code_prefix"], [SourceColumnName = "customer_city", DestinationColumnName = "customer_city"], [SourceColumnName = "customer_state", DestinationColumnName = "customer_state"]}], DynamicSchema = false, UpdateMethod = [Kind = "Append"], TypeSettings = [Kind = "Table"]]]}]
shared olist_customers_dataset = let
  Origen = PowerPlatform.Dataflows([]),
  #"Navegación 1" = Origen{[Id = "Workspaces"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[dataflowId = "588c8f46-ff2a-40b7-839a-e35b82e702b8"]}[Data],
  #"Navegación 4" = #"Navegación 3"{[entity = "olist_customers_dataset", version = ""]}[Data],
  #"Mayúsculas aplicadas en cada palabra" = Table.TransformColumns(#"Navegación 4", {{"customer_city", each Text.Proper(_), type nullable text}}),
  #"Duplicados quitados" = Table.Distinct(#"Mayúsculas aplicadas en cada palabra", {"customer_id"})
in
  #"Duplicados quitados";
shared olist_products_dataset_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "SL_productos", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared olist_order_reviews_dataset_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "SL_reseñas", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared olist_order_payments_dataset_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "SL_ordenes_pago", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared olist_sellers_dataset_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "SL_vendedores", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared product_category_name_translation_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "SL_traduccion_categoria", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared olist_geolocation_dataset_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "SL_geolocalizacion", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared olist_customers_dataset_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "SL_clientes", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
shared BR_ped = let
  Origen = Fabric.Warehouse([HierarchicalNavigation = null]),
  #"Navegación 1" = Origen{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Schema = "dbo", Item = "BR_ped"]}[Data],
  #"Tipo de columna cambiado" = Table.TransformColumnTypes(#"Navegación 3", {{"order_purchase_timestamp", type date}, {"order_approved_at", type date}, {"order_delivered_carrier_date", type date}, {"order_delivered_customer_date", type date}, {"order_estimated_delivery_date", type date}})
in
  #"Tipo de columna cambiado";
shared SL_ped = let
  Origen = Fabric.Warehouse([HierarchicalNavigation = null]),
  #"Navegación 1" = Origen{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  #"Navegación 2" = #"Navegación 1"{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  #"Navegación 3" = #"Navegación 2"{[Schema = "dbo", Item = "SL_ped"]}[Data]
in
  #"Navegación 3";
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Fact_Sales_Silver_DataDestination", IsNewTarget = false], Settings = [Kind = "Manual", AllowCreation = false, ColumnSettings = [Mappings = {[SourceColumnName = "order_id", DestinationColumnName = "order_id"], [SourceColumnName = "customer_id", DestinationColumnName = "customer_id"], [SourceColumnName = "order_status", DestinationColumnName = "order_status"], [SourceColumnName = "order_purchase_timestamp", DestinationColumnName = "order_purchase_timestamp"], [SourceColumnName = "order_approved_at", DestinationColumnName = "order_approved_at"], [SourceColumnName = "order_delivered_carrier_date", DestinationColumnName = "order_delivered_carrier_date"], [SourceColumnName = "order_delivered_customer_date", DestinationColumnName = "order_delivered_customer_date"], [SourceColumnName = "order_estimated_delivery_date", DestinationColumnName = "order_estimated_delivery_date"]}], DynamicSchema = false, UpdateMethod = [Kind = "Replace"], TypeSettings = [Kind = "Table"]]]}]
shared Fact_Sales_Silver = let
  Origen = Table.Combine({BR_ped, SL_ped}),
  #"Duplicados quitados" = Table.Distinct(Origen, {"order_id"})
in
  #"Duplicados quitados";
shared Fact_Sales_Silver_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Schema = "dbo", Item = "SL_ped"]}[Data]
in
  TableNavigation;
shared olist_order_items_dataset_DataDestination = let
  Pattern = Fabric.Warehouse([HierarchicalNavigation = null, CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "cd02c6fc-d6de-41a3-bd04-20eefc533ee0"]}[Data],
  Navigation_2 = Navigation_1{[warehouseId = "798abeba-2b6b-4ebc-8550-576d0adb2bd5"]}[Data],
  TableNavigation = Navigation_2{[Item = "SL_pedidos_item", Schema = "dbo"]}?[Data]?
in
  TableNavigation;
