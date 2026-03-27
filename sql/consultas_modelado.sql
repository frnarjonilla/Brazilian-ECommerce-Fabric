-- ==========================================================
-- PROYECTO: Brazilian E-Commerce (Olist)
-- DESCRIPCIÓN: Modelado de datos y creación de vistas Gold
-- HERRAMIENTA: Microsoft Fabric Warehouse
-- ==========================================================

-- 1. Creación de la Vista de Ventas Consolidadas (Fact Table)
-- Esta vista une pedidos con pagos y clientes para facilitar el análisis.

CREATE VIEW gold.Fact_Sales AS
SELECT 
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp AS purchase_date,
    p.payment_type,
    p.payment_value AS total_amount,
    p.payment_installments
FROM silver.orders o
JOIN silver.order_payments p ON o.order_id = p.order_id
WHERE o.order_status = 'delivered';

GO

-- 2. Creación de la Dimensión de Productos
-- Limpieza de nombres y categorías para el reporte final.

CREATE VIEW gold.Dim_Products AS
SELECT 
    product_id,
    UPPER(product_category_name) AS category_name,
    product_weight_g / 1000.0 AS weight_kg, -- Conversión de unidades
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM silver.products
WHERE product_category_name IS NOT NULL;

GO

-- 3. Análisis de Eficiencia Logística (Consulta de Negocio)
-- Esta consulta identifica la diferencia entre entrega estimada y real.

SELECT 
    customer_state,
    AVG(DATEDIFF(day, order_purchase_timestamp, order_delivered_customer_date)) AS avg_delivery_days,
    AVG(DATEDIFF(day, order_delivered_customer_date, order_estimated_delivery_date)) AS delay_vs_estimate
FROM silver.orders
GROUP BY customer_state
ORDER BY avg_delivery_days DESC;
