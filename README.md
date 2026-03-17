End-to-End Data Engineering Portfolio: Brazilian E-Commerce (Olist) en Microsoft Fabric

📝 Descripción del Proyecto
Este proyecto implementa una solución de análisis de datos integral utilizando Microsoft Fabric. El objetivo es transformar datos brutos del ecosistema de e-commerce brasileño (Olist) en insights accionables, asegurando la calidad del dato y la estabilidad del sistema mediante pipelines robustos y automatización.

🏗️ Arquitectura Técnica

El proyecto sigue una arquitectura de Medallón (Bronze -> Silver -> Gold) integrada en un entorno SaaS:

Ingestión: Carga de archivos planos al Data Warehouse de Fabric.

Procesamiento: Transformación de datos mediante Notebooks (PySpark) para limpieza avanzada y lógica de negocio.

Orquestación: Data Factory Pipelines con lógica de "Self-healing" (autorreparación) y reintentos automáticos.

Visualización: Dashboard interactivo en Power BI con métricas clave de ventas y logística.

Automatización: Integración con Power Automate para alertas de errores en tiempo real y envío de reportes.

🛠️ Tecnologías Utilizadas

Microsoft Fabric: Warehouse, Notebooks, Pipelines.

Lenguajes: SQL (T-SQL) y Python (PySpark).

Visualización: Power BI (Direct Lake / Import).

Automatización: Power Automate (Webhooks HTTP).

🚀 Características Destacadas

1. Ingeniería de Datos con PySpark: A diferencia de los procesos ETL tradicionales, utilicé Notebooks de Spark para manejar transformaciones complejas.

Logro: Implementación de cálculos de impuestos y filtros de integridad utilizando DataFrames de Spark.

2. Pipeline Robusto y Gestión de Errores
Diseñé un flujo de trabajo que minimiza la intervención humana:

Retry Logic: Configuración de reintentos automáticos ante fallos transitorios.

Error Handling: Ruta de fallo ("On Failure") que dispara scripts de limpieza SQL para evitar duplicidad de datos.

Notificaciones: Alerta automática a través de Power Automate ante errores críticos no recuperables.
