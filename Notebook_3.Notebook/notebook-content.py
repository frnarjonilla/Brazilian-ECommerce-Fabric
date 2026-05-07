# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "warehouse": {
# META       "default_warehouse": "0adb2bd5-576d-8550-4ebc-2b6b798abeba",
# META       "known_warehouses": [
# META         {
# META           "id": "0adb2bd5-576d-8550-4ebc-2b6b798abeba",
# META           "type": "Datawarehouse"
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

df = spark.read.table("`Proyecto Brazilian Olist`.OlistBrazilian.dbo.BR_pedidos_item")

from pyspark.sql.functions import col, round

df_final = df.withColumn("precio_total", round(col("price") + col("freight_value"), 2))

display(df_final.limit(10))

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
