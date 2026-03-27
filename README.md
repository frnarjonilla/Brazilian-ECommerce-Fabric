# 📊 End-to-End Data Engineering: Brazilian E-Commerce (Olist)
![Status: Finished](https://img.shields.io/badge/Status-Finished-green)
![Platform: Microsoft Fabric](https://img.shields.io/badge/Platform-Microsoft%20Fabric-blue)
![Tech: PySpark](https://img.shields.io/badge/Tech-PySpark-orange)
![Tech: SQL](https://img.shields.io/badge/Tech-SQL-lightgrey)

## 📖 Descripción del Proyecto
Este proyecto implementa una solución integral de análisis de datos para el ecosistema de **Olist** (el marketplace más grande de Brasil). Utilizando **Microsoft Fabric**, he construido un flujo que transforma datos crudos en insights estratégicos, optimizando la arquitectura para la escalabilidad y la toma de decisiones en tiempo real.

---

## 🏗️ Arquitectura de la Solución
He aplicado una **Arquitectura de Medallón** simplificada dentro del ecosistema SaaS de Fabric:

1.  **Ingesta (Bronze):** Carga masiva de datasets de Olist en el **Data Warehouse**.
2.  **Procesamiento (Silver):** Transformación avanzada, limpieza y feature engineering mediante **Notebooks de PySpark**.
3.  **Modelado (Gold):** Estructuración de un **Esquema en Estrella** para consumo analítico optimizado.
4.  **Entrega de Valor:** Reportes interactivos en **Power BI** mediante tecnología **Direct Lake**.

---

## 🛠️ Stack Tecnológico
* **Almacenamiento:** Microsoft Fabric Warehouse (T-SQL).
* **Motor de Procesamiento:** Apache Spark (PySpark 3.4).
* **Orquestación:** Data Factory Pipelines.
* **Automatización:** Power Automate para alertas de KPIs y salud del flujo.
* **Visualización:** Power BI Desktop & Service.

---

## 🚀 Puntos Clave del Desarrollo

### 🐍 Ingeniería de Datos con PySpark
Para las transformaciones complejas, utilicé Spark para asegurar la escalabilidad. Un reto clave fue la normalización de columnas y el cálculo de métricas financieras.
* **Reto Técnico:** Resolución de inconsistencias en nombres de columnas (`freight_value`) y tipos de datos.
* **Solución:** Implementación de un script de limpieza que automatiza el cálculo del `precio_total` (precio + flete) con redondeo de precisión.

### 🏛️ Modelado Dimensional
Diseñé un esquema de estrella en el Warehouse para reducir la latencia en los reportes:
* **Tablas de Hechos:** Ventas y pedidos.
* **Tablas de Dimensión:** Productos, Vendedores y Geografía.

### 🤖 Automatización y Notificaciones
Implementé un flujo de trabajo que cierra la brecha entre el dato y el usuario mediante **Power Automate**, asegurando notificaciones automáticas al finalizar el refresco de datos y alertas de errores en el Pipeline.

---

## 📂 Estructura del Repositorio
* **[/notebooks](./notebooks):** Scripts de PySpark para limpieza y transformación.
* **[/sql_scripts](./sql_scripts):** Vistas y consultas de modelado en el Warehouse.
* **[/images](./images):** Capturas de pantalla con las evidencias del proyecto (Warehouse, Notebooks, Pipelines y Dashboards).

---

## 🖼️ Evidencias Técnicas (Capturas)
Para consultar la implementación visual del proyecto, puede acceder a las capturas en la carpeta de recursos:
* [Ejecución de Notebook PySpark](./images/Notebook.png)
* [Vista del Data Warehouse](./images/Warehouse.png)
* [Dashboard Final Power BI](./images/d1.png)

---

## 👤 Contacto
**Francisco Narjonilla**
* [LinkedIn](www.linkedin.com/in/francisco-arjonilla)
* [Email](frnarjonilla@gmail.com)
