# -------------------------------------------------------------------------
# PROYECTO: Brazilian E-Commerce (Olist) - Microsoft Fabric
# DESCRIPCIÓN: ETL y Limpieza de Datos usando PySpark
# OBJETIVO: Procesamiento de pedidos, limpieza de nulos y feature engineering
# -------------------------------------------------------------------------

from pyspark.sql import SparkSession
from pyspark.sql.functions import col, when, round, coalesce, current_timestamp

# 1. Inicializar sesión de Spark (Fabric ya lo hace, pero es buena práctica)
spark = SparkSession.builder.appName("OlistTransformation").getOrCreate()

# 2. Carga de datos desde el Lakehouse (Capa Bronze)
# Nota: Sustituir por la ruta real de tu Lakehouse en Fabric
df_orders = spark.read.table("bronze_orders")
df_items = spark.read.table("bronze_order_items")

# 3. Limpieza y Transformación (Capa Silver)
# Corregimos nombres de columnas y manejamos valores nulos en el flete
df_cleaned_items = df_items.select(
    col("order_id"),
    col("product_id"),
    col("price").cast("double"),
    coalesce(col("freight_value"), col("price") * 0.1).alias("freight_value") # Lógica de negocio para nulos
)

# 4. Feature Engineering: Creación de métricas de negocio
# Calculamos el precio total (producto + envío) con redondeo de precisión
df_transformed = df_cleaned_items.withColumn(
    "total_order_value", 
    round(col("price") + col("freight_value"), 2)
)

# 5. Filtrado de datos inconsistentes
# Solo mantenemos pedidos con precios positivos
df_final = df_transformed.filter(col("total_order_value") > 0)

# 6. Auditoría: Añadir timestamp de procesamiento
df_final = df_final.withColumn("processed_at", current_timestamp())

# 7. Escritura de resultados (Capa Gold / Warehouse)
# Guardamos como tabla Delta para asegurar transacciones ACID
try:
    df_final.write.format("delta").mode("overwrite").saveAsTable("silver_order_items_refined")
    print(">>> Transformación completada con éxito.")
except Exception as e:
    print(f"XXX Error en la escritura: {e}")

# Mostrar una muestra de los resultados para validación
df_final.show(5)
