# 🛒 Brazilian E-Commerce Data Pipeline (Microsoft Fabric)

Este proyecto implementa una arquitectura de datos moderna de extremo a extremo utilizando el dataset público de **Olist (Kaggle)**. El objetivo es transformar datos crudos de E-Commerce en un modelo dimensional listo para analítica avanzada, utilizando **Microsoft Fabric** como plataforma central.

---

## 🏗️ Arquitectura del Proyecto (Medallion Architecture)

El pipeline sigue el patrón de diseño de **Arquitectura Medallón** para garantizar la limpieza, integridad y escalabilidad de los datos en el OneLake:

1.  **Bronze (Raw Layer):** Ingesta de 9 datasets en formato CSV (clientes, pedidos, productos, pagos, etc.) sin transformaciones.
2.  **Silver (Cleaned Layer):** Procesamiento con **PySpark (Notebooks)** para:
    * Tipado de datos (Schema Enforcement).
    * Limpieza de nulos y duplicados.
    * Normalización de campos de fecha y moneda.
    * Cálculo de métricas de logística (tiempo de entrega real vs. estimado).
3.  **Gold (Curated Layer):** Creación de un **Esquema en Estrella (Star Schema)** con tablas de hechos y dimensiones optimizadas para consultas SQL y Power BI.

---

## 🛠️ Stack Tecnológico

* **Plataforma:** Microsoft Fabric.
* **Motor de Procesamiento:** Apache Spark (PySpark).
* **Almacenamiento:** OneLake con formato **Delta Lake**.
* **Orquestación:** Fabric Pipelines.
* **Lenguajes:** Python (PySpark) y T-SQL.

---

## 🚀 Key Technical Features

* **Procesamiento Distribuido:** Uso de Spark para manejar relaciones complejas entre millones de registros de ventas y pagos.
* **Delta Lake Table Management:** Implementación de tablas Delta para asegurar transacciones ACID y facilitar el "Time Travel" de los datos.
* **Transformaciones de Ingeniería:** * Unión de múltiples fuentes para consolidar el perfil de ventas por vendedor y categoría.
    * Cálculo de KPIs de rendimiento logístico y segmentación geográfica.

---

## 📁 Estructura del Repositorio

* `/Notebooks`: Contiene los scripts de PySpark para las capas Silver y Gold.
* `/SQL_Queries`: Consultas para la validación de datos en el SQL Endpoint de Fabric.
* `/Screenshots`: Capturas del flujo de trabajo en el Workspace.

---

## 📈 Insights Generados

A través de este pipeline, el modelo final permite responder a:
1.  ¿Cuál es el tiempo medio de entrega por estado en Brasil?
2.  ¿Qué categorías de productos generan el mayor LTV (Lifetime Value)?
3.  ¿Cómo afectan los métodos de pago (boleto vs tarjeta) al ciclo de vida del pedido?

---

## 👤 Autor

**Francisco Javier Arjonilla Tello**
* **LinkedIn:** [linkedin.com/in/francisco-arjonilla](https://www.linkedin.com/in/francisco-arjonilla)
* **Email:** frnarjonilla@gmail.com
