📊 End-to-End Data Engineering: Brazilian E-Commerce (Olist). Implementación integral en Microsoft Fabric

Este proyecto demuestra la construcción de una solución de datos moderna utilizando Microsoft Fabric, cubriendo desde la ingesta en un Data Warehouse hasta la transformación avanzada con PySpark y la visualización estratégica en Power BI.

🏗️ Arquitectura del Proyecto
La solución se basa en una arquitectura de Medallón, aprovechando el ecosistema SaaS de Fabric:

Ingesta (Bronze): Carga de datos crudos del ecosistema Olist (Kaggle) directamente en el Warehouse.

Transformación (Silver): Uso de Notebooks de Apache Spark para limpieza de datos, manejo de nulos y feature engineering.

Modelado (Gold): Estructuración de tablas finales en el Warehouse mediante SQL para consumo analítico.

Visualización: Reportes interactivos en Power BI conectados mediante Direct Lake para máximo rendimiento.

🛠️ Tecnologías Utilizadas
Plataforma: Microsoft Fabric (SaaS)

Almacenamiento: Data Warehouse (T-SQL)

Procesamiento: PySpark (Python 3.10)

Visualización: Power BI

Automatización: Power Automate (Notificaciones y Alertas)

🚀 Puntos Clave del Desarrollo
🐍 Ingeniería de Datos con PySpark: Para las transformaciones más complejas, opté por Notebooks de Spark en lugar de SQL tradicional. Esto permite una mayor escalabilidad y flexibilidad.

Cálculo de Métricas: Implementación de lógica para consolidar precio_total (precio + flete) con redondeo de precisión.

Manejo de Esquemas: Resolución de conflictos de nombres de columnas y tipos de datos mediante DataFrames.

![Notebook PySpark](./images/Notebook.png)

🏛️ Modelado en el Warehouse
El corazón del proyecto reside en el Warehouse, donde se definieron las relaciones entre pedidos, productos y vendedores, garantizando la integridad referencial y facilitando el análisis multidimensional.

📈 Insights de Negocio (Ejemplos)
A través del análisis realizado, se identificaron puntos críticos para la operación:

Logística: Identificación de las regiones de Brasil con mayores costos de envío relativo al precio del producto.

Ventas: Análisis de los periodos pico para optimizar la disponibilidad de los vendedores.
